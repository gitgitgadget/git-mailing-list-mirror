From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] xmalloc: include size in the failure message
Date: Fri, 20 Aug 2010 17:09:51 +0200
Message-ID: <1282316991-23320-1-git-send-email-Matthieu.Moy@imag.fr>
References: <7vhbipcpe1.fsf@alter.siamese.dyndns.org>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 20 17:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmTHs-0000pq-UZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 17:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199Ab0HTPNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 11:13:36 -0400
Received: from imag.imag.fr ([129.88.30.1]:49572 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab0HTPNf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 11:13:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o7KF9tqA012894
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Aug 2010 17:09:55 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OmTEB-0006Aq-ED; Fri, 20 Aug 2010 17:09:55 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1OmTEB-00064u-D2; Fri, 20 Aug 2010 17:09:55 +0200
X-Mailer: git-send-email 1.7.2.1.83.ge0227
In-Reply-To: <7vhbipcpe1.fsf@alter.siamese.dyndns.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 20 Aug 2010 17:09:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154049>

Out-of-memory errors can either be actual lack of memory, or bugs (like
code trying to call xmalloc(-1) by mistake). A little more information
may help tracking bugs reported by users.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Out-of-memory errors can either be actual lack of memory, or bugs (like
>> code trying to call xmalloc(-1) by mistake). A little more information
>> may help tracking bugs reported by users.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> This kind of thing may help for cases like
>>
>> Subject: Out of memory error during git push
>> http://thread.gmane.org/gmane.comp.version-control.git/153988
>
> Unless a single allocation try to grab unreasonably amount of memory,
> probably a failure from a specific single failure may not help much.

I don't promise miracle ;-). But at least, the diagnosis allows one to
distinguish small allocations, huge ones, and silly errors like small
negative numbers turned into unreasonably big ones.

>>  		if (!ret)
>> -			die("Out of memory, malloc failed");
>> +			die("Out of memory, malloc failed (tried to allocate %u bytes)", size);
>
> Perhaps use %lu format with cast to ulong?

Will do.

> alloc.c: fix formatting size_t to string
>
> Under NO_C99_FORMAT the format and the argument would not match if size_t
> is not the same size as uint.  As the one in sha1_file.c seems to be done
> in a better way, let's use that one.

Sounds good. Not sure why we don't basically use the %lu version
everywhere though.

 wrapper.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index afb4f6f..fd8ead3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -40,7 +40,8 @@ void *xmalloc(size_t size)
 		if (!ret && !size)
 			ret = malloc(1);
 		if (!ret)
-			die("Out of memory, malloc failed");
+			die("Out of memory, malloc failed (tried to allocate %lu bytes)",
+			    (unsigned long)size);
 	}
 #ifdef XMALLOC_POISON
 	memset(ret, 0xA5, size);
-- 
1.7.2.1.83.ge0227
