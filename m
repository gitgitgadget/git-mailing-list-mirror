From: Paolo Giarrusso <p.giarrusso@gmail.com>
Subject: Fwd: [PATCH] git-subtree: Avoid using echo -n even indirectly
Date: Wed, 9 Oct 2013 12:32:31 +0200
Message-ID: <CAAcnjCQ+c=8wYZkqS7VzZ_bDDDkSwdQ3qdz77osrSpKDS9ON7Q@mail.gmail.com>
References: <1381291045-98372-1-git-send-email-p.giarrusso@gmail.com>
 <CALUzUxovH5MTP1_DMigRx1Hp+X6v3_YdLK2vSG4KwRLNSDHN-w@mail.gmail.com> <CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 12:32:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTr4b-0004kI-PZ
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 12:32:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525Ab3JIKcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 06:32:54 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:38054 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3JIKcx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 06:32:53 -0400
Received: by mail-lb0-f179.google.com with SMTP id x18so601570lbi.10
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=65pXYd54+2K5DcoGVF06mWzHxNsF2dlZI5jbbG6jVPQ=;
        b=iPPNbmQD2BiEeL+CAvPA2Lx4psyMeck+6cvdKAX3Ozcgsu8GLq8+0L5PaJ2Y9pQiU6
         7cx1rBiX2x5+6QTfa4qj6/3V/LiOmGM+adovxouGx6/5YbXgS0GyUs09aQVhg7zvdFPy
         ygDBqHeG71PDBsOGlq5QzchiqTr5UG8keDl3IbZ3bluUt4ENxbjO6ayx9rhVZzERHlfh
         WooQ7Sux+u9gVW2mUlykTgPK1KtGBd9LVSqPMRnmW2+i5S2vBMX7Cy9M4xNkEWk6i679
         AdwNYImXld7ZZDWhOqHDOE/PNiqHjE6eBDWoCWTSG99tfNZffn+q3Y62HN0UgjcZzb6Z
         1vCw==
X-Received: by 10.112.0.173 with SMTP id 13mr6696299lbf.8.1381314772002; Wed,
 09 Oct 2013 03:32:52 -0700 (PDT)
Received: by 10.112.190.102 with HTTP; Wed, 9 Oct 2013 03:32:31 -0700 (PDT)
In-Reply-To: <CAAcnjCT1bdR+9kDW=q_326OhiSMm3_j-yOh0-ayTkObK3bZ3bQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235805>

(Resending without HTML).

On Wed, Oct 9, 2013 at 12:20 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
>
> On Wed, Oct 9, 2013 at 11:57 AM, Paolo G. Giarrusso
> <p.giarrusso@gmail.com> wrote:
> > diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> > index 7d7af03..ebfb78f 100755
> > --- a/contrib/subtree/git-subtree.sh
> > +++ b/contrib/subtree/git-subtree.sh
> > @@ -592,7 +592,9 @@ cmd_split()
> >         eval "$grl" |
> >         while read rev parents; do
> >                 revcount=$(($revcount + 1))
> > -               say -n "$revcount/$revmax ($createcount)
> > "
> > +               if [ -z "$quiet" ]; then
> > +                       printf "%s" "$revcount/$revmax ($createcount)
> > " >&2

An additional note for reviewers and appliers: the original and the
patched codeboth embed a literal ^M, not a new line, go to back to the
beginning of the line and overwrite it, so the above is not a
consequence of line-wrap.

I used git-format-patch and git-send-email, and the ^M is visible in
Vim in the exported patch (that's why I didn't remark on it).
Seeing the email, I wonder whether there's hope something like that
can be preserved in an email, and whether the code should use some
escape sequence instead.

> > +               fi
>
> Reviewers might wish to know that "say" in git-subtree is defined as
>
>         say()
>         {
>                 if [ -z "$quiet" ]; then
>                         echo "$@" >&2
>                fi
>         }
>
> Hence the "if" and the redirect.

Indeed. I considered having a variant of `say` instead of inlining and
customizing it, but for once I decided to keep this simple, since this
variant of `say` is currently used only once. Otherwise, one could
change say to use printf, but that's more invasive.

Cheers,
-- 
Paolo G. Giarrusso - Ph.D. Student, Philipps-University Marburg
http://www.informatik.uni-marburg.de/~pgiarrusso/
