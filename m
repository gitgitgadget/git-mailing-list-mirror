From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git and securing a repository
Date: Wed, 2 Jan 2008 22:58:38 -0500
Message-ID: <20080103035838.GA24004@spearce.org>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com> <477B6199.6070601@advancedsl.com.ar> <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com> <477B69ED.3090107@advancedsl.com.ar> <m3ir2co5s4.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gonzalo =?utf-8?Q?Garramu=C3=B1o?= <ggarra@advancedsl.com.ar>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 04:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAHEd-00043N-31
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 04:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbYACD6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 22:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbYACD6o
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 22:58:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38642 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbYACD6n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 22:58:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JAHDw-0005lw-IM; Wed, 02 Jan 2008 22:58:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B4F7120FBAE; Wed,  2 Jan 2008 22:58:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <m3ir2co5s4.fsf@roke.D-201>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69506>

Jakub Narebski <jnareb@gmail.com> wrote:
> Gonzalo Garramu=C3=B1o <ggarra@advancedsl.com.ar> writes:
> > David Symonds wrote:
> >>
> >> You can do arbitrarily-fine-grained authentication via the
> >> pre-receive hook.
> >=20
> > Can you provide some more info?  Looking at the kernel.org git docs=
,
> > the pre-receive hook seems very limited as no parameters are allowe=
d.
> > So I'm not sure how an authentication system could be created.

If you read the documentation carefully you will note that the
pre-receive hook receives input on stdin; 1 line of data per ref
that is being pushed with the old/new SHA-1 values and the ref
name.  The hook exits 0 to allow all changes to take place and
can exit > 0 to abort and disallow all updates.

This is a "batch" form of the update hook.

> > It also seems to be a push hook only (not invoked on pulls).
>=20
> Some of read-only (fetch only) access protocols do not support
> authentication: http, ftp, rsync, git. Authentication is provided onl=
y
> for access via ssh and for push via https (WebDAV).

Authentication could be supported for http, ftp, or ssh based fetch,
but there you are relying on the server that provides access to do
the authentication and authorization for you; typically that will
boil down to UNIX filesystem read permission.  Though with HTTP
and a fancy Apache config it doesn't have to be.
=20
> There is example update hook in contrib/hooks, named update-paranoid,
> which could be base of what you want. Note that you probably rather
> use newer pre-receive hook instead of older update hook.

update-paranoid uses the update hook rather than pre-receive to
allow it to allow/deny on a per-ref basis.  One of the flaws of
the pre-receive hook "API" is it is an all-or-nothing proposition.

So by using the "older" update hook update-paranoid can make its
decision on a per-ref basis and allow some refs to change in this
push but abort/deny others.  I find that useful but not everyone
might.
=20
> AFAIK both update and pre-receive hooks are invoked also on fetch...
> but I might be mistaken.

No, they are *not* invoked on fetch.  Currently no hooks execute
during fetch; either on the server *or* on the client side of
the connection.

--=20
Shawn.
