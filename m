From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 2/5] gitweb: Move check-ref-format code into separate function
Date: Wed,  4 Dec 2013 14:43:00 +0100
Message-ID: <1386164583-14109-3-git-send-email-krzesimir@endocode.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 14:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoCjx-0007Bq-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 14:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463Ab3LDNnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 08:43:35 -0500
Received: from mail-ee0-f53.google.com ([74.125.83.53]:37516 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454Ab3LDNnd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 08:43:33 -0500
Received: by mail-ee0-f53.google.com with SMTP id b57so2402965eek.12
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 05:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KFLAkUQuyEq17f5f9RMCxyqM9CrMNJQo1wy+eHDv/sc=;
        b=VykGgG5p9D3r+7gDIhtAY7MTHa5304SNs/i228sIZt+w04Ik9oaf5ht2BGyUEnirVy
         t2gVWdIxKmEA+K/TJAzQwb/xWQE2DIuXfuuZK6kPQauD2kBKTJHEBIFketchUCwBQxKJ
         MSphIMAp4RKWx59h8a4Ga7UqCTD6e01wLrhGG7fyENZ5Bc9Ll9xXAtj4ujbAYgt3/8mg
         mLnP4XdOc7Ne9ceExpbt7XFiS1axUDzNKDFiJ2TYHt0OuWkYlqEY7lH7m6znurQtx8z+
         GHvZNFTpykkWQ6c4EV84v4toaAOop/KwnMTsCadK3QoH4or4YIMo4K0XKLvd49dS15l+
         lt2A==
X-Gm-Message-State: ALoCoQnqf9HdzR5erJcgM5vRXvGXWFfayajJgVtbH0EddD1gBsfr2TREAjHphxF1t3L9fai24imA
X-Received: by 10.15.77.134 with SMTP id p6mr51480453eey.0.1386164611948;
        Wed, 04 Dec 2013 05:43:31 -0800 (PST)
Received: from localhost.home (95-91-240-208-dynip.superkabel.de. [95.91.240.208])
        by mx.google.com with ESMTPSA id z42sm22327433eeo.17.2013.12.04.05.43.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2013 05:43:31 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238779>

This check will be used in more than one place later.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ee61f9e..67415b9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1452,6 +1452,16 @@ sub validate_pathname {
 	return $input;
 }
=20
+sub check_ref_format {
+	my $input =3D shift || return undef;
+
+	# restrictions on ref name according to git-check-ref-format
+	if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
+		return undef;
+	}
+	return $input;
+}
+
 sub validate_refname {
 	my $input =3D shift || return undef;
=20
@@ -1462,10 +1472,9 @@ sub validate_refname {
 	# it must be correct pathname
 	$input =3D validate_pathname($input)
 		or return undef;
-	# restrictions on ref name according to git-check-ref-format
-	if ($input =3D~ m!(/\.|\.\.|[\000-\040\177 ~^:?*\[]|/$)!) {
-		return undef;
-	}
+	# check git-check-ref-format restrictions
+	check_ref_format($input)
+		or return undef;
 	return $input;
 }
=20
--=20
1.8.3.1
