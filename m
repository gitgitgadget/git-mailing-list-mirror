From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7400 broken on pu (Mac OS X)
Date: Thu, 10 Jan 2013 09:58:31 -0800
Message-ID: <7v38y83ooo.fsf@alter.siamese.dyndns.org>
References: <50EDBA37.30205@web.de>
 <20130110062838.GA11634@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 18:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtMP1-0005qt-2J
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 18:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab3AJR6f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 12:58:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753530Ab3AJR6e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2013 12:58:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20696A15D;
	Thu, 10 Jan 2013 12:58:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1Bioh+5lsvTo
	7NKsSsabV+V4ZYU=; b=j4Doe6OHqPS8wTBgikLhLaJXQ9O/YjGwWm71VOK/TMcu
	PHvfHrAu2/3Ril+CF0LsjZvOgRVGKLoKWnSXZG07fsnwQz6SyMSqKAHnKmIZwfSl
	/+B9oonSipMGf5j0yd/9c/fgaY10dUZetm0mGDNXyJf0kr8OsWPoCaZSGMeNTYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xcZvjl
	v0tUtrsrymoCI+SmE28bBgeL+iLtcGIeQA/KKX+diwJ/Kz/M2LlfBLpQFyjprGtR
	7+0pi8V5VWC7BxMlFQsvRU/mhddawdfHuTQrFLKbiA+YR6GYvzUW6gkolWovrRpU
	BtqzL5xMY+2fMwev5zodauY10m8DxaX35CDk0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14E58A15C;
	Thu, 10 Jan 2013 12:58:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 557F8A15B; Thu, 10 Jan 2013
 12:58:33 -0500 (EST)
In-Reply-To: <20130110062838.GA11634@duynguyen-vnpc.dek-tpc.internal> (Duy
 Nguyen's message of "Thu, 10 Jan 2013 13:28:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59513F32-5B4F-11E2-BCB1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213145>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 09, 2013 at 07:43:03PM +0100, Torsten B=C3=B6gershausen w=
rote:
>> The current pu fails on Mac OS, case insensitive FS.
>>=20
>>=20
>> Bisecting points out
>> commit 3f28e4fafc046284657945798d71c57608bee479
>> [snip]
>> Date:   Sun Jan 6 13:21:07 2013 +0700
>>=20
>>     Convert add_files_to_cache to take struct pathspec
>>=20
>
> I can reproduce it by setting core.ignorecase to true. There is a bug
> that I overlooked. Can you verify if this throw-away patch fixes it
> for you? A proper fix will be in the reroll later.

I can see why it is wrong to let pathspec.raw be rewritten without
making matching change to the containing pathspec, but I find it
strange why it matters only on case-insensitive codepath.

I agree with the "Hack" comment that the canonicalization should be
done at a higher level upfront.  Then ls-files does not need its own
strip_trailing_slash_from_submodules(), and check_path_for_gitlink()
can (and should---the callers of "check_anything" would not expect
the function to change things) stop rewriting its parameter.

Thanks for a quick response.

> -- 8< --
> diff --git a/builtin/add.c b/builtin/add.c
> index 641037f..61cb8bd 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -155,12 +155,13 @@ static char *prune_directory(struct dir_struct =
*dir, const char **pathspec, int
>  	return seen;
>  }
> =20
> -static void treat_gitlinks(const char **pathspec)
> +static int treat_gitlinks(const char **pathspec)
>  {
>  	int i;
> +	int modified =3D 0;
> =20
>  	if (!pathspec || !*pathspec)
> -		return;
> +		return modified;
> =20
>  	for (i =3D 0; i < active_nr; i++) {
>  		struct cache_entry *ce =3D active_cache[i];
> @@ -171,15 +172,17 @@ static void treat_gitlinks(const char **pathspe=
c)
>  				if (len2 <=3D len || pathspec[j][len] !=3D '/' ||
>  				    memcmp(ce->name, pathspec[j], len))
>  					continue;
> -				if (len2 =3D=3D len + 1)
> +				if (len2 =3D=3D len + 1) {
>  					/* strip trailing slash */
>  					pathspec[j] =3D xstrndup(ce->name, len);
> -				else
> +					modified =3D 1;
> +				} else
>  					die (_("Path '%s' is in submodule '%.*s'"),
>  						pathspec[j], len, ce->name);
>  			}
>  		}
>  	}
> +	return modified;
>  }
> =20
>  static void refresh(int verbose, const struct pathspec *pathspec)
> @@ -418,7 +421,16 @@ int cmd_add(int argc, const char **argv, const c=
har *prefix)
> =20
>  	if (read_cache() < 0)
>  		die(_("index file corrupt"));
> -	treat_gitlinks(pathspec.raw);
> +	if (treat_gitlinks(pathspec.raw))
> +		/*
> +		 * HACK: treat_gitlinks strips the trailing slashes
> +		 * out of submodule entries but it only affects
> +		 * raw[]. Everything in pathspec.items is not touched.
> +		 * Re-init it to propagate the change. Long term, this
> +		 * function should be moved to pathspec.c and update
> +		 * everything in a consistent way.
> +		 */
> +		init_pathspec(&pathspec, pathspec.raw);
> =20
>  	if (add_new_files) {
>  		int baselen;
> -- 8< --
