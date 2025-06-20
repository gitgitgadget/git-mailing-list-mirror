Received: from mail.thalheim.io (mail.thalheim.io [95.217.199.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18EC221576
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.199.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401531; cv=none; b=HnrWQJGY4W5qe49AJvwWY/vNkpFh1HEWQa7HjGHzujxv2Miaf9klkFIk51QSaFJhsGgwFpvGX65TjN/kHoqH6gsRwnub23YAYbRxnnb2b2cfb0LsAgq21w79OcEXz4YuyHyB+Bzb7AdT0t/OOzMaSuHG5NKJkIy6rGbKPuh2A0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401531; c=relaxed/simple;
	bh=0xwq6y0KXBiH2vgNFvuPr3hCdCJMDVC9KwrVOEnsHOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDq0tgubzaeAnB37fWRP1qhsV5HRBYVOZBYJxeS28VW54BY50qJ5SnIPCIj+07CgqiSgXP37zCHBLcRA8cAlnzX5gehwu8VoL77W445huL1Z15ci1/tVesMRKWn3yv6V4gGU4npS0od4doh2zUVJOKP+cidLpAOxtNuWGEyySWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=CdlB2FzZ; arc=none smtp.client-ip=95.217.199.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="CdlB2FzZ"
Received: from localhost (unknown [IPv6:2001:a61:2a2d:e101:8495:ad93:205d:87b2])
	by mail.thalheim.io (Postfix) with ESMTPSA id CEE2C25175E;
	Fri, 20 Jun 2025 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1750401527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7z2R6DEm83X84FjVY2FshvbQ5l/CHPLaQG/RCmT10g=;
	b=CdlB2FzZA+C6mk0xEqekGP/DFQogrZAkXh9LEiZtal6ES6+mEOVmLUeNlUcZuoYcEY/6EK
	eMZkdcByVc+e9gDCkKuY77dqyjAhi8/0RvyNUXe2rq9AcHFrrVSRpgNgnXLukxv7lv9QMg
	LtRehW/Q7Pnadxv6vgCqufmgAYpNf0s=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@higgsboson.tk smtp.mailfrom=joerg@thalheim.io
From: Joerg Thalheim <joerg@thalheim.io>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Aditya Garg <gargaditya08@live.com>,
	=?UTF-8?q?J=C3=B6rg=20Thalheim?= <joerg@thalheim.io>
Subject: [PATCH v2 2/2] imap-send: improve error messages with configuration hints
Date: Fri, 20 Jun 2025 08:38:36 +0200
Message-ID: <20250620063836.252881-3-joerg@thalheim.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620063836.252881-1-joerg@thalheim.io>
References: <8af387d5007b15cce49c924104d0e88522812e42@thalheim.io>
 <20250620063836.252881-1-joerg@thalheim.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jörg Thalheim <joerg@thalheim.io>

Replace basic error messages with more helpful ones that guide users
on how to resolve configuration issues. When imap.host or imap.folder
are missing, provide the exact git config commands needed to fix the
problem, along with examples of typical values.

This uses the advise() API to display hints that can be disabled
by users who don't want them, and error() for the main error message.

Signed-off-by: Jörg Thalheim <joerg@thalheim.io>
---
 imap-send.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 33690cd66a..e4613aa236 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -25,6 +25,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "advice.h"
 #include "config.h"
 #include "credential.h"
 #include "gettext.h"
@@ -1811,7 +1812,9 @@ int cmd_main(int argc, const char **argv)
 
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no IMAP host specified\n");
+			error(_("no IMAP host specified"));
+			advise(_("set the IMAP host with 'git config imap.host <host>'"));
+			advise(_("(e.g., 'git config imap.host imaps://imap.example.com')"));
 			ret = 1;
 			goto out;
 		}
@@ -1831,7 +1834,9 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (!server.folder) {
-		fprintf(stderr, "no IMAP folder specified\n");
+		error(_("no IMAP folder specified"));
+		advise(_("set the target folder with 'git config imap.folder <folder>'"));
+		advise(_("(e.g., 'git config imap.folder Drafts')"));
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0

