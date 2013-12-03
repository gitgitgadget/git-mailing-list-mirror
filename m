From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 1/3] gitweb: Move check-ref-format code into separate function
Date: Tue,  3 Dec 2013 15:56:41 +0100
Message-ID: <1386082603-8404-2-git-send-email-krzesimir@endocode.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 15:57:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnrQ5-0006xp-GX
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 15:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab3LCO5l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 09:57:41 -0500
Received: from mail-bk0-f47.google.com ([209.85.214.47]:47797 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab3LCO5i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 09:57:38 -0500
Received: by mail-bk0-f47.google.com with SMTP id mx12so5971089bkb.6
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 06:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=JgD3dK3U8TVZe7IOr7sxqdVUcW88QLCfcOnlqJO979A=;
        b=e64XGpwrXfP/0TS06HV7i/WFtVF/24fj+K8wj7oBs37RufZb4OeB/Dm/dTXYgLUJnN
         7SVRcG/L0RVyrbT6jvohPJUWN0jwx2gDYB5qtxU1+oil/Ht0qq6JIM+jAVxX9v1nrFdR
         gaCVf61Phg//qgDMGtpOJQR66/jxJWVLfrl5AXJSE3sr+uir95R65x+M+tZa1fWa70qu
         phoG8dUr94Nuw8RuIXFTXsMiu/LffEo9ZEeTmZcm6As+kD+9ywocCZBOYdEVWE1sose5
         7KGssysbvh465xxL3hWcI8aZkFjWJIpYBRN9c8T8B31Qlvo3KqflOJENPL6YdS4nS5UM
         zX+w==
X-Gm-Message-State: ALoCoQnGdI1Qm1CBPwQPld6py26sQiD0OwZtdG3JTXqHCzVXjROYfclVdBQXorfLqPcksr9uInL2
X-Received: by 10.204.54.136 with SMTP id q8mr417129bkg.100.1386082657241;
        Tue, 03 Dec 2013 06:57:37 -0800 (PST)
Received: from localhost.localdomain (p5792264C.dip0.t-ipconnect.de. [87.146.38.76])
        by mx.google.com with ESMTPSA id bf8sm30500407bkb.14.2013.12.03.06.57.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2013 06:57:36 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238693>

This check will be used in more than one place later.

Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
---
 gitweb/gitweb.perl | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 68c77f6..f7730d7 100755
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
+	$input =3D check_ref_format($input)
+		or return undef;
 	return $input;
 }
=20
--=20
1.8.3.1
