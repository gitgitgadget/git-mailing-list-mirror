From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program" over SSH connection
Date: Wed, 25 Jun 2008 01:34:52 -0400
Message-ID: <20080625053452.GI11793@spearce.org>
References: <20080624233236.GI29404@genesis.frugalware.org> <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org> <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:36:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNfr-0005yU-4o
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYFYFfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbYFYFfL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:35:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50042 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbYFYFfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:35:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBNeg-0000lh-Cp; Wed, 25 Jun 2008 01:34:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0E01B20FBAE; Wed, 25 Jun 2008 01:34:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86233>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> >>> Any other suggestions that is workable?
> >>
> >> diff --git a/builtin-clone.c b/builtin-clone.c
> >> index 5c5acb4..98d0f0f 100644
> >> --- a/builtin-clone.c
> >> +++ b/builtin-clone.c
> >> @@ -37,7 +37,7 @@ static int option_quiet, option_no_checkout, option_bare;
> >
> > << a patch to conditionally change "git-program" default to "git program"
> > snipped >>

Shouldn't "git upload-pack" work on the server side as far back as
0.99.9k?  That's back really old.  And my patch fixed "git " to be
"git-" when talking to git-daemon, thus keeping clients compatible
with all current git:// servers.

For SSH servers that can't handle "git upload-pack" the user can
change it to --upload-pack=git-upload-pack and get back to the
old behavior, until the server operator can upgrade.

Your patch doesn't offer that work around on the client side.
 
> Typofix: s/cond/uncond/;
> 
> > How would that help client that talk with git-daemon, unlike what I sent
> > earlier?

Check my change in git_connect again:

diff --git a/connect.c b/connect.c
index e92af29..dbabd93 100644
--- a/connect.c
+++ b/connect.c
@@ -576,8 +576,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 * from extended components with a NUL byte.
 		 */
 		packet_write(fd[1],
-			     "%s %s%chost=%s%c",
-			     prog, path, 0,
+			     "git-%s %s%chost=%s%c",
+			     prog + 4, path, 0,
 			     target_host, 0);
 		free(target_host);
 		free(url);

Its buggy if the user tried to do "git ls-remote --upload-pack=crp git://"
but if this is the direction we want to go we can obviously work out a
better method of forcing "git " to be "git-" when talking to git-daemon.

> If we force --upload-pack workaround to _everybody_ we are already lost.
> 
> Also I think the previous one still lets you work it around by giving a
> full path, like "/usr/local/bin/git-upload-pack", because "/usr" does not
> match "git-" ;-)

Please tell me, where is git-upload-pack on repo.or.cz?

$ ssh repo.or.cz which git-upload-pack
fatal: unrecognized command 'which git-upload-pack'

I doubt I can pass it '/usr/local/bin/git-upload-pack' and get it
to work too.  So I don't think this is a good work around.

Obviously pasky will fix repo.or.cz to accept both at some point
in the near future, likely before 1.6.0 releases, because he's cool
like that.  Not everyone is.

Please don't make 1.6.0 unavailable to end-users because their
server operator can't currently accept "git upload-pack" without
giving them a workaround to force "git-upload-pack" over SSH.

-- 
Shawn.
