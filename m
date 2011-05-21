From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] userdiff/perl: match full line of POD headers
Date: Sat, 21 May 2011 14:35:51 -0500
Message-ID: <20110521193551.GF10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 21:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrxy-0002aa-Jc
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 21:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab1EUTf5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 15:35:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49688 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab1EUTf4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 15:35:56 -0400
Received: by iyb14 with SMTP id 14so3674754iyb.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 12:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HM6MaMaJBQENo2gWgk/E5/Mj2vo4nkxKsTSLPQtEvQg=;
        b=lxbqfH7nfR9U1hI0qLlPU8s6o2AlMSJvMJ0xSXXS87hFKOQBAK8vPI3XKPX4cnqdeB
         91CZXUdsg6OMWAtvqEPBQwHAJzKssFyilsT0v09OIBCCnNFxtSCZr6oebIGCavezyJ97
         hmxeynAZtd8sZX3eiDmW85dSGc3Vwbi2HtsAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=U+VYT/D1fwWa/N4NOGhDOiBOA51UHpF7l+AzKpkVqI2glAPnB0roNIpwzGQhTmCnVL
         MSQfmIRSU27gGZl2N1Avb1EOOxh8F4LUqRJ22zyPBZBaU9wcPP2k0LoOP9lO/MrFEaQa
         l8bNkjW5kurRbeuLmfFPaF+hLadskqWZZfe9U=
Received: by 10.42.135.194 with SMTP id q2mr6542981ict.63.1306006555877;
        Sat, 21 May 2011 12:35:55 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.ameritech.net [69.209.78.180])
        by mx.google.com with ESMTPS id d9sm2073967ibb.53.2011.05.21.12.35.54
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 12:35:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521185314.GA10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174172>

The builtin perl userdiff driver is not greedy enough about catching
POD header lines.  Capture the whole line, so instead of just
declaring that we are in some "@@ =3Dhead1" section, diff/grep output
can explain that the enclosing section is about "@@ =3Dhead1 OPTIONS".

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4018-diff-funcname.sh |    4 ++++
 userdiff.c               |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index f071a8f..8a57149 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -125,6 +125,10 @@ test_expect_success 'perl pattern is not distracte=
d by sub within POD' '
 	test_expect_funcname "=3Dhead" perl
 '
=20
+test_expect_success 'perl pattern gets full line of POD header' '
+	test_expect_funcname "=3Dhead1 SYNOPSIS\$" perl
+'
+
 test_expect_success 'custom pattern' '
 	test_config diff.java.funcname "!static
 !String
diff --git a/userdiff.c b/userdiff.c
index 2cca0af..32ead96 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -63,7 +63,7 @@ PATTERNS("perl",
 	 "^package .*;\n"
 	 "^sub .* \\{\n"
 	 "^[A-Z]+ \\{\n"	/* BEGIN, END, ... */
-	 "^=3Dhead[0-9] ",	/* POD */
+	 "^=3Dhead[0-9] .*",	/* POD */
 	 /* -- */
 	 "[[:alpha:]_'][[:alnum:]_']*"
 	 "|0[xb]?[0-9a-fA-F_]*"
--=20
1.7.5.1
