From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: grep --no-index and pathspec
Date: Sat, 12 Feb 2011 15:14:59 +0700
Message-ID: <AANLkTikG1C=7NRGoi+HWz8rE9RN8-pF6o0=S29GZA3eK@mail.gmail.com>
References: <20110211095938.360726y1zinab9gk@webmail.df.eu>
 <4D55500B.1070603@drmicha.warpmail.net> <7v8vxm1l6q.fsf@alter.siamese.dyndns.org>
 <7vwrl6z20p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Lars Noschinski <lars@public.noschinski.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 09:15:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoAdt-0001io-Dj
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 09:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab1BLIPk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 03:15:40 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46540 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab1BLIPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 03:15:31 -0500
Received: by wwa36 with SMTP id 36so3356799wwa.1
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 00:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=h5mfFX3cRseU3gR75FQyQx74G7+aqPm6Elfj80+qUNI=;
        b=ihrFqXun5CB23LE+1Cakp1w2Jm0mkv7bzZ3punVJ5WdDJrrU7AQEgjVPC6Xf9+Ws5W
         JbFkQyD2LYcf+LVpymIQYNJpkmpLmtEE3znokMXEzMXfzVSIgPPxSt35c4aYor58Qp77
         o1Ir5vUfDMWdjSoeiOj9hqIwvkMVxfE3kSt/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=b3CKDwDNQmhz4ihGB7ZOfvESHj/FEr8ZlsJsud0Ts8O9XAUsj2H0LwulSNlp1EvDyh
         gB+D9qLmOtZeUkdtxi25Trbwylb3Y0+NDCvRQjjS2hC5of0hGIMsLcQpLgbjr5w495yL
         1XTx5fzz2rp0vNotiy8reEbJox2lgosY7Hdo8=
Received: by 10.216.186.144 with SMTP id w16mr1461148wem.13.1297498529671;
 Sat, 12 Feb 2011 00:15:29 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sat, 12 Feb 2011 00:14:59 -0800 (PST)
In-Reply-To: <7vwrl6z20p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166599>

2011/2/12 Junio C Hamano <gitster@pobox.com>:
> This is a band-aid modelled after what builtin/clean.c does to the
> returned list from fill_directory(), and it seems to do its job, but =
I am
> quite unhappy about it.
>
> The function fill_directory() already takes a pathspec, albeit in the
> degenerate "const char **" form. =C2=A0Why does its output need furth=
er
> filtering?

Because it was designed so? Quotes from 9fc42d6 (Optimize directory
listing with pathspec limiter. - 2007-03-30), which added
simplify_away(), the function that does pathspec filtering for
fill_directory():

    NOTE! This does *not* obviate the need for the caller to do the *ex=
act*
    pathspec match later. It's a first-level filter on "read_directory(=
)", but
    it does not do the full pathspec thing. Maybe it should. But in the
    meantime, builtin-add.c really does need to do first

        read_directory(dir, .., pathspec);
        if (pathspec)
                prune_directory(dir, pathspec, baselen);

    ie the "prune_directory()" part will do the *exact* pathspec prunin=
g,
    while the "read_directory()" will use the pathspec just to do some =
quick
    high-level pruning of the directories it will recurse into.

> @@ -626,6 +626,10 @@ static int grep_directory(struct grep_opt *opt, =
const struct pathspec *pathspec)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fill_directory(&dir, pathspec->raw);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i < dir.nr; i++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name =3D=
 dir.entries[i]->name;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int namelen =3D st=
rlen(name);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!match_pathspe=
c_depth(pathspec, name, namelen, 0, NULL))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hit |=3D grep_=
file(opt, dir.entries[i]->name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hit && opt=
->status_only)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;

Looks good. We could move prune_directory() from builtin/add.c to
dir.c and use it here, but the gain is nothing (except noticing people
some pathspecs do not match any).
--=20
Duy
