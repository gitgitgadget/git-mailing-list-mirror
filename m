From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should notes handle replace commits?
Date: Fri, 08 Jan 2016 12:09:45 -0800
Message-ID: <xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
References: <20160108012830.GA2110@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 21:09:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHdM8-00014b-NQ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 21:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbcAHUJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 15:09:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751700AbcAHUJs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 15:09:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6374390DB;
	Fri,  8 Jan 2016 15:09:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LIWY6BlG2KRcf5mYjxrkCGpkSvU=; b=rrGWZ5
	kqMMrohp7I3ztSiW0lfEcVQXZrPELQOwZLMM73O+3AQB8HRHyeWpMBkksY40R3m+
	U02OD5DEYgoVMc4qbmkAhuySBxtFvXBPjw822GDMUKs5UisOOUrULOgIFRBTT2fm
	cPFWmQaDCSSBrX+xKcN6PvqO0/cj73tiegqoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iLhe1JmUO23XsfWhjQNf/VG+iXeGb2Gl
	kG4pHlLiYfztOmNmpQe9vYZXjh9eG6alJRu2s4e5df5oEiRobHAJaJkGGEtuGJ2a
	fPvhTKQ71A0Ub7+0wfLQw/FajtVDHJyBVUPbBeD8oEYnoGPatUIe8lBEFffSKv+1
	X0PdB78+Ops=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCB2F390DA;
	Fri,  8 Jan 2016 15:09:47 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 191CD390D2;
	Fri,  8 Jan 2016 15:09:47 -0500 (EST)
In-Reply-To: <20160108012830.GA2110@glandium.org> (Mike Hommey's message of
	"Fri, 8 Jan 2016 10:28:30 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3F28C72-B643-11E5-8A81-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283581>

Mike Hommey <mh@glandium.org> writes:

> Assuming that the "first" commit on master is the same as the "real
> third" on old, you can graft with:
>
>   $ git rev-parse master~ old | xargs > .git/info/grafts

With "graft", you told Git that the parent of master~1 ("second") is
not master~2 ("third") but is old ("real third").

> And then:
>   $ git log master --format='%s - %N'
>   third - third note
>
>   second - second note
>
>   real third - real third note

So it is expected that after "second" you see "real third", as you
are seeing the "real third" with its notes.

> Now, if you try to do the same with replace:
>
>   $ rm .git/info/grafts
>   $ git replace master~2 old

With "replace", you told Git that the contents (i.e. message, tree,
etc.) of master~2 ("first") is not what it really is but is what
appears in old ("real third").

>   $ git log master --format='%s - %N'
>   third - third note
>
>   second - second note
>
>   real third - first note

Hence Git tries to show master~2, i.e. "first", here; its contents
is replaced with that of "real third", but the object name of the
commit shown after "second" is shown, as far as Git is concerned, is
still that of "first", so it is not surprising that the note that is
associated with it is shown here, as the whole point of "notes" is
that it is kept outside the contents recorded _in_ the commit.

>   real second - real second note
>
>   real first - real first note
>
> Note how "real third" now has "first note", instead of "real third
> note".

So it is not a correct observation that '"real third" now has "first
note"'.  You are still seeing "first", but its message, together
with its tree and its parents, are replaced by those of "real
third".

> So the question is, is this the behavior this should have?

The behaviour is a natural consequence of what graft and replace are
about (i.e. "telling Git what the parents of a commit are" vs
"telling Git what the contents of a commit are"), so the answer to
the "should" question is a resounding "yes".

It is a separate issue if the behaviour is useful for the purpose
you wanted to use "replace" for.
