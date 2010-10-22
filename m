From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] checkout-index -h: show usage even in an invalid
 repository
Date: Fri, 22 Oct 2010 01:44:01 -0500
Message-ID: <20101022064400.GC6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BPw-0003S7-8a
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0JVGrs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:47:48 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35263 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360Ab0JVGrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:47:47 -0400
Received: by gxk23 with SMTP id 23so123848gxk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cS+2GRXOpGFdQod1t5SXF/OWWDE8zQNu76IOoQz4GL4=;
        b=gpgWHPMEwTvmemDZ6EOzxXvh995MEmNGe7Ena48WqBEF1xmexzWVojDNiqVkVotojS
         GLaTRL0hGTuqgA5YTYhOCnaea9UlDgFM6opNW4v+C55BogskPjI9x+M/XtWuz+YfVY3e
         4dfZ9FuVqfMkAWWVL1HSBiE8NJuunVer7v+3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u05H4v7x7fOWkZEKdpsnlGtCnDYSs3xiwGnaLeaW9tKrJJth37RrpgEisD1xwAuNC3
         3BWdOcMl3lcsANTevhqWURP2R6b0qUSC75HhcjAYamrKvTLwnRapGUIs7kD7EHmSrg2Y
         fFI6u96jw4nT69o7uMdOiL3jGhk8GYKeEAgiE=
Received: by 10.100.171.18 with SMTP id t18mr168097ane.191.1287730066722;
        Thu, 21 Oct 2010 23:47:46 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id d8sm3062363ana.22.2010.10.21.23.47.45
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:47:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159652>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

checkout-index loads the index before parsing options.  Erroring out
is counterproductive at that point if the operator is hunting for a
command to recover useful data from the broken repository.

[jn: new commit message, tests]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/checkout-index.c        |    3 +++
 t/t2006-checkout-index-basic.sh |   24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 t/t2006-checkout-index-basic.sh

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a7a5ee1..3bf3422 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -241,6 +241,9 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
 		OPT_END()
 	};
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_checkout_index_usage,
+				   builtin_checkout_index_options);
 	git_config(git_default_config, NULL);
 	state.base_dir =3D "";
 	prefix_length =3D prefix ? strlen(prefix) : 0;
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-b=
asic.sh
new file mode 100755
index 0000000..b855983
--- /dev/null
+++ b/t/t2006-checkout-index-basic.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description=3D'basic checkout-index tests
+'
+
+. ./test-lib.sh
+
+test_expect_success 'checkout-index --gobbledegook' '
+	test_expect_code 129 git checkout-index --gobbledegook 2>err &&
+	grep "[Uu]sage" err
+'
+
+test_expect_success 'checkout-index -h in broken repository' '
+	mkdir broken &&
+	(
+		cd broken &&
+		git init &&
+		>.git/index &&
+		test_expect_code 129 git checkout-index -h >usage 2>&1
+	) &&
+	grep "[Uu]sage" broken/usage
+'
+
+test_done
--=20
1.7.2.3
