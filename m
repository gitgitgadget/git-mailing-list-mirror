From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] revisions passed to cherry-pick should be in
 "default" order
Date: Wed, 15 Aug 2012 10:16:09 -0700
Message-ID: <7vk3x06ppi.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.a19f320a.5d99.3fdfSMTPIN_ADDED@gmr-mx.google.com>
 <7vtxw6d0ct.fsf@alter.siamese.dyndns.org>
 <CAOeW2eEbe9_m_QSbsJUbWPhf6G17X3vqbh__TCefrB0G2VKXdw@mail.gmail.com>
 <7vehnacxkf.fsf@alter.siamese.dyndns.org>
 <CAOeW2eH--Y_gq4jBBhd5EQRw+uuaNWrMT-Sua7CeJO-N9KHCLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 19:16:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1hCd-00041A-8d
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 19:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab2HORQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 13:16:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab2HORQM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 13:16:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6348251;
	Wed, 15 Aug 2012 13:16:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mmQFTYOyVN2eZ8vcE1vfIWVtjZ8=; b=cNt4ps
	fQfqe3QOimeG9gqGI907ycJX5LBZP5U+gEkFJgW6S7ptWiEKlUyOziWJNqgazY64
	0vhEFFSna6voiFtrmJmIQ4usVcKn0guDT39oVSU4ZunAItKjqXmvmylc4tKTqLVn
	dO/QRT4Jmwl5tM0ROPtw4zbXM5ZlLIppvfaZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cPWqqxnZr3hhx5OP78fGmMaojbtz1H4i
	qMzcpTr29OBY5IlzHweKGJPuw738diAxG9h4iRdvsY6Bxf+huWlJjfa9O7xna5z0
	guSdv/kqxvrrdNIfqOM3rB66e+lganxbWl7I7XYjqsd2g1Xq4Rm6IhlOj+AckkG0
	xw96M/AFlo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D90D58250;
	Wed, 15 Aug 2012 13:16:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45F63824F; Wed, 15 Aug 2012
 13:16:11 -0400 (EDT)
In-Reply-To: <CAOeW2eH--Y_gq4jBBhd5EQRw+uuaNWrMT-Sua7CeJO-N9KHCLg@mail.gmail.com> (Martin
 von Zweigbergk's message of "Tue, 14 Aug 2012 23:05:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8FE5740-E6FC-11E1-BA42-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203474>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> So all of the above case give the right result in the end as long
> as the timestamps are chronological, and case 1) gives the right
> result regardless. The other two cases only works in most cases
> because the unexpcted sorting when no-walk is in effect
> counteracts the final reversal.

In short, if you have three commits in a row, A--B--C, with
timestamps that are not skewed, and want to replay changes of B and
then C in that order, all three you listed ends up doing the right
thing.  But if you want to apply the change C and then B:

    - "git cherry-pick A..C" is obviously not a way to do so, so we
      won't discuss it further.

    - "git cherry-pick C B" is the most natural way the user would
      want to express this request, but because of the sorting
      (i.e. commit_list_sort_by_date() in prepare_revision_walk(),
      combined with ->reverse in sequencer.c::prepare_revs()), it
      applies B and then C.  That is the real bug.

      Feeding the revs to "git cherry-pick --stdin" in the order the
      user wishes them to be applied has the same issue.

> IIUC, this could be implemented by making cherry-pick iterate
> over rev_info.pending.objects just like 'git show' does when not
> walking.

Yes, that was exactly why I said sequencer.c::prepare_revs() is
wrong to call prepare_revision_walk() unconditionally, even when
there is no revision walking involved.

I actually think your approach to place the "do not sort when we are
not walking" logic in prepare_revision_walk() makes more sense.
"show" has to look at pending.objects[] because it needs to show
objects other than commits (e.g. "git show :foo"), so there won't be
any change in its implementation with your change.  It will have to
look at pending.objects[] itself.

But "cherry-pick" and sequencer-derived commands only deal with
commits.  It would be far less error prone to let them call
get_revision() repeatedly like all other revision enumerating
commands do, than to have them go over the pending.objects[] list,
dereferencing tags and using only commits.  The resulting callers
would be more readable, too, I would think.
