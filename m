From: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
Subject: Re: Merge after directory rename ?
Date: Mon, 22 Aug 2011 10:49:18 +0200
Message-ID: <CAC9GOO8w_zZ8wuRambnGoaS+rKskdjuSZVpF+b4mzdhzK48bjg@mail.gmail.com>
References: <j2ru2h$cd$1@dough.gmane.org>
	<CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
	<CAMOZ1Bt8cP146xiDXfSA-naSOaS3AC8pUZgW12=3TMg2JGCD=w@mail.gmail.com>
	<j2s83l$eqg$1@dough.gmane.org>
	<CAMOZ1Bsb7UxYOFpRWh47+130upfD9_E=CMQtZd1NyUWPwWiW4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 10:49:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvQCM-00068U-Ui
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 10:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753717Ab1HVItV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 04:49:21 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61334 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab1HVItU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 04:49:20 -0400
Received: by qwk3 with SMTP id 3so2854076qwk.19
        for <git@vger.kernel.org>; Mon, 22 Aug 2011 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KL41RmVrmdcmjBcKoRy1q+NDB2A4yv7nN1/WdG6G+44=;
        b=dE6hgm/F/CfhhaQONPb3vUxuZ7M5F4OgAqqoeOGMDFQonfRCPgcqtHawQ73dODhYEr
         XoepMLWbdmIYpRXmYTGjo3cMnjmSLE/mtU3IVThLnDpqi1s9Vqxe1/zo8MzsZBdytheW
         41HtZb511AM/rA/PCcPxYB2P+mkwLb2LZ4ggw=
Received: by 10.229.61.104 with SMTP id s40mr1125107qch.299.1314002959246;
 Mon, 22 Aug 2011 01:49:19 -0700 (PDT)
Received: by 10.229.246.202 with HTTP; Mon, 22 Aug 2011 01:49:18 -0700 (PDT)
In-Reply-To: <CAMOZ1Bsb7UxYOFpRWh47+130upfD9_E=CMQtZd1NyUWPwWiW4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179850>

2011/8/22 Michael Witten <mfwitten@gmail.com>:
> I assume the smiley is tongue-in-cheek; however, in case it is not: It
> can't be automatic in general; did my examples mean nothing?
>
>> Or at least detect/warn about tree conflict.
>
> Did my examples mean nothing?

Well kind of. Your example was different because you have created dir1
independently on branch1 and master in which case automatic rename
wouldn't be expected. If you would've created dir1 before branching
and renamed dir1 to dir3 (renamed all files under dir1) then I would
expect a rename while merging.

The exact behaviour of merging branch1 to master I want is:

let base = $(git merge-base master branch1)
for each {modified,added,deleted} file in $base..branch1:
  let dir = $(dirname $file)
  if $dir exists in master:
    if $dir existed in $base: [1]
      proceed
    else: # both branches independently introduced same directory
      tree conflict
  else: # no $dir in master
    if $dir existed in $base:
      if all $dir/* files in $base..master were renamed to $newdir/*:
        rename $file [s/$dir/$newdir/]
      else: # $dir was removed
        tree conflict
    else:
       proceed # simple addition

Where "$dir exists" means that a file with path of matching prefix exists.
By default tree conflict should be ignored (proceed with merge as
today) but user should be able to make it fatal.

[1] It would be better if instead of comparing two trees it would
analyze each commit independently to detect shadowed renames:
(dir1=>dir2 then new dir1) => still rename.

>
>> Directory renames can happen quite frequently when working with Java/C#
>> and it is unreasonable to expect that lazy user will have to keep track of
>> it manually (with huge number of files it's impossible).
>
> Git doesn't know anything about Java/C#; that's the point.

And it shouldn't. Renames can happen with anything, I'm just pointing
out that they are quite frequent in Java/C#.
You might as well have a C project and rename directory "src" to
"sources" and, when merging branch created from before that, expect to
get automatic s/src/sources/.

> In general, the user could make use of switches (as suggested). In
> particular, perhaps there are merge hooks or merge drivers that could
> be used or implemented for allowing a more environment-specific
> handling of merges, a la GNU's ChangeLog merge driver:
> Also, see the configuration section of `git help merge'. Also look at
> the tool `git mergetool'.
>

Merge drivers are file type specific, mergetool is used to resolve
conflicts after merge and I don't see a pre-merge hook :(
