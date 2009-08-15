From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn bug report: %20 in http:// should translate to a space
 ' ' automatically
Date: Sat, 15 Aug 2009 20:16:37 +0200
Message-ID: <20090815181637.GC19833@atjola.homenet>
References: <4A86F4DA.5090605@smullindesign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Mike Smullin <mike@smullindesign.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 20:17:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McNov-0004x5-0B
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 20:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbZHOSQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Aug 2009 14:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbZHOSQk
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 14:16:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:46326 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750726AbZHOSQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 14:16:40 -0400
Received: (qmail invoked by alias); 15 Aug 2009 18:16:39 -0000
Received: from i59F57F2D.versanet.de (EHLO atjola.homenet) [89.245.127.45]
  by mail.gmx.net (mp066) with SMTP; 15 Aug 2009 20:16:39 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18W2mdYUiIWypPlpr4KnRRyCkIFqI2mT7wMN3VnDr
	pKGebdwPPhF3uD
Content-Disposition: inline
In-Reply-To: <4A86F4DA.5090605@smullindesign.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126015>

On 2009.08.15 11:48:10 -0600, Mike Smullin wrote:
> Hello,
>=20
> This one took me over an hour to figure out with the help of doener
> in #git on irc.freenode.net:

[IRC log omitted]

To wrap that up:

1) git svn clone http://host/repo/path%20with%20spaces/foo/bar/goo

Works, but see below.

2) git svn clone -Tgoo http://host/repo/path%20with%20spaces/foo/bar

=46ails.

3) git svn clone -Tgoo "http://host/repo/path with spaces/foo/bar"

Works.


In Mike's case, there was a rename from foo/goo to foo/bar/goo. 1) fail=
s
to follow that rename, 2) just completely fails and 3) works and follow=
s
the rename.

Cloning via http:// didn't provide any interesting error messages, but
cloning via svn+ssh:// showed:

=46or 1)
W: Ignoring error from SVN, path probably does not exist: (160013):
=46ilesystem has no item: File not found: revision 100, path
'/path with spaces/foo/bar"

=46or 2)
W: Ignoring error from SVN, path probably does not exist: (160013):
=46ilesystem has no item: File not found: revision 100, path
'/path%20with%20spaces/foo/bar"


So 2) somehow has the spaces escaped there, but 1) doesn't.

I guess that 1) has it right, and the rename detection just doesn't wor=
k
because the old name is outside of "url" for the svn-remote. And 2)
somehow gets it wrong, likely double-escaping the spaces or so. (I have
no idea...)

My totally uneducated guess is that git-svn fails to unescaped the path
when it splits it into the higher-level part for "url" and the rest of
it for "fetch".

HTH
Bj=F6rn
