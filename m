From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH 5/3] Alternative --dirstat implementation,
 based on diffstat analysis
Date: Wed, 13 Apr 2011 00:03:02 +0200
Message-ID: <201104130003.02869.johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <BANLkTi=yYU+v1Xx_YO6kpC8+1ukOdwb6SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:03:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9lg5-0006r7-4w
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 00:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299Ab1DLWDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 18:03:11 -0400
Received: from smtp.getmail.no ([84.208.15.66]:51819 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757195Ab1DLWDK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 18:03:10 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJK003VM7X8CR50@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 13 Apr 2011 00:03:08 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id CA7651EA58BC_DA4CC1CB	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 22:03:08 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 93DD51EA31DA_DA4CC1BF	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 22:03:07 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJK000777X3EE30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 13 Apr 2011 00:03:07 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <BANLkTi=yYU+v1Xx_YO6kpC8+1ukOdwb6SQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171421>

On Tuesday 12 April 2011, Linus Torvalds wrote:
> On Tue, Apr 12, 2011 at 7:46 AM, Linus Torvalds
> 
> <torvalds@linux-foundation.org> wrote:
> > So I don't hate the idea, but I do hate the "use a config option"
> > part. Or rather, I hate the fact that it's the _only_ way to do it
> > (and the particular config name you chose).
> 
> Oh, and one thing strikes me: I think the fast dirstat gave reasonable
> values when you had mixed text and binary (in the kernel tree, look
> for the Documentation/logo.gif file, for example: it changed to the
> Tasmanian devil in one release).
> 
> Have you checked what happens to that when you use the diffstat one?
> Because binary files are done very differently (byte-based counts).
> 
> So check out
> 
>    git show --dirstat 3d4f16348b77efbf81b7fa186a18a0eb815b6b84
> 
> with and without your change. The old dirstat gives
> 
>   44.0% Documentation/
>   55.9% drivers/video/logo/
> 
> which is at least not completely insane.

My change obviously makes a difference:

  68.7% Documentation/
  31.2% drivers/video/logo/

To make some more sense of the number, here they are with some extra
output from a debug printf:

$ ../git/git show --dirstat 3d4f163
  [...]

        Documentation/logo.gif: +16335 -0 => damage = 16335
        Documentation/logo.svg: +0 -310450 => damage = 310450
        Documentation/logo.txt: +562 -200 => damage = 762
        drivers/video/logo/logo_linux_clut224.ppm: +76628 -136093 => damage = 212721
        drivers/video/logo/logo_linux_vga16.ppm: +76837 -126084 => damage = 202921
  44.0% Documentation/
  55.9% drivers/video/logo/


$ ../git/git -c diff.dirstatbasedondiffstat=true show --dirstat 3d4f163
  [...]

        Documentation/logo.gif: +16335 -0 => damage = 16335
        Documentation/logo.svg: +0 -2911 => damage = 2911
        Documentation/logo.txt: +12 -3 => damage = 15
        drivers/video/logo/logo_linux_clut224.ppm: +1602 -2826 => damage = 4428
        drivers/video/logo/logo_linux_vga16.ppm: +1602 -2737 => damage = 4339
  68.7% Documentation/
  31.2% drivers/video/logo/

In the original dirstat numbers (computed by diffcore_count_changes())
all the numbers (both from text and binary files) are on a byte scale.
(making the binary logo.gif changes proportional in scale to the rest).

In the diffstat analysis, however, binary changes are reported in bytes,
while text changes are reported in lines. This obviously makes binary
changes count disproportionately more than textual changes.

> The reason I bring this up is because I think this was an issue at one
> point, and one of the statistics things (--stat or --numstat or
> --dirstat) gave absolutely horrid values (basically comparing "bytes
> changed" for binaries with "lines changed" for text files). Resulting
> in totally skewed statistics.

Indeed, that's exactly what's going on here. Looking at the other
--*stat options:

--stat has a special output mode for binary files:

        Documentation/logo.gif      | Bin 0 -> 16335 bytes

--numstat refuses to show any meaningful output for binary files:

        -       -       Documentation/logo.gif

--shortstat skips binary (and unmerged) files altogether.


So, how should we count binary files in the diffstat version of
--dirstat? Looking at the available data in struct diffstat_file,
there's not a lot of "source material" available. If I had easy
access to the file pre/post size, and the total number of lines,
I could calculate the average number of bytes per line, and then
multiply that with the diffstat numbers to get an approximate
byte count. A crude fallback would be to use 64 bytes per line...

A better solution might be to add a flag to struct diffstat_t
indicating that we want byte counts (as opposed to line counts) for
text files, and then use that flag from within diffstat_consume() to
add "len" instead of "1" to x->added/deleted.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
