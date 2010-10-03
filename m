From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Sun, 3 Oct 2010 08:30:49 +0000
Message-ID: <AANLkTikU7D5dWAc-04cVUnjPPrC7rjaqjPe_j3rEvn0u@mail.gmail.com>
References: <20101003043221.1960.73178.stgit@SlamDunk>
	<20101003043228.1960.88989.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 10:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2JyC-0006V9-1Z
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 10:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab0JCIau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 04:30:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39435 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab0JCIat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 04:30:49 -0400
Received: by iwn5 with SMTP id 5so5599498iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v5kONoSu7xJjuM9mHbiAX1WJkX4G5WfS5z/6/hKPu/4=;
        b=defnL4PjYeiz1hLXDqpghGemmv3ocnEhXiXfpa3I3EuAM/evJveJshNO922jUIvZA0
         y80DEV4M8x810Ma1Z00FwFeF5so5K0tzwDVca+WZZ0KlstkWtsL4E6W6oTO1kWgsgEfG
         wv7t5VbWIQyBsVD+FefDNAC6juMIDOAwHclQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f1wBEo50IxV8+muiZzX2hqQixHtdQpe3MkwQGzmAQ3UOoVaLU3HtYbS09U6uYcAObQ
         ZryxwfKLSreUliJrhRTlMBBe27CZprFsDhmqV/7rfI0KFuap4KLWRFysMofJZYjuvgca
         4t3+/uoQAD6o94BTErEACkrfnLXee6OjEgF4s=
Received: by 10.231.192.67 with SMTP id dp3mr8254646ibb.180.1286094649102;
 Sun, 03 Oct 2010 01:30:49 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 01:30:49 -0700 (PDT)
In-Reply-To: <20101003043228.1960.88989.stgit@SlamDunk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157845>

On Sun, Oct 3, 2010 at 04:32, Joshua Jensen <jjensen@workspacewhiz.com>=
 wrote:

> diff --git a/dir.c b/dir.c
> index d1e5e5e..ffa410d 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -18,6 +18,68 @@ static int read_directory_recursive(struct dir_str=
uct *dir, const char *path, in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int check_only, const struct path_simplify=
 *simplify);
> =C2=A0static int get_dtype(struct dirent *de, const char *path, int l=
en);
>
> +/* helper string functions with support for the ignore_case flag */
> +int strcmp_icase(const char *a, const char *b)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return ignore_case ? strcasecmp(a, b) : strcmp=
(a, b);
> +}
> +
> +int strncmp_icase(const char *a, const char *b, size_t count)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return ignore_case ? strncasecmp(a, b, count) =
: strncmp(a, b, count);
> +}
> +
> +int fnmatch_casefold(const char *pattern, const char *string, int fl=
ags)
> +{
> + =C2=A0 =C2=A0 =C2=A0 char lowerPatternBuf[MAX_PATH];
> + =C2=A0 =C2=A0 =C2=A0 char lowerStringBuf[MAX_PATH];
> + =C2=A0 =C2=A0 =C2=A0 char* lowerPattern;
> + =C2=A0 =C2=A0 =C2=A0 char* lowerString;
> + =C2=A0 =C2=A0 =C2=A0 size_t patternLen;
> + =C2=A0 =C2=A0 =C2=A0 size_t stringLen;
> + =C2=A0 =C2=A0 =C2=A0 char* out;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Use the provided stack buffer, if poss=
ible. =C2=A0If the string is too
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* large, allocate buffer space.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 patternLen =3D strlen(pattern);
> + =C2=A0 =C2=A0 =C2=A0 if (patternLen + 1 > sizeof(lowerPatternBuf))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lowerPattern =3D x=
malloc(patternLen + 1);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lowerPattern =3D l=
owerPatternBuf;
> +
> + =C2=A0 =C2=A0 =C2=A0 stringLen =3D strlen(string);
> + =C2=A0 =C2=A0 =C2=A0 if (stringLen + 1 > sizeof(lowerStringBuf))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lowerString =3D xm=
alloc(stringLen + 1);
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 lowerString =3D lo=
werStringBuf;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Make the pattern and string lowercase to pa=
ss to fnmatch. */
> + =C2=A0 =C2=A0 =C2=A0 for (out =3D lowerPattern; *pattern; ++out, ++=
pattern)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D tolower(*=
pattern);
> + =C2=A0 =C2=A0 =C2=A0 *out =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (out =3D lowerString; *string; ++out, ++st=
ring)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D tolower(*=
string);
> + =C2=A0 =C2=A0 =C2=A0 *out =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 ret =3D fnmatch(lowerPattern, lowerString, fla=
gs);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Free the pattern or string if it was alloca=
ted. */
> + =C2=A0 =C2=A0 =C2=A0 if (lowerPattern !=3D lowerPatternBuf)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(lowerPattern)=
;
> + =C2=A0 =C2=A0 =C2=A0 if (lowerString !=3D lowerStringBuf)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(lowerString);
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> +}
> +
> +int fnmatch_icase(const char *pattern, const char *string, int flags=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 return ignore_case ? fnmatch_casefold(pattern,=
 string, flags) : fnmatch(pattern, string, flags);
> +}


I liked v1 of this patch better, although it obviously had portability
issues. But I think it would be better to handle this with:

    #ifndef FNM_CASEFOLD
    int fnmatch_casefold(const char *pattern, const char *string, int f=
lags)
    {
        ...
    }
    #endf

    int fnmatch_icase(const char *pattern, const char *string, int flag=
s)
    {
    #ifndef FNM_CASEFOLD
     =C2=A0 =C2=A0 =C2=A0 return ignore_case ? fnmatch_casefold(pattern=
, string,
flags) : fnmatch(pattern, string, flags);
    #else
            return fnmatch(pattern, string, flags | (ignore_case ?
=46NM_CASEFOLD : 0));
    #endif
    }

Or simply use fnmatch(..., FNM_CASEFOLD) everywhere and include
compat/fnmatch/* on platforms like Solaris that don't have the GNU
extension.

That would allow the GNU libc, FreeBSD libc and others that implement
the GNU extension to do case folding for us, and we wouldn't have to
maintain our own fnmatch_casefold.
