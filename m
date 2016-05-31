From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Tue, 31 May 2016 15:34:22 -0700
Message-ID: <xmqqtwhd3lht.fsf@gitster.mtv.corp.google.com>
References: <20160531220818.GB46739@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 00:34:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sF5-0004Fd-1M
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbcEaWe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 18:34:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753676AbcEaWe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 18:34:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A4A31EDDB;
	Tue, 31 May 2016 18:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6DY8XpW2b/5wcQrWkG2FvNf5vh8=; b=J3aO4+
	TnMam8I4pzr9WSM5nsL8jF/TYgwddCUl2uzfEoL/Phrzms+oh1cfjpsTdkmuBUmF
	+6r2Tgf4akCchF9e/KDVZ27F6Vn4O4ZksyHSEOqi3JRGk5tQiY70TVBBjuZp/wZ5
	v1OAsCmn5eOl6QceDAnrcDb8kSlIOSB+h0C8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xco82Kg3y+JN4ickyppUxU2JYZ+FfOic
	PkWMM6vV+N1FrBHBEbOLEsfU+qYAV57z0vSc45cx9KTimdbZqppV7M2nCIOg8D42
	1BwIaDDaLOZspr6sfiUuTnRrraiL+yyvetJN0sugIlXbjndaQ7ZjiP/RShMpJhST
	spqrMRnWEqs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 535CE1EDDA;
	Tue, 31 May 2016 18:34:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0D631EDD9;
	Tue, 31 May 2016 18:34:23 -0400 (EDT)
In-Reply-To: <20160531220818.GB46739@zoidberg> (Edward Thomson's message of
	"Tue, 31 May 2016 17:08:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D32D1772-277F-11E6-BF72-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296025>

Edward Thomson <ethomson@edwardthomson.com> writes:

> +static char *chmod_arg = NULL;
> +

I'll drop " = NULL", as it is our convention to let BSS take care of
the zero initialization for global variables as much as possible.

Other than that, I did not see anything objectionable in this round,
but I did notice that you kept the "this takes two bits out of 32"
Dscho mentioned--I do not have a strong preference either way, so
I'll queue it (at least tentatively) on 'pu'.

> @@ -346,7 +354,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
>  		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
>  		 (!(addremove || take_worktree_changes)
> -		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
> +		  ? ADD_CACHE_IGNORE_REMOVAL : 0)) |
> +		 (chmod_arg && *chmod_arg == '+' ? ADD_CACHE_FORCE_EXECUTABLE : 0) |
> +		 (chmod_arg && *chmod_arg == '-' ? ADD_CACHE_FORCE_NOTEXECUTABLE : 0);
>  
>  	if (require_pathspec && argc == 0) {
>  		fprintf(stderr, _("Nothing specified, nothing added.\n"));
> diff --git a/cache.h b/cache.h
> index 6049f86..da03cd9 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -581,6 +581,8 @@ extern int remove_file_from_index(struct index_state *, const char *path);
>  #define ADD_CACHE_IGNORE_ERRORS	4
>  #define ADD_CACHE_IGNORE_REMOVAL 8
>  #define ADD_CACHE_INTENT 16
> +#define ADD_CACHE_FORCE_EXECUTABLE 32
> +#define ADD_CACHE_FORCE_NOTEXECUTABLE 64
