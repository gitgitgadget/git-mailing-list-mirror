From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Produce a nicer output in case of sha1_object_info
 failures in ls-tree -l
Date: Thu, 19 Mar 2009 16:08:43 -0700
Message-ID: <7v4oxp6rgk.fsf@gitster.siamese.dyndns.org>
References: <20090319203002.GA31014@blimp.localdomain>
 <7v4oxp89eb.fsf@gitster.siamese.dyndns.org>
 <20090319220020.GA8433@blimp.localdomain>
 <7vmybh6u15.fsf@gitster.siamese.dyndns.org>
 <20090319225429.GC8433@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRNX-0008SA-1l
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbZCSXIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbZCSXIx
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:08:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45679 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbZCSXIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:08:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CACB7ADA;
	Thu, 19 Mar 2009 19:08:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 719E37AD9; Thu,
 19 Mar 2009 19:08:45 -0400 (EDT)
In-Reply-To: <20090319225429.GC8433@blimp.localdomain> (Alex Riesen's message
 of "Thu, 19 Mar 2009 23:54:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7EB03F0-14DA-11DE-9E6A-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113856>

Alex Riesen <raa.lkml@gmail.com> writes:

> How about this patch instead? I chose "BAD" for the marker, as any
> automatic processing trying blindly to convert it into a number will
> get a 0, which seems safe to me.

Such a broken automatic processing won't mind getting any garbage; the
choice among this patch, your original "say 0 when we do not know" patch,
or unpatched "size is undefined when an entry is corrupt" git wouldn't
make a whit of difference to it.

An automatic processing that does validate its input will notice BAD is
not a number, and can handle such a corrupt entry more sanely, which is
potentially a big plus.

I think this round is a big improvement.

>  builtin-ls-tree.c |   22 ++++++++++++----------
>  1 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
> index fca4631..22008df 100644
> --- a/builtin-ls-tree.c
> +++ b/builtin-ls-tree.c
> @@ -60,7 +60,6 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
>  {
>  	int retval = 0;
>  	const char *type = blob_type;
> -	unsigned long size;
>  
>  	if (S_ISGITLINK(mode)) {
>  		/*
> @@ -90,17 +89,20 @@ static int show_tree(const unsigned char *sha1, const char *base, int baselen,
>  
>  	if (!(ls_options & LS_NAME_ONLY)) {
>  		if (ls_options & LS_SHOW_SIZE) {
> +			char size_text[24];
>  			if (!strcmp(type, blob_type)) {
> -				sha1_object_info(sha1, &size);
> -				printf("%06o %s %s %7lu\t", mode, type,
> -				       abbrev ? find_unique_abbrev(sha1, abbrev)
> -				              : sha1_to_hex(sha1),
> -				       size);
> +				unsigned long size;
> +				if (sha1_object_info(sha1, &size) == OBJ_BAD)
> +					strcpy(size_text, "BAD");
> +				else
> +					snprintf(size_text, sizeof(size_text),
> +						 "%lu", size);
>  			} else
> -				printf("%06o %s %s %7c\t", mode, type,
> -				       abbrev ? find_unique_abbrev(sha1, abbrev)
> -				              : sha1_to_hex(sha1),
> -				       '-');
> +				strcpy(size_text, "-");
> +			printf("%06o %s %s %7s\t", mode, type,
> +			       abbrev ? find_unique_abbrev(sha1, abbrev)
> +				      : sha1_to_hex(sha1),
> +			       size_text);
>  		} else
>  			printf("%06o %s %s\t", mode, type,
>  			       abbrev ? find_unique_abbrev(sha1, abbrev)
> -- 
> 1.6.2.1.237.g7206c6
