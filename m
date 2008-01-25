From: Jeff King <peff@peff.net>
Subject: Re: On pathnames
Date: Fri, 25 Jan 2008 00:59:10 -0500
Message-ID: <20080125055910.GB21973@coredump.intra.peff.net>
References: <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org> <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org> <20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu> <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org> <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org> <alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org> <7vprvr7x8h.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801242227250.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>, Theodore Tso <tytso@MIT.EDU>,
	Mike Hommey <mh@glandium.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 07:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIHbZ-0005wa-0M
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 06:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757748AbYAYF7Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 00:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757381AbYAYF7Q
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 00:59:16 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3995 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757332AbYAYF7N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 00:59:13 -0500
Received: (qmail 18388 invoked by uid 111); 25 Jan 2008 05:59:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 25 Jan 2008 00:59:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Jan 2008 00:59:10 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0801242227250.13593@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71681>

On Thu, Jan 24, 2008 at 11:00:44PM -0500, Daniel Barkalow wrote:

> I think it would be nicer to have:
>=20
> $ git checkout branch
> Warning: xt_CONNMARK.c conflicts with xt_connmark.c; not checking it =
out
> $ git checkout xt_CONNMARK.c --as xt_CONNMARK_caps.c
> $ edit xt_CONNMARK_caps.c
> $ git add xt_CONNMARK_caps.c
>=20
> Where the index, when support for filesystems with filename restricti=
ons=20
> is enabled, keeps track both of the name of the file in the project a=
nd=20
> the name of the file in the filesystem, with this mapping determined=20
> entirely by the user asking for problem files to be present under=20
> different names in the working tree.

Hrm. That makes me think: what if rather than doing utf8-ish
comparisons, the index stores a bidirectional mapping for any "munged"
names, and you can manipulate that mapping?

As in, the index entry for M=E4rchen has an extra entry saying "I am
actually on the filesystem as Ma"rchen" (let's call this an alias) and
there is a pseudo-entry in the index for Ma"rchen that says "I'm not
really here. See M=E4rchen" (let's call this a backref).

Then index-modifying commands like "git-add" or "git-checkout" can set
up the mapping, either manually (using --as or similar) or using a
particular munging scheme (git config core.filemunge hfs). Any time we
give an index path to the filesystem, we use its alias name. Any time w=
e
look up an index entry and it ends up being a backref, we dereference
until we get a real entry. Index iterators would need to skip backrefs.

I think all systems would follow the same codepath, there is no penalty
for filenames which don't use the mapping, and it would be testable on
non-challenged filesystems. But perhaps I am missing some obvious
deficiency or impossibility.

-Peff
