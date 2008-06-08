From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH] Use SUDO_UID to guess committer identity
Date: Sat, 7 Jun 2008 20:23:43 -0400
Message-ID: <20080608002343.GG12896@spearce.org>
References: <20080607071130.GZ12896@spearce.org> <7v63slnegm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 02:25:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K58ia-0005kl-Gf
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbYFHAXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755008AbYFHAXs
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:23:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50961 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736AbYFHAXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:23:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K58h4-0003Ut-RG; Sat, 07 Jun 2008 20:23:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 10DE920FBAE; Sat,  7 Jun 2008 20:23:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v63slnegm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84234>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > When invoking Git commands though sudo against a bare repository
> > with reflogs enabled we should attempt to record the actual user's
> > information in the reflog, not the identity of the user sudo entered.
> >
> > For example when executing:
> >
> > 	sudo -u gitadm git --git-dir=/srv/git.git branch -f pu master
> >
> > We want record information about the caller of sudo, not gitadm.
> 
> If you are using something esoteric like pseudo, isn't it too much to ask
> to also use existing GIT_COMMITTER_NAME, or are there reasons why it is
> not sufficient?

The issue is when users run commands though sudo, but forget to set a
value for GIT_COMMITTER_NAME/EMAIL, or to configure ~/.gitconfig in
their personal account.  Now git has to guess the values for these
based on the gecos of getuid(), and getuid() is returning the uid
of the service account sudo entered (gitadm), not the real user's
account.  So the reflogs show generic "GIT Admin" and not who it was.

Eh, I'm myself not entirely happy with the patch.  It honors the
real user's $HOME/.gitconfig user.name/email settings and not the
SUDO_UID data.  I'd almost prefer favoring SUDO_UID over whatever
we inherit in from the enviroment or from $HOME/.gitconfig when it
comes to committer identity.

-- 
Shawn.
