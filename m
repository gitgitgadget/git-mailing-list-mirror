From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] archive: add user-configurable tar-filter
 infrastructure
Date: Wed, 15 Jun 2011 16:33:33 -0700
Message-ID: <7vr56uisaa.fsf@alter.siamese.dyndns.org>
References: <20110615223030.GA16110@sigill.intra.peff.net>
 <20110615223301.GB16807@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 01:33:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWzaf-00013L-I1
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 01:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab1FOXdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 19:33:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48356 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab1FOXdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 19:33:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2B1063AB;
	Wed, 15 Jun 2011 19:35:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=a2EBw+0GMj/yys38xznKLEaj6+w=; b=WAZ/J4/yxfhbTC/lrBkO
	RBwWqP6NizQvBkMbbOOQXt0Bg3XmnCQBNPBtY4f+qF4ukgEL9DTlbuIZV0M5xqLn
	2qUdpKVMF4Q4gUy4rfSee3GakuA2t9RJjdib0K2PDWaAz1TnAQohnMOsHYkkMu7b
	IlsLgmogzEksTrfA/Aa7oMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=XUutQewXBQL6ujU1BmPLLLuSV8fUNxFEKItlg0jR5EnxN/
	BZW5FKH+dMmWyqInUMNVVRmtm3rR/WZyrgz54PSNyxocLkgmNfy8l5cyxR47WakX
	TbPXhpa4ACtVBRqV5x114L9gzjQjV+cGgZ3hMEOArO4oKXAa6zo5Zpdw4GZ30=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EAB3163AA;
	Wed, 15 Jun 2011 19:35:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37D9F63A9; Wed, 15 Jun 2011
 19:35:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30EF4E92-97A8-11E0-AA32-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175869>

Jeff King <peff@peff.net> writes:

> Archive supports two output formats: tar and zip. The tar
> ...
> +static struct tar_filter *tar_filter_by_namelen(const char *name,
> +						int len)
> +{
> +	struct tar_filter *p;
> +	for (p = tar_filters; p; p = p->next)
> +		if (!strncmp(p->name, name, len) && !p->name[len])
> +			return p;
> +	return NULL;
> +}

Makes me wonder if we want to have a generic table that is keyed by name
whose contents can be looked up by counted string. string_list is the
closest thing we already have, but I do not think it has counted string
interface (shouldn't be a rocket surgery to add it, though).

> +static int tar_filter_config(const char *var, const char *value, void *data)
> +{
> ...
> +	if (!strcmp(type, "command")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		tf->command = xstrdup(value);

Does this result in small leak if the same filter is multiply defined, say
in /etc/gitconfig and then in ~/.gitconfig?

> diff --git a/archive.h b/archive.h
> index 038ac35..8386c46 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -1,6 +1,8 @@
>  #ifndef ARCHIVE_H
>  #define ARCHIVE_H
>  
> +#include "string-list.h"
> +
>  struct archiver_args {
>  	const char *base;
>  	size_t baselen;
> @@ -27,4 +29,17 @@ extern int write_zip_archive(struct archiver_args *);
>  extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
>  extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
>  
> +struct tar_filter {
> +	char *name;
> +	char *command;
> +	struct string_list extensions;
> +	unsigned use_compression:1;

I suspect that you plan to pass sprintf("-%d", level) for the ones marked
with this bit, but I wonder if we want to give a bit more control on how a
compression level option is shaped for the particular command, and where
on the command line the option comes.  As long as we are targetting gzip
and nothing else it is fine, and I suspect newer compression commands
would try to mimic the -[0-9] command line interface gzip has (e.g. xz),
so this probably is not an issue in practice.
