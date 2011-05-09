From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 2/6] grep: Extract compile_regexp_failed() from compile_regexp()
Date: Mon,  9 May 2011 23:52:04 +0200
Message-ID: <1304977928-7142-3-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:53:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYO6-0000Ry-KI
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296Ab1EIVwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 17:52:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62598 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754368Ab1EIVwk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:52:40 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so4231859wya.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=umEK7wMAqcczFBAoK0wQgmHxQ+LfLgJJUgc8G/JOaNY=;
        b=E5uVhwSudUcGM+ADd3bvEZq1qXfBkEsk+IRf+6uvfV5H5DiPwy/eUW+4SBs+TF+/5E
         2yVQO1bu4ZulHYiYm1lW6TvSRGdB1+jWgPjXtBSZqd8LcFMHtiN1qNH47zYgtpDFM3Wq
         bg8NezYuU67sj6x3ere69pYfW3gOrAwYZP9dY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xhj22iKs/S8Vrn+kJzU4wP6TqlEeX29nwiZgkFZfSJa7EskUsQSUXims/EVNWNv1eo
         77RPlZhf9G7EyJzvj1D4jiNoLN6UeIYR6QVESqCut0eT0+2eEbl9mnNuNYJ9QOKHertw
         fIoB6Nsh9E2auQqHW8xvTZXYmURV32LcRfzFk=
Received: by 10.217.7.70 with SMTP id z48mr3180185wes.57.1304977958705;
        Mon, 09 May 2011 14:52:38 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id w12sm4021181wby.7.2011.05.09.14.52.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:52:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173259>

This simplifies compile_regexp() a little and allows re-using error
handling code.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 grep.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/grep.c b/grep.c
index 250462e..870d10c 100644
--- a/grep.c
+++ b/grep.c
@@ -59,6 +59,21 @@ struct grep_opt *grep_opt_dup(const struct grep_opt =
*opt)
 	return ret;
 }
=20
+static NORETURN void compile_regexp_failed(const struct grep_pat *p,
+		const char *error)
+{
+	char where[1024];
+
+	if (p->no)
+		sprintf(where, "In '%s' at %d, ", p->origin, p->no);
+	else if (p->origin)
+		sprintf(where, "%s, ", p->origin);
+	else
+		where[0] =3D 0;
+
+	die("%s'%s': %s", where, p->pattern, error);
+}
+
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	int err;
@@ -73,17 +88,9 @@ static void compile_regexp(struct grep_pat *p, struc=
t grep_opt *opt)
 	err =3D regcomp(&p->regexp, p->pattern, opt->regflags);
 	if (err) {
 		char errbuf[1024];
-		char where[1024];
-		if (p->no)
-			sprintf(where, "In '%s' at %d, ",
-				p->origin, p->no);
-		else if (p->origin)
-			sprintf(where, "%s, ", p->origin);
-		else
-			where[0] =3D 0;
 		regerror(err, &p->regexp, errbuf, 1024);
 		regfree(&p->regexp);
-		die("%s'%s': %s", where, p->pattern, errbuf);
+		compile_regexp_failed(p, errbuf);
 	}
 }
=20
--=20
1.7.3.4
