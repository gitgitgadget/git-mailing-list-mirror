From: Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: git rerere is confused with identical conflicts in multiple files
Date: Fri, 10 Jul 2015 16:21:52 +0100
Message-ID: <559FE310.5060204@imgtec.com>
References: <559F7C81.50805@imgtec.com>
 <xmqqvbdsksmv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 17:22:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDa7j-0000e6-Fs
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 17:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbbGJPV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 11:21:56 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:53423 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702AbbGJPVy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 11:21:54 -0400
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
	by Websense Email Security Gateway with ESMTPS id 2C1B7704DB13D;
	Fri, 10 Jul 2015 16:21:50 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 10 Jul 2015 16:21:53 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 10 Jul
 2015 16:21:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <xmqqvbdsksmv.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [192.168.154.48]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273820>

Hi,

On 07/10/2015 03:13 PM, Junio C Hamano wrote:
> Markos Chandras <Markos.Chandras@imgtec.com> writes:
> 
>> $ cat .git/MERGE_RR
>> 5563edc0fb427275a0ca5677c93c40def8b53258
>> arch/mips/include/asm/cpu-type.hf175ff6228f624296b661664bce4ab4e84d712cc
>>
>> arch/mips/include/asm/cpu.h5563edc0fb427275a0ca5677c93c40def8b53258
>>    arch/mips/kernel/idle.c5563edc0fb427275a0ca5677c93c40def8b53258
>> arch/mips/kernel/spram.c5563edc0fb427275a0ca5677c93c40def8b53258
>> arch/mips/kernel/traps.c5563edc0fb427275a0ca5677c93c40def8b53258
>> arch/mips/mm/c-r4k.c
>>
>> so as you see, multiple files share the same hash. That's probably
>> because the "conflicting context ( the part between >>> <<<<)" in every
>> file but cpu.h is identical and git seems to calculate the hash purely
>> on the conflicting context. That makes git rerere thinks that it only
>> has to resolve 2 conflicts instead of 6.
> 
> Yes, that is by design, and should not change.  The thing is, you do
> want to share the same resolution across files, regardless of the
> path, when the recorded resolution replays cleanly [*1*].

I see.

> [...]
> 
> The thing to fix is "did it conflict, if so punt" step.  Within the
> same conflict ID, we would introduce the concept of "variant", and
> allow you to keep rr_cache/$ID/{preimage,postimage}.$variant.  The
> first part of the per MERGE_RR entry process would instead go like
> so:
> 
>     - Does rr-cache/$ID/ has one or more postimages?
>       - If so, for each variant, attempt three-way merge using
>         preimage, postimage and thisimage.
>       - Did one of the three-way merges replay cleanly?
>         - If so, be happy.
>         - If not, assign an unused variant to this path and change
>           its MERGE_RR entry from $ID to $ID.$variant
> 
>     - Does path still have conflicts?
>       - If not, record rr-cache/$ID/postimage for "variant".
> 
> The current "preimage", "postimage" will be kept as the first
> variant in rr-cache/$ID/ directory.  The second variant will likely
> be named (I don't have a code yet but have been slowly laying out
> the fundation to allow us to do this) "preimage.0" and "postimage.0",
> and the third one will have ".1" suffix.
> 
> This approach has the added benefit that existing rr-cache entries
> will stay valid (in addition to being able to replay the same
> resolution even after you renamed the path that conflict, unlike the
> case when you hashed the pathname together to break the conflict ID
> computtion).

I understand. Thanks for the explanation.

> 
> A WIP has been published on jc/rerere topic in my repository for the
> past few weeks, but I haven't reached the interesting "multi variant"
> part yet, as I said.

I am happy to test it when you have something more complete. If you can
reply to this e-mail when the 'variant' patch finds its way into the
master branch that would be great as well

-- 
markos
