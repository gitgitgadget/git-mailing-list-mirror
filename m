From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated submodules
Date: Mon, 09 Jul 2012 20:33:15 +0200
Message-ID: <4FFB23EB.8060409@web.de>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de> <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de> <7vsjd2n1wt.fsf@alter.siamese.dyndns.org> <4FF9A261.3040907@web.de> <7vhathn0f4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:33:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoIm0-0000G7-5f
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 20:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab2GISdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 14:33:24 -0400
Received: from mout.web.de ([212.227.15.3]:60216 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab2GISdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 14:33:22 -0400
Received: from [192.168.178.48] ([91.3.173.156]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M9GYQ-1SdpR21WZy-00D3PW; Mon, 09 Jul 2012 20:33:18
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vhathn0f4.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:xejfv00Fip4YmzNkluWfXg62wnZ5fiW4xjfrEw+eG5F
 riP43RjKHxiMrNv2rMv0IQzTMuwdazObhVXKZSIu+chEKKsfjZ
 11GPVz5MHkMXmNj4A7FkaXbjYFIMGElbde8VcBJhg85Hkpftaj
 mpRmMsPGxYSpch4FNCgEUf4KC8zBWU8eA1LoETQB+GJnFpOLHs
 AuxcFGZxllustAJsWmG7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201217>

Am 09.07.2012 04:17, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> So I still think "--recurse-submodules" does not make any sense to
> the "rm" command.  I would understand a "Do not attempt to remove
> submodules and ignore their existence altogether" option, even
> though I do not think it is useful.

Yes, when "rm" removes populated submodule work trees by default
then there is no need for a "--recurse-submodules" option. And
then we don't need a "--no-recurse-submodules" either as that use
case is already covered by the "--cached" option, right?

>> All other core commands happily change the index without updating
>> the submodule's work tree.
> 
> What are "all other core commands"?  "fetch" by definition does not
> touch working tree inside or outside working tree.  "add" is about
> recording the state from the working tree to the index, and
> following the earlier point you raised (I unfortunately culled from
> the quote), as the rest of core Git considers a submodule a single
> path entity in the context of the superproject, "the state from the
> working tree" for the submodule is where its HEAD points at, so it
> is correct not to look at the working tree.

I wanted to say "all other /work tree updating/ core commands"
here (checkout, merge, reset ...). Sorry for the confusion.

> Without going outside the context of "rm", I think the current
> behaviour of "git rm path" for submodule is merely punting---erroring
> out against a request for an unimplemented feature.
> 
> If you ask an unpopulated submodule to be removed, we could simply
> rmdir() it and remove the entry from the index, but that is far
> insufficient for handling a submodule repository that is already
> "init"ed.  And we did not want to plug the "check if removal will
> lose any state from the submodule repository" logic because the
> information is no use for us for a long time until we added the
> "gitfile" support to allow us to relocate path/.git for the
> submodule safely away when we remove the working tree of it.
> 
> But now we do have gitfile, so we could remove submodule working
> tree.  I think not erroring out and removing only the index entry is
> a irresponsible thing to do.  It would mean that we pretend as if a
> feature that was earlier unimplemented (hence errored out) is now
> supported, but it does not do what the user asked us to do, no?
> 
> I do not know what other commands you have in mind, but some of them
> may be similar "recursing down and performing an operation that
> potentially can fail is too complex, and we are not sure if we have
> enough sequencing infrastructure to guide the user to sort out the
> mess in the half-result, so let's punt and not to that part and have
> the user sort out" half-features, and if that is the case, I do not
> think it is prudent to model "rm", which is something that we now
> could implement properly, with the necessary infrastructure already
> in place, after them.

Cool, so let's drop this patch and I'll teach "rm" to handle
populated submodules according to what we do for regular files:
Make sure there are no modifications which could get lost (unless
"-f") and remove all tracked files and the gitfile from the work
tree (unless "--cached") before removing the submodule from the
index. If the submodule uses the old layout with the .git
directory instead of a gitfile we error out just like we do today.

And we didn't talk about untracked or ignored files which may live
inside the submodules work tree so far, but according to what a
"rm -r" does in the superproject they should still be around after
using "rm" on a populated submodule, right?
