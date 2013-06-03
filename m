From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] unpack-trees: trivial cleanup
Date: Mon, 03 Jun 2013 10:13:39 -0700
Message-ID: <7vzjv7glrw.fsf@alter.siamese.dyndns.org>
References: <1369922181-31016-1-git-send-email-felipe.contreras@gmail.com>
	<1369922181-31016-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:13:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYKJ-0005Of-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759450Ab3FCRNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758890Ab3FCRNm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:13:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07B4F24486;
	Mon,  3 Jun 2013 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9gzYro3GSt/KL18KCktMY2V3VRk=; b=XaOx8w
	Fk9tVgZ4zAYi7EzQBqKPo3Ux5R1DE/H6Sc760I453WvPoXRA/GpU3oMw1aMJOO4b
	HpVm11Okh9aAb8dvm5InCRSU0JotvdPPSLoAE8W+ldqmESbmE2v91Ek6sy4nEToa
	/QUlHlqybzdo+uATSfUNEgyv79T5RUsuygj4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ageuyHqEOxsdP52C6rUbkpmoE2vxAP3o
	BAjxYVZqKCsGHDHQVIgDBIuwPJL/ZV+D5vBMDvizpYYJfzgqJs5NCsSIB0SX4jj+
	q5se6t0YHnqPN3bmN6Ji/42cxnXM0NcgNdxnAqKD1n+wKyaqgM2EdgPQMc0RW0vc
	oRh4JEAjsEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB24E24485;
	Mon,  3 Jun 2013 17:13:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 499AB2447E;
	Mon,  3 Jun 2013 17:13:41 +0000 (UTC)
In-Reply-To: <1369922181-31016-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 30 May 2013 08:56:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F03BEE14-CC70-11E2-B578-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226237>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> dfc has not been initialized at this point.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Upon the first entry to this function, because dfc is 

	static struct cache_entry *dfc;

it is NULL.  In that case, we allocate one instance.  When the
function is called again, we can reuse the entry, because it merely
acts as a unique sentinel value.

And we do not free() it.

>  unpack-trees.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ede4299..36f4ff7 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1040,8 +1040,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  	if (!o->skip_sparse_checkout)
>  		mark_new_skip_worktree(o->el, o->src_index, 0, CE_NEW_SKIP_WORKTREE);
>  
> -	if (!dfc)
> -		dfc = xcalloc(1, cache_entry_size(0));
> +	dfc = xcalloc(1, cache_entry_size(0));
>  	o->df_conflict_entry = dfc;
>  
>  	if (len) {
