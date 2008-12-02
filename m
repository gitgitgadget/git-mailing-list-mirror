From: Liu Yubao <yubao.liu@gmail.com>
Subject: [PATCH 2/5] don't die immediately when convert an invalid type name
Date: Tue, 02 Dec 2008 09:53:03 +0800
Message-ID: <493494FF.5030001@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:55:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KU2-00053V-J6
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYLBByJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbYLBByI
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:54:08 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:45974 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbYLBByF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:54:05 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1744819tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=PKVEvtehnhBIIVYvOgzfEGk4Y+aBScvJR3dkL8jG8d0=;
        b=Q/Zi2PigY2tnaMOQEbiMUgTeWT14iuo/8tw828UMWyvSEbDCCSt+HOTCoG/DBMbLtd
         jbQZV1eiyVtev03oRU25kZ9i0RQ4KGVz8K1BnOPI4eiwh8iDQUkKMck6TpL3oQyvVFH1
         Pp1dm9havW6IurZKEF8g79qrwigLpoFlJVvOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=Udb+CyJkr4zT86NFXewQ0h2cQXwkHYL7kw0tsUeDyymA+LuUOQBNC8WL1QMQtpi1yq
         LoVN4WiMP+od5MConzn69HhlEtAWCyGykjpIwo+SJsSiKvq1TUzfMl3MQmkAcct16LSf
         d+xDC8sAfuNgkzgtEpcwvgOB5iOLv+OERb6Lo=
Received: by 10.110.53.19 with SMTP id b19mr3552393tia.37.1228182844070;
        Mon, 01 Dec 2008 17:54:04 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id i9sm2994856tid.9.2008.12.01.17.53.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 17:53:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7voczws3np.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102097>



Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
---
 object.c    |   14 +++++++++++++-
 object.h    |    1 +
 sha1_file.c |    2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 50b6528..0a18db6 100644
--- a/object.c
+++ b/object.c
@@ -33,13 +33,25 @@ const char *typename(unsigned int type)
 	return object_type_strings[type];
 }
 
-int type_from_string(const char *str)
+int type_from_string_gently(const char *str)
 {
 	int i;
 
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
 		if (!strcmp(str, object_type_strings[i]))
 			return i;
+
+	return -1;
+}
+
+int type_from_string(const char *str)
+{
+	int i;
+
+	i = type_from_string_gently(str);
+	if (i > 0)
+		return i;
+
 	die("invalid object type \"%s\"", str);
 }
 
diff --git a/object.h b/object.h
index d962ff1..88baf2b 100644
--- a/object.h
+++ b/object.h
@@ -36,6 +36,7 @@ struct object {
 };
 
 extern const char *typename(unsigned int type);
+extern int type_from_string_gently(const char *str);
 extern int type_from_string(const char *str);
 
 extern unsigned int get_max_object_index(void);
diff --git a/sha1_file.c b/sha1_file.c
index efe6967..dccc455 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1291,7 +1291,7 @@ static int parse_sha1_header(const char *hdr, unsigned long length, unsigned lon
 	/*
 	 * The length must be followed by a zero byte
 	 */
-	return *hdr ? -1 : type_from_string(type);
+	return *hdr ? -1 : type_from_string_gently(type);
 }
 
 static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
-- 
1.6.1.rc1.5.gde86c
