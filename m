From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 06:03:30 -0500
Message-ID: <20090210110330.GB12089@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:05:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqQG-0008Un-4I
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbZBJLDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZBJLDd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:03:33 -0500
Received: from peff.net ([208.65.91.99]:39630 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbZBJLDc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:03:32 -0500
Received: (qmail 12205 invoked by uid 107); 10 Feb 2009 11:03:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 06:03:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 06:03:30 -0500
Content-Disposition: inline
In-Reply-To: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109202>

On Tue, Feb 10, 2009 at 01:51:07AM +0100, Tuncer Ayaz wrote:

> As discussed recently I started taking Junio's shortstatus patch
> from October 25th 2008 and integrated it into current master.
> 
> This revision does work as advertised by Junio and v0 also did.

I did a simple test with this:

  mkdir repo && cd repo && git init &&
  touch unchanged changed changed-staged deleted deleted-staged &&
  git add . && git commit -m one &&
  echo changes >changed &&
  echo changes >changed-staged && git add changed-staged &&
  rm deleted &&
  git rm deleted-staged &&
  git shortstatus

The output is:

           changed
  M           changed-staged
           deleted
  D           deleted-staged

Some comments:

  1. Is the staggered indentation intentional? It looks awful, and the
     only use I can think of is to separate unstaged from staged
     changes. But surely there must be a more obvious way of doing so.

  2. Why do staged changes get a letter marking what happened, but
     unstaged changes do not?

  3. What advantage does this have over just doing:

       (git diff --name-status;
        git diff --cached --name-status) | sort -k2

> Right now this is basically Junio's shortstatus
> from Oct 25th 2008 with no substantial change
> except a line or two.

This is not a very helpful commit message. What is it supposed to do?
What does the output look like? Why is it implemented this way? If Junio
sent a patch in October and it isn't substantially changed, why wasn't
it accepted then?

> +static const char * const builtin_shortstatus_usage[] = {
> +	"git shortstatus [options] [--] <filepattern>...",
> +	NULL
> +};

Really? Doing "git shortstatus subdir" seems not to affect the output,
nor does "git shortstatus I totally made up these command line
arguments".

What options are available? It looks like this is intimately tied with
"commit", which I think is one of the _shortcomings_ of the current
status. It means the command line options are non-intuitive for what
people generally want to say: "what is changed, possibly limiting to
some path".

> +	OPT_BOOLEAN(0, "mini", &mini, "print mini shortstatus"),

So now "git status --mini" doesn't complain, but it doesn't seem to
actually do anything.

> +	argc = parse_and_validate_options(argc, argv, builtin_shortstatus_usage, prefix);

Ah, I see the source of the option issues. You parse with the commit
options, but then you don't actually respect any of them. You would want
a totally separate set of options for shortstatus. In fact, I really
don't see what point there is in putting it with the 'commit' code at
all.

> +	if (mini) {
> +		for (i = 0; i < s.change.nr; i++) {
> +			struct wt_status_change_data *d;
> +			struct string_list_item *it;
> +
> +			it = &(s.change.items[i]);
> +			d = it->util;
> +			switch (d->index_status) {
> +				case DIFF_STATUS_ADDED:
> +					a = 1;
> +					break;
> +				case 0:
> +				case DIFF_STATUS_COPIED:
> +				case DIFF_STATUS_DELETED:
> +				case DIFF_STATUS_MODIFIED:
> +				case DIFF_STATUS_RENAMED:
> +				case DIFF_STATUS_TYPE_CHANGED:
> +					c = 1;
> +					break;
> +				default:
> +				case DIFF_STATUS_UNKNOWN:
> +				case DIFF_STATUS_UNMERGED:
> +					u = 1;
> +					break;
> +			}
> +		}
> +		if (c)
> +			printf("*");
> +		if (a)
> +			printf("+");
> +		if (u)
> +			printf("?");

Isn't this a bit heavy-handed? If you really just want to know "are
there any changes", can't you run a custom diff with EXIT_CODE and QUIET
set, which will bail when it sees the first change, saving you a lot of
useless computation?

> +	} else {
> +		for (i = 0; i < s.change.nr; i++) {
> +			struct wt_status_change_data *d;
> +			struct string_list_item *it;
> +			char pfx[1 + 3 + 1 + 1];

Holy magic numbers, Batman.

-Peff
