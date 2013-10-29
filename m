From: Jeff King <peff@peff.net>
Subject: Re: rcs
Date: Tue, 29 Oct 2013 14:16:14 -0400
Message-ID: <20131029181614.GA13601@sigill.intra.peff.net>
References: <B49EE6A27F1B0642B4D12AD9C064E8C7B072E3@SOARCPRVSBEU000.regnet2.soar.ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	"Hawkins, Lisa M Mrs CTR USA USASOC-SOAR" 
	<lisa.hawkins1.ctr@soar.army.mil>
To: "Finnerty, James M Mr CTR USA USASOC-SOAR" 
	<jim.finnerty.ctr@soar.army.mil>
X-From: git-owner@vger.kernel.org Tue Oct 29 19:16:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbDq4-0005av-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 19:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab3J2SQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 14:16:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:57883 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756384Ab3J2SQR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 14:16:17 -0400
Received: (qmail 10048 invoked by uid 102); 29 Oct 2013 18:16:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Oct 2013 13:16:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Oct 2013 14:16:14 -0400
Content-Disposition: inline
In-Reply-To: <B49EE6A27F1B0642B4D12AD9C064E8C7B072E3@SOARCPRVSBEU000.regnet2.soar.ns>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236939>

On Tue, Oct 29, 2013 at 11:35:21AM -0500, Finnerty, James M Mr CTR USA USASOC-SOAR wrote:

> Hi. I'm going to attempt to import a git database into Razor which is
> linux rcs based. Does the linux version of git use rcs ?

No, the formats are completely different, and you will have to
translate.  We don't usually get requests to go from git to rcs; it
usually goes the other way. :)

I don't know offhand of a tool that does it out of the box.  It should
be possible to generate the RCS files directly from the "git log" data
(though RCS does not use unified diff for storage, but rather "ed"
commands, so you'd have to translate there). A slower simpler way would
be to just "replay" the git history, committing to rcs at each step.
That might look something like the hacky, largely untested script below:

-- >8 --
#!/bin/sh

# note that this does not handle filenames which need quoting.
changed_files() {
  git diff-tree -r --name-only "$1" | tail -n +2
}

# Look at each commit in chronological order; note
# that this will linearize your history, as this
# script does not know about branches at all.
git rev-list --reverse HEAD |
while read rev; do

  # take a lock on each file we are about to update
  rcs -l $(changed_files $rev)

  # update the working tree to this revision
  git checkout -fq $rev

  # get commit date in iso8601
  date=$(git log -1 --format=%ai)

  # get author "login". This just pulls the username from
  # the email address; you may also want to map email
  # addresses to logins via a file.
  login=$(git log -1 --format=%ae | cut -d@ -f1)

  # original commit message
  msg=$(git log -1 --format=%B)

  # now we're ready to checkin
  ci -w"$login" -d"$date" -m"$msg" $(changed_files $rev) </dev/null
done
-- 8< --

There are lots of ways it can go wrong (and I tried to note them above),
but it may be enough for a simple history.

-Peff
