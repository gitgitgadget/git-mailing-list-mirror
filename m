From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] read-cache.c: fix index memory allocation
Date: Tue, 25 Oct 2011 20:00:04 +0200
Message-ID: <4EA6F924.6060208@lsrfire.ath.cx>
References: <4EA20C5B.3090808@gmail.com> <vpqfwiknmh3.fsf@bauges.imag.fr> <4EA3D1BB.2010802@gmail.com> <4EA415BD.1040109@lsrfire.ath.cx> <20111023162944.GB28156@sigill.intra.peff.net> <4EA453D3.7080002@lsrfire.ath.cx> <4EA4B8E7.5070106@lsrfire.ath.cx> <7vipne50lz.fsf@alter.siamese.dyndns.org> <4EA5DFB2.3050406@lsrfire.ath.cx> <20111024233427.GA24956@duynguyen-vnpc.dektech.internal> <CACsJy8A7yVk15aAgqDkKTz31rChA7Oj-kS2VT2y2tWS6h01GyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Hsing <tsyj2007@gmail.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 20:00:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIlIU-0004P6-M9
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 20:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990Ab1JYSAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 14:00:16 -0400
Received: from india601.server4you.de ([85.25.151.105]:60281 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab1JYSAP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 14:00:15 -0400
Received: from [192.168.2.104] (p4FFD9607.dip.t-dialin.net [79.253.150.7])
	by india601.server4you.de (Postfix) with ESMTPSA id 89C2A2F806B;
	Tue, 25 Oct 2011 20:00:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CACsJy8A7yVk15aAgqDkKTz31rChA7Oj-kS2VT2y2tWS6h01GyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184228>

Am 25.10.2011 02:01, schrieb Nguyen Thai Ngoc Duy:
> On Tue, Oct 25, 2011 at 10:34 AM, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com> wrote:
>> "git status" is slow. If your changes causes slowdown, it won't likely
>> stand out while other fast commands may show (read_cache() is used in
>> nearly all commands). So I tested using the following patch.
>>
>> The result on linux-2.6 shows about 10-20 us slowdown per each
>> read_cache() call (30-40 us on webkit, ~50k files) I think your patch
>> is good enough :-)
> 
> That was with -O0 by the way. valgrind/massif shows about 200kb memory
> more with your patch on webkit repository (7.497 MB vs 7.285 MB),
> using the same test, so memory overhead is ok too.

We can reduce that a bit -- unless block allocation of index entries
is still done somewhere.

-- >8 --
Subject: [PATCH 2/1] cache.h: put single NUL at end of struct cache_entry

Since in-memory index entries are allocated individually now, the
variable slack at the end meant to provide an eight byte alignment
is not needed anymore.  Have a single NUL instead.  This saves zero
to seven bytes for an entry, depending on its filename length.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 cache.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index ec0e571..bd106b5 100644
--- a/cache.h
+++ b/cache.h
@@ -306,7 +306,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 }
 
 #define flexible_size(STRUCT,len) ((offsetof(struct STRUCT,name) + (len) + 8) & ~7)
-#define cache_entry_size(len) flexible_size(cache_entry,len)
+#define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
 #define ondisk_cache_entry_size(len) flexible_size(ondisk_cache_entry,len)
 #define ondisk_cache_entry_extended_size(len) flexible_size(ondisk_cache_entry_extended,len)
 
-- 
1.7.7
