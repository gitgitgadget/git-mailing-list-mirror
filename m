From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20advice=3A=20extract=20function=20to=20print=20messages=20with=20prefix?=
Date: Fri,  7 Sep 2012 21:05:04 +0200
Message-ID: <1347044705-17268-2-git-send-email-ralf.thielow@gmail.com>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
 <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 07 21:05:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA3rw-0005tW-DE
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 21:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab2IGTFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 15:05:21 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:47512 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2IGTFO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 15:05:14 -0400
Received: by weyx8 with SMTP id x8so1968230wey.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3fejO+7F4NSli3ovIDAIIH6EfkIHx5K77j9f3wgr6oY=;
        b=CkHmQ2+6+DRLQ+K5jUa8HrdToIFBoqcRfIhgHngSCawslDcdTaYoU7hOzAE7rS4oAZ
         4LeIs29+s2ni22u/JzhBV0TMpLTjGX72gOFkIO6LVwPQ8SjhZvxrn+02myKBNSZM2F4T
         IlZDC0TPYjd2WEiI8o4fiAUMenfxdYHiDuAp08JyVolGCwCHYPDmizDv0KAgaWXWibeh
         jR13KUn85RKztErzBmYxMg1aD5UZRYZOT31LbF9nB+n2Fm5koRGfNqTN+lZJs1qZS5JY
         FnZlb9QL0E4Jjhn39kA7dQDSB1cuDRtz9219N8f4ukBn6qNfykxD8lgpL56nQj97hLFt
         M86Q==
Received: by 10.180.24.4 with SMTP id q4mr216722wif.19.1347044713248;
        Fri, 07 Sep 2012 12:05:13 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id cl8sm208337wib.10.2012.09.07.12.05.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2012 12:05:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.176.g3fc0e4c.dirty
In-Reply-To: <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204990>

Extract a function that allows to print messages
with a prefix.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 advice.c | 14 ++++++++++----
 advice.h |  1 +
 2 Dateien ge=C3=A4ndert, 11 Zeilen hinzugef=C3=BCgt(+), 4 Zeilen entfe=
rnt(-)

diff --git a/advice.c b/advice.c
index edfbd4a..e73d53b 100644
--- a/advice.c
+++ b/advice.c
@@ -25,25 +25,31 @@ static struct {
 	{ "detachedhead", &advice_detached_head },
 };
=20
-void advise(const char *advice, ...)
+void print_with_prefix(const char *prefix, const char *msg, ...)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	va_list params;
 	const char *cp, *np;
=20
-	va_start(params, advice);
-	strbuf_vaddf(&buf, advice, params);
+	va_start(params, msg);
+	strbuf_vaddf(&buf, msg, params);
 	va_end(params);
=20
 	for (cp =3D buf.buf; *cp; cp =3D np) {
 		np =3D strchrnul(cp, '\n');
-		fprintf(stderr,	_("hint: %.*s\n"), (int)(np - cp), cp);
+		fprintf(stderr,	 "%s %.*s\n", prefix, (int)(np - cp), cp);
 		if (*np)
 			np++;
 	}
 	strbuf_release(&buf);
 }
=20
+void advise(const char *advice, ...)
+{
+	va_list vl;
+	print_with_prefix(_("hint:"), advice, vl);
+}
+
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k =3D skip_prefix(var, "advice.");
diff --git a/advice.h b/advice.h
index f3cdbbf..328e255 100644
--- a/advice.h
+++ b/advice.h
@@ -14,6 +14,7 @@ extern int advice_implicit_identity;
 extern int advice_detached_head;
=20
 int git_default_advice_config(const char *var, const char *value);
+void print_with_prefix(const char *prefix, const char *msg, ...);
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
--=20
1.7.12.176.g3fc0e4c.dirty
