From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v4] git-am: allow e-mail file(s) as input
Date: Thu, 16 Jul 2009 06:05:23 +0200
Message-ID: <eae6ce0ac7ff600e3e7ab261a5f020651e39ddfa.1247717023.git.nicolas.s.dev@gmx.fr>
References: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 06:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRIEB-0004Iu-BO
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 06:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbZGPEFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 00:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbZGPEFn
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 00:05:43 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:37847 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbZGPEFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 00:05:43 -0400
Received: by ewy26 with SMTP id 26so4543246ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 21:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=0mAJsPZEreNADziCBSHLc9rMMDVqp1UBoAnCSODp7ms=;
        b=dfq7Gx1+PyLphuv/pMsvIeTQ6E6RtoIQZPRuJTW6Quz3a4DoGdR+Q7anAZKOUQkHLF
         CMRRE3Bim/yIW1/UxwslprZm74Kc5YQSlb6yRvE/hlCHYQeQM4PfSFpxxwcSoTA7KE8s
         wTjomBtk3tuYehuf8Db1iiHIkxwC+f69lo2U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=U2QCo0i25b7b2qNRFN8mEe4LG66T38kUXW1blVNjgajQmoYp/l5YL8smWIWuqPkWvD
         7ZWlEoioCij7zjuKsGsEAItCb1YHiQ6BmQ1OVV13zNAh2eqZCB/cgMAkEsC6IloRY5Az
         AxERlFH8jf1VuXy+vDfKkodyLSrVL23OILtoQ=
Received: by 10.211.199.11 with SMTP id b11mr10250269ebq.68.1247717141854;
        Wed, 15 Jul 2009 21:05:41 -0700 (PDT)
Received: from localhost (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 28sm1062933eye.36.2009.07.15.21.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 21:05:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc0.129.gdc42
In-Reply-To: <7v7hy9bb8k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123361>

We traditionally allowed a mbox file or a directory name of a maildir to be
given to "git am". Even though file in a maildir (or more generally, a piece
of RFC2822 e-mail) is not a mbox file, it contains enough information to create
a commit out of it, so there is no reason to reject one.

This builds on top of a5a6755 (git-am foreign patch support: introduce
patch_format, 2009-05-27) that introduced mailbox format detection. The codepath
to deal with a mbox requires it to begin with "From " line and also allows it to
begin with "From: ", but a random piece of e-mail can and often do begin with
any valid RFC2822 header lines.

Instead of checking the first line, we extract all the lines up to the
first empty line, and make sure they look like e-mail headers.

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 Documentation/git-am.txt |    6 +++---
 git-am.sh                |    8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 32e689b..2a930a7 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	 [--ignore-date]
 	 [--whitespace=<option>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--reject] [-q | --quiet]
-	 [<mbox> | <Maildir>...]
+	 [<mbox> | <Maildir>... | <email>... ]
 'git am' (--skip | --resolved | --abort)
 
 DESCRIPTION
@@ -25,8 +25,8 @@ current branch.
 
 OPTIONS
 -------
-<mbox>|<Maildir>...::
-	The list of mailbox files to read patches from. If you do not
+<mbox>|<Maildir>...|<email>...::
+	The list of mailbox files or email to read patches from. If you do not
 	supply this argument, the command reads from the standard input.
 	If you supply directories, they will be treated as Maildirs.
 
diff --git a/git-am.sh b/git-am.sh
index d64d997..87a886d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -162,6 +162,14 @@ check_patch_format () {
 		return 0
 	fi
 
+	# then, accept (series of) email(s)
+	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |
+	grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null &&
+	{
+		patch_format=mbox
+		return 0
+	}
+
 	# otherwise, check the first few lines of the first patch to try
 	# to detect its format
 	{
-- 
1.6.4.rc0.129.gdc42
