From: =?UTF-8?B?SmVhbi1Ob8OrbCBBdmlsYQ==?= <avila.jn@gmail.com>
Subject: Re: [PATCH] Add directory pattern matching to attributes
Date: Thu, 06 Dec 2012 10:02:12 +0100
Message-ID: <50C05F14.8080809@gmail.com>
References: <201212052310.30690.jn.avila@free.fr> <7vlidcjcm9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 06 10:02:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgXLu-0007aC-54
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 10:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252Ab2LFJCU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Dec 2012 04:02:20 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36616 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab2LFJCS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 04:02:18 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2564368bkw.19
        for <git@vger.kernel.org>; Thu, 06 Dec 2012 01:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=mqNthqPr/NPmM7Eu3SdJr6u+B1PvtAJaIPO4dtjpFhM=;
        b=Uvlj80I/Nu5a6dA9vHa8c4I0HJycil1TqWQyORmwo6QyOVR/MloKNI/cWgjZez0MQN
         r/fgsqojyKgJQmKngQ3Zs3/zzto982UYnVvUwMx/cn6kQURR7oaLQ2iPUajfWRzpF4Os
         ZWYjNeGYQxOd8NPA/kh1X1PfXwZ2VPwxK7bhmCVs4+NKvUSGSmNFcXuFdsmEfry38pJw
         Sjfhfq9l6gZOpj7DtWmnozLR4+Mp5CSGqpkZayz4pnvD0kzkkn78lDxFvN07iSO5FlHu
         w7mEno5dI8bcca3dVG4W2lsNXByP3UenYyYhHlzl+f089lnuUKxor8rDqaHZzi4aDEE6
         SGrA==
Received: by 10.204.4.145 with SMTP id 17mr255342bkr.34.1354784536525;
        Thu, 06 Dec 2012 01:02:16 -0800 (PST)
Received: from [192.168.1.54] ([178.21.183.81])
        by mx.google.com with ESMTPS id y11sm5616536bkw.8.2012.12.06.01.02.15
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Dec 2012 01:02:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vlidcjcm9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211159>

On 06/12/2012 00:35, Junio C Hamano wrote:
> "Jean-No=C3=ABl AVILA" <jn.avila@free.fr> writes:
>
>> -static void prepare_attr_stack(const char *path)
>> +static void prepare_attr_stack(const char *path, unsigned mode)
>>   {
>>   	struct attr_stack *elem, *info;
>>   	int dirlen, len;
>> @@ -645,28 +645,43 @@ static void prepare_attr_stack(const char *pat=
h)
>>   }
> Why?
>
> The new "mode" parameter does not seem to be used in this function
> at all.
>
>>   static int path_matches(const char *pathname, int pathlen,
>> -			const char *pattern,
>> +			const unsigned mode, char *pattern,
>>   			const char *base, int baselen)
>>   {
>> -	if (!strchr(pattern, '/')) {
>> +	size_t len;
>> +	char buf[PATH_MAX];
>> +	char * lpattern =3D buf;
>> +	len =3D strlen(pattern);
>> +	if (PATH_MAX <=3D len)
>> +		return 0;
>> +	strncpy(buf,pattern,len);
>> +	buf[len] =3D'\0';
>> +	if (len && lpattern[len - 1] =3D=3D '/') {
>> +		if (S_ISDIR(mode))
>> +			lpattern[len - 1] =3D '\0';
>> +		else
>> +			return 0;
>> +	}
>> +	if (!strchr(lpattern, '/')) {
>>   		/* match basename */
>>   		const char *basename =3D strrchr(pathname, '/');
>>   		basename =3D basename ? basename + 1 : pathname;
>> -		return (fnmatch_icase(pattern, basename, 0) =3D=3D 0);
>> +		return (fnmatch_icase(lpattern, basename, 0) =3D=3D 0);
>>   	}
>>   	/*
>>   	 * match with FNM_PATHNAME; the pattern has base implicitly
>>   	 * in front of it.
>>   	 */
>> -	if (*pattern =3D=3D '/')
>> -		pattern++;
>> +	if (*lpattern =3D=3D '/')
>> +		lpattern++;
>>   	if (pathlen < baselen ||
>>   	    (baselen && pathname[baselen] !=3D '/') ||
>>   	    strncmp(pathname, base, baselen))
>>   		return 0;
>>   	if (baselen !=3D 0)
>>   		baselen++;
>> -	return fnmatch_icase(pattern, pathname + baselen, FNM_PATHNAME) =3D=
=3D 0;
>> +	return fnmatch_icase(lpattern, pathname + baselen, FNM_PATHNAME) =3D=
=3D 0;
>>   }
> It appears to me that you are forcing the caller to tell this
> function if the path is a directory, but in the attribute system,
> the caller does not necessarily know if the path it is passing is
> meant to be a directory or a regular file.  "check-attr" is meant to
> be usable against a path that does not even exist on the working
> tree, so using stat() or lstat() in it is not a solution.  In other
> words, it is unfair (read: unworkable) to force it to append a
> trailing slash after the path it calls this function with.

Thank you for your comments. Changing the whole attr.h interface header
is definitely not a good option, but at some point, we may need more=20
information
on the path to be able to match a path pattern against it.

>
> If you are interested in export-subst, all is not lost, though:
>
> 	$ git init
>          $ mkdir a
>          $ >a/b
>          $ echo a export-ignore >.gitattributes
>          $ git add a/b .gitattributes
> 	$ git commit -m initial
>          $ git archive HEAD | tar tf -
>          .gitattributes
>          $ exit
>
> You could change the "echo" to
>
> 	$ echo "a/*" export-ignore >.gitattributes
>
> as well, but it seems to create an useless empty directory "a/" in
> the output, which I think is an unrelated bug in "git archive".

This is quite different from the pattern matching documented for gitign=
ore.

Moreover,

  $ mkdir -p not-ignored-dir/ignored-dir
  $ echo test >not-ignored-dir/ignored-dir/ignored
  $ echo 'ignored-dir/*' >.gitattributes
  $ git add not-ignored-dir .gitattributes
  $ git commit -m '.'
  $ git archive HEAD | tar tf -
=2Egitattributes
not-ignored-dir/
not-ignored-dir/ignored-dir/
not-ignored-dir/ignored-dir/ignored


>
> This patch seems to be based on a stale codebase.
Sorry. I thought the patch submissions had to be based on the 'maint'=20
branch.

>    I do not think
> I'd be opposed to change the sementics to allow the callers that
> know that a path is a directory to optionally pass mode parameter by
> ending the pathname with slash (in other words, have "git
> check-attr" ask about a directory 'a' by saying "git check-attr
> export-subst a/", and lose the "mode" argument in this patch), or
> keep the "mode" parameter and instead allow "git check-attr" to ask
> about a directory that does not exist in the working tree by a more
> explicit "git check-attr --directory export-ignore a" or something.
> Such an enhancement should be done on top of the current codebase.

OK. I like the idea of proposing a path ending with '/' when it is mean=
t=20
to be
directory. This would not change the interface attr.h . I will rework=20
with this idea.

Thank you.
