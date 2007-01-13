From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 17:19:36 +0100
Message-ID: <20070113161936.GB4825@xp.machine.xx>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com> <7virfct737.fsf@assigned-by-dhcp.cox.net> <slrneqfnb8.a6s.Peter.B.Baumann@xp.machine.xx> <7vejq0t4ij.fsf@assigned-by-dhcp.cox.net> <20070112210403.GB6262@xp.machine.xx> <7v7ivrpx9y.fsf@assigned-by-dhcp.cox.net> <20070113093322.GA4825@xp.machine.xx> <Pine.LNX.4.63.0701131204511.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 17:19:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5lam-00070E-Dp
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 17:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbXAMQSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 11:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbXAMQSo
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 11:18:44 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:43160 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422711AbXAMQSn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jan 2007 11:18:43 -0500
Received: (qmail 7531 invoked by uid 0); 13 Jan 2007 16:18:39 -0000
Received: from p54aaa36b.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.163.107)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 13 Jan 2007 16:18:39 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701131204511.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36755>

On Sat, Jan 13, 2007 at 12:17:18PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 13 Jan 2007, Peter Baumann wrote:
> 
> > On Fri, Jan 12, 2007 at 04:48:09PM -0800, Junio C Hamano wrote:
> > > Peter Baumann <waste.manager@gmx.de> writes:
> > > 
> > > > ? What does it mean to "add" something to a project? It has 
> > > > _nothing_ to do ? with "filenames". Yeah, the filename obviously 
> > > > exists, but it's not ? something that exists on its own. You add the 
> > > > ONLY thing that git tracks. ? ? You add CONTENT. ? ? When you do 
> > > > "git add file.c" you aren't adding a filename to the list of ? files 
> > > > that git knows about. Not even CLOSE. No. You are really adding ? 
> > > > _content_ to the project you are tracking.
> > > 
> > > Read this again, please.  Ponder it if you may.
> > > 
> > 
> > Yes. I am adding content. And not a file. But at least to me, it makes a
> > *BIG* difference if I'm adding totally new content (reserving one more
> > bucket where to place to content) or just replacing the content *in* one
> > of those already reserved buckets.
> 
> Bzzzzt! Nope. "Reserved buckets" as you use it is nothing else than a 
> file.
> 
> > And that has nothing to do with files (or at least the silly me can't 
> > grok it).
> 
> Content: a byte stream with a label (so you can find it again). Of 
> _course_ you don't want the byte stream vanish in a big black hole, so you 
> _have_ to name it.
> 
> But git-add actually does two things: it adds a (completely new) object, 
> which just holds the byte stream, being named by its content (the hash). 
> 
OK. Now we are talking clear. I don't like git-add to do two things (see
below)

> But when committing, the _existing_ tree object is "updated", by writing a 
> _new_ tree object. So, it is not an "updating" in the sense of "editing", 
> rather "updating" as in copy-on-write.
> 
> So no, there are no "reserved buckets". You are very much _adding_ 
> new information.
> 

I unterstand the concept of the index, I even glanced at the code. The
index holds for every file... err..  content a struct cache_entry (my
above mentioned "buckets"). If I add a new cache_entry, I enlarge my
later committed tree by at least one new file (adding a new file could
also add an entry for a directory in the final tree object).

I would much more like the idea of having one command (git-add) which
would enlarge the index by a new struct cache_entry and another which
replaces a previously added cache_entry. Because I'd like to control
how my final tree looks like and add least to me adding a file entry to
a tree is something different than updating a file entry (at least
mentally).

I'd favour the following model:

 git-add: register the content of a previously unkown file to git
    (there was now struct chache_entry in the index previously which
     described a file with the same name)

 git-rm: remove a struct cache_entry from the index and after some
    safty checks remove the file, too. (see in the mailinglist archive;
    there was much talk about git-rm and its semantic)

 git-refresh (or git-stage or git-update or what-ever you call it):
    replace the cache_entry by a new one

And this all about content; the content which would represent my next
tree object. Because developers don't think of "add" if they want to
remove a file from the commit. If the power users liked to have only one
command, wich does remove, add and update then lets not call it add.
Better make this commmand the above mentioned git-refresh which would do
"the right thing" if called with a new file/removed file

Im simply think its confusing to call the described command git-add, as
we have it now. It's at least *very* confusing for new starters.

-Peter

> Another way to look at it: in git, you never "take away" anything. You 
> only add things. Even if you remove a file from your working tree, and 
> want to commit the change, it means that you _add_ information: The 
> information that this file is no longer in the current revision. But the 
> commit references the old revision (indeed, the _whole_ ancestry!), in 
> which the file _was_ present, so you literally _added_ something _on top_ 
> of the old revision.
> 
> Hth,
> Dscho
> 
