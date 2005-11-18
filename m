From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Using sticky directories to control access to branches.
Date: Thu, 17 Nov 2005 23:55:32 -0800
Message-ID: <7vfypumlu3.fsf@assigned-by-dhcp.cox.net>
References: <20051117170129.GA14013@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 09:06:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed168-0006su-Mh
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 08:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVKRHzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKRHze
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 02:55:34 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50838 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030398AbVKRHze (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 02:55:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118075428.OXKZ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 02:54:28 -0500
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051117170129.GA14013@hpsvcnb.fc.hp.com> (Carl Baldwin's
	message of "Thu, 17 Nov 2005 10:01:29 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12211>

Carl Baldwin <cnb@fc.hp.com> writes:

> Now, git was probably designed to do this on purpose because it is the
> safest way to update a branch in an automic way.

Yes.  How about using hooks/update?  The documentation for
receive-pack suggests the use of it for generating commit
notification e-mails, but this is more general mechanism.

When your developer runs git-push into the repository,
git-receive-pack is run (either locally or over ssh) as that
developer, so is hooks/update script.  Quoting from the relevant
section of the documentation:

    Before each ref is updated, if $GIT_DIR/hooks/update file exists
    and executable, it is called with three parameters:

           $GIT_DIR/hooks/update refname sha1-old sha1-new

    The refname parameter is relative to $GIT_DIR; e.g. for the
    master head this is "refs/heads/master".  Two sha1 are the
    object names for the refname before and after the update.  Note
    that the hook is called before the refname is updated, so either
    sha1-old is 0{40} (meaning there is no such ref yet), or it
    should match what is recorded in refname.

So if your policy is (1) always require fast-forward push
(i.e. never allow "git-push repo +branch:branch"), (2) you
have a list of users allowed to update each branch, and (3) you
do not let tags to be overwritten, then:

	#!/bin/sh
	# This is a sample hooks/update script, written by JC
        # in his e-mail buffer, so naturally it is not tested
        # but hopefully would convey the idea.

	umask 002
        case "$1" in
        refs/tags/*)
		# No overwriting an existing tag
        	if test -f "$GIT_DIR/$1"
                then
                	exit 1
		fi
	refs/heads/*)
        	# No rebasing or rewinding
                if expr "$2" : '0*$' >/dev/null
                then
                	# creating a new branch
			;
		else
                	# updating -- make sure it is a fast forward
        		mb=`git-merge-base "$2" "$3"`
			case "$mb,$2" in
                        "$2,$mb")
                        	;; # fast forward -- happy
			*)
                        	exit 1 ;; # unhappy
			esac
		fi
	esac

	# Is he allowed to update it?
	me=`id -u -n` ;# e.g. "junio"
	while read head_pattern users
        do
		if expr "$1" : "$head_pattern" >/dev/null
		then
			case " $users " in
			*" $me "*)
                        	exit 0 ;; # happy
			'*')
                        	exit 0 ;; # anybody
			esac
		fi
	done
	exit 1

For the sake of simplicity, I assumed that you keep something
like this in $GIT_DIR/info/allowed-pushers file:

	refs/heads/master	junio
        refs/heads/cogito$	pasky
	refs/heads/bw/		linus
        refs/heads/tmp/		*
        refs/tags/v[0-9]*	junio

With , Linus can push or create "bw/penguin" or "bw/zebra" or
"bw/panda" branches, Pasky can do only "cogito", and I can do
master branch and make versioned tags.  And anybody can do
tmp/blah branches.  This assumes all the users are in a single
group that can write into $GIT_DIR/ and underneath.
