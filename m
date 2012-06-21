From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Automatic dependency tracking in the Git build system (was: Re: [PATCHv2
 1/8] Makefile: apply dependencies consistently to sparse/asm targets)
Date: Thu, 21 Jun 2012 10:52:55 +0200
Message-ID: <4FE2E0E7.3040009@gmail.com>
References: <20120619232231.GA6328@sigill.intra.peff.net> <20120619232310.GA6496@sigill.intra.peff.net> <20120620035015.GA4213@burratino> <20120620042607.GA10414@sigill.intra.peff.net> <20120620102750.GB4579@burratino> <20120620163714.GB12856@sigill.intra.peff.net> <20120620182855.GA26948@sigill.intra.peff.net> <CAFzf2Xw3TdvZCFLvbqKY5F9b+0hTzTQEEfmqjL9u=uvyc7mZ5w@mail.gmail.com> <20120620193638.GA32418@sigill.intra.peff.net> <CAFzf2XwmZo4ErG_9w0m66k4OPtDr_4_xvATL_6sOo8QVg0DhJA@mail.gmail.com> <20120620195709.GB32228@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Automake List <automake@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 10:53:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shd8c-0002LQ-7e
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 10:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758999Ab2FUIxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 04:53:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61167 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758987Ab2FUIxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2012 04:53:03 -0400
Received: by bkcji2 with SMTP id ji2so283645bkc.19
        for <git@vger.kernel.org>; Thu, 21 Jun 2012 01:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=MIBbtBsr6GpWS7X2th27U2sgqEFbYU1p8SpOwLWKsmM=;
        b=J3hE10/dVc+CjHcZgUGRwFb+a1b3ABWJW2ZLWw11pcmNUGAoAea1mupP+RlpesM2LX
         AYYnXTPRsyPauBt7uxZhXo3AojjnR7z7c9KVzEr3EOLgSBQnSzzR+vmW52VDMeMlc2EC
         ZKWQgoEE7Y0Av+jNM9RrY/jYOqH15gwC9OicVTQ0sP4B5WYYEY4sJs2cl/asqdccmGjC
         NXRWyrTdGJ8RepCv0rmAEqndCEvcUpXWEiegMdqVCeCAFMuUDHeTesVaAj38UTI/05uI
         4nh5x+irSIB0xt8UnCm0LZ78LTXJvzArI7EoHNecGAYZcO7S7TMu7JJ43sZMzXfs8FN4
         2WXw==
Received: by 10.204.153.193 with SMTP id l1mr11580304bkw.120.1340268781418;
        Thu, 21 Jun 2012 01:53:01 -0700 (PDT)
Received: from [79.7.93.8] (host8-93-dynamic.7-79-r.retail.telecomitalia.it. [79.7.93.8])
        by mx.google.com with ESMTPS id m2sm31028460bkm.2.2012.06.21.01.52.57
        (version=SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 01:52:59 -0700 (PDT)
In-Reply-To: <20120620195709.GB32228@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200398>

[Adding the Automake list in CC:]

On 06/20/2012 09:57 PM, Jeff King wrote:
> On Wed, Jun 20, 2012 at 02:45:31PM -0500, Jonathan Nieder wrote:
> 
>> Jeff King wrote:
>>
>>> Did you read the argument in patch 2? They are almost certainly not
>>> helping anyone, anyway.
>>
>> Yes, I read patch 2. I hacked on git from time to time in the days
>> before COMPUTE_HEADER_DEPENDENCIES, and it sometimes involved changing
>> header files. When they were not in LIB_H, the experience was much
>> nicer.
>>
>> Is that called "not helping"? I'm afraid I don't follow this line of
>> argument at all.
> 
> I just assumed that people who are actively hacking on individual header
> files in git actually have a compiler that can do COMPUTE_HEADER_DEPENDENCIES.
> Maybe that is not the case. If it were such a big deal, then why is
> everything in LIB_H? Why don't people use these manual rules, or convert
> existing LIB_H entries to use them?
> 
> For people who are not actively hacking on header files in git, the
> arguments from that patch apply (namely that LIB_H is so gigantic that
> you are unlikely to hit a specific change where one of the few manual
> rules is triggered, but LIB_H is not).
> 
>> On the other hand, if someone were proposing adding a simple awk
>> script to implement a "make dep" fallback, I would understand that.
> 
> I'd be OK with that. Do you have one in mind, or do we need to write it
> from scratch? Surely somebody else has solved this problem before.
>

[begin shameless plug]

Have you taken a look at the 'depcomp' script that comes with Automake?
 <http://git.savannah.gnu.org/cgit/automake.git/tree/lib/depcomp>
Once you get past some of its idiosyncrasies and few historical warts,
it has a lot of built-in knowledge about automatic dependency tracking
for a lot of different compilers.

[end shameless plug]

HTH,
  Stefano
