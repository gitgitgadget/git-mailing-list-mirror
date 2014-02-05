From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Wed, 05 Feb 2014 09:36:55 -0800
Message-ID: <xmqqfvnx5umg.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
	<xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
	<xmqqeh3jbwbt.fsf@gitster.dls.corp.google.com>
	<20140204163400.GA20436@tugrik.mns.mnsspb.ru>
	<xmqq4n4eafmj.fsf@gitster.dls.corp.google.com>
	<20140205165119.GA18558@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed Feb 05 18:37:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB6PP-0005qR-Ds
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 18:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbaBERhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 12:37:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbaBERhB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 12:37:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C59FD6805A;
	Wed,  5 Feb 2014 12:37:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IWCLhc/DEJYE410utOj6J0WYoGU=; b=ptBh5P
	pnOHqa3UiAgAE6poDbz6XUN5uTT+NAeqXAjJO07Vo01UJXUul0+gDj5jMqP5yxJ7
	8OghsibsGgA1lr9r3yeBZP/p2DDLuQIAdls/peYGuG6/Wjn+bP3p22N8z5rm4Z9H
	FU/BV8DAjdOlSypOxw5QdxInnFaP9IBMdDgr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UZbZu37OKS7kLwcb1XLr6ns+HC+eJ2Ft
	S/1wXyrgOdsv232Ti2Sq3gC8lSAVne6BK1OUMXBuRyawUO0EkGOKVKaJry2rNOCo
	2xAusbXiSyu58oo3sVSMd+FgvBu6xNrrDc9o8FR9j2rvl1yz0p/Zaes87NPQdvxw
	4NgN4w7wHTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3059F68058;
	Wed,  5 Feb 2014 12:37:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19B7568056;
	Wed,  5 Feb 2014 12:36:59 -0500 (EST)
In-Reply-To: <20140205165119.GA18558@tugrik.mns.mnsspb.ru> (Kirill Smelkov's
	message of "Wed, 5 Feb 2014 20:51:19 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1D67DCE4-8E8C-11E3-BF95-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241617>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Only, before I clean things up, I'd like to ask - would the following
> patch be accepted
>
> ---- 8< ---
> diff --git a/tree-walk.c b/tree-walk.c
> index 79dba1d..4dc86c7 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -37,7 +37,7 @@ static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned
>  
>  	/* Initialize the descriptor entry */
>  	desc->entry.path = path;
> -	desc->entry.mode = mode;
> +	desc->entry.mode = canon_mode(mode);
>  	desc->entry.sha1 = (const unsigned char *)(path + len);
>  }
>  
> diff --git a/tree-walk.h b/tree-walk.h
> index ae04b64..ae7fb3a 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -16,7 +16,7 @@ struct tree_desc {
>  static inline const unsigned char *tree_entry_extract(struct tree_desc *desc, const char **pathp, unsigned int *modep)
>  {
>  	*pathp = desc->entry.path;
> -	*modep = canon_mode(desc->entry.mode);
> +	*modep = desc->entry.mode;
>  	return desc->entry.sha1;
>  }
> ---- 8< ---
>  
> ?

Doesn't desc point into and walks over the data we read from the
tree object directly?

We try to keep (tree|commit)->buffer intact and that is done pretty
deliberately.  While you are walking a tree or parsing a commit,
somebody else, perhaps called indirectly by a helper function you
call, may call lookup_object() for the same object, get the copy
that has already been read and start using it.  This kind of change
will introduce bugs that are hard to debug unless it is done very
carefully (e.g. starting from making tree.buffer into a const pointer
and propagating constness throughout the system), which might not be
worth the pain.
