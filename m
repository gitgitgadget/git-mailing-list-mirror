From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_directory: avoid invoking exclude machinery on
 tracked files
Date: Fri, 15 Feb 2013 08:52:03 -0800
Message-ID: <7vd2w1wmdo.fsf@alter.siamese.dyndns.org>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 15 17:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6OWY-0001j5-Ee
	for gcvg-git-2@plane.gmane.org; Fri, 15 Feb 2013 17:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab3BOQwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2013 11:52:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41090 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab3BOQwI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Feb 2013 11:52:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D10C0D81A;
	Fri, 15 Feb 2013 11:52:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E5W6lX7HxSVZ
	JdEjzlxcrV0y2Uw=; b=JYraBQrIbhEeCnkQ7SBnQpah5jYGBh2Rsn/n1IiNnARA
	GbhULCQccLRarXo3HxlK0Pl1m3xKrmcjjclwjXKbpSHYwOWTz9hpL1EJSIAwRQHD
	ND6oHe2rtE/YJvdCsHl2S8bvDwn5YkEs2QzICeUrWXJOHBnsG72VEjKkok9H+gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UFmfss
	fHmIHNGxzcHmoXKdE7D1kXkGRHUR9bmdQPclktfY9cnS9St+D0PKMwz8+I9agKQO
	qvYowk15aM3tStelRxZNYGoKhnfdwCHecJmElM1awMNoANqX9mLjiVy/H3p8iLmD
	feFV+ZNmusMwDpB0nwaY/G970mzGgpq75hC3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C54DAD819;
	Fri, 15 Feb 2013 11:52:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2307CD818; Fri, 15 Feb 2013
 11:52:05 -0500 (EST)
In-Reply-To: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 15 Feb
 2013 21:17:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 070C133E-7790-11E2-8D3B-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216349>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> read_directory() (and its friendly wrapper fill_directory) collects
> untracked/ignored files by traversing through the whole worktree (*),
> feeding every entry to treat_one_path(), where each entry is checked
> against .gitignore patterns.
>
> One may see that tracked files can't be excluded and we do not need t=
o
> run them through exclude machinery. On repos where there are many
> .gitignore patterns and/or a lot of tracked files, this unnecessary
> processing can become expensive.
>
> This patch avoids it mostly for normal cases. Directories are still
> processed as before. DIR_SHOW_IGNORED and DIR_COLLECT_IGNORED are not
> normally used unless some options are given (e.g. "checkout
> --overwrite-ignore", "add -f"...) so people still need to pay penalty
> in some cases, just not as often as before.
>
> git status   | webkit linux-2.6 libreoffice-core gentoo-x86
> -------------+----------------------------------------------
> before       | 1.159s    0.226s           0.415s     0.597s
> after        | 0.778s    0.176s           0.266s     0.556s
> nr. patterns |    89       376               19          0
> nr. tracked  |   182k       40k              63k       101k
>
> (*) Not completely true. read_directory may skip recursing into a
>     directory if it's entirely excluded and DIR_SHOW_OTHER_DIRECTORIE=
S
>     is not set.
>
> Tracked-down-by: Karsten Blees <karsten.blees@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  For reference:
>  http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=3D=
216195
>
>  dir.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 57394e4..bdff256 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1244,7 +1244,19 @@ static enum path_treatment treat_one_path(stru=
ct dir_struct *dir,
>  					  const struct path_simplify *simplify,
>  					  int dtype, struct dirent *de)
>  {
> -	int exclude =3D is_excluded(dir, path->buf, &dtype);
> +	int exclude;
> +
> +	if (dtype =3D=3D DT_UNKNOWN)
> +		dtype =3D get_dtype(de, path->buf, path->len);
> +
> +	if (!(dir->flags & DIR_SHOW_IGNORED) &&
> +	    !(dir->flags & DIR_COLLECT_IGNORED) &&
> +	    dtype !=3D DT_DIR &&
> +	    cache_name_exists(path->buf, path->len, ignore_case))
> +		return path_ignored;
> +
> +	exclude =3D is_excluded(dir, path->buf, &dtype);
> +
>  	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
>  	    && exclude_matches_pathspec(path->buf, path->len, simplify))
>  		dir_add_ignored(dir, path->buf, path->len);

Interesting.

In the current code, we always check if a path is excluded, and when
dealing with DT_REG/DT_LNK, we call treat_file():

 * When such a path is excluded, treat_file() returns true when we
   are not showing ignored directories. This causes treat_one_path()
   to return path_ignored, so for excluded DT_REG/DT_LNK paths when
   no DIR_*_IGNORED is in effect, this change is a correct
   optimization.

 * When such a path is not excluded, on the ther hand, and when we
   are not showing ignored directories, treat_file() just returns
   the value of exclude_file, which is initialized to false and is
   not changed in the function.  This causes treat_one_path() to
   return path_handled.  However, the new code returns path_ignored
   in this case.

What guarantees that this change is regression free?  I do not seem
to be able to find anything that checks if the path is already known
to the index in the original code for the case you special cased
(i.e. DIR_*_IGNORED is not set and dtype is not DT_DIR).  Do all the
callers that reach this function in their callgraph, when they get
path_ignored for a path in the index, behave as if the difference
between path_ignored and path_handled does not matter?

> @@ -1256,9 +1268,6 @@ static enum path_treatment treat_one_path(struc=
t dir_struct *dir,
>  	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
>  		return path_ignored;
> =20
> -	if (dtype =3D=3D DT_UNKNOWN)
> -		dtype =3D get_dtype(de, path->buf, path->len);
> -
>  	switch (dtype) {
>  	default:
>  		return path_ignored;
