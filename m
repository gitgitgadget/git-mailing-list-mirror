From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/ PATCH 2/5] unpack_trees: group errors by type
Date: Wed, 09 Jun 2010 09:50:20 -0700
Message-ID: <7v39wwp2ur.fsf@alter.siamese.dyndns.org>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr>
 <1276087446-25112-4-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 09 18:50:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMOUA-0000rF-Vx
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 18:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758003Ab0FIQud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 12:50:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992Ab0FIQuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 12:50:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A7ADBA786;
	Wed,  9 Jun 2010 12:50:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5d0csnB1305dfb0aTt3+oEtysx8=; b=mLbLTNNjittxqDHcKti/D3L
	TYYgZbvryKNwxv0HrVpclB2+ejEYxK1PkBs/W85ZEgs7VKIGYOsZJRW4WeRSsBtV
	ulC5GB+VUAlmp7olVO6xt6q+eRQUCTGUSaJcLzwr1l5sC3VUBy5MFglw85Zk2Hc8
	tHgCsEoc+wVJsHN9j97Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iSe+qZDzsP9eb6OoVs1WuOK/kbLKogDD5eJuWMI/JlfqZFjfv
	e+MUgx5mgS4GPe3WulXaAlKddZVLGcT7gdZz7YwdSf+SytKjqrXDYlxG7j0W/H80
	WT4428jR0Dz1P6FAojpd/244fnuAn9bPsfYVJt6TlJ3sWuHx7itHjZUzj4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1C5CBA782;
	Wed,  9 Jun 2010 12:50:27 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71C9EBA77D; Wed,  9 Jun
 2010 12:50:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B4AEE10-73E7-11DF-AC80-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148792>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> +/*
> + * Store error messages in an array, each case
> + * corresponding to a error message type
> + */
> +typedef enum {
> +	would_overwrite,
> +	not_uptodate_file,
> +	not_uptodate_dir,
> +	would_lose_untracked,
> +	would_lose_untracked_removed,
> +	sparse_not_uptodate_file
> +} unpack_trees_error;
> +#define NB_UNPACK_TREES_ERROR 6
> +struct rejected_files *unpack_rejects[NB_UNPACK_TREES_ERROR];

You folks seem to like global variables a lot...  Isn't there a struct
passed throughout the callchain in unpack_trees that you can attach this
information to?

Also "rejected_files" is not as technically correct (there are symlinks)
as "rejected_paths".

Style: we don't encourage "typedef enum { ... } unpack_trees_error";
instead we tend to just say "enum unpack_trees_error" both in the
definition and in the use.

> +	if (!porcelain) {
> +		error(msg,file,action);
> +		return -1;
> +	}

Style:
	if (!porcelain)
        	return error(msg, file, action);

> +static void free_rejected_files(unpack_trees_error e)
> +{
> +	while(unpack_rejects[e]->list) {

Style:
	while (unpack_rejects[e]->list) {

> +static void display_error_msgs()
> +{
> +	int i;
> +	int hasPorcelain = 0;

Style: we don't encourage camelCase.

Whichever way spelled, "has porcelain?" is puzzling.

Is this about "are we issuing error messages as a Porcelain program, or
are we a plumbing without noisy error messages?"  Or is this about "have
we said anything in the loop, and if so finish the message with
'Aborting'"?  If the former, I would name it after "we are Porcelain";
if the latter, I would name it after "we said something".

> +	for (i=0; i<NB_UNPACK_TREES_ERROR; i++) {

Style:

	for (i = 0; i < NB_UNPACK_TREES_ERROR; i++) {

> +		if (unpack_rejects[i] && unpack_rejects[i]->list) {
> +			hasPorcelain = 1;
> +			struct rejected_files_list *f = unpack_rejects[i]->list;
> +			char *action = unpack_rejects[i]->action;
> +			char *file = malloc(unpack_rejects[i]->size+1);
> +			*file = '\0';
> +			while (f) {
> +				strcat(file,"\t");
> +				strcat(file,f->file);
> +				strcat(file,"\n");
> +				f = f->next;
> +			}
> +			error(unpack_rejects[i]->msg,file,action);
> +			free_rejected_files(i);

It feels wrong to malloc() inside the loop (and without freeing, which is
worse).  At least the code should use strbuf to do something like:

	struct strbuf indented = STRBUF_INIT;
	for (f = unpack_rejects[i]->list; f; f = f->next)
                strbuf_addf(&indented, "\t%s\n", f->file);
	error(..., indented.buf, action);
        strbuf_release(&indented);
