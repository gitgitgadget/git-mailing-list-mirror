From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 02/44] ruby: add support for internal ruby programs
Date: Sat, 28 Sep 2013 17:03:27 -0500
Message-ID: <1380405849-13000-3-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2iH-0002jN-Ji
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab3I1WKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59853 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab3I1WKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:02 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so4102273obc.5
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ja8No33md/8ovAE187FbnJJ5cQTX0199dZ3A5v0GuRg=;
        b=RtfioTUF1n+OSWvToIKYDZAbBFXH4srDzH33UstgYUZ0CRPUMch6nBc2rq4xeI4opJ
         CWb7wh8SZtvhFYYpoB8LFDIyQxKBa0rIUgOvERw8hOc36ebGXfHSdSFz97P5BQBf467S
         lHqWYBJgASQh1Em+g0lpkKCmLWmASZqUF5Wu+ORXyTKFcVzPBdIlbs3S+wvurGc0JkY2
         twxnLzP9w4YKxwACKSjPG9duszyvp+SyeKlTSJBeD8V70KgayJqJNW6nrsjaxaHaTc0o
         KeDL5dM39A3cHYk9mc3BkyAFxuh5Yc8TWeU/YtjpvpoFE9xKA8Ioup/NQiAbUCZmi7fK
         /Rrw==
X-Received: by 10.60.52.81 with SMTP id r17mr12518417oeo.3.1380406202189;
        Sat, 28 Sep 2013 15:10:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id bq4sm19539471obb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235523>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile |  9 +++++++++
 ruby.c   | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2fdee15..27e61c0 100644
--- a/Makefile
+++ b/Makefile
@@ -429,6 +429,7 @@ BASIC_LDFLAGS =
 # Guard against environment variables
 BUILTIN_OBJS =
 BUILT_INS =
+RUBY_PROGRAMS =
 COMPAT_CFLAGS =
 COMPAT_OBJS =
 XDIFF_OBJS =
@@ -493,6 +494,8 @@ SCRIPT_PYTHON += git-p4.py
 
 SCRIPT_RUBY += git-rb-setup.rb
 
+PROGRAMS += $(RUBY_PROGRAMS)
+
 NO_INSTALL += git-remote-testgit
 NO_INSTALL += git-remote-testpy
 
@@ -1754,6 +1757,12 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
+$(RUBY_PROGRAMS): git-ruby$X
+	$(QUIET_BUILT_IN)$(RM) $@ && \
+	ln $< $@ 2>/dev/null || \
+	ln -s $< $@ 2>/dev/null || \
+	cp $< $@
+
 common-cmds.h: ./generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
diff --git a/ruby.c b/ruby.c
index ee6a0e7..339e376 100644
--- a/ruby.c
+++ b/ruby.c
@@ -52,5 +52,22 @@ static int run_ruby_command(const char *cmd, int argc, const char **argv)
 
 int main(int argc, const char **argv)
 {
-	return run_ruby_command(argv[1], argc, argv);
+	if (!strcmp(argv[0], "git-ruby")) {
+		return run_ruby_command(argv[1], argc, argv);
+	} else {
+		const char *cmd = argv[0];
+		static char buf[PATH_MAX + 1];
+		const char *args[argc + 1];
+		int i;
+
+		snprintf(buf, PATH_MAX, "%s/%s.rb",
+				git_exec_path(), basename((char *)cmd));
+
+		args[0] = "git";
+		args[1] = buf;
+		for (i = 0; i < argc - 1; i++)
+			args[i + 2] = (char *)argv[i + 1];
+
+		return run_ruby_command(cmd, argc + 1, args);
+	}
 }
-- 
1.8.4-fc
