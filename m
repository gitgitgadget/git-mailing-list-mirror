From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated submodules
Date: Wed, 14 Sep 2011 20:26:05 +0200
Message-ID: <4E70F1BD.70804@web.de>
References: <20110912195652.GA27850@sigill.intra.peff.net> <7vwrdd5x61.fsf@alter.siamese.dyndns.org> <4E6FB05C.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git-dev@github.com,
	Martin Fick <mfick@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 20:26:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3uA1-0004XN-UY
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 20:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757298Ab1INS0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 14:26:08 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39036 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261Ab1INS0H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 14:26:07 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3330E1AB30064;
	Wed, 14 Sep 2011 20:26:06 +0200 (CEST)
Received: from [79.247.251.231] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1R3u9t-0002UB-00; Wed, 14 Sep 2011 20:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <4E6FB05C.6010202@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18yNOBQV6ElVDxDtnvhR9R+iabaAcazT0GvxgG9
	oPYwdWbPxcPq4icYfsk0eaB2xBa6K/e4S14vxE3IRW86jIa8m3
	kOD/iuQOoLu5uz4B03WA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181372>

Am 13.09.2011 21:34, schrieb Jens Lehmann:
> Am 12.09.2011 22:21, schrieb Junio C Hamano:
>> Jeff King <peff@peff.net> writes:
>>
>>> Instead, this patch structures the code like this:
>>
>> Yup, I agree that's the right way to do the other half of the issue.
> 
> Ack from me too! I tested it on the repo with 3k refs and the time went
> down from 142s to 1s (when applied to 3793ac56b4, as later versions of
> master contain my other half which would skip Peff's code).
> 
> On current master including my other half this takes 0.90s, while running
> with Peff's code on top of 3793ac56b4 it takes .96s. That is 6 hundreds
> of a second (7%) extra for not having to worry if one must run "git fetch
> --recurse-submodules" or not.

Just for the record: Martin Fick was so kind to run Peff's fix (without my
half) on his 100k refs repo that showed this regression. Here are the results
of some test runs:

 1.7.7.rc0.189.gab72a

    10m8.133s  9m7.971s  8m16.600s 13m57.821s
     8m34.974s 8m41.527s


 1.7.7.rc0.189.gab72a  --no-recurse-submodules

    10m43.833s  7m41.283s 8m17.889s  8m4.549s
    8m12.668s  7m59.180s

The fastest runs are 8% apart, which is pretty much the same slowdown as in
the 3k ref repo. Looks like we do have O(n) now :-)
