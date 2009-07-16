From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v6] mailinfo: allow e-mail files as input
Date: Thu, 16 Jul 2009 19:45:34 +0200
Message-ID: <f006bbb9c754c80c133798ff70db5b5291dae060.1247766192.git.nicolas.s.dev@gmx.fr>
References: <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 16 19:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRV1p-000815-BX
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 19:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897AbZGPRpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 13:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932891AbZGPRpt
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 13:45:49 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:33250 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757AbZGPRpr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 13:45:47 -0400
Received: by mail-ew0-f226.google.com with SMTP id 26so314349ewy.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=xKBBTVvNl6omUCKa0zGb631g2X2IRm+Wrep8Dql3SgA=;
        b=sNPMr9HzXW50NncO6DjI6OTkLqyjRtgMdfrynnnaBnYRJZDUn+fUrChtZjLyrTSf7l
         4a7JBrS7MiIX5MWS3NKMGvmCRrEsbr9jc3ocZNkPQ2nBqjsmfh+G9SGambnEg+Ne95Hd
         hFEBUepzXbQX4zaz8470ds1DMiiBmfqYDkd+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=LTOc+oeSlkv8I4KjQvt1MyMjhpLtwIhRXLTANV4UutF1TR1T7FKBHTh+ZYRZpCKhVn
         RXeocgR6EtDu35QvuQkhttAtEd1C8YWl09z5Vr8v7T8/5itIiPkjl1Kt+x1/gqTnNGYK
         2F55ETzWnoLNxunxShGPikqu7Cpw19Al0j97A=
Received: by 10.210.125.13 with SMTP id x13mr53515ebc.28.1247766347242;
        Thu, 16 Jul 2009 10:45:47 -0700 (PDT)
Received: from localhost (88-121-124-61.rev.libertysurf.net [88.121.124.61])
        by mx.google.com with ESMTPS id 28sm784699eye.56.2009.07.16.10.45.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Jul 2009 10:45:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc1.169.gd0406
In-Reply-To: <7v8wip9jjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123411>

We traditionally allowed a mbox file or a directory name of a maildir to be
given to "git am".  Even though an individual file in a maildir (or more
generally, a piece of RFC2822 e-mail) is not a mbox file, it contains enough
information to create a commit out of it, so there is no reason to reject one.
It allows to run 'git am' with an email list argument, something like:

 $ git am dir/*
 $ git am email1 email2

This builds on top of a5a6755 (git-am foreign patch support: introduce
patch_format, 2009-05-27) that introduced mailbox format detection.  The
codepath to deal with a mbox requires it to begin with "From " line and
also allows it to begin with "From: ", but a random piece of e-mail can
and often do begin with any valid RFC2822 header lines.

Instead of checking the first line, we extract all the lines up to the
first empty line, and make sure they look like e-mail headers.

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 Documentation/git-am.txt |    6 ++--
 git-am.sh                |   14 ++++++++++++
 t/t4150-am.sh            |   54 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 3 deletions(-)

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
index d64d997..617ca2f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -191,6 +191,20 @@ check_patch_format () {
 			esac
 			;;
 		esac
+		if test -z "$patch_format" &&
+			test -n "$l1" &&
+			test -n "$l2" &&
+			test -n "$l3"
+		then
+			# This begins with three non-empty lines.  Is this a
+			# piece of e-mail a-la RFC2822?  Grab all the headers,
+			# discarding the indented remainder of folded lines,
+			# and see if it looks like that they all begin with the
+			# header field names...
+			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
+			grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
+			patch_format=mbox
+		fi
 	} < "$1" || clean_abort
 }
 
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index a12bf84..4c99240 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -63,6 +63,53 @@ with the data reset to initial values.
 
 EOF
 
+cat >rfc2822_email <<EOF
+Return-Path: <user@domain.name>
+X-Flags: 0000
+	999
+Delivered-To: delivery to user@domain.name
+Received: (qmail invoked by alias); 16 Jul 2009 05:25:49 -0000
+Received: from vger.knl.xyz (EHLO vger.knl.xyz) [4.3.2.1]
+  by mx0.gmx.com (mx-us004) with SMTP; 16 Jul 2009 01:25:49 -0400
+Received: (majordomo@vger.knl.xyz) by vger.knl.xyz via listexpand
+	id S1757506AbZGPFZp (ORCPT <rfc822;user@domain.name>);
+	Thu, 16 Jul 2009 01:25:45 -0400
+Received: (majordomo@vger.knl.xyz) by vger.knl.xyz id F1757505AbZGPPER
+	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 01:25:45 -0400
+Received: from hsmail.qwknetllc.com ([208.71.137.138]:35086 "EHLO
+	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.knl.xyz
+	with ESMTP id F1757505AbZGPPER (ORCPT <rfc822;git@vger.knl.xyz>);
+	Thu, 16 Jul 2009 01:25:44 -0400
+X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.knl.xyz; Thu, 16 Jul 2009 01:25:44 EDT
+Received: (qmail 31380 invoked by uid 399); 15 Jul 2009 23:19:01 -0600
+Received: from unknown (HELO ?192.168.1.107?) (user@domain.name@1.2.3.4)
+  by hsmail.qwknetllc.com with ESMTPAM; 15 Jul 2009 23:19:01 -0600
+X-Originating-IP: 1.2.3.4
+Message-ID: <ADDDASSSS.123456789@domain.name>
+Date:	Wed, 15 Jul 2009 23:19:05 -0600
+From:	sender <user@domain.name>
+User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
+MIME-Version: 1.0
+To:	git@vger.knl.xyz
+Subject: [PATCH] apply patch from rfc2822 formated email
+Content-Type: text/plain; charset=ISO-8859-1; format=flowed
+Content-Transfer-Encoding: 7bit
+Sender:	git-owner@vger.knl.xyz
+Precedence: bulk
+List-ID: <git.vger.knl.xyz>
+X-Mailing-List:	git@vger.knl.xyz
+X-Antivirus: 0 (no virus found)
+X-Antispam: -2 (not scanned, spam filter disabled)
+X-UID: PIhtafixEX1VXO6puPmJy7wxySDc4NMwX
+Content-Length: 123465
+
+This text is part of the internal format of your mail folder, and is not
+a real message.  It is created automatically by the mail system software.
+If deleted, important folder data will be lost, and it will be re-created
+with the data reset to initial values.
+
+EOF
+
 echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expected
 
 test_expect_success setup '
@@ -222,6 +269,13 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 	test -z "$(git diff master^..HEAD)"
 '
 
+test_expect_success 'am takes patches from a RFC2822 formated email' '
+	git checkout first &&
+	cat rfc2822_email patch1 | git am &&
+	! test -d .git/rebase-apply &&
+	test -z "$(git diff master^..HEAD)"
+'
+
 test_expect_success 'am fails on mail without patch' '
 	test_must_fail git am <failmail &&
 	rm -r .git/rebase-apply/
-- 
1.6.4.rc1.169.gd0406
