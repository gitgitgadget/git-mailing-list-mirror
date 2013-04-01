From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] checkout: add --no-widen for restoring files in sparse
 checkout mode
Date: Mon, 1 Apr 2013 12:13:53 +0700
Message-ID: <CACsJy8BVcu2VwxgQ9URViHMx2+6436npcYSHyZ5Mj0aVhVFtug@mail.gmail.com>
References: <1364101583-6035-1-git-send-email-pclouds@gmail.com>
 <1364637753-18785-1-git-send-email-pclouds@gmail.com> <20130401044816.GI11704@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Kirill_M=C3=BCller?= <kirill.mueller@ivt.baug.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 07:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMX52-0002JV-R8
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 07:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146Ab3DAFOY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 01:14:24 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46892 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3DAFOY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Apr 2013 01:14:24 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so1703047oag.19
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 22:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ojmM9znhqxJ0ed6gjM6Bgx1dPBUIU+w7Pvp+g2DCvM0=;
        b=wCyqqPL4aQ/b/A3C/GFSY+CKiZY5HY/mTT9OEEbL9B9TdI3i6+kQaCxvwkZi3zPKC5
         OmhmdaW1f0+5/ad2pmFmjRpKY3a1EBO3Abt0FAKnPnwUJ6ANznmXzl7yybwaovdPg1UI
         0Ojw8dV+NreCrEmpb+ikLBkTjZmxin+ygNd7iCw4yWT3bYo19NjQOc1cbS5lbU1saRmg
         ckINVqTQ3re0lczgm8NRayY6kt741YeU5dD9E02YDnFIMAK1zLBjqjqtDH8ZS3tY0W1H
         yWwH8c/AJxo1jDNo81HgTjVroUeVxI0EMtq26yqhQyiBfVbF0/R2yHRVjSLx7tvIJk/+
         9wRg==
X-Received: by 10.60.99.68 with SMTP id eo4mr3509439oeb.126.1364793263563;
 Sun, 31 Mar 2013 22:14:23 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Sun, 31 Mar 2013 22:13:53 -0700 (PDT)
In-Reply-To: <20130401044816.GI11704@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219671>

On Mon, Apr 1, 2013 at 11:48 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> "git checkout -- <paths>" is usually used to restore all modified
>> files in <paths>. In sparse checkout mode, this command is overloade=
d
>> with another meaning: to add back all files in <paths> that are
>> excluded by sparse patterns.
>>
>> Add "--no-widen" option to do what normal mode does: restore all
>> modified files and nothing else.
>
> In an ideal world, I would like "git checkout --widen" to modify the
> .git/info/sparse-checkout file, to be able to do:
>
>         git clone --sparse-checkout=3DDocumentation git://repo.or.cz/=
git.git
>         cd git
>         git checkout --widen -- README COPYING INSTALL
>
> and hack on a tree with Documentation/, README, COPYING, and INSTALL
> present with no actual code to distract.  And "git checkout --no-wide=
n"
> could be a way to ask to respect the existing sparse pattern.

In an ideal world, I would spend more time on this and add
--edit-sparse, which opens up $EDITOR, lets you edit the patterns and
reapplies the patterns after $EDITOR exits (catching faults if
possible). Unfortunately I don't use sparse checkout as much as before
and therefore have little motivation to do it. I would really like
narrow clone to replace sparse checkout, but I haven't made much
progress on that front either. I'll try to get back on that once
pathspec-magics topic is settled.

> This patch isn't about tweaking the sparse-checkout pattern; instead,
> it's about how "git checkout" interacts with the skip-worktree bit.
> Maybe a good name would be --respect-skip-worktree?

I'm bad at naming. If nobody objects, I'll take this as the new option =
name.

>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -180,6 +180,17 @@ branch by running "git rm -rf ." from the top l=
evel of the working tree.
>>  Afterwards you will be ready to prepare your new files, repopulatin=
g the
>>  working tree, by copying them from elsewhere, extracting a tarball,=
 etc.
>>
>> +--no-widen::
>> +     In sparse checkout mode, `git checkout -- <paths>` would
>> +     update all entries matched by <paths> regardless of sparse
>> +     patterns. This option only updates entries matched by <paths>
>> +     and sparse patterns.
>> +
>> +--widen::
>> +     Revert the effect of `--no-widen` if specified and make
>> +     `git checkout -- <paths>` update all entries matched by
>> +     <paths> regardless of sparse patterns.
>
> Perhaps, combining the descriptions of the positive and negative form=
s:
>
>         --respect-skip-worktree::
>                 By default, `git checkout -- <paths>` creates or upda=
tes files
>                 matching <paths> regardless of the skip-worktree bit.=
  This
>                 option makes 'git checkout' skips entries with the
>                 skip-worktree bit set, which can be useful in sparse =
checkout
>                 mode.

OK

> I'm afraid I can't imagine when --no-respect-skip-worktree would be
> useful.  That can easily be a failure of my imagination, though.

There may be scripts that expect "git checkout -- foo" to reset
everything in "foo". Or maybe you just want to check out a single file
and do not bother to edit sparse patterns as you won't need it for
long.
