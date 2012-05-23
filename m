From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Wed, 23 May 2012 11:53:34 -0700
Message-ID: <7vzk8yzq35.fsf@alter.siamese.dyndns.org>
References: <4FBAA33D.1080703@kdbg.org>
 <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 20:53:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXGgq-0007MR-B2
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 20:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932Ab2EWSxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 14:53:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932155Ab2EWSxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 14:53:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EB028967;
	Wed, 23 May 2012 14:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VUnOgeJTahekotOcnrXCv0c8CgQ=; b=j5FUIO
	99bS9I6Nj5s3M8gVPsTdDx+xmL5ZI5kxpZZz602qCGOZ0gq3wT9yhZoUrZayM0l1
	0SxBzk/H0i+xhtLLNdmW9G+7aCUp3G+U2WZkKAS6Z2dhpdyKRS5jpnEpgzR8HXzA
	whfEJylwywQzw04nTNTtOXymNtXnGzPJOLfV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WaWROIEKRrXBCfuNcWYTSxnGw4yMhxCi
	zc+Wn3d3szBNd7WRP8ii1d1tcIHOMuhU3KFF77A3cMfxQGTzku4jcAjha9mgv1YB
	BbF4cupzek4UuY3TZJOtCDcvxw74jnSQ5KgKGD9D8SLvDOjBBJqDPxAHp/YGtxQ4
	DN7i0JEl09k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9596B8966;
	Wed, 23 May 2012 14:53:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E01438962; Wed, 23 May 2012
 14:53:35 -0400 (EDT)
In-Reply-To: <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com> (Martin
 von Zweigbergk's message of "Wed, 23 May 2012 08:37:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 99F7BAD2-A508-11E1-8D49-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198316>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Mon, May 21, 2012 at 1:19 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Replace the 'git merge' by a cherry-pick that picks the changes that the
>> merge introduces with respect to the first parent.
>
> Just a reminder of what I said in [1] (the same thread that you referenced):
>
> I think this will break "git rebase -p --onto g b f" on  the below history.
>
>           .-e-.
>          /     \
>       .-c---d---f
>      /
> a---b---g


... where the replayed history would look like this:

                  .-e'.
                 /     \
    a---b---g---c'--d'--f'

and e' and e, even though being "moral equivalent", may have different
degrees of change since c' and c respectively depending on how changes
between b and c and changes between b and g are related to each other.

If the change in the dag b..f does not have much to do with the change
between b and g, then the change from c to e would be the same as the
change from c' to e', and if the original merge at f resolved conflicts
between e and d (or added an evil change), replaying the difference from e
to f on top of e' may give a better result.

I think your original point was that the above clean picture would not
hold if e-b and g-b has interactions.  g-b may contain some change that
e-b has independently done, in which case e'-g would be made smaller than
e-b when the conflict is resolved while replaying e to produce e' on top
of c' (the same applies if you replace e with any commit in the dag
"rev-list ^b e d").  The merge to produce f' may result in conflicts,
whether you merge e' and d' or replay f-e on top of e'.

A better way to keep potential "evil merges" at f while replaying to
produce f' may *not* be by applying the difference f-e on top of e'.
Instead, you can learn from what 'rerere' does.  That is, to attempt a
mechanical merge between e and d and call the result (with possible
conflict markers and all) pre-f.  If you compare pre-f and f, that is the
resolution and evil change made at f.  When reproducing f', mechanically
merge e' and d', call the result (again, with possible conflict markers
and all) pre-f', and try reproducing f' by a 3-way merge between pre-f,
pre-f' and f.
