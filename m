From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Fri, 17 Aug 2012 18:44:40 +0200
Message-ID: <502E74F8.4070209@web.de>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de> <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de> <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de> <7vhathn0f4.fsf@alter.siamese.dyndns.org> <4FFB23EB.8060409@web.de> <7vpq84k9n5.fsf@alter.siamese.dyndns.org> <4FFB3DB9.6090808@web.de> <7vmx1uzekb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 18:44:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2PfL-0001cd-Tc
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 18:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab2HQQoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 12:44:46 -0400
Received: from mout.web.de ([212.227.17.12]:52524 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758503Ab2HQQon (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 12:44:43 -0400
Received: from [192.168.178.41] ([91.3.156.248]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lhedd-1TXZXM19u5-00mQVF; Fri, 17 Aug 2012 18:44:42
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vmx1uzekb.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:obPUK/8kRJO9fo7aFA8BRBbKZ+QajrUxo2foiqhJ1KN
 CYyXc5eylI0ChQbtNrLKdorTeERKP1WUJQCgJrtKVkPzGAVlSE
 F3TXLmGUaqpXPgIz1pCVeqnplZajEou3Fe6yh5yrdnxolwekCO
 i7LB92G1p9jIIxUoUu/TWyDI4WXOQJaRERhcpzcmDiJrAVO0Z8
 RbeABDWb3YmtoKXdAlzCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203623>

Am 16.08.2012 23:56, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 09.07.2012 21:38, schrieb Junio C Hamano:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>
>>>> Cool, so let's drop this patch and I'll teach "rm" to handle
>>>> populated submodules according to what we do for regular files:
>>>> Make sure there are no modifications which could get lost (unless
>>>> "-f") and remove all tracked files and the gitfile from the work
>>>> tree (unless "--cached") before removing the submodule from the
>>>> index. If the submodule uses the old layout with the .git
>>>> directory instead of a gitfile we error out just like we do today.
>>>
>>> Alternatively we could "mv" .git directory out of the way and the
>>> next "git checkout" of a branch that still has the submodule can
>>> make a gitfile to point there, no?
>>
>> Yup. That would mean a smooth transition for legacy .git-dir
>> submodules into the new gitfile world.
>>
>>>> And we didn't talk about untracked or ignored files which may live
>>>> inside the submodules work tree so far, but according to what a
>>>> "rm -r" does in the superproject they should still be around after
>>>> using "rm" on a populated submodule, right?
>>>
>>> Until we add the "precious" class, untracked and ignored files are
>>> expendable, so if a submodule working tree has no modification and
>>> only has leftover *.o files, they can be nuked as part of submodule
>>> removal, but if it has an untracked and unignored *.c file for
>>> example, the "rm" operation without "-f" should be stopped, no?
>>
>> Ok, untracked files mark the submodule modified while ignored files
>> which are not tracked won't.
>>
>> Thanks for this discussion, I'll start hacking on that.
> 
> A mild ping on seemingly stalled topic.

I'm almost there. The only thing left is to check if a nested
submodule is using a git directory. In that case I expect "rm" to
fail even when -f is used to protect the submodule's history. I
still need to find a suitable command for recursing the submodules
and doing that check.
