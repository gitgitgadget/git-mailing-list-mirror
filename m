From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 13:44:48 -0400
Message-ID: <20060829174448.GD21729@spearce.org>
References: <20060829134233.GA21335@spearce.org> <ed1kn3$c3r$1@sea.gmane.org> <20060829162747.GA21729@spearce.org> <7v8xl7moo7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 19:45:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI7dv-0007IL-Na
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 19:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWH2Row convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 Aug 2006 13:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWH2Row
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 13:44:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:24541 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965176AbWH2Rov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 13:44:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GI7di-0002Hx-Kn; Tue, 29 Aug 2006 13:44:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 31F8A20FB7F; Tue, 29 Aug 2006 13:44:48 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xl7moo7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26210>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>=20
> >> Shawn Pearce wrote:
> >>=20
> >> > From a data locality perspective putting the base object before
> >> > or after the delta shouldn't matter, as either way the delta
> >> > is useless without the base. =A0So placing the base immediately
> >> > before the delta should perform just as well as placing it after=
=2E
> >> > Either way the OS should have the base in cache by the time the
> >> > delta is being accessed.
> >...=20
> > I'm going to shutup now and not say anything further on the subject
> > unless I've got some hard results indicating a different organizati=
on
> > is better or worse than what we have right now.
>=20
> I think that may be a sensible thing to do (no sarcasm -- I
> think this measurement is long overdue).
>=20
> The code was initially proposed just like you suggested but is
> in the current form precisely for the reason of avoiding
> back-seek.  I distinctly remember me asking Linus "does mmap()
> favor forward scan by doing readahead?  I thought its point was
> to allow random access" (the answer is "yes" and "yes but
> forward is the common case").
>=20
> The pack-using side in sha1_file.c used to read deltified object
> (both header and delta) in full, pick up and read base, and
> apply delta to base.  This was thought to be memory hungry on a
> longer delta chain, so the current code reads only the header of
> a deltified object, reads base, then reads the delta to apply.
> The last step involves seeking back, and might make the
> back-seek avoidance less effective than before.

Thank you.  That was the sort of response I was looking for.  :-)

I know Jon wants to shrink that ~500 MB Mozilla pack to something
a lot smaller, and I'd like to help him do that without losing huge
amounts of performance on the read.  Very long delta chains (5000!)
are simply impossible to wade through for even one object; doing it
for an entire commit to checkout the files is something I wouldn't
want to wish on anyone.

So I'm probably going to wind up spending some time doing research
and experimentation on pack storage.  I may just discover we're
as good as we can get.  Or I may find that doing something else
saves us only 5% at the cost of far too much complexity and thus
isn't really worth doing.  Or I may get lucky and discover a way
to improve on what we have.

More on this thread (maybe) in a few months.  I have other stuff
I should be doing right now.  :)

--=20
Shawn.
