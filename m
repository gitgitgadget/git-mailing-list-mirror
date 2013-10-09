From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bisect needing to be at repo top-level?
Date: Wed, 09 Oct 2013 21:01:14 +0200
Message-ID: <5255A7FA.8090504@googlemail.com>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com> <xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com> <20130917175813.GA14173@blizzard> <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com> <5255A02E.3050405@googlemail.com> <20131009185459.GA2823@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <git@cryptocrack.de>,
	"Burton, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 21:01:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTz0S-0001cv-7O
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 21:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548Ab3JITBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 15:01:06 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:41477 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab3JITBF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 15:01:05 -0400
Received: by mail-wg0-f51.google.com with SMTP id c11so1295904wgh.6
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vlqCXRDZQ7ezmYbnPsan1cFNYas/oLdF+fcporKmsjE=;
        b=NY5fCKeCdoGhqC4SUNL5DAqTYPDhF0i4fkP8qziQZP2NdBYj0jagh85UDHwjiLo0az
         olZBOEGqxkTSH4jP6j/n2I5yH0Cb9bWAXrlX9mCHGND/UIecmr4I7CG6JcGmz9cMaehf
         /CrvRbX6A8W263knuA+owR7GMzr5dlG0bF5wKZrwNKC8Z5qUk4V4SGQMNBj9Kt2048X+
         8dISR6o9OR8e62jsFqKhTKz+6lmC9CkKY31i947OEz5zozDcmCKY3P1DCcjPjZ1kE2qb
         5k2c+ls2ac386XvVO25mq+6IDlC52p3NppYaGBlSSrjzJT4F5oqcWnYoaLNJjl3Pac9E
         EYcw==
X-Received: by 10.180.20.163 with SMTP id o3mr30031761wie.1.1381345263968;
        Wed, 09 Oct 2013 12:01:03 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id ey4sm18286606wic.11.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 12:01:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131009185459.GA2823@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235834>

On 10/09/2013 08:55 PM, Jeff King wrote:
> On Wed, Oct 09, 2013 at 08:27:58PM +0200, Stefan Beller wrote:
> 
>>> At least on Linux, if you checkout a revision with "foo/" directory,
>>> chdir to it and then checkout a revision with "foo" file to nuke
>>> your current place, I know "git checkout" will happily do so and you
>>> will still be in a directory that is connected nowhere.  Your ".."
>>> is probably pointing at the top-level, but there is no reverse, so
>>> "cd ../foo" may or may not work from that state, and it would lead
>>> to an interesting confusion.
>>>
>>> We may want to check the condition and forbid such a checkout.
>>
>> I think forbidding such a checkout is a bit hard:
>> 	$ git checkout <branch>
>> 	fatal: checkout not possible, because of said reason (dangling pwd)
>> 	$ cd ../.. # go to top level or somewhere else unaffected
>> 	$ git checkout <branch> # this will work
>>
>> Wouldn't it be better to navigate to the 'nearest' possible working dir on checkout?
>> Such a workflow would emerge:
>> 	$ git checkout <branch> # this includes the "cd .." of the previous step, it just went the dir structure up, until a valid dir was found.
>> 	warning: the current working directory is not part of the tree, navigating to $(PWD)
> 
> The problem is that the program calling "git checkout" (e.g., the shell)
> is in the directory that is going away, and git cannot impact the
> working directory of its parent. So there is no way to "fix" it here.
> Our only options are to proceed and hope the user can figure it out, or
> to warn/forbid.
> 
> -Peff
> 

Oops my bad. I did not think this through.

Maybe we could still have a config option,
which either forbids it, or just shows a warning.
I'll try to familiarize with the code and see what I can do.

Stefan
