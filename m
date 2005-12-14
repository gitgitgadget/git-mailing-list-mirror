From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] git-am --one
Date: Tue, 13 Dec 2005 17:10:29 -0800
Message-ID: <439F7105.9050302@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080605010801030702080802"
X-From: git-owner@vger.kernel.org Wed Dec 14 02:11:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmLAI-0006Yr-0v
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 02:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030310AbVLNBKi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 20:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVLNBKi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 20:10:38 -0500
Received: from terminus.zytor.com ([192.83.249.54]:49128 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932631AbVLNBKh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 20:10:37 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBE1AYnk020087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 Dec 2005 17:10:34 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13609>

This is a multi-part message in MIME format.
--------------080605010801030702080802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds the --one (-o) option to git-am, to apply a single 
message in RFC 2822 format, as opposed to an mbox.  With some MUAs it's 
a lot easier to save individual messages than with mboxes, and either 
way the user may want to control the ordering if there are known 
interdependencies.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------080605010801030702080802
Content-Type: text/plain;
 name="git-am-one"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-am-one"

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index a415fe2..bec5c84 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -8,7 +8,7 @@ git-am - Apply a series of patches in a 
 
 SYNOPSIS
 --------
-'git-am' [--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way] <mbox>...
+'git-am' [--one] [--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way] <mbox>...
 'git-am' [--skip | --resolved]
 
 DESCRIPTION
@@ -19,6 +19,10 @@ current branch.
 
 OPTIONS
 -------
+--one::
+	Indicates that <mbox> contains a single message in RFC 2822
+	format, without mbox-style separators.
+
 --signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
diff --git a/git-am.sh b/git-am.sh
index 6ed527c..9628651 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -4,7 +4,7 @@
 . git-sh-setup
 
 usage () {
-    echo >&2 "usage: $0 [--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way] <mbox>"
+    echo >&2 "usage: $0 [--one] [--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way] <mbox>"
     echo >&2 "	or, when resuming"
     echo >&2 "	$0 [--skip | --resolved]"
     exit 1;
@@ -98,11 +98,13 @@ fall_back_3way () {
 }
 
 prec=4
-dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary=
+dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= one=
 
 while case "$#" in 0) break;; esac
 do
 	case "$1" in
+	-o|--o|--on|--one)
+	one=t; shift;;
 	-d=*|--d=*|--do=*|--dot=*|--dote=*|--dotes=*|--dotest=*)
 	dotest=`expr "$1" : '-[^=]*=\(.*\)'`; shift ;;
 	-d|--d|--do|--dot|--dote|--dotes|--dotest)
@@ -165,8 +167,16 @@ else
 	mkdir -p "$dotest" || exit
 
 	# cat does the right thing for us, including '-' to mean
-	# standard input.
-	cat "$@" |
+	# standard input.  To prepend the header, we thus want a
+	# second cat, sigh...
+	if test "$one" = t
+	then
+		LANG=C date +'From - %a %b %d %T %Y' > "$dotest"/fakefrom
+		fakefrom="$dotest"/fakefrom
+	else
+		fakefrom=/dev/null
+	fi
+	cat "$@" | cat "$fakefrom" - |
 	git-mailsplit -d$prec "$dotest/" >"$dotest/last" || {
 		rm -fr "$dotest"
 		exit 1

--------------080605010801030702080802--
