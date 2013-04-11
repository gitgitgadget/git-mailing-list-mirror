From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/3] Teach mv to move submodules together with their
 work trees
Date: Thu, 11 Apr 2013 09:46:58 -0700
Message-ID: <7vd2u1j9q5.fsf@alter.siamese.dyndns.org>
References: <515C88FE.9020203@web.de> <515C8958.4080704@web.de>
 <CALkWK0mWHwTV8dc9F3tyq9HYOnC2S56x_efr1+eRsqJqTFutXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 18:47:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQKeS-0002Hk-TB
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 18:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934682Ab3DKQrD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 12:47:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934395Ab3DKQrB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 12:47:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1831214EC1;
	Thu, 11 Apr 2013 16:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WbDn9AkQzLwthcih8uhRHpTsRMo=; b=Z6ObOl
	+fsgxDAB2SxFiF2gQHnCRWFKLH4X5z+pXDnITFfTPw3oa7XhdX9z+TMY4pz1Gh5p
	F9qWT3r+Piv/xL9e/kP6d2/fB/SfpqcwSxt00mNm/Qq3DqoxKqxmGpMmpCvByyFA
	6wnnt4lFc653zhaOa5J/ltVHkKftdFL+yGe8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J+6yp9YP9IVKn2+b0VfEcj18Igb3Vx0o
	Dy6dvGThMxJOHSOPANLeMRLCb+rpXrswqHx7DchqPTghnUWX3U1rK8+Tp9clRxLG
	i7p7sFr5H7ULMdJxiUO9abIXIBRs/L0ceNNWK0/4BYu6yS3W2ZluVFmI9Pv5U9Rx
	kM4Gi/7cRMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BBAB14EC0;
	Thu, 11 Apr 2013 16:47:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B31014EBF; Thu, 11 Apr
 2013 16:47:00 +0000 (UTC)
In-Reply-To: <CALkWK0mWHwTV8dc9F3tyq9HYOnC2S56x_efr1+eRsqJqTFutXA@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Thu, 11 Apr 2013 14:42:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E2EFE8E-A2C7-11E2-9981-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220888>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Why does it search for a submodule with a trailing slash in the index?
>  You make it sound like it's doing something unnatural; in reality, it
> does this because it executes lstat() on the filesystem path
> specified, and the stat mode matches S_ISDIR (because it _is_ a
> directory on the filesystem).  It is stored in the index as an entry
> (without a trailing slash) with the mode 160000, gitlink.
>
> What happens if I attempt to git mv oldpath/ newpath/ (with the
> literal slashes, probably because I'm using a stupid shell
> completion)?

I think it should work.

	mkdir a && >a/f && git add a/f && git mv a/ b/

>> Fix that by searching for the name without a trailing slash and continue
>> if it is a submodule.
>
> So, the correct solution is not to "search for a name without a
> trailing slash", but rather to handle the gitlink entry in the index
> appropriately.

For moving an entire directory's contents, because the index is
flat, you would look for "name/", because you know all of the paths
contained in it will share that prefix.

But when dealing with a submodule, you need to see if the path that
found to be a directory in the working tree is a gitlink in the
index.  And the way to do so is to look for it without trailing
slash, because there is nothing hanging under it in the index.

So the right implementation of "handle appropriately" is to "search
without slash".  They are saying the same thing, and the latter is a
more specific way to point out in what way the existing code that
wanted to delegate moving to "submodule mv" and not having to worry
about gitlinks was unprepared for it, and what change is needed to
make it "handle appropriately".

So I think there is no need to rephrase here, but your comment makes
me wonder if the patch covers the case where you have a submodule at
"a/x" and the user does "git mv a/ b/".  The src_is_dir thing will
notice "a/" is a directory, finds all the paths inside a/ including
"a/x" (and we won't see any paths inside the submodule's working
tree) to "b/", and update the cache entries and the working tree.
Does the adjusting of the path for that moved submodule, which is a
theme for [PATCH 3/3], cover that case, too?

Another thing to wonder is if we correctly reject "git mv a/x/f here"
in the same example where a/x is a directory.  The path is beyond
the lower boundary of our working tree and should not be touched.
