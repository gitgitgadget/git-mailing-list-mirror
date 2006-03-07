From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone does not work with GIT_OBJECT_DIRECTORY set
Date: Mon, 06 Mar 2006 22:29:51 -0800
Message-ID: <7vu0aa4vj4.fsf@assigned-by-dhcp.cox.net>
References: <20060306012115.GG20768@kvack.org>
	<7vmzg4cq6y.fsf@assigned-by-dhcp.cox.net>
	<20060306013854.GH20768@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 07:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGVht-0003gq-Pb
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 07:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWCGG3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 01:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWCGG3z
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 01:29:55 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20971 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751383AbWCGG3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 01:29:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307062558.WWGB20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 01:25:58 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
In-Reply-To: <20060306013854.GH20768@kvack.org> (Benjamin LaHaise's message of
	"Sun, 5 Mar 2006 20:38:54 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17322>

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Sun, Mar 05, 2006 at 05:33:25PM -0800, Junio C Hamano wrote:
>> Please try it without GIT_OBJECT_DIRECTORY and see it works
>> correctly (I think it should).  If that is the case, maybe
>> git-clone should explicitly unset GIT_OBJECT_DIRECTORY.
>
> Nope.  There is no .git/objects directory, so how would it be able to 
> find the objects?

Ah, I misunderstood what you were trying to do here.  What you
meant with this is:

	$ git clone linux-2.6.git bootcache.git

* linux-2.6.git is a local directory with HEAD, refs/* and stuff
  but does not have objects/.

* bootcache.git is a local directory to be created anew.

Even though linux-2.6.git does not have objects subdirectory, it
is usually not a problem for you because you use GIT_OBJECT_DIRECTORY
for that.

Short answer for this is: sorry, "git clone" barebone Porcelain
does not support such a configuration if your source repository
is local.  It works for destination, though:

	$ export GIT_OBJECT_DIRECTORY=/tmp/foobla 
	$ git clone git://git.kernel.org/.../linux-2.6.git bootcache.git

You will get a single pack in /tmp/foobla/pack and would not
even have bootcache.git/.git/objects directory.

I should probably add that GIT_OBJECT_DIRECTORY environment
variable has outlived its usefulness.  Initially we added that
flexibility without really knowing where it would lead us, but
it has turned out that often we would want the refs and objects
go hand-in-hand.  Two or more repositories sharing the object
pool to save storage initially sounded a good idea, but that
would make fsck-objects cumbersome (you have to learn to ignore
dangling warnings, which makes checking rather pointless), and
packing less useful (you need to collect refs in all the
repositories that share the object pool).

I think the recommended way these days to set up multiple
repositories that work on related projects is to set up a single
clone from external source (e.g. linux-2.6.git), and make a set
of local "-l -s" clones out of it, and then fetch forked
upstreams into them.  It would go something like this:

(initial setup)
	$ git clone --bare git://git.kernel.org/.../torvalds/linux-2.6.git \
          linux-2.6.git

    (do this only once for each forked upstream)
        $ git clone -l -s -n linux-2.6.git netdev-2.6
	$ cd netdev-2.6
        $ ed .git/remotes/origin ;# adjust to jgarzik tree's location
        $ mkdir .git/refs/stashed
        $ mv .git/refs/heads .git/refs/tags .git/refs/stashed
        $ mkdir .git/refs/heads .git/refs/tags
	$ git fetch -k 
        $ cp .git/refs/heads/origin .git/refs/heads/master
        $ rm -fr .git/refs/stashed
        $ git checkout
        
(update the shared master tree from time to time)
	$ cd linux-2.6.git
        $ GIT_DIR=. git fetch-pack \
          git://git.kernel.org/.../torvalds/linux-2.6.git

(working in the individual forked tree is just as usual)
	$ cd netdev-2.6
        $ git fetch ;# or git pull

I think the part for each forked upstream above that consists of
10 or so commands above can be more or less automated.  The part
that needs human input is the adjusting of .git/remotes/origin,
which depends on where each forked upstream tree is and what
branches there are of interest.
