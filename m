From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Mon, 04 Sep 2006 13:09:01 -0700
Message-ID: <7vy7szmm1u.fsf@assigned-by-dhcp.cox.net>
References: <44F977C0.4060901@lsrfire.ath.cx>
	<44F982BD.1050509@lsrfire.ath.cx>
	<cda58cb80609021313p5156a14du4895e53387dd24dc@mail.gmail.com>
	<44FC6EDE.4010300@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 04 22:09:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKKkj-0000iu-F1
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 22:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWIDUIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 16:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWIDUIq
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 16:08:46 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:20129 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964982AbWIDUIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 16:08:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904200844.CCYM12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 16:08:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JL8b1V00L1kojtg0000000
	Mon, 04 Sep 2006 16:08:38 -0400
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44FC6EDE.4010300@lsrfire.ath.cx> (Rene Scharfe's message of
	"Mon, 04 Sep 2006 20:22:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26432>

Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Franck Bui-Huu schrieb:
>>
>> Well I don't see why putting the remote operations in an other file. I
>> was more thinking on something like this:
>> 
>> git-archive --format=<fmt> [--remote=<repo>] <tree-ish> [path...]
>
> My intention was to put both halves of the wire protocol implementation
> into the same source file.  I still think this is a good idea, but of
> course it's independent from any command line interface considerations.

I think so too, and agree with your reasoning. 

> No, git-upload-archive would accept only a single parameter: the path to
> the repository.  It'd receive all other options via the wire protocol,
> just like git-upload-tar.

Same here.

> We could remove the existing commands git-upload-tar and git-zip-tree
> right now, as they were never part of a release, yet.  git-upload-zip
> doesn't exist, yet, and git-tar-tree would probably survive as legacy
> interface, calling git-archive-tree internals.  Junio, am I correct
> regarding the cool-blooded killing of unreleased commands?
>>> git-tar-tree is now called by git-upload-tar.

I do think leaving tar-tree vs upload-tar protocol alone would
not hurt development of this new archive vs upload-archive
protocol.  Also 'git-tar-tree --remote' has been part of git for
some time now (1.4.2 has it).  Having said that, I suspect
nobody really relies on that, and I think this restructuring is
a good change.  Time to poll the userbase?

	Do people get upset if we said "git-tar-tree
	--remote=xyzzy.example.com" is no more, and you will
	have to say "git-fetch-archive -f tar xyzzy.example.com"?

>>> Does it make sense to change the wire protocol to simply send the
>>> command line options one by one?
>> 
>> That would make sense if the number of options grow up.

... or different archive backends want different kind of things
(tar-tree without compression would not want -z6 but zip-tree
would).

>> But if we allow
>> pathspec for remote operations, then  we need to send them to the
>> uploader.

Yup.

> If we simply send each option to the downloader without understanding
> them then the uploader can be kept really simple.  The protocol can be
> kept simple, and it would be future-proof: we will never have to update
> it.  I'm a bit worried about the security implications of such a setup,
> strangely _because_ I can't see a way to exploit it right now (and
> because it allows arbitrary input, which we must be able to cope with
> anyway).

>>>
>>> The interface could be something like this:
>>>
>>>    git-download-archive <repo> <git-archive-tree options...>
>>>    git-upload-archive <directory>
>>>
>> I think it is, IMHO. And that's why I think we could have only one
>> command for building localy/remotely archive whatever the format.
>> git-archive should be a main procelain command, and we should get rid
>> of git-{tar,zip}-tree commands.
>
> OK, makes sense; users will never need to call git-upload-archive
> directly, and having a single command for all archiving is a good thing.

So to recap:

 - "git-archive-tree --format <foo> <foo specific options> <tree>"
   would know how to create <foo> format archive and send the result
   to stdout.

 - "git-download-archive <repo> <git-archive-tree-command-line>"
   would talk with "git-upload-archive" in the remote repository,
   give archive-tree command line to it and receives the result.

 - "git-upload-archive <repo>" is not used by the end user.
   Underlying git-archive-tree command line options are sent
   over the protocol from download-archive, just like upload-tar
   does.

If this is what you mean, I think three of us are in agreement
here.

> My next steps will be to make traverse_tree() support path specs, in
> order to achieve feature parity with read_tree_recursive().  I hope that
> the former keeps being significantly faster than the latter even after
> that.

A thing that have been bothering me for some time in pathspec
area is that we have two (eh perhaps three) quite different
pathspec semantics.

 - diff-tree family (and anything based on revision.c including
   git-log) is a strict prefix directory match (e.g. no
   wildcards, and "Documentation/howto" matches the directory
   but not "Documentation/howto-index.sh")

 - ls-files family (ls-files used to be an one odd man out, but
   git-grep mimics it, and "git-commit <paths>" uses ls-files
   internally so they form a family) is prefix match with
   fnmatch match upon wildcard (e.g. "Documentation/howto" still
   matches the directory but not "Documentation/howto-index.sh",
   but you can say "Documentation/howto*" to match both, and you
   can even say "Document*").

The former semantics is very friendly with "struct tree_desc"
based traversal.  Allowing pathspecs with ls-files style
matching would probably more useful but more work.  And there
are at least four implementations of pathspec matcher with
slightly different interfaces (ugh, sorry) if I am not mistaken:
builtin-ls-files.c has one (match), tree-diff.c has another
(interesting), builtin-grep.c has one (pathspec_matches), dir.c
has another (match_pathspec).

We might be able to share code with para-walk.c in "pu" (it is
designed to walk zero or more trees optionally with index and
working tree in parallel and we would be using it to walk only
single tree without index nor working tree).  That would give me
an incentive to clean up the code ;-) Currently it is a ten
"WIP" patch series.

One thing it attempts to do on the side is to consolidate the
diff-tree style ones into one by introducing another in
read-cache.c (pathname_included) but it does not convert
existing users of other matchers to use it yet.
