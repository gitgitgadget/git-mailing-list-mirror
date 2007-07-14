From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Add --show-size to git log to print message size
Date: Sat, 14 Jul 2007 18:52:10 +0200
Message-ID: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 18:52:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9kqy-0007lX-Fq
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 18:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755606AbXGNQwR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 12:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbXGNQwR
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 12:52:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:6176 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348AbXGNQwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 12:52:16 -0400
Received: by wa-out-1112.google.com with SMTP id v27so988198wah
        for <git@vger.kernel.org>; Sat, 14 Jul 2007 09:52:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=imBmNFqZIUMDoaNf/jeVj4TGtDt/cKoTpMYalGTs8Kfor3rAfuL0em8gB2xMQH5igu61yry9rkY79EH41YzIuGfcQRq+R4CSeCJALSLqt0Hlut7MDApkTxhNS1I2zT5kWzQikWob5dh0hGFFyUTDy0L+Yns/4nCkluv/NuHPL24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=esRufd7Moxh1AbUSF7MNQ1amTsK4dGLhXOuyAKFu/76HhxR9NxYEWT3peVgh2iLdB+uh6f3GpmyUQWOB42TCWRbEiqaHBobTfkDGlW2dhAM5F4U7tldRKcKNzmeWL0IGac2twWEmW54pqprMRvo5owPGJX49OlxVpGi1yqM7aoo=
Received: by 10.114.146.1 with SMTP id t1mr2685712wad.1184431930598;
        Sat, 14 Jul 2007 09:52:10 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sat, 14 Jul 2007 09:52:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52487>

Print message size just before the corresponding message
to speedup the parsing by scripts/porcelains tools.

Because git log output is normally read incrementally by
porcelain tools, if message size is ignored then an
expensive seek of the delimiting char, as example '\0'
must be done when parsing the output stream.

With this patch it is possible to avoid an otherwise
mandatory seek for '\0' starting from the beginning
of log body.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This little patch makes great difference in loading
performance of our loved ;-) tool....and probably
also others.

Please apply.

Thanks
Marco


 log-tree.c |    3 +++
 revision.c |    4 ++++
 revision.h |    1 +
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 8624d5a..2fb7761 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -295,6 +295,9 @@ void show_log(struct rev_info *opt,
 	if (opt->add_signoff)
  		len = append_signoff(&msgbuf, &msgbuf_len, len,
 				     opt->add_signoff);
+ 	if (opt->show_size)
+		printf("size %i\n", len);
+
  	printf("%s%s%s", msgbuf, extra, sep);
  	free(msgbuf);
 }
diff --git a/revision.c b/revision.c
index 33ee9ee..3850a1e 100644
--- a/revision.c
+++ b/revision.c
@@ -1136,6 +1136,10 @@ int setup_revisions(int argc,
 				continue;
 			}
+			if (!strcmp(arg, "--show-size")) {
+				revs->show_size = 1;
+				continue;
+			}

 			/*
 			 * Grepping the commit log
diff --git a/revision.h b/revision.h
index f46b4d5..584b3f1 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,7 @@ struct rev_info {
  	const char	*log_reencode;
  	const char	*subject_prefix;
 	int		no_inline;
+	int		show_size;

 	/* Filter by commit log message */
  	struct grep_opt	*grep_filter;
-- 
1.5.3.rc0.81.g1ed84-dirty
