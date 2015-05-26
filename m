From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 02/11] upload-pack: only accept capabilities on the first "want" line
Date: Tue, 26 May 2015 15:01:06 -0700
Message-ID: <1432677675-5118-3-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMun-0001v1-90
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbbEZWBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 18:01:32 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32993 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbbEZWBa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:30 -0400
Received: by igbpi8 with SMTP id pi8so71633600igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3wWApfCEpFT7SXlVREWnQYRCl6+ji7mhLUYKz9IShhg=;
        b=VBRdS80H/hhS1tjoM78eFbUo/SKibLEzyjjsSHSXogwM8bLsLc0/4kcH21S3ZUrIvN
         ME2WRnhncwRgjs5sfCPqmVBnopuJL6d0dlwtdxmJA+XtlkOMI3uTo++Y9pFEKAfFfl3G
         RaJjVYXa/+jgqRiIGH0oxHBfya2t6S6dbHMuMLsVr5pSiJxWErlm2xtng3hEeoFvgygD
         kF+wH82EiLg1jbvl4hzMubYrfa2NBLRVVnjkCrAv46j0LnKa0BU02OI7MUK3fRQxPCFL
         CbMOPoUMCIWDyIL11N+DTNr9tjUt5Bw9M+W3XKkdiPxwh7BZ3Tg3trG310elYkd4qtDG
         nS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3wWApfCEpFT7SXlVREWnQYRCl6+ji7mhLUYKz9IShhg=;
        b=cKygp40i8PDA03okbuT1JlSiIQTjZrkGRVc8PHuMOMnbGGxMFLEN5OCFxEj8Wk60h/
         Toq7o2QIsYpbh9mGt7EfUUu+V7kaWESAzB7b3ItY1e8EVtu26qeYyk+rO4rK1yxDuDN0
         MRyE4E7KtfNsyB8oDE78IS/53LyAVbeLPGbhEtBTOhQP/N5GhedJAuY7wh3huaYd5+Cn
         6NfdlVfQb2PVHYSZ/SE4XyaQQrk104JjoAxixIuv2MwMn2wLL1uUu77IEGsh2Y0xujfV
         ZnomeePy88ueLQDJCm2lm/yom8Agfh7PJbHS2/gAU8UnBBX0d+pbQ+nx+h3zBYrqGmsE
         MkQA==
X-Gm-Message-State: ALoCoQl5QtPbGJ2Wz6KtBzJ4bozSvTQESfeV5QI0PnB5Gw160V3knt+CSgBNUFEB3iIPx3rbECP0
X-Received: by 10.107.17.17 with SMTP id z17mr38152247ioi.76.1432677688275;
        Tue, 26 May 2015 15:01:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id g1sm12017531iog.4.2015.05.26.15.01.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269987>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

pack-protocol.txt says so and fetch-pack also follows it even though
upload-pack is a bit lax. Fix it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 upload-pack.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 5449ff7..6734777 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -558,6 +558,7 @@ static void receive_needs(void)
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
 	int depth =3D 0;
 	int has_non_tip =3D 0;
+	int first_want =3D 1;
=20
 	shallow_nr =3D 0;
 	for (;;) {
@@ -596,7 +597,11 @@ static void receive_needs(void)
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
=20
-		parse_features(line + 45);
+		if (first_want) {
+			parse_features(line + 45);
+			first_want =3D 0;
+		} else if (line[45])
+			die("garbage at the end of 'want' line %s", line + 45);
=20
 		o =3D parse_object(sha1_buf);
 		if (!o)
--=20
2.4.1.345.gab207b6.dirty
