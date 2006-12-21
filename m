From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Add a test for git-rerere
Date: Thu, 21 Dec 2006 09:34:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612210927150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612201737190.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4prqfm6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 09:34:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJNW-0005G1-14
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422799AbWLUIeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 03:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422806AbWLUIeK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:34:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:39356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422799AbWLUIeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 03:34:09 -0500
Received: (qmail invoked by alias); 21 Dec 2006 08:34:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 21 Dec 2006 09:34:07 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4prqfm6c.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35027>

Hi,

On Wed, 20 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +sha1=4f58849a60b4f969a2848966b6d02893b783e8fb
> > +rr=.git/rr-cache/$sha1
> > +test_expect_success 'recorded preimage' "grep ======= $rr/preimage"
> > +
> > +test_expect_success 'no postimage or thisimage yet' \
> > +	"test ! -f $rr/postimage -a ! -f $rr/thisimage"
> 
> I am worried that this test specifies the behaviour a bit too
> precisely.  It is not t0000 basic where we want bit-for-bit
> match with the expected result.  Wouldn't this test break when
> you further improve xdl_merge, for example?

In this case, I doubt that xdl_merge() can do _anything_. The example is 
set up so it _must_ fail with any sane merge algorithm.

And I very much wanted the behaviour put down very precisely, so that I 
catch any bugs in builtin-rerere. In fact, as I went, I wrote the test 
with the original rerere, and then whipped the builtin until it conformed.

Since anyone modifying rerere's behaviour can modify this test to catch 
that behaviour, too, I am not so worried.
 
> > +rm $rr/postimage
> > +echo -ne "$sha1\ta1\0" > .git/rr-cache/MERGE_RR
> 
> Hmmmmmm.  I've stayed away from "echo -e" so far...

Rather do it with tr? Like this:

	echo -n "$sha1	a1X" | tr X '\0' > .git/rr-cache/MERGE_RR

> > +sha2=4000000000000000000000000000000000000000
> > +rr2=.git/rr-cache/$sha2
> > +mkdir $rr2
> > +echo Hello > $rr2/preimage
> 
> Collisions are not so likely and perhaps we do not care.

Both. If collisions were likely, we both would know by now _and_ would be 
in serious trouble. And we do not care, since there cannot be any other 
directory in rr-cache, apart from $sha1/.

> > +case "$(date -d @11111111 +%s 2>/dev/null)" in
> > +[1-9]*)
> > +	# it is a recent GNU date. good.
> > +	now=$(date +%s)
> > +	let almost_15_days_ago=$now+60-15*86400
> > +	let just_over_15_days_ago=$now-1-15*86400
> > +	let almost_60_days_ago=$now+60-60*86400
> > +	let just_over_60_days_ago=$now-1-60*86400
> 
> Hmmmmm.  I've stayed away from "let" so far as well...

Is $((1+2)) portable enough? I always thought this is a bashism...

Ciao,
Dscho
