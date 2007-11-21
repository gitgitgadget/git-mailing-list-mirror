From: Jeff King <peff@peff.net>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 06:27:57 -0500
Message-ID: <20071121112757.GA17231@sigill.intra.peff.net>
References: <47440912.8010800@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Wincent Colaiuta <win@wincent.com>
To: Toby White <tow21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Nov 21 12:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iunkf-0006jU-UW
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 12:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbXKUL2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 06:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbXKUL2B
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 06:28:01 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4405 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755130AbXKUL2A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 06:28:00 -0500
Received: (qmail 6468 invoked by uid 111); 21 Nov 2007 11:27:58 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 06:27:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 06:27:57 -0500
Content-Disposition: inline
In-Reply-To: <47440912.8010800@cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65631>

On Wed, Nov 21, 2007 at 10:31:46AM +0000, Toby White wrote:

> So I wrote a quick script (below) which does what I need. Of all
> the available git-diff flags, it only understands "--cached", and
> up to two commit objects, and no paths, but that's enough for me.
> Within those constraints, it has the same semantics as git-diff.

Have you looked at the documentation for GIT_EXTERNAL_DIFF (try git(7))?
I think it is a cleaner way of doing what you want (although I think you
will get each file diffed individually, which is perhaps not what you
want).

Something like:

$ cat >merge.sh <<EOF
#!/bin/sh
opendiff "$1" "$2"
EOF
$ GIT_EXTERNAL_DIFF=./merge.sh git-diff ...

> #!/bin/sh
> #
> # Filemerge.app must not already be open before running
> # this script, or opendiff below will return immediately,
> # and the TMPDIRs deleted before it gets the chance to read
> # them.
>
> if test $# = 0; then
>   OLD=`git-write-tree`
> elif test "$1" = --cached; then
>   OLD=HEAD
>   NEW=`git-write-tree`
>   shift
> fi
> if test $# -gt 0; then
>   OLD="$1"; shift
> fi
> test $# -gt 0 && test -z "$CACHED" && NEW="$1"

write-tree? Yikes. If you want to diff against the working tree, then do
that. If you want to diff against the index, then you probably want to
git-checkout-index to a tmpdir, and diff against that.

> git-archive --format=tar $OLD | (cd $TMPDIR1; tar xf -)

Again, this could be simpler and faster by using git-checkout-index
(preceded by git-read-tree into a temp index, if you are comparing
against a tree).

-Peff
