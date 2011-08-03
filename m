From: Tay Ray Chuan <rctay89@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20http=2Ec=3A=20fix=20an=20invalid=20free=28=29?=
Date: Wed,  3 Aug 2011 19:54:03 +0800
Message-ID: <1312372443-11508-1-git-send-email-rctay89@gmail.com>
References: <20110802033344.GA17494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, avarab@gmail.com,
	Jeff King <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 03 13:54:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoa1g-0003D3-Om
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 13:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab1HCLyN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 07:54:13 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61000 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab1HCLyK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 07:54:10 -0400
Received: by pzk37 with SMTP id 37so1492774pzk.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bG/TZYm3P8TMnUQtbIs7+vOLd5UmJzcNmRP2zOENIAc=;
        b=aMgzzZg/6+wRPoZIyowtNJ+TFXzfakmWbWbOdEOPyLJCIwr6HFBD7/TBjEq+PrqkBJ
         ZXjPt7hQt556lIX3UfDXmO/ssOSFG6OS5m82t3CYkUJ6XMPjlC+wqoA9T2+QAYeTUQ6E
         yDL7OMV1FpWQSCiDBiAZOkKjCBDVcg7FprFS4=
Received: by 10.142.111.8 with SMTP id j8mr3757012wfc.108.1312372449986;
        Wed, 03 Aug 2011 04:54:09 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id b4sm981437pba.27.2011.08.03.04.54.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 04:54:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <20110802033344.GA17494@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178560>

Remove a free() on the static buffer returned by sha1_file_name().

While we're at it, replace xmalloc() calls on the structs
http_(object|pack)_request with xcalloc() so that pointers in the
structs get initialized to NULL. That way, free()'s are safe - for
example, a free() on the url string member when aborting.

This fixes an invalid free().

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Helped-by: Jeff King peff@peff.net
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index a1ea3db..a59cac4 100644
--- a/http.c
+++ b/http.c
@@ -1121,9 +1121,8 @@ struct http_pack_request *new_http_pack_request(
 	struct strbuf buf =3D STRBUF_INIT;
 	struct http_pack_request *preq;

-	preq =3D xmalloc(sizeof(*preq));
+	preq =3D xcalloc(1, sizeof(*preq));
 	preq->target =3D target;
-	preq->range_header =3D NULL;

 	end_url_with_slash(&buf, base_url);
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
@@ -1215,7 +1214,7 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 	struct curl_slist *range_header =3D NULL;
 	struct http_object_request *freq;

-	freq =3D xmalloc(sizeof(*freq));
+	freq =3D xcalloc(1, sizeof(*freq));
 	hashcpy(freq->sha1, sha1);
 	freq->localfile =3D -1;

@@ -1253,8 +1252,6 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 		goto abort;
 	}

-	memset(&freq->stream, 0, sizeof(freq->stream));
-
 	git_inflate_init(&freq->stream);

 	git_SHA1_Init(&freq->c);
@@ -1329,7 +1326,6 @@ struct http_object_request *new_http_object_reque=
st(const char *base_url,
 	return freq;

 abort:
-	free(filename);
 	free(freq->url);
 	free(freq);
 	return NULL;
--
1.7.6.11.g49037.dirty
