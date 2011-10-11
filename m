From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/WIP PATCH] Use config value rebase.editor as editor when
 starting git rebase -i
Date: Tue, 11 Oct 2011 14:15:25 -0400
Message-ID: <CABURp0oQJ_rUQyOmm+CmZaqBp2mZYCwZRAz_mO5BshK4E+6eCA@mail.gmail.com>
References: <201110111956.08829.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Tue Oct 11 20:15:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDgro-0002zq-Jx
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 20:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab1JKSPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 14:15:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40936 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab1JKSPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 14:15:47 -0400
Received: by wyg34 with SMTP id 34so7345491wyg.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UTcCkr+N4lfkFZLsV2XW2soTI9VXdOA9NWePRVVd9hM=;
        b=hUQng3A0eBK0qCJB1n/DxqayOWyYSeYPyJ+hjuVD57ewpAOc2gRZsZjd+HyZA/cxOp
         KPVIBZxjorgT6ID6MjkEWPoxUdLttZENy7llJ99+sIXmKlGtlLOY8EL4TkR1fGyk6M1t
         9a0nai3OCcvEse+f/g/k5a50kIv06gsupR3tU=
Received: by 10.216.159.12 with SMTP id r12mr1306358wek.87.1318356946222; Tue,
 11 Oct 2011 11:15:46 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 11 Oct 2011 11:15:25 -0700 (PDT)
In-Reply-To: <201110111956.08829.kumbayo84@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183316>

On Tue, Oct 11, 2011 at 1:56 PM, Peter Oberndorfer <kumbayo84@arcor.de>=
 wrote:
> i wrote a (not yet released) git rebase -i helper that allows to orde=
r commits
> by drag/drop and allows to select the action from a combo box.
> (written in Qt)
> See http://i55.tinypic.com/2d94gg0.jpg for how it currently looks lik=
e. :-)
> No more typos, no more lost commit by cutting without pasting...

[+1]

>
> To integrate this properly into git i need something like this patch.
>
> Open questions/problems:
> * GIT_EDITOR env var is not honored anymore after this change.
> =A0Help from somebody with more bash knowledge is highly appreciated!
>
> * Should git_rebase_editor be in git-rebase--interactive.sh instead
> =A0(since it is only used there)
>
> * How should the config be called?
> =A0It is not directly used during rebase, only during rebase -i
> =A0that might not be fully clear from the config name.
>
> * Better config.txt description?
>
> Thanks,
> Greetings Peter
>
> PS: My tool will hopefully be released soon.
> Cleanup code, test(lin/ win), write some doc (how to use with git),
> choose name :-), choose license...
>
> =A0Documentation/config.txt =A0 | =A0 =A06 ++++++
> =A0git-rebase--interactive.sh | =A0 =A02 +-
> =A0git-sh-setup.sh =A0 =A0 =A0 =A0 =A0 =A0| =A0 13 +++++++++++++
> =A03 files changed, 20 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 03296b7..1d9ae79 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1591,6 +1591,12 @@ rebase.stat::
> =A0 =A0 =A0 =A0Whether to show a diffstat of what changed upstream si=
nce the last
> =A0 =A0 =A0 =A0rebase. False by default.
>
> +rebase.editor::
> + =A0 =A0 =A0 Text editor used by git rebase -i for editing the rebas=
se todo file.
s/rebasse/rebase/

> =A0cp "$todo" "$todo".backup
> -git_editor "$todo" ||
> +git_rebase_editor "$todo" ||
> =A0 =A0 =A0 =A0die_abort "Could not execute editor"

Maybe something like this would work:
  git_rebase_editor "$todo" ||
  git_editor "$todo" ||
=A0 =A0 =A0 =A0die_abort "Could not execute editor"

If git_rebase_editor call returns an error (non-zero exit code), then
git_editor will be invoked. If that also returns an error, then the
die_abort is called.

I think this will allow your env:GIT_EDITOR to work as expected.

Phil
