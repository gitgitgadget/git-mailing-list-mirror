From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Fri, 4 Sep 2009 21:29:56 +0800
Message-ID: <20090904212956.f02b0c60.rctay89@gmail.com>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
 <0016e6470f36315b8a0472bc75a8@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 15:29:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjYrT-0007Pp-Bj
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 15:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZIDN3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbZIDN3p
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 09:29:45 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:50138 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbZIDN3o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 09:29:44 -0400
Received: by fxm17 with SMTP id 17so669902fxm.37
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=U3C6yAflIpCahYwv+Mqim3mg5zkEH+qlvvr3Xsvx4uo=;
        b=CrISQkPXOXoJUqDd7fuc6/vB+0t0u5XgKDPBLpT/N2azxUO5W1Au/kcu2WwLq7SlZN
         ViAses4kqhKq8JCyvBmy1qkVkOS2Qiq18Cpt9z9U7pK+8r081KlY+6iZZJGBcrBLX0d0
         7NGiXFBvcaI2N0xX2l+/VYpNN/2MgcYllLLx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=AbX/qbniOj2NU9Bxwd6wZRVTv6gPtmi4crMsp13nDcyjOpR1Qsv52hAVnOZllKk0xK
         Sk+SsRJYf+AsGUcpq4EVlLimjnW4d6gVQ/aHqSnFPFeYKHvYdfla0nUNxgSKj+8uesng
         zX5hm76XbDOZeR6fLIXRusOQ0ndRWpFO/Hj+c=
Received: by 10.103.126.12 with SMTP id d12mr4720582mun.40.1252070985643;
        Fri, 04 Sep 2009 06:29:45 -0700 (PDT)
Received: from your-cukc5e3z5n (cm99.zeta152.maxonline.com.sg [116.87.152.99])
        by mx.google.com with ESMTPS id s11sm206030mue.13.2009.09.04.06.29.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 06:29:44 -0700 (PDT)
In-Reply-To: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127733>

Hi,

On Fri, Sep 4, 2009 at 6:25 PM, Junio C Hamano<gitster@pobox.com> wrote:
> codesite-noreply@google.com writes:
>
>> Status: New
>> Owner: ----
>>
>> New issue 323 by bjelli: Can't clone over http
>> http://code.google.com/p/msysgit/issues/detail?id=323

Junio, thanks for bringing this issue to the list's and my attention.

> This does not seem to be an msysgit issue.  Even on a Linux host, v1.6.2.5
> seems to work Ok but 'maint', 'master', nor 'next' does not clone this one
> correctly.

Releases including and after v1.6.4 will have this issue:

>> error: Unable to verify pack 382c25c935b744e909c749532578112d72a4aff9 is
>> available
>> error: Unable to find 0a41ac04d56ccc96491989dc71d9875cd804fc6b under
>> http://github.com/tekkub/addontemplate.git

The issue at hand is due to git checking the http repository for the
pack file before commencing the transfer; failing which, the transfer
aborts.

Right now, git chokes on the 500 error that github.com gives it, which
shouldn't be the case, even though that's a weird response.

--
Cheers,
Ray Chuan

-- >8 --
Subject: [PATCH] http.c: clarify missing-pack-check

Abort the pack transfer only if the pack is not available in the HTTP-
served repository; otherwise, allow the transfer to continue, even if
the check failed.

This addresses an issue raised by bjelli:

  http://code.google.com/p/msysgit/issues/detail?id=323

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 5926c5b..cba7e9a 100644
--- a/http.c
+++ b/http.c
@@ -864,6 +864,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
 static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 {
 	int ret = 0;
+	int result;
 	char *hex = xstrdup(sha1_to_hex(sha1));
 	char *filename;
 	char *url;
@@ -874,11 +875,14 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
 	strbuf_addf(&buf, "objects/pack/pack-%s.pack", hex);
 	url = strbuf_detach(&buf, 0);

-	if (http_get_strbuf(url, NULL, 0)) {
-		ret = error("Unable to verify pack %s is available",
+	result = http_get_strbuf(url, NULL, 0);
+	if (result == HTTP_MISSING_TARGET) {
+		ret = error("Unable to find pack %s",
 			    hex);
 		goto cleanup;
-	}
+	} else if (result && http_is_verbose)
+		fprintf(stderr, "Unable to verify pack %s is available\n",
+			hex);

 	if (has_pack_index(sha1)) {
 		ret = 0;
--
1.6.4.2
