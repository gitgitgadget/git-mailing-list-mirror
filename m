From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2
Date: Sun, 07 May 2006 02:39:35 -0700
Message-ID: <7vy7xekwbs.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605041627310.6713@iabervon.org>
	<Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
	<7vhd43vgnm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
	<BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE>
	<Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
	<BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE>
	<Pine.LNX.4.64.0605061008340.16343@g5.osdl.org>
	<7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 11:39:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcfjn-0003sB-QG
	for gcvg-git@gmane.org; Sun, 07 May 2006 11:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWEGJjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 05:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWEGJjh
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 05:39:37 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41626 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932113AbWEGJjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 05:39:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060507093935.LEAZ19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 May 2006 05:39:35 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 6 May 2006 23:33:26 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19697>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It was done because the very syntax of the config suggests it be a 
> user-editable file. I do not want to mess with the comments more than 
> necessary.

I personally feel that is a lost cause _unless_ you come up with
a reasonable convention for where to put comments, stress that
rule to the user in the documentation, _and_ make repo-config to
follow that rule as well.

We _do_ want to treat config file as hand editable and cat
reviewable file, not an unreadable gunk like xml, so trying to
preserve user comments is important and I am not opposed to that
you did (at least some of) it.  But as the code currently
stands, what it does is at best half baked, at worst somewhat
confusing.

A demonstration.  What is wrong with this picture?

        $ cat .git/config
        [core]
                repositoryformatversion = 0
                ; are the mode bits trustworthy?
                filemode = true ; yes, on ext3 
                ; We want symlinked HEAD because we will bisect
                ; recent kernel history.
                prefersymlinkrefs = true
        $ git repo-config core.prefersymlinkrefs false
        $ git repo-config core.filemode false
        $ cat .git/config
        [core]
                repositoryformatversion = 0
                ; are the mode bits trustworthy?
                filemode = false
                ; We want symlinked HEAD because we will bisect
                ; recent kernel history.
                prefersymlinkrefs = false
	$ exit

The comment given to "filemode" is "reasonable" in that it
describes what the value that is set to the variable does, and
losing the original comment given to its "true" when we set it
to false is better than keeping it, so that part happens to be
doing the right thing -- only because I knew what repo-config
would do to the comments and arranged original comments in the
file that way.

But what about prefersymlinkrefs one?  When setting the variable
to such a non-standard value, it is unreasonable for people to
want to justify why with a comment like the above.  But after
resetting the value the comment becomes stale.

It gets worse:

        $ git repo-config --unset core.filemode
        $ cat .git/config
        [core]
                repositoryformatversion = 0
                ; please please use symlinks please
                prefersymlinkrefs = false
                ; are the mode bits trustworthy?
	$ exit

There now is a confusing trailing comment left that does not
comment anything.  Removing core.filemode is not so common, but
this can happen whenever you remove any variable, so we can use
any other variable as an example.

Now, enough being negative and pointing out problems.  Time to
become constructive.  Probably a reasonable convention would be
to define the config file format to be something like this:

        <comment that applies to the section>
        [section]
                <comment that applies to the variable stands on
		 its own before the variable>
                variable [= value] <comment that applies to the
        			    fact the variable is set to
                                    this particular value starts
				    on the same line as the
                                    "variable = value" thing>

 - when a variable is reset to another value, remove the
   "value comment";
 - when a variable disappears, remove "variable comment";
 - when a section disappears, remove "section comment";
 - otherwise leave the comment intact.

Then we could tell the user the rule is like above, and tell
them to structure the file with comments that way, if they ever
want to edit the file by hand.

Now if we wanted to do something like the above, I suspect that
it would be easier and less error prone to first scan the config
file, note what appears where, and do the processing in-core,
and then write the results out, perhaps using data structures
like these:

        struct config_section {
            char *pre_comment;
            char *name; /* e.g. "core" */
            struct config_section *next; /* next section */
            struct config_var *vars; /* pointer to the first one */
        };
        struct config_var {
            char *pre_comment;
            char *name;
            char *value; /* "existence" bool may have NULL,
                          * otherwise probably a string "= value"
                          */
            char *value_comment;
            struct config_var *next; /* pointer to the next one
                                      * in the section
                                      */
        };

Obviously, data structures like these would make it even easier
if we decide we do _not_ care about comments (we would just lose
x_comment fields, parse the thing and write the resulting list
out).
