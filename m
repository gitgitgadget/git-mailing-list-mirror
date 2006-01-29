From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Sat, 28 Jan 2006 19:53:43 -0800
Message-ID: <7v7j8jpu48.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<118833cc0601281814i503bf934ge32b12e7b090c44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 04:53:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F33dL-0003XG-Od
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 04:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWA2Dxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jan 2006 22:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWA2Dxp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jan 2006 22:53:45 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:9460 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750778AbWA2Dxo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2006 22:53:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060129035044.WETQ20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 28 Jan 2006 22:50:44 -0500
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0601281814i503bf934ge32b12e7b090c44@mail.gmail.com>
	(Morten Welinder's message of "Sat, 28 Jan 2006 21:14:26 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15203>

Morten Welinder <mwelinder@gmail.com> writes:

>> Can I hear experiences from other big projects that tried to use
>> git [*1*]?  I suspect there are many that have tried, and I
>> would not be surprised at all if git did not work out well for
>> them.
>
> I've been playing with Gnumeric under git.
> ...
> We haven't switched yet, but I expect that we will...

I might have sounded as if I was looking for failure report, but
success stories are of course welcome ;-).  It's always good to
hear their git experiences first-hand from people in the top
echelon of public projects.

> 270M is about 40% of the cvs repository size.  Given
> compression I would have expected bigger savings.

I think that 40% sounds about right.  My understanding of the
underlying format CVS uses, RCS, is that it stores an full copy
of the tip of trunk uncompressed, and other versions of the file
are represented as incremental delta from that.  The packed git
format does not favor particular version based on the distance
from the tip, and stores either a compressed full copy, or a
delta from some other revision (which may not necessarily be
represented as a full copy).  When we store something as a delta
from something else, we limit the length of the delta chain to a
full copy to 10 (by default), so that you can get to a specific
object with at most 10 applications of delta on top of a full
copy.

Comparing these two formats for storage efficiency is tricky:

 - A full copy of the version at the tip in CVS is not
   compressed but in git a full copy is compressed -- zlib gives
   50% for typical text sources -- git has some advantage here.

 - Because of delta-length limit, we store full copy, albeit
   compressed [*1*], every ten or so versions.  This trades off
   storage effciency for run-time efficiency.

 - CVS storage records most things as delta for a long-lived
   project, and delta are less compressible (IOW, you could
   think of them as already compressed somewhat), so it is not
   _that_ inefficient to begin with.

 - Delta representation is used only when representing something
   as a delta from something else buys as enough space reduction
   than compressing it as a full copy in git.  This is a pure
   improvement from the CVS format.

[Footnote]

*1* You could make different trade-off by using --depth flag
when running git-pack-objects.
