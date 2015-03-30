From: Yi EungJun <semtlenori@gmail.com>
Subject: [PATCH] diff-highlight: Fix broken multibyte string
Date: Tue, 31 Mar 2015 00:55:33 +0900
Message-ID: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yi EungJun <eungjun.yi@navercorp.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 17:56:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycc2X-0004It-F8
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 17:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbbC3Pzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2015 11:55:45 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33988 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbbC3Pzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 11:55:44 -0400
Received: by pdbni2 with SMTP id ni2so179707737pdb.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 08:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=2F65G/nnnrOdZomk74uyCrF3eotqc7L7NAaUh5pxUQQ=;
        b=PeGOw0TkPY3tLrRvF7K+SbbVFvD1v2vnIJ89V2VHn0lVAJaI6M8Yh7YL3ckcNeZ2IQ
         0F35TCyuR1Lgc7PFzyTcMsoSue6lFgMQ9VAXD9mKKbYScc3d03jiyYL8902z2i4c3lAO
         VsSeGrvZuO42fe1DEiLWJXwtK8RzzeZdDSBSuqhIZ8LoVq0z+4WD+FbG8Qq6k44lQr6A
         tsWjA6zvLAFK9YKIEu3gL+olanIBg0rbZrL4vCXnaz3gmPKsbilJxwd0OwguziHQ2YbO
         Q9nltIZKFmFl6uqlnldf51JMudDcaiB4isfmjH8ts5rk9qSi3/9Aiz4YqJbpQjc66UwO
         PKYg==
X-Received: by 10.68.132.194 with SMTP id ow2mr59741641pbb.51.1427730943894;
        Mon, 30 Mar 2015 08:55:43 -0700 (PDT)
Received: from gmail.com ([211.176.168.210])
        by mx.google.com with ESMTPSA id j5sm11096523pdo.60.2015.03.30.08.55.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2015 08:55:43 -0700 (PDT)
X-Google-Original-From: Yi EungJun <eungjun.yi@navercorp.com>
X-Mailer: git-send-email 2.3.2.209.gd67f9d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266456>

=46rom: Yi EungJun <eungjun.yi@navercorp.com>

Highlighted string might be broken if the common subsequence is a prope=
r subset
of a multibyte character. For example, if the old string is "=EC=A7=84"=
 and the new
string is "=EC=A7=80", then we expect the diff is rendered as follows:

	-=EC=A7=84
	+=EC=A7=80

but actually it was rendered as follows:

    -<EC><A7><84>
    +<EC><A7><80>

This fixes the bug by splitting the string by multibyte characters.
---
 contrib/diff-highlight/diff-highlight | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highl=
ight/diff-highlight
index 08c88bb..2662c1a 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -2,6 +2,9 @@
=20
 use warnings FATAL =3D> 'all';
 use strict;
+use File::Basename;
+use File::Spec::Functions qw( catdir );
+use String::Multibyte;
=20
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
@@ -24,6 +27,8 @@ my @removed;
 my @added;
 my $in_hunk;
=20
+my $mbcs =3D get_mbcs();
+
 # Some scripts may not realize that SIGPIPE is being ignored when laun=
ching the
 # pager--for instance scripts written in Python.
 $SIG{PIPE} =3D 'DEFAULT';
@@ -164,8 +169,8 @@ sub highlight_pair {
=20
 sub split_line {
 	local $_ =3D shift;
-	return map { /$COLOR/ ? $_ : (split //) }
-	       split /($COLOR*)/;
+	return map { /$COLOR/ ? $_ : ($mbcs ? $mbcs->strsplit('', $_) : split=
 //) }
+	       split /($COLOR)/;
 }
=20
 sub highlight_line {
@@ -211,3 +216,19 @@ sub is_pair_interesting {
 	       $suffix_a !~ /^$BORING*$/ ||
 	       $suffix_b !~ /^$BORING*$/;
 }
+
+# Returns an instance of String::Multibyte based on the charset define=
d by
+# i18n.commitencoding or UTF-8, or undef if String::Multibyte doesn't =
support
+# the charset.
+sub get_mbcs {
+	my $dir =3D catdir(dirname($INC{'String/Multibyte.pm'}), 'Multibyte')=
;
+	opendir my $dh, $dir or return;
+	my @mbcs_charsets =3D grep s/[.]pm\z//, readdir $dh;
+	close $dh;
+	my $expected_charset =3D `git config i18n.commitencoding` || "UTF-8";
+	$expected_charset =3D~ s/-//g;
+	my @matches =3D grep {/^$expected_charset$/i} @mbcs_charsets;
+	my $charset =3D shift @matches;
+
+	return eval 'String::Multibyte->new($charset)';
+}
--=20
2.3.2.209.gd67f9d5.dirty
