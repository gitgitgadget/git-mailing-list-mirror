From: Illia Bobyr <Illia.Bobyr@ronin-capital.com>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Thu, 14 Jul 2011 11:26:11 -0500
Message-ID: <4E1F18A3.5070605@ronin-capital.com>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <7vliw4d1hu.fsf@alter.siamese.dyndns.org>
 <20110711220107.GC30155@sigill.intra.peff.net>
 <7vk4bo9ze5.fsf@alter.siamese.dyndns.org>
 <20110712000304.GA32276@sigill.intra.peff.net>
 <20110712193844.GA17322@toss.lan>
 <20110712194540.GA21180@sigill.intra.peff.net>
 <20110712210716.GB17322@toss.lan>
 <20110712213607.GA12447@sigill.intra.peff.net>
 <20110714080453.GA6690@toss.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jul 14 18:26:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhOkN-0002i7-Ay
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 18:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab1GNQ0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 12:26:38 -0400
Received: from spam01.roncap.com ([64.95.232.121]:43246 "EHLO
	spam01.roncap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab1GNQ0h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2011 12:26:37 -0400
X-ASG-Debug-ID: 1310660795-4742e19c0001-QuoKaX
Received: from psys-sltc-exhc2.ronin.roncap.com ([10.106.240.22]) by spam01.roncap.com with ESMTP id alY70izSLPu2Kddh (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO); Thu, 14 Jul 2011 11:26:35 -0500 (CDT)
X-Barracuda-Envelope-From: Illia.Bobyr@ronin-capital.com
Received: from psys-cltc-excl1.ronin.roncap.com ([fe80::6131:9de3:c24c:5b2d])
 by psys-sltc-exhc2.ronin.roncap.com ([::1]) with mapi; Thu, 14 Jul 2011
 11:26:14 -0500
X-ASG-Orig-Subj: Re: [PATCH 2/5] add object-cache infrastructure
Thread-Topic: [PATCH 2/5] add object-cache infrastructure
Thread-Index: AcxCQr93g4/AUUTGTAWbXuJzQkja0Q==
In-Reply-To: <20110714080453.GA6690@toss.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 5.1; rv:5.0) Gecko/20110624
 Thunderbird/5.0
acceptlanguage: en-US
X-Barracuda-Connect: UNKNOWN[10.106.240.22]
X-Barracuda-Start-Time: 1310660795
X-Barracuda-Encrypted: AES128-SHA
X-Barracuda-URL: http://spam01.roncap.com:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at roncap.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177133>

On 7/14/2011 3:04 AM, Clemens Buchacher wrote:
> On Tue, Jul 12, 2011 at 05:36:07PM -0400, Jeff King wrote:
>> In the normal case of applying patch B on top of patch A, it doesn't
>> matter if we use per-hunk patch-ids or normal patch-ids. Because even if
>> we decide to actually go through with the merge of B on top of A, any
>> hunks that _would have_ had their per-hunk patch-ids match will merge
>> cleanly.
>>
>> But in the real world, it is about applying patch Z on top of patches
>> A..Y, where Z has similar hunks to patch N. And then it _does_ make a
>> difference, because it is about skipping hunks from Z that are already
>> in N, but will end up applied on top of Y. And what's in Y and what's in
>> N may be quite different.
>>
>> Does that sound right?
> Yes, exactly.
>
> And one possible solution would be to drop all hunks from Z which
> are already somewhere in A..Y. But that undermines the whole
> changeset idea.
>
> If we detect the similarities between Z and N, then we could rebase
> Z to N, make the user resolve any conflicts, which should make more
> sense than what we would have between Z and Y. Then we have Z' on
> top of N:
>
>    Z      Z'     Z"
>   /      /      /
> A--..--N--..--Y
>
> Subsequently we rebase Z' to Y, at which point only changes remain
> that we disagreed with. For those we may have to do conflict
> resolution again. So, in some cases this approach could result in
> more work.

This is where rerere helps, AFAIU.
And if the conflict is non-trivial there is a chance that it is really 
something you would like to take a look at.