From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Our merge bases sometimes suck
Date: Thu, 19 Jun 2014 23:53:42 -0700
Message-ID: <xmqqtx7gdqbt.fsf@gitster.dls.corp.google.com>
References: <539A25BF.4060501@alum.mit.edu>
	<xmqq8uovo9pa.fsf@gitster.dls.corp.google.com>
	<53A06264.9080205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 20 08:53:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxshu-0002x4-Up
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 08:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933971AbaFTGxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 02:53:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52303 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbaFTGxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 02:53:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77F461B6D9;
	Fri, 20 Jun 2014 02:53:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ho3HiheXgn4SyF9Egzd3azQw+Xk=; b=tHjQlg
	QfVu4i74xkchX36TeDHHPK0ZVloyG/7uUYWLvGENYHSeuFOrhEPlcyOub4mb3Nu7
	FrfwLbYfsO7vLD2AHGwtE0DcCFo1nZwK43iiqOMijDmvyRZc96I+eXMpixZecmEY
	XML0pSwAdF2Gb6mzb71wU8nNnlWxJ0s5gXx8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ddohmvZTP+3Esah4UAJflMYAJ8RtQuc0
	BdLM5gCVS64xe8f6/N+NtMeiPIxtzFZLgsbVnR/AKSbG4ZYCur0GU6WKCHjGIxCj
	r04i0FXksNL/q9n3+gRbpc8sJOJ3no4RNoQFziGWRY1ZQNtyHmgo0s/H6f/cKQgA
	5RXvA52L5xc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CCFD1B6D8;
	Fri, 20 Jun 2014 02:53:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 187741B6D6;
	Fri, 20 Jun 2014 02:53:40 -0400 (EDT)
In-Reply-To: <53A06264.9080205@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 17 Jun 2014 17:44:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9C5F5B60-F847-11E3-8458-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252215>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It just looks asymmetric, but actually it is symmetric, which was kindof
> surprising when I realized it....
>
> Since "|branch ∧ master|" is the same for all candidates, minimizing N
> is the same as maximizing |candidate|, which is the same as
>
>     git rev-list --count --no-merges $candidate
>
> This is clearly symmetric in master vs. base.

Hmph, but that obviously will become very expensive to compute as
project grows.

When we (potentially) have multiple merge-bases, after finding all
the candidates by traversing from the two commits to be merged, we
already make another set of traversals, starting from the candidates
and painting the ancestors down to their common ancestors.  This is
done to discover if each candidate is reachable from any other
candidate (in which case the reachable one is not a merge-base).

The resulting graph of this traversal is currently used only to cull
non-merge-bases out of the candidates, but I wonder if you can
*count* the nodes in it in each color and use that number (which is
essentially the number of commits that can be reached only from one
candidate and not from other candidates) to derive a score for each
candidate, and use it to assess the goodness of merge-bases, just
like the number you are counting in the above full traversal.
