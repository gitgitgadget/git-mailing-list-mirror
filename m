From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/fast-import-blob-access] t9300: use perl "head -c" clone
 in place of "dd bs=1 count=16000" kluge
Date: Mon, 13 Dec 2010 03:28:05 -0600
Message-ID: <20101213092805.GB23443@burratino>
References: <0BB1933F-1C3D-4C24-9C91-263121BF55FB@gernhardtsoftware.com>
 <20101212214909.GA19709@burratino>
 <2F4185D2-5846-45CB-BC92-6BC07AE5CEC8@gernhardtsoftware.com>
 <20101213063151.GB20812@burratino>
 <7vfwu25e9q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 10:28:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS4he-0005W7-2G
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 10:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab0LMJ2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 04:28:12 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57825 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0LMJ2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 04:28:11 -0500
Received: by yxt3 with SMTP id 3so3145526yxt.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 01:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=l0WGuaXmvCFwM53wPPtDF/NZ1tzCJUO9+9xkzk0pl44=;
        b=u8jFp/9tXKgfM3PRh80OitmBhdD242VooXYtlh5hUgJvS+dRFkxT+zjCsGu11dLJZI
         S9yOLNG1XaSLscRhMi2gmi9FWf8Gf3cDPZER5GM8c8Zf4SRP6pkCYiXmv57c/xecl+5b
         N+XOwlZqjEu7P6dG56bNyvvcBglR3dghKvjk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=odzPmwLd3gkq9aiKSERuAIlYsQYzowTuwJUh3SGwXVGy0d/emmiF5dqLo21YAiXrw1
         w/vrgConRo14jV3u8YRpDcwGxJpFSCVJU0BaKY2NDN05kfrDAQizV1ZXV07pUJeC+lHl
         uVJDeHNDsgFyDJ5EoHvkI2ktiJw3k1k6rAxuY=
Received: by 10.147.41.5 with SMTP id t5mr5704881yaj.38.1292232491091;
        Mon, 13 Dec 2010 01:28:11 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id g27sm1491598yhd.13.2010.12.13.01.28.09
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Dec 2010 01:28:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vfwu25e9q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163528>

It is unfortunate to have to issue thousands of one-byte read calls to
work around dd's refusal to buffer input that would fill a block after
a short read (a3a6f4, 2010-12-13).  We could do better by using
"head -c", if it were available on all platforms we cared about.
Replace it with some simple perl.

While doing so, restructure 9300.114 to use a subshell instead of a
script.  Subshells can inherit functions (like the new head_c) from
the parent shell while external scripts cannot.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> It is unfortunate and feels
> yucky that we have to issue 8k+ read(2) of one byte

How about this?

 t/t9300-fast-import.sh |   84 ++++++++++++++++++++++++++++--------------------
 1 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ed28d3c..924a833 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -7,6 +7,23 @@ test_description='test git fast-import utility'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh ;# test-lib chdir's into trash
 
+# Print $1 bytes from stdin to stdout.
+#
+# This could be written as "head -c $1", but IRIX "head" does not
+# support the -c option.
+head_c () {
+	perl -e '
+		my $len = $ARGV[1];
+		while ($len > 0) {
+			my $s;
+			my $nread = sysread(STDIN, $s, $len);
+			die "cannot read: $!" unless defined($nread);
+			print $s;
+			$len -= $nread;
+		}
+	' - "$1"
+}
+
 file2_data='file2
 second line of EOF'
 
@@ -1780,44 +1797,41 @@ test_expect_success PIPE 'R: copy using cat-file' '
 	rm -f blobs &&
 	cat >frontend <<-\FRONTEND_END &&
 	#!/bin/sh
-	cat <<EOF &&
-	feature cat-blob
-	blob
-	mark :1
-	data <<BLOB
-	EOF
-	cat big
-	cat <<EOF
-	BLOB
-	cat-blob :1
-	EOF
-
-	read blob_id type size <&3 &&
-	echo "$blob_id $type $size" >response &&
-	dd of=blob bs=1 count=$size <&3 &&
-	read newline <&3 &&
-
-	cat <<EOF &&
-	commit refs/heads/copied
-	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-	data <<COMMIT
-	copy big file as file3
-	COMMIT
-	M 644 inline file3
-	data <<BLOB
-	EOF
-	cat blob &&
-	cat <<EOF
-	BLOB
-	EOF
 	FRONTEND_END
 
 	mkfifo blobs &&
 	(
 		export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL GIT_COMMITTER_DATE &&
-		sh frontend 3<blobs |
-		git fast-import --cat-blob-fd=3 3>blobs
-	) &&
+		cat <<-\EOF &&
+		feature cat-blob
+		blob
+		mark :1
+		data <<BLOB
+		EOF
+		cat big &&
+		cat <<-\EOF &&
+		BLOB
+		cat-blob :1
+		EOF
+
+		read blob_id type size <&3 &&
+		echo "$blob_id $type $size" >response &&
+		head_c $size >blob <&3 &&
+		read newline <&3 &&
+
+		cat <<-EOF &&
+		commit refs/heads/copied
+		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+		data <<COMMIT
+		copy big file as file3
+		COMMIT
+		M 644 inline file3
+		data <<BLOB
+		EOF
+		cat blob &&
+		echo BLOB
+	) 3<blobs |
+	git fast-import --cat-blob-fd=3 3>blobs &&
 	git show copied:file3 >actual &&
 	test_cmp expect.response response &&
 	test_cmp big actual
@@ -1845,7 +1859,7 @@ test_expect_success PIPE 'R: print blob mid-commit' '
 		EOF
 
 		read blob_id type size <&3 &&
-		dd of=actual bs=1 count=$size <&3 &&
+		head_c $size >actual <&3 &&
 		read newline <&3 &&
 
 		echo
@@ -1880,7 +1894,7 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 		echo "cat-blob $to_get" &&
 
 		read blob_id type size <&3 &&
-		dd of=actual bs=1 count=$size <&3 &&
+		head_c $size >actual <&3 &&
 		read newline <&3 &&
 
 		echo deleteall
-- 
1.7.2.4.568.g3733c.dirty
