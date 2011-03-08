From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Re: BUG? git log -Sfoo --max-count=N
Date: Tue, 08 Mar 2011 11:22:03 -0800
Message-ID: <7vvczte7tw.fsf@alter.siamese.dyndns.org>
References: <87hbbgvske.fsf@wanadoo.es> <vpqpqq3qern.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?=C3=93scar?= Fuentes <ofv@wanadoo.es>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px2U9-0002JF-UC
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab1CHTWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:22:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436Ab1CHTWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:22:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B5F23005;
	Tue,  8 Mar 2011 14:23:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E4ep2mX8l6FzAnoWFUMiI7avNls=; b=HNgHoO
	tq6zRyXceLaFQHRl7cym6O+bIolzBSR6Hmy0hk7P2r6DLqEi/x80+u2PLlZUohIh
	m2rRFvAoADrhutblYrS0RE2WGHLTTra9O8N427w8kTzW3R8smVEs/JLZdNzWOrLM
	AyvUHoZFdG5S8S5ahqZ6oaNJmhV1iyWMBnnD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fC4/tfmYr2hof9NVtrkXw+h9o0FahcEY
	Z7qrRVeTxdf7u5kQK/FtPdEgGzS7jeRM+pG1Il6S9LHL1vm77u5XnOwhoIjOzgdm
	svLh8nH2ghDJ6rOKHnKL2L4dn7e5r7+Y8J92oU+59i6H1DatJgdw+eaIN2SDQLSy
	jMImJPfjHLI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EBD253004;
	Tue,  8 Mar 2011 14:23:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23BF93003; Tue,  8 Mar 2011
 14:23:31 -0500 (EST)
In-Reply-To: <vpqpqq3qern.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 07 Mar 2011 13:46:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90D63934-49B9-11E0-9EB7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168677>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> In case the commit isn't actually shown, cancel the decrement of
> max_count.

I briefly wondered if this change is enough to deal with the way boundary
commits are handled in revision.c::get_revision_internal().  Once the
count drops to zero, the function switches to "boundary commits output
mode", and incrementing the variable after that happens wouldn't have any
effect, but that happens only upon the next call to get_revision() that
has zero in max_count upon entry to the function, so incrementing here
would be compatible with the precondition of that function.

I agree that this codepath is subtle, but it doesn't feel a particularly
good change to move the call to log_tree_commit() to get_revision() as a
general callback, either.  The function does way too many things other
than "determine if this commit is shown and return 0/1".

> ---
>  builtin/log.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index f5ed690..b83900b 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -263,7 +263,12 @@ static int cmd_log_walk(struct rev_info *rev)
>          * retain that state information if replacing rev->diffopt in this loop
>          */
>         while ((commit = get_revision(rev)) != NULL) {
> -               log_tree_commit(rev, commit);
> +               if (!log_tree_commit(rev, commit))
> +                       /*
> +                        * We decremented max_count in get_revision,
> +                        * but we didn't actually show the commit.
> +                        */
> +                       rev->max_count++;
>                 if (!rev->reflog_info) {
>                         /* we allow cycles in reflog ancestry */
>                         free(commit->buffer);
> -- 
> 1.7.4.1.176.g6b069.dirty
