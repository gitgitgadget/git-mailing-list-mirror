From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 18/19] setup.c: document get_pathspec()
Date: Fri, 28 Dec 2012 12:36:34 -0800
Message-ID: <7v7go1j4ml.fsf@alter.siamese.dyndns.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
 <1356575558-2674-19-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:37:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Togg7-0008A8-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab2L1Ugl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:36:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139Ab2L1Ugh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:36:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FBB0A9D2;
	Fri, 28 Dec 2012 15:36:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ex4ii+laUCT6Pt3ORjusZf4D7/o=; b=mYtBwe
	fcfg/3CBI1o5Txch7hoF7QpIm/+Y2/cjAfa28zQsWJWMTyUVvSoNAgBzeGtZskgD
	aHyN38su0UwVIzvrNHCAuf7I8OYPviyAgIaoASpbWpcjbFSPsjOHKr8l11lGY/2c
	GsF0yDuMzGgMc3YjYr9h6R9oRSfx0Zj7hPJLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QXj6sJPD+PnTXwZ7PkxCmdpsdvmXeB24
	z/EOA6Fhv/WG6b7yuESyBu9vMsSCtokBONMZRHvZiegC6AY03FE0g+XrYe5dqQpa
	aNwJPv+w44HERVI14brQ9AMAOdgkUZwQoKm3j7+aL5Eh4JLZXp4sRnX0LyZipbQZ
	Ac3TvJGPupg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E4E9A9D1;
	Fri, 28 Dec 2012 15:36:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D03DDA9D0; Fri, 28 Dec 2012
 15:36:35 -0500 (EST)
In-Reply-To: <1356575558-2674-19-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 27 Dec 2012 02:32:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45F58306-512E-11E2-AB48-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212258>

Adam Spiers <git@adamspiers.org> writes:

> Since we have just created a new pathspec-handling library, now is a
> good time to add some comments explaining get_pathspec().
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---

Yes, but we would rather not to see new users of this function added
to our codebase in its current form, as explained in the nearby
comment.  We would want to migrate everybody to "struct pathspec"
based interface to support magic pathspecs in the longer term.

>  setup.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/setup.c b/setup.c
> index 7663a4c..03d6d5c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -249,6 +249,21 @@ static const char *prefix_pathspec(const char *prefix, int prefixlen, const char
>  		return prefix_path(prefix, prefixlen, copyfrom);
>  }
>  
> +/*
> + * prefix - a path relative to the root of the working tree
> + * pathspec - a list of paths underneath the prefix path
> + *
> + * Iterates over pathspec, prepending each path with prefix,
> + * and return the resulting list.
> + *
> + * If pathspec is empty, return a singleton list containing prefix.
> + *
> + * If pathspec and prefix are both empty, return an empty list.
> + *
> + * This is typically used by built-in commands such as add.c, in order
> + * to normalize argv arguments provided to the built-in into a list of
> + * paths to process, all relative to the root of the working tree.
> + */
>  const char **get_pathspec(const char *prefix, const char **pathspec)
>  {
>  	const char *entry = *pathspec;
