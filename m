From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is
 only temporary
Date: Wed, 15 Oct 2014 16:51:54 -0400
Message-ID: <543EDE6A.7040500@xiplink.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>	<543E85FA.6050404@xiplink.com> <xmqqwq81w8az.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:52:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeVY4-00016w-LY
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 22:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbaJOUvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 16:51:53 -0400
Received: from smtp106.ord1c.emailsrvr.com ([108.166.43.106]:49533 "EHLO
	smtp106.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762AbaJOUvw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 16:51:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 5D6D818081F;
	Wed, 15 Oct 2014 16:51:51 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 26B16180A1D;
	Wed, 15 Oct 2014 16:51:51 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.13);
	Wed, 15 Oct 2014 20:51:51 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqwq81w8az.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-10-15 01:29 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> I think things would be more understandable if the option was "--dissociate
>> <repository>" and was an explicit alternative to --reference:
>> 	[[--reference | --dissociate] <repository>]
>>
>> I'm still not liking the name "--dissociate" though.  The original suggestion
>> of "--borrow" is better.  Perhaps "--library" or "--local-cache"?  I dunno...
> 
> I was not thinking when I originally started the topic with
> "--borrow", until I realized that it would not make much sense,
> primarily because we allow multiple references.

I hadn't realized that was possible.  There's no indication in the man page
that multiple --references are allowed (or forbidden, for that matter).

> What should this command line do, and how would you implement such a
> behaviour?
> 
>     $ git clone \
>         --reference=/local/pool/linux.git \
>         --borrow=../my/neighbour/linux-hack.git \
>         git://git.kernel.org/...../linux.git
> 
> With "do the usual --reference thing, but then dissociate the result
> from referents" option, there is no ambiguity and that is why I did
> not go with the "--borrow" option suggested in the original thread.

I had not considered this case.  My limited imagination has a hard time
coming up with a scenario where more than one --reference (or
--borrow/--dissociate) would make sense.  In this example, the --borrow seems
useless.  How would clone decide that it even needed objects from the
neighbour repo?  None of the refs on gko need any of the neighbour's unique
objects.  (I get the feeling I don't understand how clone works...)

>> So now I'm wondering if the implementation would be more efficient as an
>> extension of the --local operation.  That is, instead of a post-clone repack,
>> do a --local clone first followed by a simple "git fetch" from the source repo.
> 
> The network overhead may be comparable to the "--reference"
> optimization, but if your "clone --local" ends up copying (instead
> of hard-linking), the initial cost to copy locally would be a pure
> extra price over "clone --reference and then --dissociate".  If the
> local clone uses hard-linking, it would be cheaper, but it still
> costs more than dropping an entry into .git/objects/info/alternates,
> I would imagine.  You will pay with your scheme the same cost to run
> "repack -a -d", which is paid by "--dissociate" at the end of clone,
> eventually at the first "gc", so there is no efficiency advantage,
> either.
> 
> The above is my knee-jerk assessment without any measuring, though.

That makes sense to me, at least.  I agree with your assessment.

		M.
