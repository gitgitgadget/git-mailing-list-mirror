From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] userdiff/perl: anchor "sub" and "package" patterns on
 the left
Date: Sat, 21 May 2011 14:29:01 -0500
Message-ID: <20110521192901.GE10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 21:29:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrrM-0008LY-Iw
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 21:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab1EUT3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 15:29:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58023 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab1EUT3F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 15:29:05 -0400
Received: by iyb14 with SMTP id 14so3672503iyb.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gskHK1VLcUsngRGVysnsq5oM/NSy30rJMQrd5SZn37I=;
        b=DJ2BzFnTdcpvWN9frwKX46UeVCzDAVtu5aY19WJLr4n6pteGxYzNXL+bc85r0+rp+q
         R1Z/c2IkmB9B2U3Qsq6kN7XAYxcxBjLkTTey/bL1rOqWrAFcpzYJ7NR8hZcunoVopfUY
         3uOFzMnUi3VAFr6htnufKZF1+U+mmiCnNrz9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kujib/hiQDKSsojzanLOZB22FiBISgNgv28oFemr9U3c/NEYTK72046TzmAPUzGFNU
         mH1JqaZD6nwRBvPzuoOl41KQ9D3Xx4e5tmymoDCRXo1EiiKAKF40Fr+4cfOt7bmGQzOv
         HA+ZSA/15vIFg8xvqHIyUVuR55IKdBa6CiVqw=
Received: by 10.42.123.15 with SMTP id p15mr6327582icr.93.1306006145293;
        Sat, 21 May 2011 12:29:05 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.ameritech.net [69.209.78.180])
        by mx.google.com with ESMTPS id c1sm2076404ibe.0.2011.05.21.12.29.03
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 12:29:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521185314.GA10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174171>

The userdiff funcname mechanism has no concept of nested scopes ---
instead, "git diff" and "git grep --show-function" simply label the
diff header with the most recent matching line.  Unfortunately that
means text following a subroutine in a POD section:

	=3Dhead1 DESCRIPTION

	You might use this facility like so:

		sub example {
			foo;
		}

	Now, having said that, let's say more about the facility.
	Blah blah blah ... etc etc.

gets the subroutine name instead of the POD header in its diff/grep
funcname header, making it harder to get oriented when reading a
diff without enough context.

The fix is simple: anchor the funcname syntax to the left margin so
nested subroutines and packages like this won't get picked up.  (The
builtin C++ funcname pattern already does the same thing.)  This means
the userdiff driver will misparse the idiom

	{
		my $static;
		sub foo {
			... use $static ...
		}
	}

but I think that's worth it; we can revisit this later if the userdiff
mechanism learns to keep track of the beginning and end of nested
scopes.

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4018-diff-funcname.sh |   59 ++++++++++++++++++++++++++++++++++++++=
+++++--
 userdiff.c               |    4 +-
 2 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index ad74c60..f071a8f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -29,6 +29,47 @@ public class Beer
 }
 EOF
 sed 's/beer\\/beer,\\/' <Beer.java >Beer-correct.java
+cat >Beer.perl <<\EOF
+package Beer;
+
+use strict;
+use warnings;
+use parent qw(Exporter);
+our @EXPORT_OK =3D qw(round);
+
+sub round {
+	my ($n) =3D @_;
+	print "$n bottles of beer on the wall ";
+	print "$n bottles of beer\n";
+	print "Take one down, pass it around, ";
+	$n =3D $n - 1;
+	print "$n bottles of beer on the wall.\n";
+}
+
+__END__
+
+=3Dhead1 NAME
+
+Beer - subroutine to output fragment of a drinking song
+
+=3Dhead1 SYNOPSIS
+
+	use Beer qw(round);
+
+	sub song {
+		for (my $i =3D 99; $i > 0; $i--) {
+			round $i;
+		}
+	}
+
+	song;
+
+=3Dcut
+EOF
+sed -e '
+	s/beer\\/beer,\\/
+	s/song;/song();/
+' <Beer.perl >Beer-correct.perl
=20
 test_config () {
 	git config "$1" "$2" &&
@@ -36,8 +77,9 @@ test_config () {
 }
=20
 test_expect_funcname () {
-	test_expect_code 1 git diff --no-index \
-		Beer.java Beer-correct.java >diff &&
+	lang=3D${2-java}
+	test_expect_code 1 git diff --no-index -U1 \
+		"Beer.$lang" "Beer-correct.$lang" >diff &&
 	grep "^@@.*@@ $1" diff
 }
=20
@@ -65,13 +107,24 @@ test_expect_success 'default behaviour' '
 '
=20
 test_expect_success 'set up .gitattributes declaring drivers to test' =
'
-	echo "*.java diff=3Djava" >.gitattributes
+	cat >.gitattributes <<-\EOF
+	*.java diff=3Djava
+	*.perl diff=3Dperl
+	EOF
 '
=20
 test_expect_success 'preset java pattern' '
 	test_expect_funcname "public static void main("
 '
=20
+test_expect_success 'preset perl pattern' '
+	test_expect_funcname "sub round {\$" perl
+'
+
+test_expect_success 'perl pattern is not distracted by sub within POD'=
 '
+	test_expect_funcname "=3Dhead" perl
+'
+
 test_expect_success 'custom pattern' '
 	test_config diff.java.funcname "!static
 !String
diff --git a/userdiff.c b/userdiff.c
index 1ff4797..2cca0af 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -60,8 +60,8 @@ PATTERNS("pascal",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
 	 "|<>|<=3D|>=3D|:=3D|\\.\\."),
 PATTERNS("perl",
-	 "^[ \t]*package .*;\n"
-	 "^[ \t]*sub .* \\{\n"
+	 "^package .*;\n"
+	 "^sub .* \\{\n"
 	 "^[A-Z]+ \\{\n"	/* BEGIN, END, ... */
 	 "^=3Dhead[0-9] ",	/* POD */
 	 /* -- */
--=20
1.7.5.1
