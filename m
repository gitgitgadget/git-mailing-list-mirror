From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 28/51] refs.c: rename ref_array -> ref_dir
Date: Mon, 12 Dec 2011 16:45:42 -0800
Message-ID: <7v7h21xps9.fsf@alter.siamese.dyndns.org>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
 <1323668338-1764-29-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Dec 13 01:45:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGVC-0003um-Pn
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1LMApq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:45:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472Ab1LMApp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:45:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8CF87AEF;
	Mon, 12 Dec 2011 19:45:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=LousOytU2dltYNr7Cn895Hf5Ic8=; b=fp1NbiqeN5iTdc4iQoGR
	96/+tuLXAfI5HPREWLJV7Org02VtNTqNcT2aQPSfmNbzwy9pXvfBjGSsL+N83yJP
	vAw/TlOwRPe5lFIjchjDt7WOhmmDJroNX1IE13y0N1urKpQI5x9nUXbfXGAip28U
	SS+ebk7sTg6CVcQvj51r5tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RBxJ4JGctHJNoviOu1HOcMS44BwKgoKTC5dAp97cExsFEF
	IG9oRaspwdUPhDcGUhOcSqbWasUY4WX+3CY8hmcsvH0ngMqF0AMdhvbRsiyxgb0e
	u3fLkxD1scUFVD5tcF/fzkdxivh580aavRLDlV2UyDA2lxgezIZrzzIqeNiQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C02777AEE;
	Mon, 12 Dec 2011 19:45:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 269447AED; Mon, 12 Dec 2011
 19:45:44 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA0FD2B4-2523-11E1-8956-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186990>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> This purely textual change is in preparation for storing references
> hierarchically, when the old ref_array structure will represent one
> "directory" of references.  Rename functions that deal with this
> structure analogously, and also rename the structure's "refs" member
> to "entries".
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |  166 ++++++++++++++++++++++++++++++++--------------------------------
>  1 files changed, 83 insertions(+), 83 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index fe6d657..b74ef80 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -106,9 +106,9 @@ struct ref_value {
>  	unsigned char peeled[20];
>  };
>  
> -struct ref_array {
> +struct ref_dir {
>  	int nr, alloc;
> -	struct ref_entry **refs;
> +	struct ref_entry **entries;
>  };

The s/refs/entries/ renaming is a sane thing to do; on the other hand, I
somehow find the s/ref_array/ref_dir/ renaming is a short-sighted change
and undesirable, as you are essentially declaring that "if you use this
structure, the contents you store there are expected to be named
hierarchically", forbidding users that want to use a simple flat array.

BUT. That was an observation before I continued reading the remainder of
the series.

I think the above observation primarily come from my worries around the
extra ref stuff, which by nature does not fit well with the hierarchical
naming (they do not even have any meaningful names). Sorting or requiring
uniqueness among them do not make any sense, let alone cutting their names
in hierarchical boundaries.

As an alternative, it _might_ make sense to get rid of "add_extra_ref()"
API from refs.c and make it the responsibility for its users to add their
extra anchor points where they use for_each_ref() to find out all anchor
points in the history from the refs.c subsystem. If we go that route, I
fully agree that "s/ref_array/ref_dir/" renaming is the right thing to do,
as refs.c subsystem will _only_ handle the hierarchical ref namespace and
nothing else after such a change.

A bit of background refresher.

"git clone --reference=../another-repo.git $origin" is a typical user of
the add_extra_ref() API. It runs an equivalent of ls-remote against the
reference repository, and uses add_extra_ref() to cause its later call to
for_each_ref() to return the names of the objects at the tips of refs in
that reference repository.

During the object transfer (i.e. the equivalent of "git fetch") from the
origin, "clone" and "upload-pack" negotiate what objects need to be sent,
and this is done by the receiving end telling what it has to the sending
end, and the sending end uses this information to subtract what the
receiving end claims to already have from what is going to be sent.

And the enumeration of what the receiving end, especially when there is no
"reference", is done using for_each_ref(), as object transfer considers
everything reachable from the refs complete. add_extra_ref() is a _hack_
to cause for_each_ref() to include objects that actually do _not_ sit at
the tip of any of our refs.

When cloning, we do not have any ref, and after clone is done, we do not
want the refs the repository we are borrowing its objects from to be our
ref (after all, we may be using a local copy of linux-3.0 repository as
our reference but cloning from linux-2.4 history), and that is why this
hack was invented (in the old scripted version, we tentatively created
real refs in our ref namespace and removed them after clone finished).

In the case of "clone", these extra refs are registered with names taken
from the repository we are borrowing from, so they may be unique and
without conflict among them if you are borrowing from one repository, but
if you borrow from more than one repositories, it is likely that all of
them have "refs/heads/master" and there is no reason to expect that the
extra refs added with add_extra_ref() API have unique names. Worse, in
"receive-pack" that runs on the receiving end when you "git push" your
history, "refs" that exist in repositories that the receiving repository
is borrowing from (i.e. it has $GIT_DIR/objects/info/alternates) are
advertised with ".have" in their names (not using anything refs/* is to
avoid the pusher from mistakenly think there is such a ref that is
eligible for "matching push" logic), and these ".have" entries obviously
are not unique. The code also uses the same add_extra_ref() hack to cause
for_each_ref() to report them.

The removal of this hack, taking receive-pack as an example, would be to
stop using add_extra_ref() but instead to keep a local list of object
names that the code currently uses add_extra_ref() to keep track of, and
then modify write_head_info() to feed show_ref_cb() with these object
names in addition to the current for_each_ref() callback.

It may make the resulting code cleaner if we go that route, and if we were
to do so, I think the right place to do so in the series would be either
at the very beginning of the series (as part of the preliminary clean-up),
or immediately before "do_for_each_ref: correctly terminate while
processing extra_refs" (making that commit unnecessary, as after such a
fix, refs.c API won't have to worry about the extra_refs hack anymore).

What do you think?
