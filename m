From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Fri, 10 Feb 2006 17:04:45 -0500
Message-ID: <20060210220445.GD456@mythryan2.michonline.com>
References: <11394103753694-git-send-email-ryan@michonline.com> <7vd5hxpr2d.fsf@assigned-by-dhcp.cox.net> <20060208210756.GA9490@mythryan2.michonline.com> <7vlkwlo788.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 10:57:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7rVA-0002LT-RS
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 10:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWBKJ5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 04:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWBKJ5J
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 04:57:09 -0500
Received: from mail.autoweb.net ([198.172.237.26]:13233 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751368AbWBKJ5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 04:57:07 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F7rV2-0004PV-0C; Sat, 11 Feb 2006 04:57:07 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F7rUx-0002UO-2h; Sat, 11 Feb 2006 04:57:03 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F7gO1-0003gj-Va; Fri, 10 Feb 2006 17:05:06 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkwlo788.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Spam-Score: -4.3
X-Spam-Report: Spam detection software, running on the system "h4x0r5.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Feb 08, 2006 at 01:45:11PM -0800, Junio C Hamano
	wrote: > Ryan Anderson <ryan@michonline.com> writes: > > >> It's been a
	while since I looked at it the last time so it may > >> not even work
	with the current git, but here it is.. > > > > I'll take a look through
	this in greater detail later, hopefully your > > approach can be
	applied. Diff-analyzing is apparently tricky. > > Reading diff is tricky
	but I was lazy to match up the lines by > hand, which is also a real
	work ;-). [...] 
	Content analysis details:   (-4.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15935>

On Wed, Feb 08, 2006 at 01:45:11PM -0800, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> >> It's been a while since I looked at it the last time so it may
> >> not even work with the current git, but here it is..
> >
> > I'll take a look through this in greater detail later, hopefully your
> > approach can be applied.  Diff-analyzing is apparently tricky.
> 
> Reading diff is tricky but I was lazy to match up the lines by
> hand, which is also a real work ;-).

Reading a diff is tricky, yes, but if you're willing to just throw RAM
at the problem, it might not be quite as bad as I was trying at first.

My current thought on how to get it more correct is this:
	foreach $rev (@revqueue) {
		foreach $parent (@{$revs{$rev}{parents}}) {
			my @templines = @{$revs{$rev}{lines}};

			$revs{$parent}{lines} = apply_diff(\@templlines);
		}
	}

The @lines arrays that get built will be entirely made up of hash or
array references, so they just get reused for each successive file.

When apply_diff() deletes a line from the new copy, it should mark that
line as "claimed" by the current rev.

I'm thinking that each element of @lines will look like this:
	{
		text => $text,
		in_original => [0 | 1],
		claimed_by => $rev,
	}
at least to start.

This method can sanity check itself by calling git cat-file and actually
reading in each version of the file, and comparing it against the
generated copy, aborting if we get the two out of sync.

I'll see about implementing something along these lines this weekend,
time permitting.

-- 

Ryan Anderson
  sometimes Pug Majere
