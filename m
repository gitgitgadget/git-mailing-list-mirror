From: Liu Yubao <yubao.liu@gmail.com>
Subject: [PATCH 4/5] support reading uncompressed loose object
Date: Tue, 02 Dec 2008 09:56:04 +0800
Message-ID: <493495B4.5070304@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KW0-0005Xj-Cq
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYLBB4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbYLBB4L
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:56:11 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:58018 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYLBB4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:56:11 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1745269tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=fvErzZ3GI75jVgcSUr7OVjoodKz6SDujDw5mtjymukM=;
        b=sYeb0Ynp2P6TnrtyQPLbj0cszXp3oYQNhJ/PNBuU94RwiQKZUs3Yt1CnI48KY+A88C
         ECNrghRis/+CFdUBdm6sHdxWKmbUIT20emBpWiwuPj1ITuQu87rkfODYyI4u31ShgDc9
         alglbrgNYVhlznzzradKePpjgzLMZUfI4aQ3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rbtyA33qhMvxgRJEg5bwZiXlRM55xJYnA1yW9W+H1rBGzzwk/QLleSTrWATlNAjXUt
         8CMNiUGVX8UAhq6QpLPpAfEVlMqLv+7nFbuecrWxOjPZaOKjohA67siXAEmkKmIyrpkC
         gDVuKIMSxV/zb8qFbXLRsgyns4KaZam0Ar/qI=
Received: by 10.110.53.19 with SMTP id b19mr3542047tia.38.1228182969289;
        Mon, 01 Dec 2008 17:56:09 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id a14sm2494764tia.12.2008.12.01.17.56.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 17:56:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7voczws3np.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102099>



Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
---
 sha1_file.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 79062f0..05a9fa3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1985,6 +1985,16 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return error("unable to find %s", sha1_to_hex(sha1));
+
+	/*
+	 * Is it an uncompressed loose objects?
+	 */
+	if ((status = parse_sha1_header(map, mapsize, &size)) >= 0) {
+		if (sizep)
+			*sizep = size;
+		goto L_leave;
+	}
+
 	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error("unable to unpack %s header",
 			       sha1_to_hex(sha1));
@@ -1993,6 +2003,8 @@ static int sha1_loose_object_info(const unsigned char *sha1, unsigned long *size
 	else if (sizep)
 		*sizep = size;
 	inflateEnd(&stream);
+
+L_leave:
 	munmap(map, mapsize);
 	return status;
 }
@@ -2124,7 +2136,13 @@ void *read_object(const unsigned char *sha1, enum object_type *type,
 		return buf;
 	map = map_sha1_file(sha1, &mapsize);
 	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
+		/*
+		 * Is it an uncompressed loose object?
+		 */
+		if ((*type = parse_sha1_header(map, mapsize, size)) >= 0)
+			buf = xmemdupz(map + strlen(map) + 1, *size);
+		else
+			buf = unpack_sha1_file(map, mapsize, type, size, sha1);
 		munmap(map, mapsize);
 		return buf;
 	}
-- 
1.6.1.rc1.5.gde86c
