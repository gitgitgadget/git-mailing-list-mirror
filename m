From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Concurrent pushes updating the same ref
Date: Thu, 6 Jan 2011 08:48:11 -0800
Message-ID: <AANLkTinGYjExrnHCqcTPu-APzk9WynxwWoKVOLaSkZ2y@mail.gmail.com>
References: <4D25E3DE.7050801@xiplink.com> <20110106163035.GA7812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 17:48:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pat0w-0005pT-0g
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 17:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862Ab1AFQsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 11:48:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33003 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab1AFQsc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 11:48:32 -0500
Received: by iyi12 with SMTP id 12so15015612iyi.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 08:48:32 -0800 (PST)
Received: by 10.231.16.68 with SMTP id n4mr24520570iba.94.1294332511905; Thu,
 06 Jan 2011 08:48:31 -0800 (PST)
Received: by 10.231.168.3 with HTTP; Thu, 6 Jan 2011 08:48:11 -0800 (PST)
In-Reply-To: <20110106163035.GA7812@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164639>

On Thu, Jan 6, 2011 at 08:30, Jeff King <peff@peff.net> wrote:
>
> Yeah, we probably should try again. The simplest possible (and untest=
ed)
> patch is below. However, a few caveats:
>
> =A01. This patch unconditionally retries for all lock files. Do all
> =A0 =A0 callers want that? I wonder if there are any exploratory lock
> =A0 =A0 acquisitions that would rather return immediately than have s=
ome
> =A0 =A0 delay.

I don't see why not.  We shouldn't be exploring to see if a lock is
possible anywhere.

> =A02. The number of tries and sleep time are pulled out of a hat.

=46WIW, JGit has started to do some of this stuff for Windows.  We're
using 10 retries, with a delay of 100 milliseconds between each.  This
was also pulled out of a hat, but it seems to have resolved the bug
reports that came in on Windows.  We unfortunately have to do retries
on directory and file deletion.

> =A03. Even with retries, I don't know if you will get the behavior yo=
u
> =A0 =A0 want. The lock procedure for refs is:
>
> =A0 =A0 =A0 =A01. get the lock
> =A0 =A0 =A0 =A02. check and remember the sha1
> =A0 =A0 =A0 =A03. release the lock

Why are we locking the ref to read it?  You can read a ref atomically
without locking.

> =A0 =A0 =A0 =A04. do some long-running work (like the actual push)
> =A0 =A0 =A0 =A05. get the lock
> =A0 =A0 =A0 =A06. check that the sha1 is the same as the remembered o=
ne
> =A0 =A0 =A0 =A07. update the sha1
> =A0 =A0 =A0 =A08. release the lock
>
> =A0 =A0 Right now you are getting contention on the lock itself. But =
may
> =A0 =A0 you not also run afoul of step (6) above? That is, one push u=
pdates
> =A0 =A0 the ref from A to B, then the other one in attempting to go f=
rom A
> =A0 =A0 to B sees that it has already changed to B under our feet and
> =A0 =A0 complains?

Not if its a force push.  :-)

--=20
Shawn.
