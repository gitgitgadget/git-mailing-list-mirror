From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Comments pack protocol description in "Git Community Book"
	(second round)
Date: Sun, 7 Jun 2009 13:06:17 -0700
Message-ID: <20090607200617.GA16497@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com> <200906062338.02451.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 22:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDOdO-00083z-3s
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbZFGUGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbZFGUGQ
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:06:16 -0400
Received: from george.spearce.org ([209.20.77.23]:46284 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbZFGUGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:06:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BF11F381FD; Sun,  7 Jun 2009 20:06:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906062338.02451.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120993>

Jakub Narebski <jnareb@gmail.com> wrote:
> There are beginnings of description of git pack protocol in section
> "Transfer Protocols"[1][2] of chapter "7. Internals and Plumbing"
> of "Git Community Book" (http://book.git-scm.com).

I'm going to try to clip unrelevant context... but I apologize if
I still quoted too much, there's a lot of text here.

> > ### Fetching Data with Upload Pack ###
...
> Although fetching via SSH protocol is, I guess, much more rare than
> fetching via anonymous unauthenticated git:// protocol,

Actually, fetching via SSH might be quite common, think about all of
those companies using Git internally... they are running something
like Gitosis or Gerrit Code Review, both of which support SSH only
access to the hosted repositories.

> it _might_ be
> good idea to tell there that fetching via SSH differs from above
> sequence that instead of opening TCP connection to port 9418 and
> sending above packet, and later reading from and writing to socket,
> "git clone ssh://myserver.com/srv/git/project.git" calls
> 
> 	ssh myserver.com git-upload-pack /srv/git/project.git
> 
> and later reads from standard output of the above command, and writes
> to standard input of above command.

Yes, this should be mentioned.  We actually should document in
the protocol specifiction how we fork SSH, and what the SSH server
should then be presenting as the command line.

I've run into problems with hosting sites like GitHub and Gitoriuous
not correctly honoring some ssh invokes, because they use the forced
command execution model and were handling only one case that could
be presented to them.

> The rest of exchange is _identical_ for git:// and for ssh:// (and
> I guess also for file:// pseudoprotocol).

Yes, the file:// pseduoprotocol works by forking a child to run the
`git-upload-pack /srv/git/project.git` executable and runs a pair
of pipes between them, just like ssh:// does when it spawns off
the ssh client process.

 
> I think it would be better to describe packet (chunk) format, called
> pkt-line in git, separately from describing the contents of above
> packet; either first pkt-line then command, or first command then
> pkt-line.

pkt-line is a basic building block, describe it early, before we
describe anything else.

> Footnote: this format somewhat reminds / resembles 'chunked' transfer
> encoding used in HTTP[1], although there are differences.
>   http://en.wikipedia.org/wiki/Chunked_transfer_encoding

This is not worth mentioning.  pkt-line is different enough that
it may just confuse the reader.
 
> Below there is (for completeness) list of git-upload-pack
> capabilities, with short description of each:
> 
>  * multi_ack (for historical reasons not multi-ack)
...
>    See the thread for more details (posts by Shawn O. Pearce and by
>    Junio C Hamano).

This really needs a diagram example, like the one I drew, to
explain the concept.  Its really hard to grasp from just reading
that paragraph what that implies, especially if you are implementing
a client or a server.

 
>  * no-progress
> 
>    Client should use it if it was started with "git clone -q" or
>    something, and doesn't want that side brand 2.  We still want

typo, should be "... side band 2." :-)

>    sideband 1 with actual data (packfile), and sideband 3 with error
>    messages.

Also, this capability really only makes sense if side-band or
side-band-64k was requested.  IOW, a sane client wouldn't ask
for this if it doesn't support side-band.

-- 
Shawn.
