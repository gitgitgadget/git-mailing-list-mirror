From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 1/4] http.h: Add debug callback and helper routine for implementing the GIT_TRACE_CURL environment variable in http.c
Date: Tue, 19 Apr 2016 15:10:41 +0000
Message-ID: <20160419151044.27814-2-gitter.spiros@gmail.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de, ramsay@ramsayjones.plus.com, gitster@pobox.com,
	sunshine@sunshineco.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 17:11:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asXIy-0007DB-2B
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 17:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbcDSPLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 11:11:00 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33418 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474AbcDSPK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 11:10:57 -0400
Received: by mail-lf0-f68.google.com with SMTP id p64so3103989lfg.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYjhJN+QiysjGOKpx0AoTj8b5YOGQZlklG29LFCnegU=;
        b=ikvKGNZrfwn4SPFb0ecsrUho2msd0r46oEybeaS31fmEOcMPIb8JFg2C0Jrw51iFYl
         b8isteK1OyeZQ7M9wM/4NNKzBq662JnCZjPv/HwebbfcjQlt3w6VNq4kvseG/EpA3Wzn
         MQ0yAhPyQUvGEW+Nqt+0lktACdpaciYF9LeUR9SaR5DXVk8WSm9dy2fFYfSqxFe7f/xD
         iKGC+s+acB85KHQKzzR2HzKAIjdwIEG+Bn1usaMJTdlwYEeiYrVPwD51N6TlA+5kkiLh
         aN95vDsDcWLwzoQ6YPI/N1fYs/RX8iBd8s7KlTmeNMkNLaJnfp9XCrNUO+zz9FyPwngJ
         6T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYjhJN+QiysjGOKpx0AoTj8b5YOGQZlklG29LFCnegU=;
        b=CQ/d7Q55s0T4Ild7hTA67RCWD9YIM6GbIhhT7biee3Db3F9Vqmhzj+lSkL6wXYm+dM
         WK2TRP7wVIM36NhSVIRWdhhVRkFKSs7RsXlELLI5hUHSkUiR+VwfdS52QqprDVUP12JH
         HinU8Q9tj/TfA7NteSkXezLN0cIPW/dkHXUEMrkxW+9zjnw/9IXnV4Kkh8I2QUlk3xIi
         GKH0dvf1qze22PgJs8UiV7PyvauqnIPehLEcglCDp7CDvxAgtdF71wcjjCXWdSwcZ+Ub
         cqs4DfNWkhWRC3uT4uJHqS7ez1vpLQAIMJEgmq/gm40AgHvCytH4aBgZlIJyFFGqgFYb
         9bVg==
X-Gm-Message-State: AOPr4FUx/KK7d5E4Efa9eOjOz5ZI+N0eLpOKeZbHeB3nPZE0RDd7ABQCTM1NCSSfEaD7Yg==
X-Received: by 10.28.58.77 with SMTP id h74mr25492854wma.82.1461078655175;
        Tue, 19 Apr 2016 08:10:55 -0700 (PDT)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([23.101.69.192])
        by smtp.gmail.com with ESMTPSA id u16sm4846168wmd.5.2016.04.19.08.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 08:10:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.383.g0f2638b
In-Reply-To: <20160419151044.27814-1-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291871>

Add the debug callback and helper routine prototype used by
curl_easy_setopt CURLOPT_DEBUGFUNCTION in http.c
for implementing the GIT_TRACE_CURL environment variable


Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 http.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/http.h b/http.h
index 4ef4bbd..a2d10bc 100644
--- a/http.h
+++ b/http.h
@@ -224,4 +224,10 @@ extern int finish_http_object_request(struct http_=
object_request *freq);
 extern void abort_http_object_request(struct http_object_request *freq=
);
 extern void release_http_object_request(struct http_object_request *fr=
eq);
=20
+/* Debug callback and helper routine for curl_easy_setopt CURLOPT_DEBU=
GFUNCTION */
+static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
+int curl_trace(CURL *handle, curl_infotype type, char *data, size_t si=
ze, void *userp);
+void curl_dump(const char *text, unsigned char *ptr, size_t size, char=
 nohex);
+
+
 #endif /* HTTP_H */
--=20
2.5.0
