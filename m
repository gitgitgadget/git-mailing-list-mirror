From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Add --log-size to git log to print message size
Date: Fri, 20 Jul 2007 20:15:13 +0200
Message-ID: <e5bfff550707201115v2531434erd9e10a2b816a59bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 20:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBx0b-0003TK-Kt
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 20:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbXGTSPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 14:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761555AbXGTSPQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 14:15:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:10724 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbXGTSPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 14:15:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1080814wah
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 11:15:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KEm47jJsQwJMpJG7WVKu5ETh5nW1hF+phncYnfMfIJJNz1TngXikmA+t5aLMzi4wQdp1p/ZU1slUU+D345yal9pvWaf6Uu2Sx0jfCJKhYLywkzJWP3Z+sMRPu273PFCY1ksYm+fKwu+UrAHDgT4BEL7uCb+CLae+k7BpVbDV3+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kU0aWwx0pytJEzstmmqlGQrLRrYadLtmXpzvr7tGxNgTTYl8lgYS8fL2cGti/BL6yJ+WKEQDQaD4OUAHonggvIW/QmuaOhMMtGFRNiOBr55hxghr7xME/uFLYwmh9ky6RlWHaox0YViAaqXsmGn5gWCHHNbESkjvs7R2lKOWvdg=
Received: by 10.114.107.19 with SMTP id f19mr699279wac.1184955313967;
        Fri, 20 Jul 2007 11:15:13 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Fri, 20 Jul 2007 11:15:13 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53109>

With this option git-log prints log message size
just before the corresponding message.

Porcelain tools could use this to speedup parsing
of git-log output.

Note that size refers to log message only. If also
patch content is shown its size is not included.

In case it is not possible to know the size upfront
size value is set to zero.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This is take 3 of this patch. In this case has been clearly added that
diff content size is not included.


  Documentation/git-log.txt |    7 +++++++
 log-tree.c                |    3 +++
 revision.c                |    4 ++++
 revision.h                |    1 +
 4 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 63c1dbe..40b9a09 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -64,6 +64,13 @@ include::pretty-options.txt[]
 --follow::
 	Continue listing the history of a file beyond renames.

+--log-size::
+	Before the log message print out its size in bytes. Intended
+	mainly for porcelain tools consumption. If git is unable to
+	produce a valid value size is set to zero.
+	Note that only message is considered, if also a diff is shown
+	its size is not included.
+
 <paths>...::
 	Show only commits that affect the specified paths.

diff --git a/log-tree.c b/log-tree.c
index 8624d5a..2dc6b1b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -295,6 +295,9 @@ void show_log(struct rev_info *opt,
 	if (opt->add_signoff)
  		len = append_signoff(&msgbuf, &msgbuf_len, len,
 				     opt->add_signoff);
+ 	if (opt->show_log_size)
+		printf("log size %i\n", len);
+
  	printf("%s%s%s", msgbuf, extra, sep);
  	free(msgbuf);
 }
diff --git a/revision.c b/revision.c
index 28b5f2e..f1cbb1f 100644
--- a/revision.c
+++ b/revision.c
@@ -1149,6 +1149,10 @@ int setup_revisions(int argc, const
  					die("unknown date format %s", arg);
 				continue;
 			}
+			if (!strcmp(arg, "--log-size")) {
+				revs->show_log_size = 1;
+				continue;
+			}

 			/*
 			 * Grepping the commit log
diff --git a/revision.h b/revision.h
index f46b4d5..98a0a8f 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,7 @@ struct rev_info {
  	const char	*log_reencode;
  	const char	*subject_prefix;
 	int		no_inline;
+	int		show_log_size;

 	/* Filter by commit log message */
  	struct grep_opt	*grep_filter;
-- 
1.5.3.rc2-dirty
