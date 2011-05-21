From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] userdiff/perl: catch sub with brace on second line
Date: Sat, 21 May 2011 14:38:26 -0500
Message-ID: <20110521193826.GG10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 21:38:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNs0S-0003aZ-2v
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 21:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803Ab1EUTic convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 15:38:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41862 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591Ab1EUTib convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 15:38:31 -0400
Received: by iwn34 with SMTP id 34so3771021iwn.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MRbpHrIsqyYLn2uuoh5xiprXUwU+YcG6fu/SDjDQd8c=;
        b=KPND1W/kRLkVJVgXHoEVxuFno6XX1SF9vn9ty3hk3vIRRq4hgWEDeRXRimjrjgnGOB
         uAc6FTzSxdFUa8FcE/GZ5dU9u5NtX4guHs7YZq47DjBR8xUcyXdGP8sXDNPBpvAWjVtl
         lr1on1KFeFcrIlHO/ZIgBr3uaWs3DLSy8aOns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Xf5qrYhXLu70VPppKUlRfr8kYDAybXPEps0V6TRyTpbhnVDrrlBj+xJD3dadM2IcO5
         i/3pD1BlINR5Fm52h91cSPvchEVDX8qAi5UGynWCm0rZ1pMAhwuVKUh8h/Wtx2MFYB/P
         1g2CPbSWAwPA5EO6urB80FWX0dAqwhrH2FcIU=
Received: by 10.42.166.65 with SMTP id n1mr6364560icy.329.1306006710627;
        Sat, 21 May 2011 12:38:30 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.sbcglobal.net [69.209.78.180])
        by mx.google.com with ESMTPS id a8sm2078431ibg.14.2011.05.21.12.38.29
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 12:38:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521185314.GA10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174173>

Accept

	sub foo
	{
	}

as an alternative to a more common style that introduces perl
functions with a brace on the first line (and likewise for BEGIN/END
blocks).  The new regex is a little hairy to avoid matching

	# forward declaration
	sub foo;

while continuing to match "sub foo($;@) {" and

	sub foo { # This routine is interesting;
		# in fact, the lines below explain how...

While at it, pay attention to Perl 5.14's "package foo {" syntax as an
alternative to the traditional "package foo;".

Requested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4018-diff-funcname.sh |   25 +++++++++++++++++++++++--
 userdiff.c               |   20 +++++++++++++++++---
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 8a57149..b2fd1a9 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -35,7 +35,11 @@ package Beer;
 use strict;
 use warnings;
 use parent qw(Exporter);
-our @EXPORT_OK =3D qw(round);
+our @EXPORT_OK =3D qw(round finalround);
+
+sub other; # forward declaration
+
+# hello
=20
 sub round {
 	my ($n) =3D @_;
@@ -46,6 +50,12 @@ sub round {
 	print "$n bottles of beer on the wall.\n";
 }
=20
+sub finalround
+{
+	print "Go to the store, buy some more\n";
+	print "99 bottles of beer on the wall.\n");
+}
+
 __END__
=20
 =3Dhead1 NAME
@@ -54,12 +64,13 @@ Beer - subroutine to output fragment of a drinking =
song
=20
 =3Dhead1 SYNOPSIS
=20
-	use Beer qw(round);
+	use Beer qw(round finalround);
=20
 	sub song {
 		for (my $i =3D 99; $i > 0; $i--) {
 			round $i;
 		}
+		finalround;
 	}
=20
 	song;
@@ -67,7 +78,9 @@ Beer - subroutine to output fragment of a drinking so=
ng
 =3Dcut
 EOF
 sed -e '
+	s/hello/goodbye/
 	s/beer\\/beer,\\/
+	s/more\\/more,\\/
 	s/song;/song();/
 ' <Beer.perl >Beer-correct.perl
=20
@@ -121,6 +134,10 @@ test_expect_success 'preset perl pattern' '
 	test_expect_funcname "sub round {\$" perl
 '
=20
+test_expect_success 'perl pattern accepts K&R style brace placement, t=
oo' '
+	test_expect_funcname "sub finalround\$" perl
+'
+
 test_expect_success 'perl pattern is not distracted by sub within POD'=
 '
 	test_expect_funcname "=3Dhead" perl
 '
@@ -129,6 +146,10 @@ test_expect_success 'perl pattern gets full line o=
f POD header' '
 	test_expect_funcname "=3Dhead1 SYNOPSIS\$" perl
 '
=20
+test_expect_success 'perl pattern is not distracted by forward declara=
tion' '
+	test_expect_funcname "package Beer;\$" perl
+'
+
 test_expect_success 'custom pattern' '
 	test_config diff.java.funcname "!static
 !String
diff --git a/userdiff.c b/userdiff.c
index 32ead96..42b86ac 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -60,9 +60,23 @@ PATTERNS("pascal",
 	 "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+"
 	 "|<>|<=3D|>=3D|:=3D|\\.\\."),
 PATTERNS("perl",
-	 "^package .*;\n"
-	 "^sub .* \\{\n"
-	 "^[A-Z]+ \\{\n"	/* BEGIN, END, ... */
+	 "^package .*\n"
+	 "^sub [[:alnum:]_':]+[ \t]*"
+		"(\\([^)]*\\)[ \t]*)?" /* prototype */
+		/*
+		 * Attributes.  A regex can't count nested parentheses,
+		 * so just slurp up whatever we see, taking care not
+		 * to accept lines like "sub foo; # defined elsewhere".
+		 *
+		 * An attribute could contain a semicolon, but at that
+		 * point it seems reasonable enough to give up.
+		 */
+		"(:[^;#]*)?"
+		"(\\{[ \t]*)?" /* brace can come here or on the next line */
+		"(#.*)?$\n" /* comment */
+	 "^[A-Z]+[ \t]*"	/* BEGIN, END, ... */
+		"(\\{[ \t]*)?" /* brace can come here or on the next line */
+		"(#.*)?$\n"
 	 "^=3Dhead[0-9] .*",	/* POD */
 	 /* -- */
 	 "[[:alpha:]_'][[:alnum:]_']*"
--=20
1.7.5.1
