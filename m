From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Fwd: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 11:43:55 -0400
Message-ID: <fcaeb9bf0705300843v10782be3i985d10144535868c@mail.gmail.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
	 <465D982C.B46DD718@eudaptics.com>
	 <fcaeb9bf0705300840w221c46c1y742388fc9e61c2fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 30 18:07:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtQhu-0007Lv-0W
	for gcvg-git@gmane.org; Wed, 30 May 2007 18:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbXE3QGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 12:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbXE3QGo
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 12:06:44 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:23031 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756790AbXE3QGm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 12:06:42 -0400
Received: by an-out-0708.google.com with SMTP id d31so715451and
        for <git@vger.kernel.org>; Wed, 30 May 2007 09:06:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lgfcXffb18kHnQN4ErpEiUxguNeYLpaQUbzGFwuGjNa3oxixTSPmuWqxkHAF72ZGqXu3rSJMmjDAH9nEY8NeDLS2DjzrCou4v7dVD7TuCavwpCI4aHVDw+M3yzXRJsEL7Ps1yAAXSB1krLMamUscIqQStQRMgiAN2Tw8XaeBqlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XX1InuSEcZhqRz7Oed4pshapTQ6kEIF8NvPEvab1DPdbLW9JdEww6iA29hYL8geoJXnxCkNikF0pzQOIrVOoIrUMxX3acgd7g4148gjDESwiwQHNnMfrz3rE4Ll4zG2EvlGfdz4YT3WumP/ZbVka24lLNvjMgctQnjkeQKlESWs=
Received: by 10.100.94.3 with SMTP id r3mr581830anb.1180539835686;
        Wed, 30 May 2007 08:43:55 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Wed, 30 May 2007 08:43:55 -0700 (PDT)
In-Reply-To: <fcaeb9bf0705300840w221c46c1y742388fc9e61c2fa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48769>

I'm sorry, forgot to CC the list.

---------- Forwarded message ----------
From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Date: May 30, 2007 11:40 AM
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
To: Johannes Sixt <J.Sixt@eudaptics.com>


On 5/30/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Nguyen Thai Ngoc Duy wrote:
> > On clearcase dynamic views (kind of virtual drives), "mv -f a b" won't
> > work if "a" is read-only. Because git-repack.sh removes all write
> > permission before moving packs, it fails on clearcase dynamic views.
> >
> > My approach is rather ugly. Does anyone have a better solution?
>
> If you do two 'git repack -a -d' in a row, the second one fails even
> with this patch, right? To fix it, you must 'chmod u+w' in the for-loop
> right above this hunk, too.

Well, I'm not sure I understand it. git-repack with the patch applied
runs fine for me. Can you explain it more detail please?

>
> Since you 'chmod a-w' after the mv, why not just remove the first ones
> before the first mv? Then you can get rid of the second try.

Because I'm not sure what that command is for :) I suspect that packs
(or anything inside .git/objects) are read-only and the author want to
make sure no one can write to the packs as soon as they are created.
The other way to do is to move 'chmod a-w' down several lines -- we
only make those files read-only after moving them to
.git/objects/packs.

>
> -- Hannes
>
> >
> > diff --git a/git-repack.sh b/git-repack.sh
> > index acb78ba..76a9525 100755
> > --- a/git-repack.sh
> > +++ b/git-repack.sh
> > @@ -86,10 +86,22 @@ else
> >         mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
> >         test -f "$PACKDIR/pack-$name.pack" &&
> >         test -f "$PACKDIR/pack-$name.idx" || {
> > -               echo >&2 "Couldn't replace the existing pack with updated one."
> > -               echo >&2 "The original set of packs have been saved as"
> > -               echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
> > -               exit 1
> > +               # Clearcase dynamic views do not allow to move file without write permission
> > +               # Try the second time with write allowed
> > +               chmod u+w "$PACKTMP-$name.pack"
> > +               chmod u+w "$PACKTMP-$name.idx"
> > +
> > +               mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
> > +               mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" &&
> > +               test -f "$PACKDIR/pack-$name.pack" &&
> > +               test -f "$PACKDIR/pack-$name.idx" || {
> > +                       echo >&2 "Couldn't replace the existing pack with updated one."
> > +                       echo >&2 "The original set of packs have been saved as"
> > +                       echo >&2 "old-pack-$name.{pack,idx} in $PACKDIR."
> > +                       exit 1
> > +               }
> > +               chmod a-w "$PACKDIR/pack-$name.pack"
> > +               chmod a-w "$PACKDIR/pack-$name.idx"
> >         }
> >         rm -f "$PACKDIR/old-pack-$name.pack" "$PACKDIR/old-pack-$name.idx"
> >  fi
> >
> > --
> > Duy
>
>


--
Duy


-- 
Duy
