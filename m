From: Jeff King <peff@peff.net>
Subject: alternate log --follow idea
Date: Tue, 28 Oct 2008 02:44:28 -0400
Message-ID: <20081028064425.GA26450@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 07:45:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuiKo-0008PW-K4
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 07:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbYJ1Goc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 02:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbYJ1Goc
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 02:44:32 -0400
Received: from peff.net ([208.65.91.99]:1673 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752527AbYJ1Goc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 02:44:32 -0400
Received: (qmail 18169 invoked by uid 111); 28 Oct 2008 06:44:30 -0000
Received: from c-98-207-159-21.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (98.207.159.21)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 02:44:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 02:44:28 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99278>

At the GitTogether this morning, I mentioned an alternate idea for
looking at the history of a file that moved. Currently we have:

 1. git log <path>

    Show the commits, in reverse chronological order, that touched any
    content that at the time of touching resided at <path>.

 2. git log --follow <path>

    Show the commits, in reverse chronological order, for the content
    currently in <path>, where we find movement of content from one path
    to another by checking single commits, and say either "all of this
    content moved from one path to another" or not.

 3. git blame <path>

    Show the current content of <path>, but with each line of content
    showing the commit that introduced it.

In a repository with moving files, '1' is often insufficient or
annoying, since you get to the "root" of the file and discover that it
really came from somewhere else. In other words, you never really cared
about that path at all, but rather about the _content_ in it.

So you try '2', but that has its own drawbacks.  It only works on one
file at a time, and it doesn't work on many cases, including "git log
--follow git-gui/git-gui.sh".

So you move to '3', which sort of works. It shows you the commits that
introduced the current content, but not in the log format. That is, if
you don't care about "which commit introduced this particular line" but
rather "what are the commits that created this content", it is not very
useful. You see the same commits repeated (since they often change many
lines), the commits are shown in file order rather than reverse
chronological order, and you don't get the usual nicely formatted log.

So the new idea is very simple: look at the current content, get the
list of all commits which were involved in creating that content, and
then display them as a flattened history in the usual git-log way.

The script below implements a very naive version:

-- >8 --
#!/bin/sh

dashed() {
	for i in "$@"; do
		case "$i" in
		-*) echo $i ;;
		esac
	done
}

nondashed() {
	for i in "$@"; do
		case "$i" in
		-*) ;;
		*) echo $i ;;
		esac
	done
}

# hope we don't have spaces in our arguments
git ls-files `nondashed "$@"` |
while read file; do
	git blame --porcelain "$file" |
	egrep '^[0-9a-f]{40}' |
	cut -d' ' -f1
done |
sort -u |
xargs git log --no-walk `dashed "$@"`
-- >8 --

You can try:

  sh blame-log.sh git-gui/git-gui.sh

which should Just Work. Because it expands its arguments via ls-files,
you can also track the content of a whole directory:

  sh blame-log.sh -p contrib/examples

which finds all of the commits that touched those files, even when they
were not yet in contrib (in fact, it even traces some of the lines back
to git-tag-script!).

Of course it has its downsides (aside from this horrific
implementation). For one thing, it's _way_ slower than a regular log,
especially on a large chunk of content.  Some of that is in the
implementation, but mostly it is that blame takes a lot of computation.
We might be able to make things better with a specialized blame.

And as somebody (I think Steven) mentioned earlier, it only traces
content which survived to the end. So it won't mention commits which
were later eradicated, which may be useful to see.

And I'm sure there are probably other little problems, as I haven't
thought too deeply about this. But maybe it is worth adding to the
arsenal of exploration tools.

-Peff
