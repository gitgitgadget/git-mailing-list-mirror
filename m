From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] bundle: give list_prerequisites() loop body its own
 function
Date: Wed, 30 Jun 2010 11:04:48 -0700
Message-ID: <7vmxuc5rcv.fsf@alter.siamese.dyndns.org>
References: <20100119002641.GA31434@gnu.kitenet.net>
 <20100626061735.GA15881@burratino> <20100626062047.GD15881@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org,
	554682@bugs.debian.org, Adam Brewster <adambrewster@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 20:05:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU1er-0000jN-Ih
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 20:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab0F3SFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 14:05:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab0F3SFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 14:05:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A887FC0248;
	Wed, 30 Jun 2010 14:05:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Seeh81fDPBdFBRA/J6m5LBM50KE=; b=eOdkO2
	FgRFehTgZaVpgUj2SbJWRixLXzXLfrDq8qll0KuPfPokV+ptUXGNk74BIWvh5olD
	UyzXHkxlZTzdLKIyOhyCiHEd7Tmhjxtpbp5xKsRfDu3/4oTPDpHL3jYRp9bJyBwX
	PVzMKIPKzXaQbbfekS2h+n3NBqJnm+6jOrPpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B1dGjIYCjL7jgsTAE8KrVHELbE3uJ5z6
	WpKMLDn4Vm/8ThqGDmVjAxyJVUIBAFE2NWWC4X5nQaO64hW9fwzHpVnwQB3IEkHu
	7JiawKpNBHkR7NzZCHX7R5V8OcqDmwHPGo1qialitk3CQdfNWHRfOdIYRry1kt2d
	qSU7MFIVloI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 457F4C0241;
	Wed, 30 Jun 2010 14:04:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 235F1C023B; Wed, 30 Jun
 2010 14:04:49 -0400 (EDT)
In-Reply-To: <20100626062047.GD15881@burratino> (Jonathan Nieder's message of
 "Sat\, 26 Jun 2010 01\:20\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE082732-8471-11DF-9C4F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149983>

Jonathan Nieder <jrnieder@gmail.com> writes:

> No functional change intended.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  bundle.c |   57 +++++++++++++++++++++++++++++++--------------------------
>  1 files changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 0dd2acb..e90b5c5 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -193,6 +193,33 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
>  		(revs->min_age == -1 || revs->min_age > date);
>  }
>  
> +static void list_prerequisite(int bundle_fd, struct rev_info *revs,
> +		struct commit *rev)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +	enum object_type type;
> +	unsigned long size;
> +
> +	/*
> +	 * The commit buffer is needed
> +	 * to pretty-print boundary commits.
> +	 */
> +	rev->buffer = read_sha1_file(rev->object.sha1, &type, &size);
> +
> +	strbuf_addch(&buf, '-');
> +	strbuf_add(&buf, sha1_to_hex(rev->object.sha1), 40);
> +	strbuf_addch(&buf, ' ');
> +	pretty_print_commit(CMIT_FMT_ONELINE, rev, &buf, &ctx);
> +	strbuf_addch(&buf, '\n');
> +
> +	write_or_die(bundle_fd, buf.buf, buf.len);
> +
> +	rev->object.flags |= UNINTERESTING;
> +	add_pending_object(revs, &rev->object, buf.buf);
> +	strbuf_release(&buf);
> +}
> +
>  static int list_prerequisites(int bundle_fd, struct rev_info *revs,
>  		int argc, const char * const *argv)
>  {
> @@ -209,33 +236,11 @@ static int list_prerequisites(int bundle_fd, struct rev_info *revs,
>  	if (prepare_revision_walk(&boundary_revs))
>  		return error("revision walk setup failed");
>  
> -	while ((rev = get_revision(&boundary_revs))) {
> -		if (rev->object.flags & BOUNDARY) {
> -...
> -		} else {
> +	while ((rev = get_revision(revs))) {
> +		if (rev->object.flags & BOUNDARY)
> +			list_prerequisite(bundle_fd, revs, rev);
> +		else
>  			rev->object.flags |= SHOWN;
> -		}

You used to walk boundary_revs but now you walk revs that is given by the
caller, exhausting the revs.pending the caller wanted to use later to feed
pack_objects with?

Confused...
