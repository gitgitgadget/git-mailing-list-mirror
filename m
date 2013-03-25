From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] attr.c: fix pattern{,len} inconsistency in struct match_attr
Date: Mon, 25 Mar 2013 13:05:08 +0700
Message-ID: <1364191510-8900-3-git-send-email-pclouds@gmail.com>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, avila.jn@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 07:06:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK0Xq-00025T-Ex
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 07:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757626Ab3CYGFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 02:05:42 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:50239 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab3CYGFm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 02:05:42 -0400
Received: by mail-pd0-f179.google.com with SMTP id x10so2368217pdj.10
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 23:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=KobD99t9sVQ5K9AwPwVTjhs+D4Qyzrh2zOuKujpRX3w=;
        b=kelib/XKngHJzWXopBSu7yOjqrAY8N6R5mJZ+OBsgc8mSv3VdkRa6CAq/VCjHKVerV
         Jiqi3qiZX1aeRazOJguj+ASRpy1IO56NZxSvpjrP9eH6L8Ltf1tpURT/YwwG4pS27LyS
         O6WA1xb7H0wvrhgz/cL/XNBqT6ev/orgnRvH4F7VN05z4aiFKS4bcrS2KiqGd8Mbcddj
         3/slDYEJi3pXMBLmVpebt1a4q3D4dDJVX73WDbf4VZ7jQghF5iXDaCej/1qmve/z36zX
         jM0m4XZvf5irnQIhC8sa4BdaidvMrgIMeERS6gybQELXv34mNfCDRJRGBPugnY7p2wZm
         WVGQ==
X-Received: by 10.68.225.40 with SMTP id rh8mr15844340pbc.137.1364191541677;
        Sun, 24 Mar 2013 23:05:41 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id 1sm12137375pba.32.2013.03.24.23.05.37
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 23:05:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 25 Mar 2013 13:05:33 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219008>

When parse_exclude_pattern detects EXC_FLAG_MUSTBEDIR, it sets
patternlen _not_ to include the trailing slash and expects the caller
to trim it. Of the two callers, add_exclude() does, parse_attr_line()
does not.

Because of that, after parse_attr_line() returns, we may have pattern
"foo/" but its length is reported 3. Some functions do not care about
patternlen and will see the pattern as "foo/" while others may see it
as "foo". This patch makes patternlen reflect the true length of
pattern.

This is a bandage patch that's required for the next patch to pass the
test suite as that patch will rely on patternlen's correctness. The
true fix comes in the patch after the next one.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 2 ++
 dir.h  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index e2f9377..1818ba5 100644
--- a/attr.c
+++ b/attr.c
@@ -255,6 +255,8 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 				      &res->u.pat.patternlen,
 				      &res->u.pat.flags,
 				      &res->u.pat.nowildcardlen);
+		if (res->u.pat.flags & EXC_FLAG_MUSTBEDIR)
+			res->u.pat.patternlen++;
 		if (res->u.pat.flags & EXC_FLAG_NEGATIVE) {
 			warning(_("Negative patterns are ignored in git attributes\n"
 				  "Use '\\!' for literal leading exclamation."));
diff --git a/dir.h b/dir.h
index c3eb4b5..dc63fc8 100644
--- a/dir.h
+++ b/dir.h
@@ -40,7 +40,7 @@ struct exclude_list {
 		struct exclude_list *el;
=20
 		const char *pattern;
-		int patternlen;
+		int patternlen;	/* must equal strlen(pattern) */
 		int nowildcardlen;
 		const char *base;
 		int baselen;
--=20
1.8.2.82.gc24b958
