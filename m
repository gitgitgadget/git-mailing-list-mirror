From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 01/16] list-files: command skeleton
Date: Sat, 14 Mar 2015 18:13:42 +0700
Message-ID: <CACsJy8Bj4impHg8qnytgsf9Tt-oHXzxMcgDLX3UcJ7gfb8sdqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 12:14:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWk1N-0007Fb-BB
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 12:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbbCNLOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2015 07:14:14 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34943 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbCNLON convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2015 07:14:13 -0400
Received: by igad1 with SMTP id d1so6210434iga.0
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 04:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=d16aq+zCxcY2eN3PdrwzhhAgUc4aFEHlT8+9ebmyOas=;
        b=qGx5RGBR8kw3czteUCVdSe7O82eeV/nd+sgyeY+PKOs7HBLn90xUN+b/XVkBNqkb4r
         y/6sLTYb2Plky9M0muscKwivgwWOqkuhARCfoBXBXQHIWsOORN124VT4exNCPe5Dw536
         G2KD1bgAjo9+C0nycZ2exrqIaYCJgiJE3bPnBSiqNxy9bhy4YMmeetRrJFt6/kJCyuS6
         QIjST1g3GpYbYnzclY3vu5ox3iupZ84r2tnXR+tMYYdF+kPDIzAmQxKszbfIrfdYVx78
         hLCREw7fWvJcCXSFmWTxwpnefw9+xEeiieVs+Ya6dXj8aLnNVosewf5k/qFg1Rwc38bs
         dIhA==
X-Received: by 10.50.1.48 with SMTP id 16mr92945991igj.45.1426331652269; Sat,
 14 Mar 2015 04:14:12 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Sat, 14 Mar 2015 04:13:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265444>

On Fri, Mar 13, 2015 at 4:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> list-files is supposed to be the user friendly version of ls-files, =
or
>> an alternative to git-status. Nothing fancy in this patch yet.
>
> The result of applying this patch alone will not give us anything
> fancy, but the patch itself is interesting ;-)

That's the point. Fancy stuff comes as separate, bite-size patches.

>> +static void populate_cached_entries(struct string_list *result,
>> +                                 const struct index_state *istate)
>> +{
>> +     int i;
>> +
>> +     for (i =3D 0; i < istate->cache_nr; i++) {
>> +             const struct cache_entry *ce =3D istate->cache[i];
>> +
>> +             if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce=
),
>> +                                 0, NULL,
>> +                                 S_ISDIR(ce->ce_mode) ||
>> +                                 S_ISGITLINK(ce->ce_mode)))
>
> Because we won't tell the user "You gave me Mkaefile but that did
> not match" when "git list-files Mkaefile" does not produce anything,
> we do not need to pass seen[] down from here.

We probably want that feature back. Not implemented yet though.

>> +     prefix =3D cmd_prefix;
>> +     if (prefix)
>> +             prefix_length =3D strlen(prefix);
>> +
>> +     if (read_cache() < 0)
>> +             die(_("index file corrupt"));
>> +
>> +     git_config(ls_config, NULL);
>> +
>> +     argc =3D parse_options(argc, argv, prefix, ls_options, ls_usag=
e, 0);
>> +
>> +     parse_pathspec(&pathspec, 0,
>> +                    PATHSPEC_PREFER_CWD |
>> +                    PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>> +                    cmd_prefix, argv);
>> +     pathspec.max_depth =3D 0;
>> +     pathspec.recursive =3D 1;
>> +
>> +     refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED,
>> +                   &pathspec, NULL, NULL);
>
> It would be better to do read-cache-preload, instead of read-cache,
> if you are going to immediately refresh.  That is what "git status"
> does.

parse_options(), or *_SLASH_CHEAP to be exact, needs the index being
loaded (but not necesarily refreshed), so we can't simply move it
closer to refresh_index() after we have got the pathspec. And doing
read-cache-preload() without pathspec where read_cache() is seems a
waste of lstat() because the default mode is only look at cwd and
subdirs, not full worktree like git-status.

I have a patch (not sent yet) that adds read-cache-preload back. But
this 01/16 will likely stay simple and unoptimized.
--=20
Duy
