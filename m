From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Tue, 26 Jun 2012 12:51:31 -0700
Message-ID: <7vobo5c0n0.fsf@alter.siamese.dyndns.org>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 26 21:51:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjbnX-0000u2-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 21:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab2FZTvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 15:51:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751590Ab2FZTvf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 15:51:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B52699B63;
	Tue, 26 Jun 2012 15:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C0ReF3ybpAn0bK0KptIn10B1KOM=; b=yY6FUp
	YfaVcQZQIfXJrKJA7Oc7zkFcXRRl9M7/lEcjWHcOhstVXrKQ++Cr9LEfNO4OkJTZ
	eAPFp8Pab0JkaMohHN2v5fHsBiZM6gj/Zq89rhpnFJbx0GPGsQkYDVowklsCblFZ
	hxVHF28axJ3E3SXufxbLtSIzEDvhHjP8ZtLy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZvNxJejbwLYOyRHXZfjXU7dffV8gjrQ
	Z2Z+fbUT10spP2JR4jQDikp0ya/khjzCOyk9bL9xKwiUyEhh9V0QFT5Btwm55Qd9
	SJwx5aGHiFf+e8Cy1UUucnlkafpNchDYOH3lN1zApN4mbsfusFdFQyQXWWeWIxrr
	ungsOGVQ2Ss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB18C9B62;
	Tue, 26 Jun 2012 15:51:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFD719B60; Tue, 26 Jun 2012
 15:51:33 -0400 (EDT)
In-Reply-To: <4FE9FF0C.8050409@web.de> (Jens Lehmann's message of "Tue, 26
 Jun 2012 20:27:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5505957C-BFC8-11E1-B226-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200676>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 26.06.2012 18:07, schrieb Junio C Hamano:
> ...
>> When the user exports GIT_WORK_TREE to tell git that the root of the
>> working tree the user wants to work on resides there (which is
>> needed when the user exports GIT_DIR to tell git that the user wants
>> to work on that repository), that wish obviously applies only to
>> that repository.  If git decides to visit the working tree of a
>> different repository (e.g. a checkout of a submodule bound to the
>> project GIT_WORK_TREE points at), even if it is done in response to
>> the user action (e.g. like passing "--recurse-submodules" option),
>> it should adjust GIT_WORK_TREE and GIT_DIR to be appropriate for
>> operations in the submodule repository while doing so.  If the more
>> recent "recursive" behaviour forgets to do so, it simply is a bug.
>
> I'm not sure what you mean by "appropriate for operations in the
> submodule repository". Should the submodule work tree be searched
> for under $GIT_WORK_TREE of the superproject or under $(pwd)?

I think either

 (1) unset GIT_WORK_TREE/GIT_DIR if the process chdirs to
     $GIT_WORK_TREE/submodule and $GIT_WORK_TREE/submodule/.git is
     the controlling reopsitory of that submodule working tree, or

 (2) set GIT_WORK_TREE/GIT_DIR to point at the working tree and
     repository of the submodule.

would be appropriate.

> As far as I can see all submodule code consistently clears all
> environment variables used by git before descending into a
> submodule (at least since February 2010 and 5ce9086dd). Maybe we
> should change that so it sets the GIT_WORK_TREE environment to
> "$GIT_WORK_TREE/submodule" to be consistent?

If the user has to use GIT_WORK_TREE to mark the root level of the
superproject working tree as such, it is very likely that the
controlling repository of the superproject does not live in the
$GIT_WORK_TREE/.git directory (in other words, $GIT_DIR points at
somewhere else).  Exporting GIT_WORK_TREE/submodule as the new value
of GIT_WORK_TREE is sensible, but I do not see a reasonable way to
deduce the value of GIT_DIR for the submodule in such a case.  The
controlling repository of the superproject is located somewhere
random; there is no reason to assume the repository for the
submodule is somewhere at fixed relation to it.

Does it mean the short answer to Richard's situation is "Don't do
it"?  I am not sure, but it is starting to sound like it.
