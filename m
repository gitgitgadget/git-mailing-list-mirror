From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] implement automatic fast-forward merge for
 submodules
Date: Wed, 07 Jul 2010 09:56:45 -0700
Message-ID: <7vwrt7w7qq.fsf@alter.siamese.dyndns.org>
References: <cover.1278508352.git.hvoigt@hvoigt.net>
 <cover.1278508352.git.hvoigt@hvoigt.net>
 <3cff3f0b6b859180556ab5ef5345179e603609a9.1278508352.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, jens.lehmann@web.de,
	jherland@gmail.com
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 18:57:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWXvk-0008P2-8o
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 18:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab0GGQ46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 12:56:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab0GGQ45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 12:56:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F8AC22D3;
	Wed,  7 Jul 2010 12:56:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3XfiM88LekoanscMKrAC4DxtiNw=; b=U1xrf2h9SjF5TWMIFReM87Q
	TanRBVt9l3CLYhjLpvIyrfxWvKbX0buDmqxRCtET514AdRC8ilICC4KdscVetzoa
	VHlE4KLOloY8xU7tbguK5Ff5hUEVwYxT34DRA8Y6PO2iF8KQcLj/sOCAgrCQWKrz
	65S9oCIjPXv3Fun7nVss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GSPoHzj6ayftx1VPYCby/1cOsec9I8fse/qjwMkp2NIBdkRw4
	n6gHLqFb1iRhglZw6ARK+SW1vIyP2Z5KdoZJD2NtfUyNRRolZeX0E3LycNeb3a8b
	xpaarN6UNIqbfhSGV/MPbc03orJcovPeCFs0hnnAmlg0QCGRDSKIdH4uxo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0950BC22CF;
	Wed,  7 Jul 2010 12:56:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC7F2C22CB; Wed,  7 Jul
 2010 12:56:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A4866E18-89E8-11DF-8404-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150482>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/submodule.c b/submodule.c
> index 61cb6e2..9bc4b80 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -6,6 +6,7 @@
>  #include "revision.h"
>  #include "run-command.h"
>  #include "diffcore.h"
> +#include "refs.h"
>  
>  static int add_submodule_odb(const char *path)
>  {
> @@ -218,3 +219,164 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
> ...
> +	while ((commit = get_revision(&revs)) != NULL) {
> +		struct object *o = &(commit->object);
> +		if (in_merge_bases(b, &commit, 1)) {
> +			add_object_array(o, NULL, &merges);
> +		}

Unnecessary braces around a single statement.  I've fixed some other style
violations to this file while replacing the topic branch.

> ...
> +static void print_commit(struct commit *commit)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct pretty_print_context ctx = {0};
> +	ctx.date_mode = DATE_NORMAL;
> +	format_commit_message(commit, " %h: %m %s", &sb, &ctx);
> +	fprintf(stderr, "%s\n", sb.buf);
> +}

strbuf_release(&sb)???
