From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] commit: push commit_index update into alloc_commit_node
Date: Tue, 10 Jun 2014 14:31:58 -0700
Message-ID: <xmqqfvjc8n8x.fsf@gitster.dls.corp.google.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609180959.GB20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:32:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTeM-0006VB-SV
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbaFJVcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:32:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59514 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109AbaFJVcE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:32:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF8D31ED85;
	Tue, 10 Jun 2014 17:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YigOiSN5Hz8o1CVBsPXOygcmU8Q=; b=ZWsYVf
	a8iiqqv0N2v12kMh7KupGXRf8jEUIYMNvqMEv3CafK0t0/G3UHLeLqBC7mi95o9H
	AUrOor5/hGaU5pLgLWLfbk9eihCIKJ9+5AZpDE037A55EpLxnz8aJEmhekTwjZ1V
	rE5wgwUPnBNwLb1fkw1CCSGaNsIT3I11IKjmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lxEmrhl1X6FUi1UJvsp2HZ+x1AI9QXRm
	RRpxCabLH5LfrFlAR3aRz7J680I2ECO/IV1QmZi2XxEIlECSk4vF6ggM6fmGcazR
	oP6ofpj0+NTr8VyOpSPd0t/DAdurwpr3VKhAp8szyCLvJa/VyVrS1CdO4fUjMHL4
	EHSdPoc9pJo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E572B1ED84;
	Tue, 10 Jun 2014 17:32:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F13301ED7A;
	Tue, 10 Jun 2014 17:31:59 -0400 (EDT)
In-Reply-To: <20140609180959.GB20315@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 Jun 2014 14:09:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A7D2A4D8-F0E6-11E3-94B0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251241>

Jeff King <peff@peff.net> writes:

> This will make the alloc_report output a little uglier (it will say
> raw_commit), but I don't think anyone cares. And I wanted to make sure
> there wasn't an easy way to accidentally call the wrong alloc function
> that doesn't handle the index.

Thanks; I like this change.

>
>  alloc.c  | 12 ++++++++++--
>  commit.c |  2 --
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/alloc.c b/alloc.c
> index 38ff7e7..eb22a45 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -47,10 +47,18 @@ union any_object {
>  
>  DEFINE_ALLOCATOR(blob, struct blob)
>  DEFINE_ALLOCATOR(tree, struct tree)
> -DEFINE_ALLOCATOR(commit, struct commit)
> +DEFINE_ALLOCATOR(raw_commit, struct commit)
>  DEFINE_ALLOCATOR(tag, struct tag)
>  DEFINE_ALLOCATOR(object, union any_object)
>  
> +void *alloc_commit_node(void)
> +{
> +	static int commit_count;
> +	struct commit *c = alloc_raw_commit_node();
> +	c->index = commit_count++;
> +	return c;
> +}
> +
>  static void report(const char *name, unsigned int count, size_t size)
>  {
>  	fprintf(stderr, "%10s: %8u (%"PRIuMAX" kB)\n",
> @@ -64,7 +72,7 @@ void alloc_report(void)
>  {
>  	REPORT(blob, struct blob);
>  	REPORT(tree, struct tree);
> -	REPORT(commit, struct commit);
> +	REPORT(raw_commit, struct commit);
>  	REPORT(tag, struct tag);
>  	REPORT(object, union any_object);
>  }
> diff --git a/commit.c b/commit.c
> index f479331..21957ee 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -17,7 +17,6 @@ static struct commit_extra_header *read_commit_extra_header_lines(const char *bu
>  int save_commit_buffer = 1;
>  
>  const char *commit_type = "commit";
> -static int commit_count;
>  
>  static struct commit *check_commit(struct object *obj,
>  				   const unsigned char *sha1,
> @@ -64,7 +63,6 @@ struct commit *lookup_commit(const unsigned char *sha1)
>  	struct object *obj = lookup_object(sha1);
>  	if (!obj) {
>  		struct commit *c = alloc_commit_node();
> -		c->index = commit_count++;
>  		return create_object(sha1, OBJ_COMMIT, c);
>  	}
>  	if (!obj->type)
