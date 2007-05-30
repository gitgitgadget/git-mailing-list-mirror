From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 17:28:44 +0200
Organization: eudaptics software gmbh
Message-ID: <465D982C.B46DD718@eudaptics.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 17:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtQ60-00067R-B1
	for gcvg-git@gmane.org; Wed, 30 May 2007 17:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbXE3P2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 11:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752756AbXE3P2J
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 11:28:09 -0400
Received: from main.gmane.org ([80.91.229.2]:37203 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbXE3P2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 11:28:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HtQ5d-0000AS-L1
	for git@vger.kernel.org; Wed, 30 May 2007 17:27:57 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 May 2007 17:27:57 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 May 2007 17:27:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48766>

Nguyen Thai Ngoc Duy wrote:
> On clearcase dynamic views (kind of virtual drives), "mv -f a b" won't
> work if "a" is read-only. Because git-repack.sh removes all write
> permission before moving packs, it fails on clearcase dynamic views.
> 
> My approach is rather ugly. Does anyone have a better solution?

If you do two 'git repack -a -d' in a row, the second one fails even
with this patch, right? To fix it, you must 'chmod u+w' in the for-loop
right above this hunk, too.

Since you 'chmod a-w' after the mv, why not just remove the first ones
before the first mv? Then you can get rid of the second try.

-- Hannes

> 
> diff --git a/git-repack.sh b/git-repack.sh
> index acb78ba..76a9525 100755
> --- a/git-repack.sh
> +++ b/git-repack.sh
> @@ -86,10 +86,22 @@ else
>         mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
>         test -f "$PACKDIR/pack-$name.pack" &&
>         test -f "$PACKDIR/pack-$name.idx" || {
> -               echo >&2 "Couldn't replace the existing pack with updated one."
> -               echo >&2 "The original set of packs have been saved as"
> -               echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
> -               exit 1
> +               # Clearcase dynamic views do not allow to move file without write permission
> +               # Try the second time with write allowed
> +               chmod u+w "$PACKTMP-$name.pack"
> +               chmod u+w "$PACKTMP-$name.idx"
> +
> +               mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
> +               mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
> +               test -f "$PACKDIR/pack-$name.pack" &&
> +               test -f "$PACKDIR/pack-$name.idx" || {
> +                       echo >&2 "Couldn't replace the existing pack with updated one."
> +                       echo >&2 "The original set of packs have been saved as"
> +                       echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
> +                       exit 1
> +               }
> +               chmod a-w "$PACKDIR/pack-$name.pack"
> +               chmod a-w "$PACKDIR/pack-$name.idx"
>         }
>         rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
>  fi
> 
> --
> Duy
