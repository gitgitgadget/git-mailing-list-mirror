From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Mon, 09 Jul 2012 22:23:21 +0200
Message-ID: <4FFB3DB9.6090808@web.de>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de> <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de> <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de> <7vhathn0f4.fsf@alter.siamese.dyndns.org> <4FFB23EB.8060409@web.de> <7vpq84k9n5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 22:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoKUg-0004A3-7t
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 22:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab2GIUXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 16:23:37 -0400
Received: from mout.web.de ([212.227.15.4]:57221 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab2GIUXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 16:23:36 -0400
Received: from [192.168.178.48] ([91.3.173.156]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LyDdJ-1RlJ7v0EeD-015ASe; Mon, 09 Jul 2012 22:23:22
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vpq84k9n5.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:rw4/ZMmwpcQq9fcw4wqfeoFHqsyltvcKgGAbilC5sci
 sxt2PHK0qXylhS0NYzBFv9W3B2EqHPGZaPkvs8CAV7PM/2KWDv
 uXOiOd+e7nBOVFlmDAk5XMVKrFjZ60rprnxJXgcb0vLzUY/LPI
 N6yAwKxihwOpRK4zkBSqbLDASvXqJ0/E/F0MN23Cv4H1HrjL6G
 ifm2khL/MXIZdPjjBcmig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201224>

Am 09.07.2012 21:38, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Cool, so let's drop this patch and I'll teach "rm" to handle
>> populated submodules according to what we do for regular files:
>> Make sure there are no modifications which could get lost (unless
>> "-f") and remove all tracked files and the gitfile from the work
>> tree (unless "--cached") before removing the submodule from the
>> index. If the submodule uses the old layout with the .git
>> directory instead of a gitfile we error out just like we do today.
> 
> Alternatively we could "mv" .git directory out of the way and the
> next "git checkout" of a branch that still has the submodule can
> make a gitfile to point there, no?

Yup. That would mean a smooth transition for legacy .git-dir
submodules into the new gitfile world.

>> And we didn't talk about untracked or ignored files which may live
>> inside the submodules work tree so far, but according to what a
>> "rm -r" does in the superproject they should still be around after
>> using "rm" on a populated submodule, right?
> 
> Until we add the "precious" class, untracked and ignored files are
> expendable, so if a submodule working tree has no modification and
> only has leftover *.o files, they can be nuked as part of submodule
> removal, but if it has an untracked and unignored *.c file for
> example, the "rm" operation without "-f" should be stopped, no?

Ok, untracked files mark the submodule modified while ignored files
which are not tracked won't.

Thanks for this discussion, I'll start hacking on that.
