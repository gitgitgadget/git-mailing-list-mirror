From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-files: allow relative pathspec
Date: Tue, 25 May 2010 22:07:39 -0700
Message-ID: <7v1vczqmhw.fsf@alter.siamese.dyndns.org>
References: <20100522163525.GA12420@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed May 26 07:07:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH8qQ-0005XB-De
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933290Ab0EZFHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 01:07:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab0EZFHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 01:07:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B750B67CB;
	Wed, 26 May 2010 01:07:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Pio9paHDTFQBz3XCZJqHS5I4Fc8=; b=jRYPZ3l47BSTrODTGez+NSF
	0XQryY63rdNWkGc6HsRMV78NgMeXtPZjTPZAkz4bqltzPWm4IK1bYY2UIl/P6wdF
	ZZc29HhWJR4HgB7eIRkGj4kte4QcSh3gQhj5Fk1wS5QPATQMR0erRXNx1lzWX64C
	WkLV8W0lTxG0UKwA470Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Dh8WYHe3gVT4+4YoGTaIMbLvpx/CmAci1BgGJL69BWWTJ/PhS
	qSKd6H7Qo+Gv1eFQHh7sHs39WF1oZESuc1xANh9PcI1QGtFsD7GE1OseIZ+wqviA
	10DZ2vIooNp0XBc/PRTWCYHkTbQo8pP/ht+qlIAV+0IAcQ4+E8ixHoQb2I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F3C57B67C8;
	Wed, 26 May 2010 01:07:44 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 227D1B67C2; Wed, 26 May
 2010 01:07:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9E9134E6-6884-11DF-8037-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147740>

Clemens Buchacher <drizzd@aon.at> writes:

> git ls-files used to error out if given paths which point outside
> the current working directory, such as '../'. We now allow such
> paths and the output is analogous to git grep -l.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>  builtin/ls-files.c |   61 +++++++++++++++++++++++++++++-----------------------
>  t/t7010-setup.sh   |   12 +++------
>  2 files changed, 38 insertions(+), 35 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index c0fbcdc..441da81 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> ...
> @@ -177,19 +185,19 @@ static int show_one_ru(struct string_list_item *item, void *cbdata)
>  		printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
>  		       find_unique_abbrev(ui->sha1[i], abbrev),
>  		       i + 1);
> -		write_name_quoted(path + offset, stdout, line_terminator);
> +		write_name(path, len);
>  	}
>  	return 0;
>  }
>  
> -static void show_ru_info(const char *prefix)
> +static void show_ru_info()

s/info()/info(void)/;

> @@ -265,7 +273,7 @@ static void prune_cache(const char *prefix)
>  	active_nr = last;
>  }
>  
> -static const char *verify_pathspec(const char *prefix)
> +static const char *verify_pathspec(const char* prefix)

Please don't; this is not C++.

> @@ -456,9 +461,10 @@ static int option_parse_exclude_standard(const struct option *opt,
>  	return 0;
>  }
>  
> -int cmd_ls_files(int argc, const char **argv, const char *prefix)
> +int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  {
>  	int require_work_tree = 0, show_tag = 0;
> +	const char *max_prefix;

This variable is used uninitialized when pathspec is NULL, I think.

Other than that, the patch feels sane.  Thanks.
