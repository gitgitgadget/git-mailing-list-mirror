From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v3 0/6] N-th last checked out branch
Date: Sat, 17 Jan 2009 04:30:05 +0100
Message-ID: <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1uL-0006DJ-8J
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177AbZAQDaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 22:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753991AbZAQDaL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 22:30:11 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31190 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753773AbZAQDaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 22:30:09 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:06 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2009 03:30:07.0024 (UTC) FILETIME=[E4A27300:01C97853]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106017>

Junio C Hamano <gitster@pobox.com> writes:
> "cd -" is a very good analogy why your "-" shortcut is a short-sighted
> convenience feature that is too narrow and not well designed.  "cd -" can
> go back, but you cannot say "ls -" to list the contents of the previous
> directory.

True.

> Another reason is the one level limitation.

It shares that limitation with my mind ;-)

But well, since you all seem to want a more general solution, here's a
draft.

I started poking around in refs.c for the backwards search, but the
two reflog functions had a lot of functionality implemented very
differently.  So 1-4 are just cleanup and adding that backwards
iterator.  Note that 3/6 changes for_each_reflog_ent() to die() when
it finds a format error, unlike the previous behaviour.  No tests
seemed to care, but maybe someone out there relies on having broken
reflogs? ;-)

>  * The code read the reflog twice, first to count how many branch
>    switching there are and then to locate the N-th entry we are interested
>    in, because I was lazy.  We may want an API to enumerate reflog entries
>    in reverse.

So this might be settled.

>  * The reflog parser only parses "checkout" and not rebase action.  It
>    also does not notice "git checkout HEAD^" is not switching to a real
>    branch.

I don't handle this, but I'm not sure how much of a problem it is.  It
can correctly detach and re-attach even in cases such as HEAD^.

Ok, now that you mention it, it will probably put you on the parent of
whatever you happened to be on, instead of the earlier value of HEAD^.

>      $ git checkout @{-1}

One problem with the syntax is that the assumption that there can only
be a single @{} construct is quite entrenched in sha1_name.c.  So if
we want to support @{-1}@{1}, that'll need some extra work.

@{-1}~2 and similar work fine though.


Other things of note:

I changed the semantics to really only look at checkouts that "did
something".  If you keep saying 'git checkout master' over and over,
those will not count towards the N.

I changed the parser to read the 'checkout: moving from $old' instead
of the 'to $new'.  The above semantics introduced too many extra
conditions for my taste if we wanted to support the pre-1.5.3 reflog
comment format.  (You'd have to check if the $to was changed from the
last [newer] entry, but then there's another border case when you do
'git init; git checkout -b side; git checkout -' because you never
moved to master.)

The @{date} syntax will be marginally slower after the refactoring
because the old parser carefully avoided parsing numbers where it
could.  (I guess it could actually be done as a bisection for an extra
order of magnitude.)

It's far too early here to be sending mail.

Interactive rebase needs a "move hunk" feature.


Thomas Rast (6):
  reflog: refactor parsing and checking
  reflog: refactor log open+mmap
  reflog: make for_each_reflog_ent use mmap
  reflog: add backwards iterator
  sha1_name: implement @{-N} syntax for N-th last checked out
  checkout: implement '@{-N}' and '-' special abbreviations

 Documentation/git-checkout.txt  |    4 +
 Documentation/git-rev-parse.txt |    3 +
 builtin-checkout.c              |   15 ++-
 cache.h                         |    1 +
 refs.c                          |  285 +++++++++++++++++++++++----------------
 refs.h                          |    1 +
 sha1_name.c                     |   79 +++++++++++-
 t/t1505-rev-parse-last.sh       |   71 ++++++++++
 t/t2012-checkout-last.sh        |   50 +++++++
 9 files changed, 387 insertions(+), 122 deletions(-)
 create mode 100755 t/t1505-rev-parse-last.sh
 create mode 100755 t/t2012-checkout-last.sh
