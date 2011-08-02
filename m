From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Possibly solved invalid free() in git-remote-http from Git
 1.7.2.1
Date: Tue, 2 Aug 2011 10:51:24 +0800
Message-ID: <20110802105124.000021c3@unknown>
References: <CACBZZX7s+NeH2jLC9Ym65_rMQkgVmfbCAkqZbBFhTiY9U8uP2A@mail.gmail.com>
	<CACBZZX5s8+O8X2mpexudGEsaQRm+tr0CQvqTZjZ700DN297__w@mail.gmail.com>
	<CACBZZX5N0DaSrU6rxW=PTMQ8b6c_sxMFJQHMaZy1L138eFFo6w@mail.gmail.com>
	<20110801180018.GA10636@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 04:51:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo550-0001Yy-LG
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 04:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab1HBCve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 22:51:34 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52927 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab1HBCvd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 22:51:33 -0400
Received: by iyb12 with SMTP id 12so7559451iyb.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 19:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ZxhlMgS1O1Cvq6jyo4uMAalAI2ahW/OeAbUXIG00wKM=;
        b=dFqzaQ+/1/y8HHcZagjhw2vqcniEurgkjcNFvCwlMFNg4BmGzTVQAhNcWhd9IpSaAZ
         Z5z8WVJQ8W8VfJaeuzTkXrKcibewSZ++eLv/BR5Gmu+ON42W4s4qeSrgp7L9d/iOtQU6
         naAeyn+7O94H3Jq6VBtjxfpwBiMZFs30V2zqw=
Received: by 10.231.111.39 with SMTP id q39mr3366639ibp.106.1312253492425;
        Mon, 01 Aug 2011 19:51:32 -0700 (PDT)
Received: from unknown (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id q13sm3756181ibi.26.2011.08.01.19.51.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 19:51:30 -0700 (PDT)
In-Reply-To: <20110801180018.GA10636@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.7.8cvs47 (GTK+ 2.16.6; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178434>

On Mon, 1 Aug 2011 12:00:19 -0600
Jeff King <peff@peff.net> wrote:
> Hmm. The memory management in the function seems weird to me.

How about this?

-->8--
diff --git a/http.c b/http.c
index b2ae8de..4da6293 100644
--- a/http.c
+++ b/http.c
@@ -1116,9 +1116,8 @@ struct http_pack_request *new_http_pack_request(
 	struct strbuf buf = STRBUF_INIT;
 	struct http_pack_request *preq;
 
-	preq = xmalloc(sizeof(*preq));
+	preq = xcalloc(1, sizeof(*preq));
 	preq->target = target;
-	preq->range_header = NULL;
 
 	end_url_with_slash(&buf, base_url);
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
@@ -1210,7 +1209,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	struct curl_slist *range_header = NULL;
 	struct http_object_request *freq;
 
-	freq = xmalloc(sizeof(*freq));
+	freq = xcalloc(1, sizeof(*freq));
 	hashcpy(freq->sha1, sha1);
 	freq->localfile = -1;
 
@@ -1248,8 +1247,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		goto abort;
 	}
 
-	memset(&freq->stream, 0, sizeof(freq->stream));
-
 	git_inflate_init(&freq->stream);
 
 	git_SHA1_Init(&freq->c);
@@ -1324,7 +1321,6 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	return freq;
 
 abort:
-	free(filename);
 	free(freq->url);
 	free(freq);
 	return NULL;


--
Cheers,
Ray Chuan
