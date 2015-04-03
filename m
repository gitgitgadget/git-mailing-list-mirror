From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] config.c: split some variables to $GIT_DIR/config.worktree
Date: Fri, 3 Apr 2015 17:30:58 +0700
Message-ID: <CACsJy8C=MPLyba68ttQ2hhrM7bg8E-tEG-0kUjTLnNMMbX0MUQ@mail.gmail.com>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
 <1427804079-13061-1-git-send-email-pclouds@gmail.com> <20150401205644.GA3656@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Fri Apr 03 12:31:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydyt0-0004VL-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 12:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbbDCKbb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 06:31:31 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34689 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbDCKb3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2015 06:31:29 -0400
Received: by iedfl3 with SMTP id fl3so99627424ied.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=q/WVbvo0lQbsXw5LO4y/Z5KWeoRq2hGKsGTntW1vTd0=;
        b=S24NAdqJiEGJVyv5tYL+Tmfi1Oxkg04VhPKO/KdEKdQqbRnatpsphEO3+8pROyhcGH
         n0/GD8FtwC1L6o3gLuuVSx7aN0HPLdXI3y5GQoXaPFUcJa/WTW03gpc3eKtnvvv7+gpd
         JX6kihsgcRUAkx0rsbWCrCIQX4LCKvBI3anhP7KF4qk1fATp81n0xnEQn4zVcuMGrmQp
         +G3eoHmiVQ3zRSamlL8RzdQKl3pfDEcIkKO3Ojc/AaA/ccEQ+LWRPXpnRuqZgrK19fGN
         EjQMKEoNivF6Tr/KfEYxu71a9xEQC6OMtncWjJpSkJucWZWrMICPRXm+dsoypCq2SIkG
         Aliw==
X-Received: by 10.42.92.16 with SMTP id r16mr2896791icm.95.1428057089188; Fri,
 03 Apr 2015 03:31:29 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Fri, 3 Apr 2015 03:30:58 -0700 (PDT)
In-Reply-To: <20150401205644.GA3656@wheezy.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266703>

On Thu, Apr 2, 2015 at 3:56 AM, Max Kirillov <max@max630.net> wrote:
> On Tue, Mar 31, 2015 at 07:14:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>>  The general principle is like in the last mail: .git/config is for
>>  both shared and private keys of main worktree (i.e. nothing is
>>  changed from today).  .git/worktrees/xx/config.worktree is for
>>  private keys only (and private keys in .git/config are ignored)
>>
>>  With this we don't have to bump core.repository_format_version for
>>  main worktree because nothing is changed. There will be problems
>>  with info/config.worktree:
>>
>>   - it's customizable, so expect the user to break it (*)
>
> I would rather say it's manual tuning rather than a break.

But if the user accidentally deletes core.worktree then something will =
break.

>>   - if we add new stuff to the template, we'll need to help migrate
>>     current info/core.worktree (which does not have new stuff).
>>     Auto updating this file could be risky. I'm tend to just
>>     warn the user that this and that keys should be included and let
>>     them modify the file.
>
> I don't think there even should be warning. Just don't
> change the info/config.worktree in the existing repositories
> and let users extend it as they feel a need for it.
>
> Later there could be a tool (an option to git config for
> example) which adds a variable or pattern to the
> info/core.worktree and copied existing variable(s) from
> commong config to worktree-specific ones.

I was thinking "git checkout --to" would do this. It checks if the
main worktree has info/core.worktree, if not, re-init the repo to add
this file from default template.

>> @@ -1932,6 +2002,23 @@ int git_config_set_multivar_in_file(const cha=
r *config_filename,
>>
>>       store.multi_replace =3D multi_replace;
>>
>> +     if (git_common_dir_env && is_config_local(key)) {
>> +             if (!config_filename)
>> +                     config_filename =3D filename_buf =3D git_pathd=
up("config.worktree");
>> +             /* cheap trick, but should work 90% of time */
>> +             else if (!ends_with(config_filename, ".worktree"))
>> +                     die("%s can only be stored in %s",
>> +                         key, git_path("config.worktree"));
>
> Is `config_filename` set only for cases when config file is
> explicitly set for "git config" command with "--file"
> option? Then probably here should not be any intelligence at
> all; if user resort to manual picking the file he must be
> allowed to do stupid things.

Yes. It may make sense in the previous versions where this feature
could work in a normal worktree, but when it becomes
multiworktree-specific, I guess we can drop this.
--=20
Duy
