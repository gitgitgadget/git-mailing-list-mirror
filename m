From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] rev-parse: add option --is-well-formed-git-dir
 [path]
Date: Thu, 11 Aug 2011 16:34:42 -0700
Message-ID: <7v62m3plnx.fsf@alter.siamese.dyndns.org>
References: <1312831022-12868-1-git-send-email-iveqy@iveqy.com>
 <1312831022-12868-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jens.lehmann@web.de, hvoigt@hvoigt.net
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 01:34:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrem0-0002YS-Rm
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 01:34:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab1HKXep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 19:34:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab1HKXeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 19:34:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E69754796;
	Thu, 11 Aug 2011 19:34:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=7CkeKryqXRdlUyY7Rxuh45gqk0I=; b=ZMqUUGE7SFxVFoUTDbIB
	uRcdCJRT3WRSFVlM4ctjVrsTpdgB3/Wk0NQi3K+ga50ug1n/MVKFi3zGSo+0+t7j
	NHfAXf124bIT3nNrsTk6HGpyXL6FaGiIrymGWNH0dAhL0ZLDIRTTPW/iWc0ku+zg
	hCmHyjBIKcqo4DxjlVhGdyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Ae4lCGnv4qq8SiQqraZwWNWmEAeNpZPYDGwbOrAHQrQrED
	+u7QYUSEBnfxrSLDn18JHctB/k7ESwZ93Nz7g86lqyxhXZjAAyRcF4qWRhfOjvr/
	m2hXEsJhttV0UgXFLd1Z3q3DR/Jg4iRuvjCwP+lVhbXxBmZq6SfehZj40KIGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD9D34795;
	Thu, 11 Aug 2011 19:34:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DDD74794; Thu, 11 Aug 2011
 19:34:43 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7DA83E82-C472-11E0-813D-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179153>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 4c19f84..82342b3 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -455,6 +455,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  	unsigned char sha1[20];
>  	const char *name = NULL;
>  
> +	if (argc > 2 && !strcmp(argv[1], "--is-well-formed-git-dir")) {
> +		const char *gitdir = resolve_gitdir(argv[2]);
> +		if(!gitdir)

(style) SP immediately after "if".

> +			die("not a gitdir");

die("not a gitdir '%s'", argv[2]) perhaps?

> +		puts(gitdir);
> +		return 0;
> +	}
> +
>  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
>  		return cmd_parseopt(argc - 1, argv + 1, prefix);

When adding a new element to existing list of other similar things, I
would prefer to see it added at the end (in this case, just before "-h",
which is kind of special), unless there is a good justification not to
(e.g. the list is sorted alphabetically).

> diff --git a/setup.c b/setup.c
> index 5ea5502..15bc305 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -808,3 +808,10 @@ const char *setup_git_directory(void)
>  {
>  	return setup_git_directory_gently(NULL);
>  }
> +
> +const char *resolve_gitdir(const char *suspect)
> +{
> +	if(is_git_directory(suspect))

(style) SP immediately after "if".
