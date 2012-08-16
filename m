From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated
 submodules
Date: Thu, 16 Aug 2012 14:56:20 -0700
Message-ID: <7vmx1uzekb.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de>
 <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de>
 <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de>
 <7vhathn0f4.fsf@alter.siamese.dyndns.org> <4FFB23EB.8060409@web.de>
 <7vpq84k9n5.fsf@alter.siamese.dyndns.org> <4FFB3DB9.6090808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 16 23:56:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T283I-0006xK-VU
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 23:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab2HPV4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 17:56:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab2HPV4W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 17:56:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 675C19A49;
	Thu, 16 Aug 2012 17:56:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z40vokL7aYqjRYLkfSRSff91CHU=; b=Rl55Jj
	w3aFqr/cDCzHBuXwnkv3CYkahX58f3ZQkqI/jCC5Ce8YTgfPkanHDVmAAu8uenk3
	yLtywLBmNRcBskG+EtqsO4Rli4vy47CwQH4eetIOCwH5Qax96YBMuM2j2iz2XzoQ
	rsqQD1kBqPKnulKHKB5u7xE9eR6eb5gpXIL+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t+FIydDnyW7vxkwI4cXVxnv2KtDgLW2T
	D1V5ZrJGlYrQ+FTZMU/9MfFnQGSqDP1sEx5Z2QyeYQLgcgLFHzRwLHrOkQtJLA8+
	zFv62Zfut1Wp3aYQeFi9ob70zjEBMetSBcdAW8MApOriaMx6oSu73ghUzOk0uueL
	SApNHXT7VeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 553BA9A48;
	Thu, 16 Aug 2012 17:56:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEA6B9A46; Thu, 16 Aug 2012
 17:56:21 -0400 (EDT)
In-Reply-To: <4FFB3DB9.6090808@web.de> (Jens Lehmann's message of "Mon, 09
 Jul 2012 22:23:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3733FF1E-E7ED-11E1-92BA-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 09.07.2012 21:38, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>>> Cool, so let's drop this patch and I'll teach "rm" to handle
>>> populated submodules according to what we do for regular files:
>>> Make sure there are no modifications which could get lost (unless
>>> "-f") and remove all tracked files and the gitfile from the work
>>> tree (unless "--cached") before removing the submodule from the
>>> index. If the submodule uses the old layout with the .git
>>> directory instead of a gitfile we error out just like we do today.
>> 
>> Alternatively we could "mv" .git directory out of the way and the
>> next "git checkout" of a branch that still has the submodule can
>> make a gitfile to point there, no?
>
> Yup. That would mean a smooth transition for legacy .git-dir
> submodules into the new gitfile world.
>
>>> And we didn't talk about untracked or ignored files which may live
>>> inside the submodules work tree so far, but according to what a
>>> "rm -r" does in the superproject they should still be around after
>>> using "rm" on a populated submodule, right?
>> 
>> Until we add the "precious" class, untracked and ignored files are
>> expendable, so if a submodule working tree has no modification and
>> only has leftover *.o files, they can be nuked as part of submodule
>> removal, but if it has an untracked and unignored *.c file for
>> example, the "rm" operation without "-f" should be stopped, no?
>
> Ok, untracked files mark the submodule modified while ignored files
> which are not tracked won't.
>
> Thanks for this discussion, I'll start hacking on that.

A mild ping on seemingly stalled topic.
