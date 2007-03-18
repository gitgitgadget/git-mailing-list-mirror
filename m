From: Petr Baudis <pasky@suse.cz>
Subject: Re: Libification project (SoC)
Date: Sun, 18 Mar 2007 15:08:16 +0100
Message-ID: <20070318140816.GG4489@pasky.or.cz>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org> <7vps79wueu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de> <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rocco Rutte <pdmef@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 18 15:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSw3d-0005KQ-2w
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 15:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbXCROIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 10:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbXCROIT
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 10:08:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40435 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbXCROIS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 10:08:18 -0400
Received: (qmail 23975 invoked by uid 2001); 18 Mar 2007 15:08:16 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42495>

On Fri, Mar 16, 2007 at 04:12:17PM CET, Johannes Schindelin wrote:
> Hi,
> 
> [please do not cull the Cc: list]
> 
> On Fri, 16 Mar 2007, Rocco Rutte wrote:
> 
> > First, I think that would be some cleanup "only" since that basically would
> > mean to
> > 
> >   1) make all functions die()ing return some value and handle it and
> >   2) wrap all static vars into structures and pass them around
> > 
> > If you don't choose a design before wrapping things up in structures, you'll
> > probably end up having one structure per source file (at least too many
> > structures).
> 
> Why? For some tasks, it should be 1) easier, 2) more elegant, and 3) 
> faster to write a function which re-initialises the static variables.
> 
> Of course, if you want to work with multiple repos _at the same time_, 
> this does not help you. But frankly, we don't support that with core-git, 
> so why should we in libgit?

Because you don't know who will want to use libgit. Maybe perl bindings
from inside of mod_perl, where single process can multiplex between many
repositories based on whichever request just arrived. You talked about
memory usage issues, but I think that's just a minor technical issue
that can be adjusted, while this is _conceptual_. Maybe someone will
want to write repodiff which looks at two repositories and compares them
(without fetching massive data around). Maybe someone will want to write
some other cool hack we didn't think about.

Because in the other subthread you just suggested the git viewers should
be multi-threaded. Of course you can state that "only a single thread
can use libgit at a time", but then multithreading is just a hack to
work around libgit limitations (albeit still legitimate) while it could
be used to do so much more cool stuff like fetching old history
information on background while you can already _work_ with the tool and
look at the new stuff details (isn't this actually exactly how gitk and
qgit already work? they couldn't with non-reentrant libgit!).

Because if you look at the UNIX history, you'll notice that first people
started with non-reentrant stuff because it was "good enough" and then
came back later and added reentrant versions anyway. Let's learn from
history. It's question of probability but it's very likely this will
happen to us as well.

This is why the _API_ should be designed to be re-entrant. The
implementation may not be re-entrant right away, it may take a while to
get there, but the API really should be.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
