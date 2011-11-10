From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] parse-options: add OPT_ULONG
Date: Thu, 10 Nov 2011 14:12:32 +0700
Message-ID: <1320909155-4575-3-git-send-email-pclouds@gmail.com>
References: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROOo0-0003mf-Hc
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399Ab1KJHMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 02:12:07 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52849 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab1KJHMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:12:06 -0500
Received: by mail-gx0-f174.google.com with SMTP id b2so2626980ggn.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 23:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LTuhtMK9V49mTCbxjIXP2ssZWK+lydzi0DibA3PWKR8=;
        b=J4lqeCpBABO4JbCnuSsCJMjtTwLn/8C4VXo0leLN18Z8t/JS26QG8QVyg1/yjqfAE6
         742TGHU5Snmy9HQfcRJqKNuFS/NsyVrsgBuGYcIT3Wo4F8Wz89m8wxuTqKa8bT1s+gYh
         E63pE67fSXqfsKZpU+LsUbwvbjfhj8X7H2mt4=
Received: by 10.68.24.231 with SMTP id x7mr12041848pbf.33.1320909125815;
        Wed, 09 Nov 2011 23:12:05 -0800 (PST)
Received: from tre ([115.73.226.96])
        by mx.google.com with ESMTPS id p10sm19256280pbd.15.2011.11.09.23.12.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 23:12:04 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 10 Nov 2011 14:12:49 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185192>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c |   15 +++++++++++++++
 parse-options.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index f0098eb..58bb83d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -144,6 +144,21 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return opterror(opt, "expects a numerical value", flags);
 		return 0;
=20
+	case OPTION_ULONG:
+		if (unset) {
+			*(unsigned long *)opt->value =3D 0;
+			return 0;
+		}
+		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
+			*(unsigned long *)opt->value =3D opt->defval;
+			return 0;
+		}
+		if (get_arg(p, opt, flags, &arg))
+			return -1;
+		if (!git_parse_ulong(arg, (unsigned long *)opt->value))
+			return opterror(opt, "expects a numerical value", flags);
+		return 0;
+
 	default:
 		die("should not happen, someone must be hit on the forehead");
 	}
diff --git a/parse-options.h b/parse-options.h
index 2e811dc..12294d7 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -16,6 +16,7 @@ enum parse_opt_type {
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
+	OPTION_ULONG,
 	OPTION_CALLBACK,
 	OPTION_LOWLEVEL_CALLBACK,
 	OPTION_FILENAME
@@ -133,6 +134,7 @@ struct option {
 #define OPT_SET_PTR(s, l, v, h, p)  { OPTION_SET_PTR, (s), (l), (v), N=
ULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "=
n", (h) }
+#define OPT_ULONG(s, l, v, h)       { OPTION_ULONG, (s), (l), (v), "n"=
, (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (=
a), (h) }
 #define OPT_STRING_LIST(s, l, v, a, h) \
 				    { OPTION_CALLBACK, (s), (l), (v), (a), \
--=20
1.7.4.74.g639db
