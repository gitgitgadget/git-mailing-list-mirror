From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] config: arbitrary number of matches for --unset and --replace-all
Date: Thu, 14 Nov 2013 21:24:52 +0100
Message-ID: <87zjp6loiz.fsf@linux-k42r.v.cablecom.net>
References: <CAPig+cQZo0R3q=J2BygTfdJ1uuiT1HPDCjTxt8mykxOXM1uf2Q@mail.gmail.com>
	<9bc62ec0072a0513865f39ba287819dd0d9d606d.1384415180.git.tr@thomasrast.ch>
	<20131114083747.GD16327@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jess Hottenstein <jess.hottenstein@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 14 21:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh3Ta-0006sw-D3
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 21:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755960Ab3KNUZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 15:25:08 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:35329 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253Ab3KNUZG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 15:25:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 146814D64C4;
	Thu, 14 Nov 2013 21:25:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 13ESu1ySdKu2; Thu, 14 Nov 2013 21:24:54 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id CAEC94D6414;
	Thu, 14 Nov 2013 21:24:53 +0100 (CET)
In-Reply-To: <20131114083747.GD16327@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Nov 2013 03:37:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237877>

Jeff King <peff@peff.net> writes:

> This code is weird to follow because of the fall-throughs. I do not
> think you have introduced any bugs with your patch, but it seems weird
> to me that we set the offset at the top of the hunk. If we hit the
> conditional in the bottom half, we do actually increment storer.seen,
> but only _after_ having overwritten the value from above (with the same
> value, no less).
>
> But if we do not follow that code path, we may end up here:
>
>> @@ -1272,6 +1275,9 @@ static int store_aux(const char *key, const char *value, void *cb)
>>  			if (strrchr(key, '.') - key == store.baselen &&
>>  			      !strncmp(key, store.key, store.baselen)) {
>>  					store.state = SECTION_SEEN;
>> +					ALLOC_GROW(store.offset,
>> +						   store.seen+1,
>> +						   store.offset_alloc);
>>  					store.offset[store.seen] = cf->do_ftell(cf);
>>  			}
>>  		}
>
> where we overwrite it again, but do not update store.seen. Or we may
> trigger neither, and leave the function with our offset stored, but
> store.seen not incremented.

It's doubly strange that we write in this hunk without any protection
against overflow.  I was too lazy to think about it long enough to come
up with a possible example that triggers this, and instead just put in
the defensive ALLOC_GROW().  But if you can trigger it, it will probably
cause the algorithm to go off the rails because it overwrote store.state
and possibly even store.seen.

-- 
Thomas Rast
tr@thomasrast.ch
