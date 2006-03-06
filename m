From: Mike McCormack <mike@codeweavers.com>
Subject: PATCH: Allow format-patch to attach patches
Date: Mon, 06 Mar 2006 22:12:12 +0900
Organization: CodeWeavers
Message-ID: <440C352C.9070009@codeweavers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010508070801010901030206"
X-From: git-owner@vger.kernel.org Mon Mar 06 14:46:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGG2b-0001Zk-FC
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 14:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWCFNqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 08:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWCFNqX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 08:46:23 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:22441 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932183AbWCFNqW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 08:46:22 -0500
Received: from foghorn.codeweavers.com ([216.251.189.130] helo=[127.0.0.1])
	by mail.codeweavers.com with esmtp (Exim 4.50)
	id 1FGFZa-0000IV-5m
	for git@vger.kernel.org; Mon, 06 Mar 2006 07:16:28 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923
X-Accept-Language: en, en-us
To: git@vger.kernel.org
X-SA-Exim-Connect-IP: 216.251.189.130
X-SA-Exim-Mail-From: mike@codeweavers.com
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17297>

This is a multi-part message in MIME format.
--------------010508070801010901030206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The --attach patch to git-format-patch to attach patches instead of 
inlining them.  Some mailers linewrap inlined patches (eg. Mozilla).

---

  git-format-patch.sh |   52 
++++++++++++++++++++++++++++++++++++++++++++-------
  1 files changed, 45 insertions(+), 7 deletions(-)


--------------010508070801010901030206
Content-Type: text/x-patch;
 name="b17ef6b06ebaaf9b6d1f47c6a788cffd77e2b927.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="b17ef6b06ebaaf9b6d1f47c6a788cffd77e2b927.diff"

b17ef6b06ebaaf9b6d1f47c6a788cffd77e2b927
diff --git a/git-format-patch.sh b/git-format-patch.sh
index bbd2e55..2ebf7e8 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
-USAGE='[-n | -k] [-o <dir> | --stdout] [--signoff] [--check] [--diff-options] <his> [<mine>]'
+USAGE='[-n | -k] [-o <dir> | --stdout] [--signoff] [--check] [--diff-options] [--attach] <his> [<mine>]'
 LONG_USAGE='Prepare each commit with its patch since <mine> head forked from
 <his> head, one file per patch formatted to resemble UNIX mailbox
 format, for e-mail submission or use with git-am.
@@ -18,7 +18,9 @@ is ignored if --stdout is specified.
 
 When -n is specified, instead of "[PATCH] Subject", the first
 line is formatted as "[PATCH N/M] Subject", unless you have only
-one patch.'
+one patch.
+
+When --attach is specified, patches are attached, not inlined.'
 
 . git-sh-setup
 
@@ -40,6 +42,8 @@ do
     -d|--d|--da|--dat|--date|\
     -m|--m|--mb|--mbo|--mbox) # now noop
     ;;
+    --at|--att|--atta|--attac|--attach)
+    attach=t ;;
     -k|--k|--ke|--kee|--keep|--keep-|--keep-s|--keep-su|--keep-sub|\
     --keep-subj|--keep-subje|--keep-subjec|--keep-subject)
     keep_subject=t ;;
@@ -150,6 +154,11 @@ done >$series
 
 me=`git-var GIT_AUTHOR_IDENT | sed -e 's/>.*/>/'`
 headers=`git-repo-config --get format.headers`
+case "$attach" in
+"") ;;
+*)
+	mimemagic="050802040500080604070107"
+esac
 
 case "$outdir" in
 */) ;;
@@ -174,7 +183,7 @@ titleScript='
 
 process_one () {
 	perl -w -e '
-my ($keep_subject, $num, $signoff, $headers, $commsg) = @ARGV;
+my ($keep_subject, $num, $signoff, $headers, $mimemagic, $commsg) = @ARGV;
 my ($signoff_pattern, $done_header, $done_subject, $done_separator, $signoff_seen,
     $last_was_signoff);
 
@@ -229,6 +238,16 @@ while (<FH>) {
 	    print "$headers\n";
 	}
         print "Subject: $_";
+	if ($mimemagic) {
+	    print "MIME-Version: 1.0\n";
+	    print "Content-Type: multipart/mixed;\n";
+	    print " boundary=\"------------$mimemagic\"\n";
+	    print "\n";
+	    print "This is a multi-part message in MIME format.\n";
+	    print "--------------$mimemagic\n";
+	    print "Content-Type: text/plain; charset=UTF-8; format=fixed\n";
+	    print "Content-Transfer-Encoding: 8bit\n";
+	}
 	$done_subject = 1;
 	next;
     }
@@ -254,14 +273,33 @@ if (!$signoff_seen && $signoff ne "") {
 }
 print "\n---\n\n";
 close FH or die "close $commsg pipe";
-' "$keep_subject" "$num" "$signoff" "$headers" $commsg
+' "$keep_subject" "$num" "$signoff" "$headers" "$mimemagic" $commsg
 
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
 	echo
+	case "$mimemagic" in
+	'');;
+	*)
+		echo "--------------$mimemagic"
+		echo "Content-Type: text/x-patch;"
+		echo " name=\"$commit.diff\""
+		echo "Content-Transfer-Encoding: 8bit"
+		echo "Content-Disposition: inline;"
+		echo " filename=\"$commit.diff\""
+		echo
+	esac
 	git-diff-tree -p $diff_opts "$commit"
-	echo "-- "
-	echo "@@GIT_VERSION@@"
-
+	case "$mimemagic" in
+	'')
+		echo "-- "
+		echo "@@GIT_VERSION@@"
+		;;
+	*)
+		echo
+		echo "--------------$mimemagic--"
+		echo
+		;;
+	esac
 	echo
 }
 


--------------010508070801010901030206--
