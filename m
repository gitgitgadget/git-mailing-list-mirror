From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 22/45] archive: convert to use parse_pathspec
Date: Fri, 15 Mar 2013 10:56:28 -0700
Message-ID: <7vfvzwv96b.fsf@alter.siamese.dyndns.org>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 18:57:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGYsF-00027D-C8
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 18:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab3COR4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 13:56:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3COR4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 13:56:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD0FAAD3;
	Fri, 15 Mar 2013 13:56:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5MQgPQfks52j
	2tUYSK7QCujo69g=; b=ub6IPqIQXw34NkEnlfdO2KbnEtJUNt5mgZXIvUte0Xj4
	Sg9Mv8NK5dnndQ4m0x//+gtsIMF+pT6zrqKTPYu11q81WZa6svFL+d2nAKFqhloN
	tzuMUVxc9P2GOEVLEO4T+4hZkLTthsW+wdexzIf9ykIYUNs/2PyoXkVmHc7ALNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=INRo5r
	Rrt2X7+Gnb++eeMzROFfgR8zNM+CM88bzl3XWNDAENh2PmDDsBiX5JSHDW2dC8+T
	nsKfkm9YUOPAY4Us5+3OF57YeEmt8PR1LsLwLZpAoFAUrPdjCW4FzJGcoAEySn7Y
	vtgpdKB14mU3HnABshomgd5X6yUxTdbJfIUhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84424AAD2;
	Fri, 15 Mar 2013 13:56:30 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A697AAD0; Fri, 15 Mar 2013
 13:56:29 -0400 (EDT)
In-Reply-To: <1363327620-29017-23-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 15 Mar
 2013 13:06:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA4201FC-8D99-11E2-9C51-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218257>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -232,11 +228,18 @@ static int path_exists(struct tree *tree, const=
 char *path)
>  static void parse_pathspec_arg(const char **pathspec,
>  		struct archiver_args *ar_args)
>  {
> -	ar_args->pathspec =3D pathspec =3D get_pathspec("", pathspec);
> +	/*
> +	 * must be consistent with parse_pathspec in path_exists()
> +	 * Also if pathspec patterns are dependent, we're in big
> +	 * trouble as we test each one separately
> +	 */
> +	parse_pathspec(&ar_args->pathspec, 0,
> +		       PATHSPEC_PREFER_FULL,
> +		       "", pathspec);
>  	if (pathspec) {
>  		while (*pathspec) {
>  			if (!path_exists(ar_args->tree, *pathspec))
> -				die("path not found: %s", *pathspec);
> +				die(_("pathspec '%s' did not match any files"), *pathspec);
>  			pathspec++;
>  		}

You do not use ar_args->pathspec even though you used parse_pathspec()
to grok it?  What's the point of this change?

>  	}
> diff --git a/archive.h b/archive.h
> index 895afcd..4a791e1 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -1,6 +1,8 @@
>  #ifndef ARCHIVE_H
>  #define ARCHIVE_H
> =20
> +#include "pathspec.h"
> +
>  struct archiver_args {
>  	const char *base;
>  	size_t baselen;
> @@ -8,7 +10,7 @@ struct archiver_args {
>  	const unsigned char *commit_sha1;
>  	const struct commit *commit;
>  	time_t time;
> -	const char **pathspec;
> +	struct pathspec pathspec;
>  	unsigned int verbose : 1;
>  	unsigned int worktree_attributes : 1;
>  	unsigned int convert : 1;
