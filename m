From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 09 Jan 2006 12:06:50 -0800
Message-ID: <7vu0cdjhd1.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 21:07:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew3I9-0000yM-SZ
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 21:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWAIUG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 15:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWAIUGz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 15:06:55 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17620 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751283AbWAIUGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 15:06:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060109200656.KGOB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 15:06:56 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 9 Jan 2006 08:47:39 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14375>

Linus Torvalds <torvalds@osdl.org> writes:

> One thing we could do is to make it easier to apply a patch to a 
> _non_current_ branch.
>...
> And one way to do that might be to teach "git-apply" to apply patches to a 
> non-active branch,...
>
> 	git diff | git-apply -b development
>
> or something similar..)
>
> Then you could always do "git pull . development" to pull in the 
> development stuff into your working branch - keeping the development 
> branch clean all the time.

I had to do something like that last night, when I hacked on
gitweb.  gitweb as shipped does not work for anybody but kay
(e.g. it has /home/kay hardcoded in it).  So I did:

	$ git clone git://git.kernel.org/pub/scm/git/gitweb gitweb
        $ cd gitweb
        $ git checkout -b custom
        $ edit gitweb.cgi ;# adjust /home/kay -> somewhere else etc.
        $ git commit -a -m "customization for junio's home"

Then I started preparing a proposed fix for Kay:

	$ git checkout -b symref master
        $ edit gitweb.cgi
        $ git commit -a -s -m "make it work on symref repository"

Now the thing is that I cannot test symref branch as is.  I
deliberately omitted the change necessary to make the upstream
work on my local machine from that branch, because I want to
keep my home-machine customization separate from what I will
eventually feed Kay.  So I do a throwaway test branch:

	$ git checkout -b test master
        $ git pull . custom symref ;# an octopus ;-)
        # I could have done two separate pulls, custom then symref.

The interesting part starts here.  Inevitably, I find bugs and
bugs and bugs in the test branch, and I fix them in the working
tree, without committing.  Eventually things starts working.
I did not commit here in the test branch, because the symref
branch is where I intend to keep this set of changes.  So
instead, I did this:

	$ git diff HEAD >P.diff
        $ git checkout -f symref
        $ git reset --soft HEAD^
        $ git apply P.diff
        $ git commit -a -C ORIG_HEAD

Usually I strongly discourage people to use "checkout -f"
because it will leave files that are in the current branch but
not in the new branch behind in the working tree.  Here I used
"checkout -f symref" because I knew this is a one-file project.

Instead of fixing the symref commit in place like this, I could
have committed P.diff as a separate "fixup" commit on top of the
symref branch, in which case the above sequence would have been:

	$ git diff HEAD >P.diff
        $ git checkout -f symref
        $ git apply P.diff
        $ git commit -a -m 'fixup bugs in the previous.'

but I did not --- it would have been more disgusting than
honest.

And after that, the usual format-patch:

	$ git format-patch origin..symref

In either case, this *was* cumbersome.  And I did it twice for
two independent topics.  Admittedly, these topic branches were
both single-commit topics, and in real life your subsystem
maintainers must be facing bigger mess than this toy experience
of mine, but the principle is the same.

I think there are a couple of ways to improve what I had to do.
I'll think aloud here.  The fictitious transcripts all start
after I got things working in the test branch working tree, with
a clean index file (i.e. changes are in the working tree only).

1. Make a commit in the "test" branch, and then cherry-pick the
   commit back to the topic branch:

	$ git commit -a -m "Fix symref fix"
        $ git checkout symref
        $ git cherry-pick -r test

2. Fix "git checkout <branch>" so that it does a reasonable thing
   even when a dirty path is different in current HEAD and
   destination branch.  Then I could:

	$ git checkout symref ;# this would not work in the current git
	    # it would die like this:
            # $ git checkout symref
            # fatal: Entry 'gitweb.cgi' not uptodate. Cannot merge.
	$ git diff ;# just to make sure inevitable automated merge
		    # did the right thing
        $ git commit -a -m "Fix symref fix"
	    # I could collapse them into one instead, like this:
	    # $ git reset --soft HEAD^
	    # $ git commit -a -C ORIG_HEAD

To retest (possibly with latest from Kay), we can rebuild the
test branch from scratch since it is by definition a throwaway
branch and never is exposed to public:

        $ git fetch origin
	$ git checkout test
        $ git reset --head origin
        $ git pull . custom symref

Obviously I prefer to have #2 work well, but #1 would work today.

I am not sure if making "git-apply" to take different branch is
a sane approach.  It might make sense to teach git-applymbox and
git-am about branches, though.  So is teaching git-merge about
merging into different branch.
