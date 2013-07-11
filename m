From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-ref: make --head always show the HEAD ref
Date: Thu, 11 Jul 2013 08:41:00 -0700
Message-ID: <7v38rlt88j.fsf@alter.siamese.dyndns.org>
References: <1369894105-48434-1-git-send-email-madcityzen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Doug Bell <madcityzen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 17:49:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJ78-0003kY-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 17:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126Ab3GKPs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 11:48:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33806 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240Ab3GKPs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 11:48:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 720DC2FBD3;
	Thu, 11 Jul 2013 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWVrNq0aOZJr766ay0KKGylfK9o=; b=plkUIr
	GYMWWk4tcTEcpprr1CkiNOXj3lMswm3+wP66yf8aLtYqi8sk+syKMNoR3tYdyQAL
	qEdFNyz5w+vmuKMXYqQy7ieBm0/jDQWCwlT1WZwE18kUnN5pyBUJlrKyf7qqWwjk
	Kk+WIrtJexZFcj65BXI7gYrYadjSAqRihchec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cz4HA4bNW6Fo6qbJQ/qy5G7TQSdW17mp
	Uxho4EQLOt1GIlerxf7s6g8bEnnN9snm3DlQptGtvXSHFbfGQfHUWpdTyHzNR0gM
	Td6hiIurdqCT6tlvfFrUQuIU2alHLXB4dwgGXuk5CtO27GuXW+EHDGSetapzH09U
	1n367UrpeKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D95D2FBD0;
	Thu, 11 Jul 2013 15:48:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E87E2FE39;
	Thu, 11 Jul 2013 15:41:02 +0000 (UTC)
In-Reply-To: <1369894105-48434-1-git-send-email-madcityzen@gmail.com> (Doug
	Bell's message of "Thu, 30 May 2013 01:08:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AA8ACEC-EA40-11E2-8152-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230108>

Doug Bell <madcityzen@gmail.com> writes:

> The docs seem to say that doing
>
> 	git show-ref --head --tags
>
> would show both the HEAD ref and all the tag refs. However, doing
> both --head and either of --tags or --heads would filter out the HEAD
> ref.
>
> Signed-off-by: Doug Bell <madcityzen@gmail.com>
> ---

I think this patch fell through the cracks, and looking at it, I am
somewhat torn.

The command help for "--head" says "show the HEAD reference", which
may mean:

 (1) in addition to everything else the command would do if there
     weren't this option specified, show HEAD;

 (2) show the HEAD and nothing else; or

 (3) add HEAD to the candidates to be shown, but apply the usual
     filtering rule based on --heads, --tags and/or pattern
     arguments.

While the last interpretation is what we have used since the
beginning of the command at 358ddb62 (Add "git show-ref" builtin
command, 2006-09-15), I tend to agree with you that the first
interpretation may make more sense, at least from the end user's
point of view.

But at a deeper level, it makes the command somewhat inconsistent.

What happens in the command is

 - We iterate over "candidates to be shown", which is usually
   "everything under refs/", but with "--head", HEAD is added to
   this set.  For each of these candidates:

   - if one or more <pattern> parameters are given, reject the
     candidate ref if it does not tail-match with any of the
     patterns;

   - if either "--heads" or "--tags" is given, among the ones that
     pass <pattern> filter, check if they:

     - begin with "refs/heads/" (if "--heads" is given); or
     - begin with "refs/tags/" (if "--tags" is given).

     and reject those that don't.

   - show it if it is still surviving after these two tests.

And taht is why "git show-ref --tags master v1.3.0" shows only the
v1.3.0 tag without showing the master branch, and giving "--heads"
instead of "--tags" yields only the master branch without the tag.

The semantics your patch wants, by changing the definition of
"--head" from (3) to (1), is:

 - If "--head" is given, show HEAD no matter what.

 - Iterate over everything under refs/, and for each of them, do the
   same filter-and-show as we currently do (see above).

While I think the new semantics is also understandable as the
current one, and personally I think it is a better behaviour than
the current one, it will require an update to the document to
highlight that "--head" is special-cased in a big way, to bypass all
the filtering that is applied to normal refs.

A few additional observations (these are not complaints to this
patch and please do not take them as such):

 - The command help says "(can be combined with heads)" for "--tags"
   and vice versa, but does not mention their interaction with
   "--head".  This is because we take interpretation (3) above and
   do not treat "--head" as a mechanism to add to <pattern>
   parameter like these two.

 - The command help for "--heads" and "--tags" says "only show
   heads/tags", which technically does not contradict with "can be
   combined with" above, but a logical consequence of combining
   ought to be showing nothing, as a ref cannot be a head (an old
   nomenclature for a "branch") and a tag at the same time.  

I think we should find a word better than "only" to use here, but I
am not sure what would be a good phrase to use.
