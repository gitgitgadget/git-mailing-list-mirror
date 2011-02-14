From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: configuring cherry-pick to always use -x?
Date: Mon, 14 Feb 2011 13:09:32 -0500
Message-ID: <AANLkTin0xB=hJ-v21+esT6Zqj2f53XiwD8tBW4qFkuVy@mail.gmail.com>
References: <4D596435.9020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 19:10:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp2sR-0002hH-Om
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 19:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129Ab1BNSKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 13:10:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56871 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab1BNSKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 13:10:03 -0500
Received: by iyj8 with SMTP id 8so5070123iyj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KRMKolRMnFHE7r93pucXd8U6wsMclrOk34XjA/ewfHQ=;
        b=LgJDZ5wW8kk7czXhNM5aRxmVGmbLM+uZWLtdy6NKljSDIW/64nTMK9lv5xE2+JTNod
         nRR3zBtvjAZ7BGFL2kDNfJ+gI6M+zUJhan1C0oP7d7QR0SZRb2/xeqHkzehxM7+HcC4P
         7Rt+CW7K9s+WdRN4FuMNoAkS8U1qErEkcZsp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IzxrYIgjYYScCDv9/pJKiMAB0xShSoaPnafrlnqb5JlEMaLtZcj/RABk1TO1s5IVMr
         6zVuGLvghl3JXROFNn/fbsD+94bBUVbQ0GJAgQ1n5OaO7qbsUVKJ6a3oqap7ty+F3ZMe
         3bBjtO7NfKtxHFgGQHuX1ASRP1RGGUhN87ApY=
Received: by 10.231.38.2 with SMTP id z2mr3136711ibd.142.1297707002669; Mon,
 14 Feb 2011 10:10:02 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 14 Feb 2011 10:09:32 -0800 (PST)
In-Reply-To: <4D596435.9020605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166744>

On Mon, Feb 14, 2011 at 12:19 PM, Adam Monsen <haircut@gmail.com> wrote=
:
> Is there a configuration option to make cherry-pick always include th=
e
> source commit hash in the new commit log message?
>
> e.g., make "git cherry-pick" always behave like "git cherry-pick -x"?

Nope, but one would be appreciated. :-)

> My most frequent use case for cherry picking is between publicly visi=
ble
> branches.
>
> I have the following configuration option set:
>
> =C2=A0alias.cpx=3Dcherry-pick -x
>
> but I rarely remember to use it.

It's worse than that. I like to keep the message generated after a
cherry-pick conflict, but the original commit authorship. I have this,
which I call recommit:

<snip>
#!/bin/sh
# Used after a cherry-pick conflicts to commit with the original
# authorship (commit -c) but keep the newly generated commit message
#
self=3D$(cd "$(dirname "$0")" && pwd -P)/$(basename "$0")
=2E "$(git --exec-path)/git-sh-setup"
require_work_tree
cd_to_toplevel
test -f .git/MERGE_MSG || die "No .git/MERGE_MSG"

if test "$GIT_EDITOR" =3D "$self"
then
  cat .git/MERGE_MSG > .GIT/COMMIT_EDITMSG
  exit 0
fi

if sha1=3D$(sed -ne \
  's/^(cherry picked from commit \([a-f0-9]\{40\}\))$/\1/p' .git/MERGE_=
MSG)
then
  export GIT_EDITOR=3D"$self"
  git commit -c $sha1
fi
</snip>

I've had it on my TODO list for a while now to:

1. add a config option to enable -x by default

2. improve the cherry-pick conflict UX. I was thinking of out
CHERRY_HEAD on conflict and then adding a cherry-pick --continue
option which acts like rebase --continue. CHERRY_HEAD is what was
being picked at the time of conflict and can be used by the bash
completion script for proper prompting, as well as obviously the
--continue option.

j.
