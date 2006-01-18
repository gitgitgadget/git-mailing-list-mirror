From: Junio C Hamano <junkio@cox.net>
Subject: Re: [QUESTION] What is a tag for?
Date: Tue, 17 Jan 2006 17:41:27 -0800
Message-ID: <7v1wz648jc.fsf@assigned-by-dhcp.cox.net>
References: <1137538344.9104.34.camel@malory>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 02:41:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ez2KW-0006O5-EB
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 02:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWARBlc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 20:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWARBlc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 20:41:32 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:8923 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751207AbWARBlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 20:41:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118014016.WDDF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 20:40:16 -0500
To: Alex Bennee <kernel-hacker@bennee.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14807>

Alex Bennee <kernel-hacker@bennee.com> writes:

> ... I'm not brave enough to sit on the very bleeding edge and
> build what ever happens to be at the "HEAD" of the tree. However when a
> kernel releases I'd like to build *that* kernel.

Then maybe its time to change your e-mail address from
kernel-hacker to kernel-builder? ;-) ;-) ;-)

> I keep thinking of tags like labels in the old convetional SCM case. Is
> this correct?

Correct.

Tags are just labels.  So you can think of them as a shorthand
that lets you easily communicate a set of selected well-known
versions with others (either people, or git tools).  Instead of
saying 2664b25051f7ab96b22b199aa2f..., you can say v2.6.16-rc1.

All of the things I demonstrate below, you can substitute v2.6.X
with their commit object names and things work the same way.  It
is more convenient and human friendly to use tags.

Except one thing:  signed tags can be verified, if you have GPG
public key of the signer (in this case Linus), with "git
verify-tag".

<offtopic>
Does anybody know where to obtain the public key to verify
v2.6.16-rc1 tag?
</offtopic>

> So what do I do with them now? Are they only for branch points?

That is one of the things often done.  To build on top of
v2.6.16-rc1:

	$ git checkout -b myhack v2.6.16-rc1
	$ hack hack hack
        $ git commit -s -m 'Add support for frotz videocard.

	This adds frotz videocard support.  Blah Blah Blah...'

You could also use them to see what happened during a given
timeframe.  For example:

	$ git log v2.6.14..v2.6.15 | git shortlog

would list you all the changes between these two releases, for
example. 

If you know something used to work at a given version, say
v2.6.15, and now it does not work, you can use it as good/bad
input for the bisection bug hunting:

	$ git bisect good v2.6.15 && git bisect bad master

> Is the
> only way to know I'm building 2.6.16-rc1 to branch from it as described
> in git-branch, even if I'm not planning on doing any development?

I do not quite understand.  Immediately after the above example
checkout, before or after doing the hackhack and commit, git
branch would probably say:

	$ git branch
          origin
	  master
        * myhack

Immediately after the example checkout, "git describe myhack"
would answer v2.6.16-rc1.  OTOH, after the hackhack and commit,
it would answer v2.6.16-rc1-gXXXXXXXX where XXXX part is an
abbreviated commit object name of the commit you have at the tip
of myhack branch.

To see what you did in the branch, the tag, if you remember
where you forked from, can be used this way: 

	$ git whatchanged -p v2.6.16-rc1..myhack

However, the above is equivalent to saying this:

	$ git whatchanged -p master..myhack

So in that sense tag is not that useful for the purpose of
getting list of commits (or, more precicely, naming a
development track).

It is useful to name a specific version:

	$ git diff v2.6.16-rc1 myhack

compares two versions; it is not equivalent to "git diff master myhack".

> Is this part of the concept that branches are cheap and you should feel
> free to create and throw them away at will?

That depends on what you exactly mean by "this", but all of the
above are quite cheap.  If the "myhack" practice turned out to
be useless, you can just:

	$ git checkout master
        $ git branch -D myhack

to come back to the tip of the mainline and delete your side branch.
