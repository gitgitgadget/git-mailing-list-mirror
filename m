From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH V4] git on Mac OS and precomposed unicode
Date: Sun, 22 Jan 2012 16:58:30 +0700
Message-ID: <CACsJy8BKQHLdoXfSKsULkWWbWjWEuZgr=bVNKmgCSArvwbf2UA@mail.gmail.com>
References: <201201212036.57632.tboegi@web.de> <7vsjj8acmh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 10:59:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RouD0-0000ms-ML
	for gcvg-git-2@lo.gmane.org; Sun, 22 Jan 2012 10:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885Ab2AVJ7G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jan 2012 04:59:06 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44286 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab2AVJ7D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2012 04:59:03 -0500
Received: by bkas6 with SMTP id s6so1667172bka.19
        for <git@vger.kernel.org>; Sun, 22 Jan 2012 01:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=X2PZ1IV6+a6UuNy91fGH7+f5riW1q2pmjTL7MtwAS6g=;
        b=fchPn4WFcsNZY/JsfObU9Et0WE3/bNtBnqeKhJsMTOQioZALAxZ9ykPFSSdIn4hWhb
         aWwasI5jshNANFu3iEqtTV5yXd5sPwYD+FHckdB/w+gtkO/2UTsRVbpbMdw+GNTb+KZE
         0d+Gkl9BoPLiua5ct9UbMUjZQX6bbb9sOAKcE=
Received: by 10.204.157.130 with SMTP id b2mr1601596bkx.22.1327226341349; Sun,
 22 Jan 2012 01:59:01 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Sun, 22 Jan 2012 01:58:30 -0800 (PST)
In-Reply-To: <7vsjj8acmh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188946>

On Sun, Jan 22, 2012 at 5:56 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> [Pinging Nguyen who has worked rather extensively on the start-up seq=
uence
> for ideas.]
>
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
> I'll try to reword the log message a bit below.
>
>> When a file called "LATIN CAPITAL LETTER A WITH DIAERESIS" (in utf-8
>> encoded as 0xc3 0x84) is created, the Mac OS filesystem converts
>> "precomposed unicode" into "decomposed unicode". readdir() will retu=
rn
>> 0x41 0xcc 0x88 for such a file, that does not match what the caller
>> thought it created.
>>
>> To work around this braindamage, allow git on Mac OS to optionally u=
se a
>> wrapper for readdir() that converts decomposed unicode back into the
>> precomposed form, which most other platforms use natively. This make=
s it
>> easier for Mac OS users to work together on the same project with pe=
ople
>> on other platforms (Note that not all Windows versions support UTF-8
>> yet. Msysgit needs the unicode branch, cygwin supports UTF-8 since
>> 1.7). This allows sharing git repositories stored on a VFAT file sys=
tem
>> (e.g. a USB stick), and mounted network share using samba.

I just have a quick look, you reencode opendir, readdir, and
closedir() to precomposed form. But files are still in decomposed
form, does open(<precomposed file>) work when only <decomposed file>
exists?

>> In order to prevent that ever a file name in decomposed unicode is
>> entering the index, a "brute force" attempt is taken: all arguments =
into
>> git (argv[1]..argv[n]) are converted into precomposed unicode. =C2=A0=
This is
>> done in git.c by calling precompose_argv(). =C2=A0This function is a=
ctually a
>> #define, and it is only defined under Mac OS. =C2=A0Nothing is conve=
rted on
>> any other platforms.

This is not entirely safe. Filenames can be taken from a file for
example (--stdin option or similar). Unless I'm mistaken, all file
names must enter git through the index, the conversion at read-cache.c
may be a better option.

>> Auto sensing:
>> When creating a new git repository with "git init" or "git clone",
>> "core.precomposedunicode" will be set "false".

This is a general comment on init auto detection feature. Perhaps we
should allow detection to be done when reinitializing a repo. Or at
least make an option to auto detect, print out new config values and
user can decide if they want to change current values themselves.

>> +void precompose_argv(int argc, const char **argv)
>> +{
>> + =C2=A0 =C2=A0 int i =3D 0;
>> + =C2=A0 =C2=A0 const char *oldarg;
>> + =C2=A0 =C2=A0 char *newarg;
>> + =C2=A0 =C2=A0 iconv_t ic_precompose;
>> +
>> + =C2=A0 =C2=A0 git_config(precomposed_unicode_config, NULL);
>
> As the first thing called after main(), I still doubt this is a safe =
thing
> to do (Pinging Nguyen who has worked rather extensively on the start-=
up
> sequence for ideas). This is ifdefed away and will not break things o=
n
> other platforms, which may make it even harder to diagnose breakages.

This can't be worse than current state of pager and alias settings,
which need to be detected even before setup_git_directory* is run.

I'd rather encode at index level and read_directory() than at argv[].
But if reencoding argv is the only feasible way, perhaps put the
conversion in parse_options()? Config reading is usually done by then,
and we can move precomposed config reading to git_default_config. If
some commands do not use parse_options yet, this is a good opportunity
to do so (I'll send pack-objects's parse_options() patch soon).
--=20
Duy
