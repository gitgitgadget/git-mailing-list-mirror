From: Jeff King <peff@peff.net>
Subject: Re: bug report
Date: Fri, 13 May 2016 04:10:15 -0400
Message-ID: <20160513081014.GA18307@sigill.intra.peff.net>
References: <CABKuJ_SN+Ynsi9-48-iKgC1n9ARZe3ZjQR9Y2q3=tYC=QGgfZQ@mail.gmail.com>
 <CAFZEwPNCEAU-sexn-dFr8dDg=_w02hLOhfQhKu_yRYtY3LeJHw@mail.gmail.com>
 <CABKuJ_QZHTRcPWbwv1FSXEijxOpXameo-JJuZREGyA5daLbKLQ@mail.gmail.com>
 <CAFZEwPP32vWrCA9H+JbFineodDtGx2_bTjGy-nZ9KW2v8bP5vQ@mail.gmail.com>
 <CABKuJ_SEK-t93sCmj6aFSAbk8muX_ocQx6ZQZV3ZrNmvVmvDQA@mail.gmail.com>
 <CAFZEwPMe2W2R2GghMnyQ4BLyvm00oHEweNSZYrqn+=9BhSazvw@mail.gmail.com>
 <CABKuJ_RrOhT+FVb9PNKhBs1ATJmLWhD757oyx+AvrCGNvT1nFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?utf-8?B?5p2O5pys6LaF?= <libenchao@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 10:10:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b18B8-0006t0-Iy
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 10:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbcEMIK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2016 04:10:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:39047 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752058AbcEMIKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 04:10:18 -0400
Received: (qmail 13462 invoked by uid 102); 13 May 2016 08:10:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 04:10:18 -0400
Received: (qmail 16936 invoked by uid 107); 13 May 2016 08:10:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 04:10:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 04:10:15 -0400
Content-Disposition: inline
In-Reply-To: <CABKuJ_RrOhT+FVb9PNKhBs1ATJmLWhD757oyx+AvrCGNvT1nFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294516>

On Fri, May 13, 2016 at 03:41:13PM +0800, =E6=9D=8E=E6=9C=AC=E8=B6=85 w=
rote:

> It does not warn me in this case. I replayed it again, below is my pr=
ocess:
>=20
> [...setup...]

So after you setup steps you have:

  $ git log --decorate --oneline --raw

  * a3ce3bc (HEAD -> B) modify
  | :100644 100644 94954ab... 23509e0... M        README.md
  * ef702eb add one line too
  | :100644 100644 ce01362... 94954ab... M        README.md
  | * fa8b99e (master, A) add one line
  |/ =20
  |   :100644 100644 ce01362... 94954ab... M      README.md
  * cf2103b add readme
    :000000 100644 0000000... ce01362... A        README.md

Note that B^ (ef702eb) and A (fa8b99e) introduce the exact same change
(moving README.md from ce01362 to 94954ab). And master is at the same
commit as A (due to your fast-forward merge earlier).

So now when you run:

> $ git rebase master

Git will try to replay the commits on master..B on top of master, in
order.  Those commits are ef702eb and a3ce3bc (your commit names will
differ, because your name and timestamps will differ).

So it replays the first one, and sees that it the patch is a noop[1];
the tree in master already has the same end state. So we skip the patch=
=2E
And then we replay the second one, which applies cleanly.

The moment where I think you'd like to be notified is when we skipped
doing anything with patch 1. You'd prefer it to say "woah, the other
side of the rebase did the same thing as us".

But rebase does not do that by default, because the intent of rebase is
that you are rebasing your work on an upstream which might be accepting
part of your work as patches. So it is a feature that rebase says
"already applied upstream -- let's ignore this one".

I don't think there is a way to ask rebase not to ignore such
already-applied patches. But I'm not sure if there should be, for two
reasons:

  1. You should consider just using "git merge" to merge the two
     branches. That preserves more information about what actually
     happened, and would find a conflict in a case like this.

  2. Even with merging, you cannot assume that the end result is sane.
     In your example, there is a textual conflict. But you can easily
     come up with other examples where a merge is textually sound, but
     has some semantic conflict (e.g., you update the signature of a
     function but a colleague adds another call to it using the old
     signature).

     You have to examine and test the results of merges for sanity. And
     likewise with rebases.

-Peff

[1] Actually, rebase does not even try to replay the first patch. When
    it generates the list of commits, it ignores any whose "patch-id" i=
s
    the same as a commit on the other side. But the end effect is the
    same.
