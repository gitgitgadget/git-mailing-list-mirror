From: Liu Yubao <yubao.liu@gmail.com>
Subject: [PATCH 3/5] optimize parse_sha1_header() a little by detecting object
 type
Date: Tue, 02 Dec 2008 09:55:05 +0800
Message-ID: <49349579.2030506@gmail.com>
References: <493399B7.5000505@gmail.com> <7voczws3np.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 02:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7KV3-0005JD-Ex
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbYLBBzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbYLBBzM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:55:12 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:52994 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbYLBBzL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:55:11 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1745063tic.23
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=eoDalLzkyiyg0+29Wl6y96NRq3iwxA3qhOCPCMNpnLs=;
        b=nSbz+JXiTG1UMC+BfTJYK4rp3hF0waeZwgyCGojtCoed88eS+aCrtiDWWRRwdYyfL9
         7+oycYjUxYw82nfWBMOLf92ydvBEHNTagJHPigGvIL4ceZrlNR8wM2rXUBVGhDJ4pyK4
         3Ym8MX7p9JeEbgmEKdsOOmc7ieeZJY12WE/qE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=xYVQzznl8weFR94iGqhiM2Ar99Ij5G91yavc5TFBt8wIMg2abt93p1rlm+KBF/Vm3w
         K4LtW89mUirNB/fw0AQjV7k6RZHw11oR9X0CTu3FAlV4dOeQtbDGkZ27M2+jFwGCa3X6
         +2qG4ll2TQbqMYOvqKaY1MX2uljqix7HZBU9I=
Received: by 10.110.47.9 with SMTP id u9mr17275949tiu.47.1228182909389;
        Mon, 01 Dec 2008 17:55:09 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id i9sm3001078tid.9.2008.12.01.17.55.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 17:55:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7voczws3np.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102098>



Signed-off-by: Liu Yubao <yubao.liu@gmail.com>
---
 sha1_file.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index dccc455..79062f0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1099,7 +1099,8 @@ static void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 
 		if (!fstat(fd, &st)) {
 			*size = xsize_t(st.st_size);
-			map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
+			if (*size > 0)
+				map = xmmap(NULL, *size, PROT_READ, MAP_PRIVATE, fd, 0);
 		}
 		close(fd);
 	}
@@ -1257,6 +1258,8 @@ static int parse_sha1_header(const char *hdr, unsigned long length, unsigned lon
 	 * terminating '\0' that we add), and is followed by
 	 * a space, at least one byte for size, and a '\0'.
 	 */
+	if ('b' != *hdr && 'c' != *hdr && 't' != *hdr)	/* blob/commit/tag/tree */
+		return -1;
 	i = 0;
 	while (hdr < hdr_end - 2) {
 		char c = *hdr++;
-- 
1.6.1.rc1.5.gde86c
