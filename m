From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH (WIP)] Show a dirty working tree and a detached HEAD
 in status for submodule
Date: Mon, 11 Jan 2010 14:45:08 -0800
Message-ID: <7vtyusb6rv.fsf@alter.siamese.dyndns.org>
References: <4B4BA096.5000909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 23:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUT0t-0007i7-HX
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 23:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab0AKWp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 17:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809Ab0AKWp1
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 17:45:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab0AKWp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 17:45:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E0CD90E71;
	Mon, 11 Jan 2010 17:45:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=47VnNM6x+rIdRvRucv3tAmMEF9c=; b=DxBvOX
	3iG/p2CibQojRcS2Qog5SOrWHTp5Ak969/Yz+BShL3Z4PrtG1BLuy/4saOqJVvUg
	qWl9r5+jrAVMYsTkHxISi4We8GA3D0c1Jg3Jag+OMKJe13RM1BvgK2GDacDZ0+vi
	VoiQRPx36gddzD+wN9l2BgkJfXlH+mPZl184g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hrPuRDJapSoJyqRUlxu0at73N+lxCcnP
	zSmAvQg8hbX0hw+olghMk2oLY7TqQDZFZtlh0yXR+tdd5cgjFVdpxWZCSEMmCxtR
	H62EEs6Kf7aKHOkinRH2fB9ZxeGwshi8jbaCBsNEwIQewVJJnQLG9cKXU4CvA/Hl
	6Afr0sQyC8g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C5DE90E70;
	Mon, 11 Jan 2010 17:45:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96DE490E6B; Mon, 11 Jan
 2010 17:45:10 -0500 (EST)
In-Reply-To: <4B4BA096.5000909@web.de> (Jens Lehmann's message of "Mon\, 11
 Jan 2010 23\:05\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE5C5A86-FF02-11DE-8FC1-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136676>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Until now a submodule only showed up as changed in the supermodule when
> the last commit in the submodule differed from the one in the index or
> the last commit of the superproject. A dirty working tree or a detached
> HEAD in a submodule were just ignored when looking at it from the
> superproject.
>
> This patch shows these changes when using git status or one of the diff
> commands which compare against the working tree in the superproject.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
>
> This is the first version of a patch letting git status and the git
> diff family show dirty working directories and a detached HEAD in
> directories. It is not intended to be merged in its present form but
> to be used as a starting point for discussion if this is going in
> the right direction.
>
>
> What the patch does:
>
> * It makes git show submodules as modified in the superproject when
>   one or more of these conditions are met:
>
>     a) The submodule contains untracked files
>     b) The submodule contains modified files
>     c) The submodules HEAD is not on a local or remote branch
>
>   That can be seen when using either "git status", "git diff[-files]"
>   & "git diff[-index] HEAD" (and with "git gui" & gitk).

If the submodule is checked out, _and_ if the HEAD there, either detached
or not, does not agree with what the "other" one records (i.e. the commit
recorded in an entry in the index, or in the tree, that you are comparing
your work tree against), then it also should be considered modified.  I
don't think your (a)-(c) cover this case.

Also I don't understand why you want to treat (c) any specially at all.
Even if (c) is something we _should_ report, please do not call that as
"detached" in its implementation.  "detached HEAD" has a very precise
technical meaning, and can point at the same commit as a local or a remote
tracking branch, which is very different from the definition your
implementation seems to use.

> * This behavior is not configurable but activated by default. A config
>   option is needed here.

I doubt it.

My gut feeling is that this should be _always_ on for a submodule
directory that has been "submodule init/update".  The user is interested
in that particular submodule, and any change to it should be reported for
both classes of users.  Theose who meant to use the submodule read-only
need to be able to notice that they accidentally made the submodule dirty
before making a commit in the superproject.  Those who wanted to work in
submodule needs to know if the state is in sync with what they expect
before making a commit in the superproject.

That of course is provided if the unconditional check does not trigger for
submodules that the user hasn't "submodue init"ed; I think you did that
correctly at the beginning of your is_submodule_modified() implementation.

> +static int is_submodule_head_detached(const char *path)
> +{

I don't understand why you should care which branch the submodule happens
to be on, as long as the next commit you make in the superproject records
the commit that is checked out in the submodule.

Of course you may want to be careful when "pushing" the superproject
results out (i.e. you would want to push out the history leading to that
commit at the submodule HEAD in the submodule history), so that the people
who are pulling from the repository you are pushing into will have
everything available.

But the thing is, in a distributed environment, the submodule HEAD being
at the tip of _some_ branch (either local or remote) you have doesn't mean
anything to help them.  IOW, for protect others, you would need a check
when you _push out_ (either in 'push' or on the receiving end).

So I'd suggest dropping this condition in "status/diff" that is about
preparing to make the next commit in your _local_ history.

If "must be reachable from somewhere" is a condition worth caring about in
some context other than "status/diff", you can do an equivalent of:

    $ git rev-parse HEAD --not --all | git rev-list --stdin

and see if anything comes out (in which case you have commits that are not
reachable from any of your refs other than the detached HEAD).

But that is not "is HEAD detached?"; it is something else.  "Dangling",
perhaps, as that is how "git fsck" call commits that are not reachable
from any of your refs ("fsck" considers HEAD a part of refs, so it is not
strictly correct but it is much closer).
