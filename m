From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-push: update remote tags only with force
Date: Wed, 31 Oct 2012 06:55:06 +0100
Message-ID: <CAMP44s2T9Rmfjd8r+2+eYh8JBPXEofm3cHuEkkY+R3cW6R6HxA@mail.gmail.com>
References: <1351661875-4307-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 06:55:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTRGq-0004H4-EM
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 06:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab2JaFzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 01:55:08 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41583 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab2JaFzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 01:55:07 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1086524obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 22:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t3GCK9YC3Q5tt/1gqlqlzFhIizA8bj44R6tc95TS6Ro=;
        b=dHpQN61m9/sUDh7MbWzNdaSWLPp7UqyEWgDfay2DiqMUyB5GoQksi4ZYQCs3EyuaL4
         /xdnUHf+3YYWUKH96aTG501rTDuPcSg+9nhVJe0TPpQ207U4iGP+PuS2cwrMsxryujnx
         TG+3fneha1LfvfhMHQTkr9OT4ZmvpX/lerO/l1ulYsBXSDwW+pqSWQaKNz9FKb2Ns+5y
         vGYwmiU+ybI6DTjrZqJ3spkUIRLgHMrvt72x4bwSZYRQgn07DYiXZL2aT1wpO5hNwstA
         Xgh74VQVtmguGx5CiwGGj78sSsRFD3BA8s/8heULYCYmohr8XnuTelGm4X5yg59oFUQC
         gkiA==
Received: by 10.60.31.241 with SMTP id d17mr30572183oei.107.1351662906360;
 Tue, 30 Oct 2012 22:55:06 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 22:55:06 -0700 (PDT)
In-Reply-To: <1351661875-4307-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208793>

Hi,

(again because the mailing list rejected it) (Gmal switched interface
and HTML is the default)

On Wed, Oct 31, 2012 at 6:37 AM, Chris Rorvick <chris@rorvick.com> wrote:
>
> References are allowed to update from one commit-ish to another if the
> former is a ancestor of the latter.  This behavior is oriented to
> branches which are expected to move with commits.  Tag references are
> expected to be static in a repository, though, thus an update to a
> tag (lightweight and annotated) should be rejected unless the update is
> forced.
>
> To enable this functionality, the following checks have been added to
> set_ref_status_for_push() for updating refs (i.e, not new or deletion)
> to restrict fast-forwarding in pushes:
>
>   1) The old and new references must be commits.  If this fails,
>      it is not a valid update for a branch.
>
>   2) The reference name cannot start with "refs/tags/".  This
>      catches lightweight tags which (usually) point to commits
>      and therefore would not be caught by (1).
>
> If either of these checks fails, then it is flagged (by default) with a
> status indicating the update is being rejected due to the reference
> already existing in the remote.  This can be overridden by passing
> --force to git push.
>
> The new status has the added benefit of being able to provide accurate
> feedback as to why the ref update failed and what can be done.
> Currently all ref update rejections are assumed to be for branches.

Makes sense to me. I've believe I've been hit by this a couple of
times when tags were updated, and a colleague did 'git push' and they
went all back, or something like that. To handle that case properly
probably more changes are needed, but this is a change in the right
direction.

> +test_expect_success 'push tag requires --force to update remote tag' '
> +       mk_test heads/master &&
> +       mk_child child1 &&
> +       mk_child child2 &&
> +       (
> +               cd child1 &&
> +               git tag lw_tag &&
> +               git tag -a -m "message 1" ann_tag &&
> +               git push ../child2 lw_tag &&
> +               git push ../child2 ann_tag &&
> +               >file1 &&
> +               git add file1 &&
> +               git commit -m "file1" &&
> +               git tag -f lw_tag &&
> +               git tag -f -a -m "message 2" ann_tag &&
> +               ! git push ../child2 lw_tag &&

You probably should use test_must_fail.

I don't see anything wrong with the patch, but I wonder if it might be
possible to split it to ease the review.

Cheers.

--
Felipe Contreras
