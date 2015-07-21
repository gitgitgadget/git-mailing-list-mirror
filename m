From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: Question: .idx without .pack causes performance issues?
Date: Tue, 21 Jul 2015 14:49:59 -0500
Message-ID: <CAEtYS8RUNyhnHWHYRiPr99_p_1x-sHX0cwRRpeVgLL_T4vTG+A@mail.gmail.com>
References: <CAEtYS8QWCg5_DtrJw-e+c50vcG0OpciR6LWon-3GgyngGn+0pQ@mail.gmail.com>
	<xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:50:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdYG-0006Z5-7j
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbbGUTuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:50:01 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37993 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbGUTuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:50:00 -0400
Received: by iggf3 with SMTP id f3so116415809igg.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rC1iRUR3IN1BAZS8SiBypa5+c1Hq2Z3AMGZTaBLH0/0=;
        b=wHfjZl8yMWXwzTccrDNGE539KJnbJVR4rHw/0npg1xUE6mkkSphKqWVx3hJriJp+PV
         KX37oId5/O0z4WurZJWL1U4JrFEe9/K0vh7FJ/7moKdKy5yCXHFWXfiHl9sGeVE1iTlP
         K8M29nJjdiN9JSBM0pWJ4A7l5Sk8ldXGUanT/LUHBHUwAzHE5yzEkadr+Frw5gZKEcoS
         S5L2EgU25t0PMe94uWR0ay6lpB/97ze2KH/mZi3SMgPeibop5kQYIPXoFxfGEPYiiZlm
         ag3mY4gELv4jI2vIs1qTi4Pv26r8alv3I/Fa8WDLc88JwRCenT3IZoSvw+PAJrPW7rma
         9NEA==
X-Received: by 10.107.9.137 with SMTP id 9mr54198690ioj.50.1437508199702; Tue,
 21 Jul 2015 12:49:59 -0700 (PDT)
Received: by 10.50.12.166 with HTTP; Tue, 21 Jul 2015 12:49:59 -0700 (PDT)
In-Reply-To: <xmqq4mkxwd77.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274406>

On Tue, Jul 21, 2015 at 1:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I wouldn't be surprised if such a configuration to have leftover
> ".idx" files that lack ".pack" affected performance, but I think you
> really have to work on getting into such a situation (unless your
> operating system is very cooperative and tries hard to corrupt your
> repository, that is ;-), so I wouldn't be surprised if you were the
> first one to report this.

I'm inclined to believe Windows isn't helping this situation: seems
like something it might do, especially because of how it behaves if
one process has a file open. Since I haven't caught a case where these
files show up, maybe adding some tweaks to look for it occurring (such
as on our Jenkins workers, if it's happening there now) would give us
a better indication of the "why" question.  It could even be that it
has occurred long ago, and the performance issue is just now observed:
our environment has run 1.7.4, 1.8.3, and now 1.9.5 -- so even an
unknown bug in a previous version could impact us now.

>
> We open the ".idx" file and try to keep as many of them in-core,
> without opening corresponding ".pack" until the data is needed.
>
> When we need an object, we learn from an ".idx" file that a
> particular pack ought to have a copy of it, and then attempt to open
> the corresponding ".pack" file.  If this fails, we do protect
> ourselves from strange repositories with only ".idx" files by not
> using that ".idx" and try to see if the sought-after object exists
> elsewhere (and if there isn't we say "no such object", which is also
> a correct thing to do).
>
> I however do not think that we mark the in-core structure that
> corresponds to an open ".idx" file in any way when such a failure
> happens.  If we really cared enough, we could do so, saying "we know
> there is .idx file, but do not bother looking at it again, as we
> know the corresponding .pack is missing", and that would speed things
> up a bit, essentially bringing us back to a sane situation without
> any ".idx" without corresponding ".pack".

I think this is where the performance hit occurs on Windows: file stat
operations in general are pretty slow, and I know msysgit did some
things to emulate as much of the POSIX API as possible -- which isn't
always easy on Windows.  But, some of the developers that know
compat/win32/ better would know more (I recall the dirent stuff being
pretty complicated, but open/fopen seem rather straightforward).  And
yes -- retrying the operation each time and failing only compounds the
issue.

>
> I do not think it is worth the effort, though.  It would be more
> fruitful to find out how you end up with ".idx exists but not
> corresponding .pack" and if that is some systemic failure, see if
> there is a way to prevent that from happening in the first place.

Agreed.  It feels like a workaround for a case where you're already in
a bad state...

>
> Also, I think it may not be a bad idea to teach "gc" to remove stale
> ".idx" files that do not have corresponding ".pack" as garbage.

I agree.  This seems like a more correct solution -- if gc understands
to clean up these bad .idx files, it would then be a non-issue when
searching the packs.  The solution you posted to check if an
associated packfile exists -- while perhaps not belonging there --
could still be useful to delete orphanend .idx files.

I think you're correct, though -- if you did propose the solution to
sha1_file.c, it would be necessary to prevent scanning that .idx
again, or else any potential gains would be lost continually
stat()'ing the file.  Now, msysgit does have core.fscache to try
caching the stat()/lstat() results to lessen the impact, but this
isn't on by default, I believe.
