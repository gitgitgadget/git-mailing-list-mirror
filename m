From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/7] completion: add tests for the __gitcomp_nl()
 completion helper function
Date: Sun, 18 Nov 2012 09:53:57 +0100
Message-ID: <CAMP44s1CFPt5ZmDuOEbLnsz5ShSSCO3O7Ws0CkMhjrpnkOMdJw@mail.gmail.com>
References: <1353150353-29874-1-git-send-email-szeder@ira.uka.de>
	<1353150353-29874-4-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 09:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0ds-0004gG-GK
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 09:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428Ab2KRIx6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 03:53:58 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63994 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2KRIx6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 03:53:58 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4013020oag.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 00:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HPAGTzfnLw/QwBuZaR6OmQuco0+gg2KGyGGqFb4iqEY=;
        b=IZH6CKRTCobMaIkXCDUMkHlVKDJfju2dqsvQgQU2pcwT2Jul9rdTERiCpq07do8amB
         gvP5pi0t8gEIol8A3ERs3m4V/n2OxOnI1aCFPsaUzW+ni2V7zvjYnPgoCdI7z3Os5DP5
         GUrZWg+m3gqlco4Vz3O3zX3k0NgieQXaot8DPUavzwdoHmF4mYfRGGOyeNxxoSlkli8i
         wgLfznF4VSoUSdpUpbtefF+KjZ7IU+ctm/pRPhx7UdYAzwduo6PBTKYjMSx4orsuzl8Q
         TsGhr98C+ZXHR7nWoUpPyQXPri+WW/P23kUeLLxmuKBEBkjOKj806IBhYWiH1QLxe47P
         fqGg==
Received: by 10.60.1.163 with SMTP id 3mr7794745oen.30.1353228837718; Sun, 18
 Nov 2012 00:53:57 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 18 Nov 2012 00:53:57 -0800 (PST)
In-Reply-To: <1353150353-29874-4-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209996>

On Sat, Nov 17, 2012 at 12:05 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> Test __gitcomp_nl()'s basic functionality, i.e. that trailing space,
> prefix, and suffix are added correctly.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  t/t9902-completion.sh | 84 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 84 insertions(+)

Too much code that can be simplified:

--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -85,6 +85,22 @@ test_gitcomp ()
 	test_cmp expected out
 }

+# Test __gitcomp_nl
+# Arguments are:
+# 1: typed text so far (cur)
+# -: the rest are passed to __gitcomp_nl
+test_gitcomp_nl ()
+{
+	local -a COMPREPLY &&
+	sed -e 's/Z$//' > expected &&
+	cur=3D"$1" &&
+	shift &&
+	__gitcomp_nl "$@" &&
+	print_comp &&
+	cp expected out /tmp
+	test_cmp expected out
+}
+
 invalid_variable_name=3D"${foo.bar}"

 test_expect_success '__gitcomp - trailing space - options' '
@@ -134,88 +150,39 @@ test_expect_success '__gitcomp - doesnt fail
because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '

+read -r -d "" refs <<-\EOF
+maint
+master
+next
+pu
+EOF
+
 test_expect_success '__gitcomp_nl - trailing space' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp_nl "m" "$refs" <<-EOF
 	maint Z
 	master Z
 	EOF
-	(
-		declare -a COMPREPLY &&
-		refs=3D"$(cat <<-\EOF
-			maint
-			master
-			next
-			pu
-			EOF
-		)" &&
-		cur=3D"m" &&
-		__gitcomp_nl "$refs" &&
-		print_comp
-	) &&
-	test_cmp expected out
 '

 test_expect_success '__gitcomp_nl - prefix' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp_nl "--fixup=3Dm" "$refs" "--fixup=3D" "m" <<-EOF
 	--fixup=3Dmaint Z
 	--fixup=3Dmaster Z
 	EOF
-	(
-		declare -a COMPREPLY &&
-		refs=3D"$(cat <<-\EOF
-			maint
-			master
-			next
-			pu
-			EOF
-		)" &&
-		cur=3D"--fixup=3Dm" &&
-		__gitcomp_nl "$refs" "--fixup=3D" "m" &&
-		print_comp
-	) &&
-	test_cmp expected out
 '

 test_expect_success '__gitcomp_nl - suffix' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp_nl "branch.ma" "$refs" "branch." "ma" "." <<-\EOF
 	branch.maint.Z
 	branch.master.Z
 	EOF
-	(
-		declare -a COMPREPLY &&
-		refs=3D"$(cat <<-\EOF
-			maint
-			master
-			next
-			pu
-			EOF
-		)" &&
-		cur=3D"branch.ma" &&
-		__gitcomp_nl "$refs" "branch." "ma" "." &&
-		print_comp
-	) &&
-	test_cmp expected out
 '

 test_expect_success '__gitcomp_nl - no suffix' '
-	sed -e "s/Z$//" >expected <<-\EOF &&
+	test_gitcomp_nl "ma" "$refs" "" "ma" "" <<-\EOF
 	maintZ
 	masterZ
 	EOF
-	(
-		declare -a COMPREPLY &&
-		refs=3D"$(cat <<-\EOF
-			maint
-			master
-			next
-			pu
-			EOF
-		)" &&
-		cur=3D"ma" &&
-		__gitcomp_nl "$refs" "" "ma" "" &&
-		print_comp
-	) &&
-	test_cmp expected out
 '

 test_expect_success '__gitcomp_nl - doesnt fail because of invalid
variable name' '

Cheers.

--=20
=46elipe Contreras
