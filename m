From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Fri, 24 Aug 2012 13:46:18 +0100
Organization: OPDS
Message-ID: <DA390375EB8D4F21ADE618B88F1F0C4C@PhilipOakley>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <20120823092624.GG6963@sigill.intra.peff.net> <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley> <20120823195648.GB15268@sigill.intra.peff.net> <7vd32g3ol6.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <mhagger@alum.mit.edu>, <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 14:45:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4tGo-0003UQ-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 14:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759332Ab2HXMpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 08:45:45 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:20624 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757095Ab2HXMpo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 08:45:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4NAFd2N1BcHIc0/2dsb2JhbABFi0KuHgQBAQJ5gQiCGwUBAQQBCAEBLh4BASEFBgIDBQIBAxUBCyUUAQQaBgcXBgESCAIBAgMBh3YKuTKLCBR+c0ODaWADiBqFQpEnhmaCZIFX
X-IronPort-AV: E=Sophos;i="4.80,304,1344207600"; 
   d="scan'208";a="45487976"
Received: from host-92-28-135-52.as13285.net (HELO PhilipOakley) ([92.28.135.52])
  by out1.ip07ir2.opaltelecom.net with SMTP; 24 Aug 2012 13:45:41 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204207>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, August 24, 2012 5:23 AM
> Jeff King <peff@peff.net> writes:
>
>>> It may be (?) that it is a good time to think about a 'datedepth'
>>> capability to bypass the current counted-depth shallow fetch that 
>>> can
>>> cause so much trouble. With a date limited depth the relevant tags
>>> could also be fetched.
>>
>> I don't have anything against such an idea, but I think it is 
>> orthogonal
>> to the issue being discussed here.
>
> Correct.
>
> The biggest problem with the "shallow" hack is that the deepening
> fetch counts from the tip of the refs at the time of deepening when
> deepening the history (i.e. "clone --depth", followed by number of
> "fetch", followed by "fetch --depth").  If you start from a shallow
> clone of depth 1, repeated fetch to keep up while the history grew
> by 100, you would still have a connected history down to the initial
> cauterization point, and "fetch --depth=200" would give you a
> history that is deeper than your original clone by 100 commits.  But
> if you start from the same shallow clone of depth 1, did not do
> anything while the history grew by 100, and then decide to fetch
> again with "fetch --depth=20", it does not grow.  It just makes
> 20-commit deep history from the updated tip, and leave the commit
> from your original clone dangling.
>
> The problem with "depth" does not have anything to do with how it is
> specified at the UI level.

That is, correct me if I'm wrong, the server currently lacks a 
capability to provide anything other than the counted depth shallow 
response (if available). Hence my comment about needing an additional 
server side capability, though that would need a well thought out set of 
use cases to make it useful.

>                                       The end-user input is used to 
> find out
> at what set of commits the history is cauterized, and once they are
> computed, the "shallow" logic solely works on "is the history before
> these cauterization points, or after, in topological terms." (and it
> has to be that way to make sure we get reproducible results).  Even
> if a new way to specify these cauterization points in terms of date
> is introduced, it does not change anything and does not solve the
> fundamental problem the code has when deepening.

fundamental problem = no server capability other than counted depth.
>
