From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH v4] Threaded grep
Date: Tue, 26 Jan 2010 17:30:12 +0100
Message-ID: <4B5F1894.4070509@googlemail.com>
References: <20100125225139.GA3048@fredrik-laptop>  <alpine.LFD.2.00.1001251542100.3574@localhost.localdomain> <4c8ef71001260410l2afd2dbx17b6e216bd9e5d8@mail.gmail.com> <alpine.LFD.2.00.1001260728260.3574@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 17:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZoJC-0003sA-9O
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 17:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab0AZQaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 11:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573Ab0AZQaZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 11:30:25 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:55124 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0AZQaY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 11:30:24 -0500
Received: by fxm20 with SMTP id 20so547935fxm.21
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=lRWAsfA4gNsSJH6wk+mh805zoFEF165ms2ly0gvKnRY=;
        b=i1iqe51M8n9vQj3zVNc1cTqejVYZ6Iteb6VoPkjrlqo02ztEfCxVszXPoL5VziO6V/
         0nKjz66HsA1Dlb7VlpbS7DC3kD7gd+siELjXGd84ZOrFQEHqo2ZTAVayp3884N6waEo7
         tR560XDYWqEOIfiX+G0WaR9nwjBOgtYv2AsPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=A7rnK9Skx9t1l2W/8gb6Sddbo4dEiadvMUMJ8T3b1JHpu16oMXn+z3yDSrX2kLa9uy
         20Tf8ZMJnoRK1gH7tKVbPivHXt23YwRXQXA7gIpGOGIMLVW4bqJxD2vjcPpubnQHWUrg
         FXlVZZUEq+Jjr5U1VfMhTaS1Mx+GRd/hzSaEI=
Received: by 10.223.144.85 with SMTP id y21mr4514434fau.71.1264523420002;
        Tue, 26 Jan 2010 08:30:20 -0800 (PST)
Received: from kallisto.local (p509269B7.dip.t-dialin.net [80.146.105.183])
        by mx.google.com with ESMTPS id 15sm3401069fxm.6.2010.01.26.08.30.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 08:30:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.1) Gecko/20090715 Thunderbird/3.0b3
In-Reply-To: <alpine.LFD.2.00.1001260728260.3574@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138055>

BSD and glibc have an extension to regexec which takes a buffer + length pair
instead of a NUL-terminated string. Since we already have the length
computed this can save us a strlen call.
---

On 26.01.10 16:28, Linus Torvalds wrote:
> so it's sadly internal to regex. It would be nice if there was a 
> non-string interface to regexec (ie a "buffer + length" instead of a 
> NUL-terminated string).

BSD and glibc have an "REG_STARTEND" flag to do that. I made a small
PoC patch to use it if it's available but it didn't give any significant
speedup on my system.



 grep.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index d281a02..60cce46 100644
--- a/grep.c
+++ b/grep.c
@@ -675,8 +675,15 @@ static int look_ahead(struct grep_opt *opt,
 
 		if (p->fixed)
 			hit = !fixmatch(p->pattern, bol, p->ignore_case, &m);
-		else
+		else {
+#ifdef REG_STARTEND
+			m.rm_so = 0;
+			m.rm_eo = *left_p;
+			hit = !regexec(&p->regexp, bol, 1, &m, REG_STARTEND);
+#else
 			hit = !regexec(&p->regexp, bol, 1, &m, 0);
+#endif
+		}
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
 		if (earliest < 0 || m.rm_so < earliest)
--
1.7.0.rc0.12.gc33c3
