From: Jeff King <peff@peff.net>
Subject: Re: creation of empty branches
Date: Thu, 15 Nov 2012 09:12:33 -0800
Message-ID: <20121115171230.GB18108@sigill.intra.peff.net>
References: <CAB9Jk9CaBECT7c_M9HvCbB8mFYGvdsmq_jFW4DF4NCO8Narnmw@mail.gmail.com>
 <CAH5451mkcszgJxziKn3q3OwSDM-qQ71PtT5+UWb=PG7VYAcFyQ@mail.gmail.com>
 <7vmwyjan96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:12:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ2zj-0003NY-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 18:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768493Ab2KORMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 12:12:38 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49585 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768440Ab2KORMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 12:12:37 -0500
Received: (qmail 18464 invoked by uid 107); 15 Nov 2012 17:13:26 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 12:13:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 09:12:33 -0800
Content-Disposition: inline
In-Reply-To: <7vmwyjan96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209832>

On Wed, Nov 14, 2012 at 01:27:33PM -0800, Junio C Hamano wrote:

> > Instead of
> >     fatal: Not a valid object name: 'master'.
> > perhaps
> >     fatal: Cannot create branch 'foo' from empty branch 'master'. To
> > rename 'master' use 'git branch -m master foo'.
> 
> The first new sentence is a definite improvement, but I do not think
> the advice in the second sentence is necessarily a good idea,
> because it is dubious that the user is likely to have wanted to
> rename 'master' to something else.  "git branch foo master" (or its
> moral equivalent "git checkout -b foo" while on master) is a wish to
> have a history that ends in 'foo' *forked* from history of 'master',
> but because you do not even have anything on 'master' yet, you
> cannot fork the history, as you explained earlier (snipped).  In
> that sense, 'empty branch' is a slight misnomer---as far as "git
> branch foo master" is concerned, the 'master' branch does not yet
> exist (and that is why we often call it an "unborn branch", not
> "empty").
> 
>     fatal: cannot fork master's history that does not exist yet.
> 
> would be more accurate description of the situation.

I agree with most of your reasoning. I think simply using Andrew's first
sentence is a little more clear to a new user, even though it may be
less technically precise, but I don't have a strong opinion.

That still leaves "checkout -b". I do not see it as a problem that "git
branch foo" does not work whereas "git checkout -b foo" does; we
special-case the latter because it can do something sensible, whereas
there is nothing sensible for "git branch foo" to do. However, I think
it is missing one piece:

-- >8 --
Subject: checkout: print a message when switching unborn branches

When we switch to a new branch using checkout, we usually output a
message indicating what happened. However, when we switch from an unborn
branch to a new branch, we do not print anything, which may leave the
user wondering what happened.

The reason is that the unborn branch is a special case (see abe1998),
and does not follow the usual switch_branches code path. Let's add a
similar informational message to the special case to match the usual
code path.

Signed-off-by: Jeff King <peff@peff.net>
---
Two possible tweaks:

  1. The message is the same as "git checkout -b" when we are actually
     moving to a new branch. We could optionally mention that the branch
     is empty or unborn.

  2. We do not check whether the old unborn branch has the same name as
     the new one. So you get "Switched to a new branch..." if you try to
     checkout the same branch. We'd have to pass more information into
     the special case to detect this. I don't know if we care.

 builtin/checkout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 781295b..a9c1b5a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -951,6 +951,9 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
 	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
 	status = create_symref("HEAD", branch_ref.buf, "checkout -b");
 	strbuf_release(&branch_ref);
+	if (!opts->quiet)
+		fprintf(stderr, _("Switched to a new branch '%s'\n"),
+			opts->new_branch);
 	return status;
 }
 
