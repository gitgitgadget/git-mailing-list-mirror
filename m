From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling peer's branch and getting tracking branch created
Date: Mon, 26 Feb 2007 17:13:27 -0800
Message-ID: <7vy7mkjtc8.fsf@assigned-by-dhcp.cox.net>
References: <17891.32095.655545.637691@lisa.zopyra.com>
	<7v7iu4l8k0.fsf@assigned-by-dhcp.cox.net>
	<17891.33854.166609.651544@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 02:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLquK-0001M0-8Y
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 02:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbXB0BN3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 20:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXB0BN3
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 20:13:29 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:37459 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbXB0BN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 20:13:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227011328.LHNQ2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 26 Feb 2007 20:13:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id URDU1W0021kojtg0000000; Mon, 26 Feb 2007 20:13:28 -0500
In-Reply-To: <17891.33854.166609.651544@lisa.zopyra.com> (Bill Lear's message
	of "Mon, 26 Feb 2007 19:07:10 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40686>

Bill Lear <rael@zopyra.com> writes:

> On Monday, February 26, 2007 at 16:59:27 (-0800) Junio C Hamano writes:
>>Bill Lear <rael@zopyra.com> writes:
>>
>>> I can't seem to figure out the correct magic to get my buddy's branch,
>>> and create the appropriate tracking branch at the same time without
>>> doing a clone.
>>
>>I'll cheat and ask "git show b6f5da1e" ;-).
>>
>>	$ git remote add -f -m master bob ../bob.git/
>
> Sorry, should have asked: what doe "-f -m master" mean?  I looked in
> the man page, but didn't see anything on this.

I should be the one who's saying sorry.  I realized it was not
documented and updated the doc last night.  Here is an excerpt:

    'add'::

    Adds a remote named <name> for the repository at
    <url>.  The command `git fetch <name>` can then be used to create and
    update remote-tracking branches <name>/<branch>.

    With `-f` option, `git fetch <name>` is run immediately after
    the remote information is set up.

    With `-t <branch>` option, instead of the default glob
    refspec for the remote to track all branches under
    `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
    is created.  You can give more than one `-t <branch>` to track
    multiple branche without grabbing all branches.

    With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
    up to point at remote's `<master>` branch instead of whatever
    branch the `HEAD` at the remote repository actually points at.

But I realize that the commit log message of b6f5da should
probably be massaged into the EXAMPLES section.


commit b6f5da1e0f4eeb59798b320f97d27f83d19f89df
Author: Junio C Hamano <junkio@cox.net>
Date:   Thu Feb 1 23:30:03 2007 -0800

    Teach git-remote add to fetch and track
    
    This adds three options to 'git-remote add'.
    
     * -f (or --fetch) option tells it to also run the initial "git
        fetch" using the newly created remote shorthand.
    
     * -t (or --track) option tells it not to use the default
        wildcard to track all branches.
    
     * -m (or --master) option tells it to make the
        remote/$name/HEAD point at a remote tracking branch other
        than master.
    
    For example, with this I can say:
    
      $ git remote add -f -t master -t quick-start -m master \
        jbf-um git://linux-nfs.org/~bfields/git.git/
    
    to
    
     (1) create remote.jbf-um.url;
    
     (2) track master and quick-start branches (and no other); the
         two -t options create these two lines:
    
           fetch = +refs/heads/master:refs/remotes/jbf-um/master
           fetch = +refs/heads/quick-start:refs/remotes/jbf-um/quick-start
    
     (3) set up remotes/jbf-um/HEAD to point at jbf-um/master so
         that later I can say "git log jbf-um"
    
    Or I could do
    
      $ git remote add -t 'ap/*' andy /home/andy/git.git
    
    to make Andy's topic branches kept track of under refs/remotes/andy/ap/.
    
    Other possible improvements I considered but haven't implemented
    (hint, hint) are:
    
     * reject wildcard letters other than a trailing '*' to the -t
       parameter;
    
     * make -m optional and when the first -t parameter does not
       have the trailing '*' default to that value (so the above
       example does not need to say "-m master");
    
     * if -m is not given, and -t parameter ends with '*' (i.e. the
       above defaulting did not tell us where to point HEAD at), and
       if we did the fetch with -f, check if 'master' was fetched
       and make HEAD point at it.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>
