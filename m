From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/subtree bugfix: Can't `add` annotated tag
Date: Thu, 08 May 2014 10:38:32 -0700
Message-ID: <xmqqoaz841d3.fsf@gitster.dls.corp.google.com>
References: <1399511079-1994-1-git-send-email-nod.helm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Cagle <kcagle@micron.com>
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 19:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiSHJ-00022D-JD
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 19:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413AbaEHRii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 13:38:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63257 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127AbaEHRih (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 13:38:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBE341498F;
	Thu,  8 May 2014 13:38:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F355qrOhUJVWiW92uuV21KamZsY=; b=yMbc7J
	jboXgLyeUW2PwVUdnZVYaTKIEA2d88c1QnsuvAFgu4S2j4ZQk44prEHx8Iqt/IQA
	ZdsDoybzptN36Rfboyxx9DGlqaMnimfETWECNDnzE5+d2/m5fa4k7NeSX+aUskdh
	h3NswWVtL4NlXwtO1eCzdQ9XOYc7dz/LJrv+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SMLviW8QJJQIZVBLX9Y5xAQLn5cF13D8
	ZDhJV4BhLtb4wVbzMBf5oUo1RwPvdgRHvdir+YGS+N5/78hYNb1EN+R3/3cnps/c
	Lux1F8bMZUIQFa2EWgSEbaQqodC2UkMI5P1c5J9Hnk1Yung53BHhlNqXebIQAvPe
	/JpI9bi8aEM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B32731498E;
	Thu,  8 May 2014 13:38:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4D4F91498C;
	Thu,  8 May 2014 13:38:34 -0400 (EDT)
In-Reply-To: <1399511079-1994-1-git-send-email-nod.helm@gmail.com> (James
	Denholm's message of "Thu, 8 May 2014 11:04:39 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9428F226-D6D7-11E3-AC21-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248428>

James Denholm <nod.helm@gmail.com> writes:

> cmd_add_commit() is passed FETCH_HEAD by cmd_add_repository, which is
> then rev-parsed into an object ID. However, if the user is fetching a
> tag rather than a branch HEAD, such as by executing:
>
> $ git subtree add -P oldGit https://github.com/git/git.git tags/v1.8.0
>
> The object ID is a tag and is never peeled, and the git commit-tree call
> (line 561) slaps us in the face because it doesn't handle tag IDs.

The "rev" (not "revs") seems to be used by more things than the
final commit-tree state.  Are we losing some useful information by
peeling it too early like this patch does?  The reason why we
stopped peeling when writing FETCH_HEAD was because we wanted to
record the fact that we merged a tag (and use the GPG signature if
found in it) when constructing the log message for the merge, and
peeling the tag too early and recording the commit in FETCH_HEAD
would make it impossible to do, and I am wondering if this change is
making the same kind of mistake here.

I see that add_msg does not use anything useful from latest_new, so
with the current state of the code, it does not make that much
difference (except that it says "from commit '$latest_new'", and by
peeling, the fact that the user wanted to use a tag is lost from the
result).

> On a side note, if merging a tag without --squash, git merge recognises
> that it's a tag and adds a note to the merge commit body. It may be
> worth mimicking this when using "subtree merge --squash" or
> "subtree add".

Yes, and this change makes such a change harder to implement on top,
I suspect.

Would it be sufficient to do

	git commit-tree $tree $headp -p "$rev^0"

in that "not squashing" codepath instead?

>  contrib/subtree/git-subtree.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index dc59a91..9453dae 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -538,7 +538,7 @@ cmd_add_commit()
>  {
>  	revs=$(git rev-parse $default --revs-only "$@") || exit $?
>  	set -- $revs
> -	rev="$1"
> +	rev=$(peel_committish "$1")
>  	
>  	debug "Adding $dir as '$rev'..."
>  	git read-tree --prefix="$dir" $rev || exit $?
