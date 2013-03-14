From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v3 3/3] git-merge-one-file: revise merge error reporting
Date: Thu, 14 Mar 2013 19:31:39 +0200
Message-ID: <5142097B.1080105@bracey.fi>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi> <1363137142-18606-1-git-send-email-kevin@bracey.fi> <1363137142-18606-3-git-send-email-kevin@bracey.fi> <7vehfj2neh.fsf@alter.siamese.dyndns.org> <51416DD5.2030805@bracey.fi> <7vr4jiyqrj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"David Aguilar <davvid@gmail.com>l Antoine Pelisse" 
	<apelisse@gmail.com>, Ciaran Jessup <ciaranj@gmail.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 18:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGC0k-0007i0-4o
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 18:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948Ab3CNRbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 13:31:47 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:52978 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755902Ab3CNRbq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 13:31:46 -0400
Received: from mail406.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id F0FA2DC37F7
	for <git@vger.kernel.org>; Thu, 14 Mar 2013 18:43:02 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 14 Mar 2013 19:32:35 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 14 Mar 2013 19:32:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
In-Reply-To: <7vr4jiyqrj.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 698339418194809048
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.53121/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrgeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218156>

On 14/03/2013 16:56, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> Maybe the virtual base itself should be different. Maybe it should put
>> a ??????? marker in place of every unique line. So you get:
>>
>> Left   ABCEFGH
>> Right XABCDEFJH  -> Merge result <|X>ABC<|D>EF<G|J>H
>> VBase ?ABC?EF??H
>>
>> That actually feels like it may be the correct answer here.
> Interesting, though the approach has downsides with the diff3
> conflict style, no?
>
Well, yes, but I would assume that we would forcibly select normal diff 
here somehow, if we aren't already. We should be - turning ABCDEFGH vs 
ABCD into ABCD<EFGH|EFGH=> is silly.

This topic has a lot in common with the zdiff3 discussion going on. The 
concern there is about large chunks of similar code appearing on two 
sides, and not being in the base, leading to useless diff3.

This is just the special case of the base being totally empty.

The thought on zdiff3 philosophy was that common additions should be 
treated as resolved, and not appear inside conflict markers. That's 
exactly what we'd be doing.  So, same conflict as above, but this time 
embedded in a larger file, using zdiff3 logic:

Left    aaaaaabaacaaABCEFGHeee
Base    aaaaaaaaaaaaeee             -> zdiff3 
aaada<b|a=f>aacaaABC<|D>EF<G|J>Heee
Right   aaadaafaaaaaABCDEFJHeee

Note that I've chosen to suppress the = marker if the lines surrounding 
the conflict are not in the base. I think that helps highlight the fact 
that we're in a diff2 section. EF<G|=J>H reads like an assertion that 
the base has EFH. Whereas EF<G|J>H avoids that.

So, anyway, commonality with zdiff3 would be good. Even if we can't 
share code, we should at least share the general style of result.

Kevin
