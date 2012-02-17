From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mixing and matching multiple projects
Date: Fri, 17 Feb 2012 11:49:14 -0800
Message-ID: <7v39a9tf45.fsf@alter.siamese.dyndns.org>
References: <7vhayptght.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 20:49:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyToS-0004Ff-BF
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 20:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660Ab2BQTtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 14:49:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab2BQTtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 14:49:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56DF87266;
	Fri, 17 Feb 2012 14:49:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iqNIcJeGHKs7Eqsy4Orl2DB0nXs=; b=VxZKGU
	2HwQ/28zhPKh7qbMnmJIFxxzqmu17MFpw8BwRWgGwP7/s6QJHXvU6kay5Hz4rAsI
	zTi6PYsFKv6c4K+7+DwsDXURDgC64vKJ7PBc1klGWkiYamEatpxx1Hl9u0Irv2Pj
	VT9pDPQBTUss6nRQjNfaqtcEyOybdswvOymZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Slqy3IkZ9zRQ9id9rcHGn058wBPBV45r
	iIO3NJaXIfJ1+IhJwJojhfxthRWEtgtIrcYiNZCTf9EYTPmdjQzOdyuPf8K3lKaI
	BZwsmtl/Sec63P/hWRs2iI5/0KIp06wlKCfuGFC8deiaNgFCNFvMpwy+NDVArAUe
	hv90dKA1euI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C7C57265;
	Fri, 17 Feb 2012 14:49:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C43727264; Fri, 17 Feb 2012
 14:49:15 -0500 (EST)
In-Reply-To: <7vhayptght.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 17 Feb 2012 11:19:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7909A3E8-59A0-11E1-9658-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190976>

Junio C Hamano <gitster@pobox.com> writes:

> But I wonder if we can do without forking the /s/xyzzy/os/.git submodule?
>
> If we *could* do this:
>
> 	cd /s/xyzzy
>       mkdir os/drivers/frotz && populate the directory with sources

A crucial step was missing here for my story to make *any* sense. Sorry.
A step to create a repository at /s/xyzzy/os/drivers/frotz/.git must be
here, like this:

        (cd os/drivers/frotz && git init && git add . && git commit)

And then that is added as a submodule to the superproject.

>       git add os/drivers/frotz ;# to the top-level superproject!!
>
> to add the "frotz driver" submodule directly to the superproject, then we
> could leave /s/xyzzy/os/.git intact, letting it follow the open source
> world. Because the superproject must be forked in order to keep track of
> what happens in the appliance that supports the "frotz" driver anyway,
> this could result in the minimum amount of forking from the end user's
> point of view.
>
> People who know the Git data structure of course can immediately see that
> this is not supported (and I strongly suspect unsupportable, but my
> suspicion has a history of being wrong from time to time, and that is why
> I am sending this message).  The index at /s/xyzzy/.git/index has to be
> able to record "os" as a gitlink and "os/drivers/frotz/frotz.c" as a
> regular blob at the same time, which is a D/F conflict.
>
> Even if you modify the index D/F conflict check to allow this, you cannot
> write the top-level tree object for the superproject, as "os" needs to be
> recorded as a gitlink to bind the /s/xyzzy/os/.git submodule, while you
> also have to have another "os" in the same top-level tree object as a tree
> object that has a single entry "drivers" (which is a tree) in it, under
> which all the "os/drivers/frotz" subdirectory hang.  All tree traversal
> code would be very unhappy to see such a tree with "duplicate" entry,
> including the unpack-trees machinery used for merging and switching
> branches, connectivity machinery used for fsck, object enumeration, and
> object transfer.  I imagine that it *could* be done, but it won't be a
> mere two-weekend hack; it has to first destroy pretty much everything in
> the current codebase and rebuild it to add such a support.
>
> The "frotz" submodule could be added as /s/xyzzy/frotz/.git and the build
> infrastructure at /s/xyzzy/.git (which we are going to fork anyway) could
> be tweaked so that it creates a symbolic link in /s/xyzzy/os/drivers to
> point there, pretending that there is a 'frotz' subdirectory. While that
> would certainly be a workaround, I am wondering if people who have used
> submodules and/or nested projects more than I have better solutions to
> this puzzle.
>
> Comments?
