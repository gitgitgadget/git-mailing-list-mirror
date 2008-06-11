From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Wed, 11 Jun 2008 16:51:49 -0700
Message-ID: <7vprqna5t6.fsf@gitster.siamese.dyndns.org>
References: <2acf029a4230f840e9f3f936e1949e01c774b4a2.1213217187.git.vmiklos@frugalware.org> <1213219039-1211-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:53:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6a81-0006Py-0z
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbYFKXwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbYFKXwF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:52:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYFKXwC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:52:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 549464F01;
	Wed, 11 Jun 2008 19:52:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 798B94EFE; Wed, 11 Jun 2008 19:51:57 -0400 (EDT)
In-Reply-To: <1213219039-1211-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Wed, 11 Jun 2008 23:17:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62C026C0-3811-11DD-AFEF-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84687>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/commit.c b/commit.c
> index bbf9c75..f9410d8 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -600,6 +600,33 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
>  	return result;
>  }
>  
> +struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
> +{
> +	struct commit_list *i, *j, *k, *ret = NULL;
> +	struct commit_list **pptr = &ret;
> +
> +	for (i = in; i; i = i->next) {
> +		if (!ret)
> +			pptr = &commit_list_insert(i->item, pptr)->next;
> +		else {
> +			struct commit_list *new = NULL, *end = NULL;
> +
> +			for (j = ret; j; j = j->next) {
> +				struct commit_list *bases;
> +				bases = get_merge_bases(i->item, j->item, cleanup);

Why is passing "cleanup" through to get_merge_bases() safe, even when you
are running it more than once?

get_merge_bases() uses PARENT1, PARENT2 and other flags internally, and
the information necessary to clean them efficiently (i.e. the set of
commits that could be smudged with these flags due to its operation) is
known only to it _after it finishes_.  You cannot even say "previous run
did not clean things up, so please clean-up before starting this round"
upfront.  That is why we have clean-up loops at the _end_ of the function
after it finishes computing what it wants to return.

The only reason clean-up is optional to the function is because there are
one-shot callers such as "git merge-base" that do not want to pay penalty
for cleaning up (the only time you do not have to tell it to clean up is
when you know the invocation is the _last_ invocation of the function, iow
there is no later invocation that will be harmed by leftover flags).
