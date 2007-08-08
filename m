From: David Kastrup <dak@gnu.org>
Subject: Man-pages in user manual (was: [ANNOUNCE] GIT 1.5.3-rc4)
Date: Wed, 08 Aug 2007 10:11:22 +0200
Message-ID: <86wsw65tud.fsf@lola.quinscape.zz>
References: <85myx7dwb3.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708041156550.5037@woody.linux-foundation.org> <85bqdndqgr.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708042127160.5037@woody.linux-foundation.org> <85bqdmctcl.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708051004480.5037@woody.linux-foundation.org> <85bqdlj1lh.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708051221290.5037@woody.linux-foundation.org> <46B6446D.4030607@gnu.org> <857io9hblv.fsf@lola.goethe.zz> <20070805223105.GC12168@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 10:12:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIgeC-000722-Es
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 10:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbXHHIMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 04:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbXHHIL7
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 04:11:59 -0400
Received: from main.gmane.org ([80.91.229.2]:48768 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbXHHIL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 04:11:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IIgdr-0007dk-OB
	for git@vger.kernel.org; Wed, 08 Aug 2007 10:11:43 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 10:11:43 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 10:11:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:iGmKVArod/yzR0QivrJp13e4aXk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55304>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Mon, Aug 06, 2007 at 12:15:24AM +0200, David Kastrup wrote:
>> Or things like including the manual pages in an appendix or elsewhere.
>> Any chance for that?  Slim, at least for me.
>
> I'd like to do exactly that at some point.  I was hoping it would be as
> simple as just adding a bunch of include:: statements, but there's
> probably some more obstacles.  If someone had the time to look into what
> would be required to get it working, I'd be grateful.

Well, I posted already a patch set (or rather, several iterations)
that built info documentation from the user manual.  I only got a
single comment from Jakub about notices in INSTALL, and about the awk
dependency.  The last iteration from yesterday addressed both AFAICT.
Since it does not affect existing Makefile targets at all, I hope that
it may end up in 1.5.3.

However, independently from info, I think the git documentation should
be structured into one or more standalone documents that make sense as
a single DocBook document (and ultimately a printed PDF) each.  Of
course this will benefit generating info, but it will also give other
people better documentation into their hands.

I digress.

Concerning your request

> If someone had the time to look into what would be required to get
> it working, I'd be grateful.

I did some digging and some trying.  The inclusion of the manual pages
will not work out of the box: they have different markup and logical
sectioning levels.

However, AsciiDoc does provide mechanisms that could be used for
including this sort of stuff, by just matching the markup used in the
man page sources and replacing it with the appropriate headers or
markup for the DocBook case.

To figure this out, read up on the following parts:
<URL:http://www.methods.co.nz/asciidoc/userguide.html#toc67>
<URL:http://www.methods.co.nz/asciidoc/userguide.html#toc71>
<URL:http://www.methods.co.nz/asciidoc/userguide.html#toc75>

It turns out, however, that this may be doing it the hard way: There
is a way to have sections/appendices consisting of just manual pages:

<URL:http://www2.informatik.hu-berlin.de/~draheim/doc/docbook-manpages.html>

So it may be easiest to just create a <reference> section in the XML,
include the man pages in there, and see what the various DocBook
converters make of that.

Of course, in such a document one would want to change the gitlink
macros to actually point to the included reference rather than an
outside resource.

That would have to be done in Documentation/asciidoc.conf as far as I
can see.

There are already autogenerated files cmds*.txt that contain lists of
the various manpages.  One could either use them directly (with a
temporary gitlink definition that includes a manual page rather than
referring to it), or generate similar files with a more
straightforward relation of content and behavior.

-- 
David Kastrup
