From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intermittent failures in t9119
Date: Mon, 06 Dec 2010 16:00:02 -0800
Message-ID: <7vd3pesb99.fsf@alter.siamese.dyndns.org>
References: <7vmxoml1p7.fsf@alter.siamese.dyndns.org>
 <7vy684t0mt.fsf@alter.siamese.dyndns.org>
 <20101206191055.GA9597@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David D. Kilzer" <ddkilzer@kilzer.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 01:00:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkyo-00031J-17
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 01:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab0LGAAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 19:00:17 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52386 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab0LGAAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 19:00:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A169720BD;
	Mon,  6 Dec 2010 19:00:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/tQQvNzujoZGIKWRWveZp7zLV7Y=; b=C4B+a/
	KbqHCPDOJTCM2IT2iGEkLtE++/c0HU2jQKSzkP6xnd0ZKJ4+vQKLL8s422l2IY9U
	8ztl/RsMUKkD25MyHFBf8/JQaa5RpHSooQ6QJaxGxTaklYUVk0asKJ1a2nIRLHF2
	KMMXm0hiAN5jvjlw23haRpPKSvd591SH+c25A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uw1EAHWYTtnV5dryLB2NTxmZqEjRe4sX
	0StmAPzlgHXZRW0nBg+iOIiplx649JdP/Fh+ZjZGyQ61kyQgxWvjgwVdnlDQj1xh
	qALxRRQPYvVjjSW6YyNWOjtvqJ59kC+sOwjPBGs4CEz0of+dkzfBJjgHBeEDIGYs
	lHIROdF9PkE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F7CE20BC;
	Mon,  6 Dec 2010 19:00:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 46C6D20A2; Mon,  6 Dec 2010
 19:00:26 -0500 (EST)
In-Reply-To: <20101206191055.GA9597@dcvr.yhbt.net> (Eric Wong's message of
 "Mon\, 6 Dec 2010 11\:10\:55 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02F0FF8A-0195-11E0-A5DD-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163062>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>>  (2) Nobody uses the value from "Text Last Updated" field in practice, so
>>      that bug has been unnoticed so far;
>> 
>>  (3) And it is not worth fixing it ;-)
>> 
>> For now, I would suggest fixing the failing test to ignore the "Text Last
>> Updated" field while comparing, and if somebody is inclined to, we would
>> update the code to match what "svn info" does.
>
> Agreed on both points.  I consider "git svn log" and "git svn info" to
> be reasonable approximations of svn behavior, not exact replicas.
> Exactly matching would be extremely difficult given variations between
> different svn versions, and also svn requiring network access while
> git svn does not.

Ok, here is a minimum patch to do that.

-- >8 --
Subject: t9119: do not compare "Text Last Updated" line from "svn info"

On the "Text Last Updated" line, "git svn info <file>" does not give the
timestamp of the commit that touched the path most recently, unlike "svn
info <file>".  Do not expect the output from two commands to match on
these lines.

There was a "ptouch" attempt to transplant the timestamp from svn working
tree files to corresponding git working tree files, which mostly hid this
difference, but is made pointless now with this change.  Remove the helper
function and calls to it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9119-git-svn-info.sh |  106 +++++++++++++++--------------------------------
 1 files changed, 34 insertions(+), 72 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index f3f397c..ff19695 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -18,21 +18,14 @@ case $v in
 	;;
 esac
 
-ptouch() {
-	perl -w -e '
-		use strict;
-		use POSIX qw(mktime);
-		die "ptouch requires exactly 2 arguments" if @ARGV != 2;
-		my $text_last_updated = shift @ARGV;
-		my $git_file = shift @ARGV;
-		die "\"$git_file\" does not exist" if ! -e $git_file;
-		if ($text_last_updated
-		    =~ /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/) {
-			my $mtime = mktime($6, $5, $4, $3, $2 - 1, $1 - 1900);
-			my $atime = $mtime;
-			utime $atime, $mtime, $git_file;
-		}
-	' "`svn_cmd info $2 | grep '^Text Last Updated:'`" "$1"
+# On the "Text Last Updated" line, "git svn info" does not return the
+# same value as "svn info" (i.e. the commit timestamp that touched the
+# path most recently); do not expect that field to match.
+test_cmp_info () {
+	sed -e '/^Text Last Updated:/d' "$1" >tmp.expect
+	sed -e '/^Text Last Updated:/d' "$2" >tmp.actual
+	test_cmp tmp.expect tmp.actual &&
+	rm -f tmp.expect tmp.actual
 }
 
 quoted_svnrepo="$(echo $svnrepo | sed 's/ /%20/')"
@@ -62,17 +55,13 @@ test_expect_success 'setup repository and import' '
 		cd gitwc &&
 		git svn init "$svnrepo" &&
 		git svn fetch
-	) &&
-	ptouch gitwc/file svnwc/file &&
-	ptouch gitwc/directory svnwc/directory &&
-	ptouch gitwc/symlink-file svnwc/symlink-file &&
-	ptouch gitwc/symlink-directory svnwc/symlink-directory
+	)
 	'
 
 test_expect_success 'info' "
 	(cd svnwc; svn info) > expected.info &&
 	(cd gitwc; git svn info) > actual.info &&
-	test_cmp expected.info actual.info
+	test_cmp_info expected.info actual.info
 	"
 
 test_expect_success 'info --url' '
@@ -82,7 +71,7 @@ test_expect_success 'info --url' '
 test_expect_success 'info .' "
 	(cd svnwc; svn info .) > expected.info-dot &&
 	(cd gitwc; git svn info .) > actual.info-dot &&
-	test_cmp expected.info-dot actual.info-dot
+	test_cmp_info expected.info-dot actual.info-dot
 	"
 
 test_expect_success 'info --url .' '
@@ -92,7 +81,7 @@ test_expect_success 'info --url .' '
 test_expect_success 'info file' "
 	(cd svnwc; svn info file) > expected.info-file &&
 	(cd gitwc; git svn info file) > actual.info-file &&
-	test_cmp expected.info-file actual.info-file
+	test_cmp_info expected.info-file actual.info-file
 	"
 
 test_expect_success 'info --url file' '
@@ -102,13 +91,13 @@ test_expect_success 'info --url file' '
 test_expect_success 'info directory' "
 	(cd svnwc; svn info directory) > expected.info-directory &&
 	(cd gitwc; git svn info directory) > actual.info-directory &&
-	test_cmp expected.info-directory actual.info-directory
+	test_cmp_info expected.info-directory actual.info-directory
 	"
 
 test_expect_success 'info inside directory' "
 	(cd svnwc/directory; svn info) > expected.info-inside-directory &&
 	(cd gitwc/directory; git svn info) > actual.info-inside-directory &&
-	test_cmp expected.info-inside-directory actual.info-inside-directory
+	test_cmp_info expected.info-inside-directory actual.info-inside-directory
 	"
 
 test_expect_success 'info --url directory' '
@@ -118,7 +107,7 @@ test_expect_success 'info --url directory' '
 test_expect_success 'info symlink-file' "
 	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
 	(cd gitwc; git svn info symlink-file) > actual.info-symlink-file &&
-	test_cmp expected.info-symlink-file actual.info-symlink-file
+	test_cmp_info expected.info-symlink-file actual.info-symlink-file
 	"
 
 test_expect_success 'info --url symlink-file' '
@@ -131,7 +120,7 @@ test_expect_success 'info symlink-directory' "
 		> expected.info-symlink-directory &&
 	(cd gitwc; git svn info symlink-directory) \
 		> actual.info-symlink-directory &&
-	test_cmp expected.info-symlink-directory actual.info-symlink-directory
+	test_cmp_info expected.info-symlink-directory actual.info-symlink-directory
 	"
 
 test_expect_success 'info --url symlink-directory' '
@@ -146,14 +135,13 @@ test_expect_success 'info added-file' "
 		git add added-file
 	) &&
 	cp gitwc/added-file svnwc/added-file &&
-	ptouch gitwc/added-file svnwc/added-file &&
 	(
 		cd svnwc &&
 		svn_cmd add added-file > /dev/null
 	) &&
 	(cd svnwc; svn info added-file) > expected.info-added-file &&
 	(cd gitwc; git svn info added-file) > actual.info-added-file &&
-	test_cmp expected.info-added-file actual.info-added-file
+	test_cmp_info expected.info-added-file actual.info-added-file
 	"
 
 test_expect_success 'info --url added-file' '
@@ -163,7 +151,6 @@ test_expect_success 'info --url added-file' '
 
 test_expect_success 'info added-directory' "
 	mkdir gitwc/added-directory svnwc/added-directory &&
-	ptouch gitwc/added-directory svnwc/added-directory &&
 	touch gitwc/added-directory/.placeholder &&
 	(
 		cd svnwc &&
@@ -177,7 +164,7 @@ test_expect_success 'info added-directory' "
 		> expected.info-added-directory &&
 	(cd gitwc; git svn info added-directory) \
 		> actual.info-added-directory &&
-	test_cmp expected.info-added-directory actual.info-added-directory
+	test_cmp_info expected.info-added-directory actual.info-added-directory
 	"
 
 test_expect_success 'info --url added-directory' '
@@ -196,13 +183,12 @@ test_expect_success 'info added-symlink-file' "
 		ln -s added-file added-symlink-file &&
 		svn_cmd add added-symlink-file > /dev/null
 	) &&
-	ptouch gitwc/added-symlink-file svnwc/added-symlink-file &&
 	(cd svnwc; svn info added-symlink-file) \
 		> expected.info-added-symlink-file &&
 	(cd gitwc; git svn info added-symlink-file) \
 		> actual.info-added-symlink-file &&
-	test_cmp expected.info-added-symlink-file \
-		 actual.info-added-symlink-file
+	test_cmp_info expected.info-added-symlink-file \
+		actual.info-added-symlink-file
 	"
 
 test_expect_success 'info --url added-symlink-file' '
@@ -221,13 +207,12 @@ test_expect_success 'info added-symlink-directory' "
 		ln -s added-directory added-symlink-directory &&
 		svn_cmd add added-symlink-directory > /dev/null
 	) &&
-	ptouch gitwc/added-symlink-directory svnwc/added-symlink-directory &&
 	(cd svnwc; svn info added-symlink-directory) \
 		> expected.info-added-symlink-directory &&
 	(cd gitwc; git svn info added-symlink-directory) \
 		> actual.info-added-symlink-directory &&
-	test_cmp expected.info-added-symlink-directory \
-		 actual.info-added-symlink-directory
+	test_cmp_info expected.info-added-symlink-directory \
+		actual.info-added-symlink-directory
 	"
 
 test_expect_success 'info --url added-symlink-directory' '
@@ -235,11 +220,6 @@ test_expect_success 'info --url added-symlink-directory' '
 	     = "$quoted_svnrepo/added-symlink-directory"
 	'
 
-# The next few tests replace the "Text Last Updated" value with a
-# placeholder since git doesn't have a way to know the date that a
-# now-deleted file was last checked out locally.  Internally it
-# simply reuses the Last Changed Date.
-
 test_expect_success 'info deleted-file' "
 	(
 		cd gitwc &&
@@ -249,13 +229,9 @@ test_expect_success 'info deleted-file' "
 		cd svnwc &&
 		svn_cmd rm --force file > /dev/null
 	) &&
-	(cd svnwc; svn info file) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		> expected.info-deleted-file &&
-	(cd gitwc; git svn info file) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		> actual.info-deleted-file &&
-	test_cmp expected.info-deleted-file actual.info-deleted-file
+	(cd svnwc; svn info file) >expected.info-deleted-file &&
+	(cd gitwc; git svn info file) >actual.info-deleted-file &&
+	test_cmp_info expected.info-deleted-file actual.info-deleted-file
 	"
 
 test_expect_success 'info --url file (deleted)' '
@@ -272,13 +248,9 @@ test_expect_success 'info deleted-directory' "
 		cd svnwc &&
 		svn_cmd rm --force directory > /dev/null
 	) &&
-	(cd svnwc; svn info directory) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		> expected.info-deleted-directory &&
-	(cd gitwc; git svn info directory) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		> actual.info-deleted-directory &&
-	test_cmp expected.info-deleted-directory actual.info-deleted-directory
+	(cd svnwc; svn info directory) >expected.info-deleted-directory &&
+	(cd gitwc; git svn info directory) >actual.info-deleted-directory &&
+	test_cmp_info expected.info-deleted-directory actual.info-deleted-directory
 	"
 
 test_expect_success 'info --url directory (deleted)' '
@@ -295,14 +267,9 @@ test_expect_success 'info deleted-symlink-file' "
 		cd svnwc &&
 		svn_cmd rm --force symlink-file > /dev/null
 	) &&
-	(cd svnwc; svn info symlink-file) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		> expected.info-deleted-symlink-file &&
-	(cd gitwc; git svn info symlink-file) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		> actual.info-deleted-symlink-file &&
-	test_cmp expected.info-deleted-symlink-file \
-		 actual.info-deleted-symlink-file
+	(cd svnwc; svn info symlink-file) >expected.info-deleted-symlink-file &&
+	(cd gitwc; git svn info symlink-file) >actual.info-deleted-symlink-file &&
+	test_cmp_info expected.info-deleted-symlink-file actual.info-deleted-symlink-file
 	"
 
 test_expect_success 'info --url symlink-file (deleted)' '
@@ -319,14 +286,9 @@ test_expect_success 'info deleted-symlink-directory' "
 		cd svnwc &&
 		svn_cmd rm --force symlink-directory > /dev/null
 	) &&
-	(cd svnwc; svn info symlink-directory) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		 > expected.info-deleted-symlink-directory &&
-	(cd gitwc; git svn info symlink-directory) |
-	sed -e 's/^\(Text Last Updated:\).*/\1 TEXT-LAST-UPDATED-STRING/' \
-		 > actual.info-deleted-symlink-directory &&
-	test_cmp expected.info-deleted-symlink-directory \
-		 actual.info-deleted-symlink-directory
+	(cd svnwc; svn info symlink-directory) >expected.info-deleted-symlink-directory &&
+	(cd gitwc; git svn info symlink-directory) >actual.info-deleted-symlink-directory &&
+	test_cmp_info expected.info-deleted-symlink-directory actual.info-deleted-symlink-directory
 	"
 
 test_expect_success 'info --url symlink-directory (deleted)' '
