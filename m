From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Mon, 16 Jul 2012 11:57:37 -0400
Message-ID: <500439F1.2040409@xiplink.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jul 16 18:06:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqnoy-0004zA-4N
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 18:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab2GPQGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 12:06:39 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:38196 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078Ab2GPQGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 12:06:36 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2012 12:06:36 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 118BE19851E;
	Mon, 16 Jul 2012 11:57:20 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 91C441984E8;
	Mon, 16 Jul 2012 11:57:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201524>

On 12-07-14 02:59 AM, mhagger@alum.mit.edu wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
> can be used to send notification emails describing pushes into a git
> repository.  This script is derived from
> contrib/hooks/post-receive-mail, but has many differences, including:
> 
> * One email per commit [1].  For each reference change, the script
>   first emits one email summarizing the reference change (including
>   one-line summaries of the new commits), then emits a separate email
>   for each new commit that was introduced, including patches.  The
>   commit notification emails are threaded to the reference change
>   email via "In-Reply-To".  For example,
> 
>   [repo] branch master updated
>   + [repo] 01/08: doc: fix xref link from api docs to manual pages
>   + [repo] 02/08: api-credentials.txt: show the big picture first
>   + [repo] 03/08: api-credentials.txt: mention credential.helper explicitly
>   + [repo] 04/08: api-credentials.txt: add "see also" section
>   + [repo] 05/08: t3510 (cherry-pick-sequence): add missing '&&'
>   + [repo] 06/08: Merge branch 'rr/maint-t3510-cascade-fix'
>   + [repo] 07/08: Merge branch 'mm/api-credentials-doc'
>   + [repo] 08/08: Git 1.7.11-rc2
> 
>   This style (similar to the "git format-patch" style used on the git
>   mailing list) makes it much easier to scan through the emails, jump
>   to patches that need further attention, and write email comments
>   about specific emails.

Thanks for this!  The current script is the source of a few itches, and it's
nice to get them scratched.

> * (Mostly) generate email contents via template expansion.

Very nice!

> * More flexible configuration: there is an "Environment" abstraction
>   that describes the environment in which the script is running.

Also very nice.

> * Better algorithm for detecting new commits [2]: analyze all
>   reference modifications together to determine which commits were
>   added by the push.

We've run into this a few times, so thanks!

[ snip ]

> * Various changes to the format of the notification emails:
> 
>   * List commits in chronological (rather than topological) order.

I'm not sure this is a good idea.  Topological order ensures that the commits
apply in the order they're presented.  If you're attached to chronological
ordering, perhaps make this configurable?

>   * Abbreviate commit names in most places in emails.  Add one-line
>     log message summaries where appropriate.
> 
>   * By default, use a short version of the repository name in the
>     prefix for the emails' subject lines (useful when multiple
>     repositories are being watched).

Thanks for this, too.

>   * In the schematic diagrams that explain non-fast-forward commits,
>     show the names of the branches involved.
> 
>   * Don't treat annotated commits so specially [3].
> 
> * Written in Python.  Easier to implement nontrivial data structures
>   and to add new features.
> 
> This script does not support the "hooks.showrev" configuration option.

This is pretty much the only downside.  We use hooks.showrev to insert a link
to our gitweb for each commit.

I'd be OK with dropping support for hooks.showrev if there was some other way
to add extra info to the commit email.  Perhaps another template string after
REVISION_HEADER_TEMPLATE, one that's empty by default?

> [1] post-receive-mail sends only one email for each reference that is
>     changed, no matter how many commits were added to the reference.
>     It is possible to have it show patches for each commit, but since
>     they are inline in a long email they are hard to read.
> 
> [2] post-receive-mail processes one reference change at a time, which
>     causes it to fail to describe new commits that were included in
>     multiple branches.  For example, if a single push adds the "*"
>     commits in the diagram below, then post-receive-mail would never
>     include the details of the two commits that are common to "master"
>     and "branch" in its notifications.
> 
>         o---o---o---*---*---*    <-- master
>                          \
>                           *---*  <-- branch
> 
> [3] When announcing a new annotated tag, post-receive-mail lists *all*
>     of the commits since the previous annotated tag.  I found such
>     emails rather confusing than useful, so I omitted this feature.

I actually like that aspect of the current script.  Another configuration
flag, maybe?


As a replacement for the current script, I think this is great.  One thing
that I think would help make it more maintainable is to have it read template
strings from a file, so that people can customize templates without changing
the script itself.  It would also help to document all the allowed template
variables.  You might also consider expanding the templates to cover all
strings that might appear in the emails, as that would basically
internationalize the code and let people create translations.

Similarly, it would be good for folks who write their own Environments to
also be able to use a separate file instead of modifying the script itself.

Thanks again -- this is good work!

		M.
