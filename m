From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git-mergetool: show original branch names when possible
Date: Mon, 20 Aug 2007 04:52:47 -0400
Message-ID: <20070820085246.GA23764@coredump.intra.peff.net>
References: <20070820075318.GA12478@coredump.intra.peff.net> <7vabsmtxsg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 10:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN30I-0005pZ-Ps
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 10:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbXHTIwv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 04:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbXHTIwv
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 04:52:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1335 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbXHTIwv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 04:52:51 -0400
Received: (qmail 18524 invoked by uid 111); 20 Aug 2007 08:53:01 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Aug 2007 04:53:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2007 04:52:47 -0400
Content-Disposition: inline
In-Reply-To: <7vabsmtxsg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56199>

On Mon, Aug 20, 2007 at 01:28:31AM -0700, Junio C Hamano wrote:

> I do not think of anything that would barf offhand (we already
> do that in FETCH_HEAD), but this would definitely be carefully
> audited.

I didn't say it up front, but I think this is definitely post-1.5.3
material. :)

> > 2. It looks like doing an anonymous 'git-pull' leaves GITHEAD_* as the
> > commit sha1, which means you will end up with that sha1 rather than
> > 'REMOTE', which is less nice than the current behavior.
> 
> Much less nice indeed.

I think this is a failing of git-merge, though, for not including that
nice human-readable information. We can fix it with something like this:

-- >8 --

diff --git a/git-merge.sh b/git-merge.sh
index e899801..742e15d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -477,7 +477,14 @@ then
 else
 	for remote
 	do
-		echo $remote $(eval echo \$GITHEAD_$remote)
+		friendly_name=$(eval echo \$GITHEAD_$remote)
+		if echo $friendly_name | egrep -q '[0-9a-f]{40}'; then
+			friendly_name=$(
+			  sed -ne "s/$friendly_name	//p" \
+			  <"$GIT_DIR/FETCH_HEAD" 2>/dev/null
+			)
+		fi
+		echo $remote "$friendly_name"
 	done >"$GIT_DIR/MERGE_HEAD"
 	printf '%s\n' "$merge_msg" >"$GIT_DIR/MERGE_MSG"
 fi

-- 8< --

But probably it should wait for a better communications channel for
cross-command state.

> It would be very nice, and I would encourage any wannabe
> Porcelain writers to go wild on this.  One worry I have is if we
> would need to support nested states.  "I was in the middle of
> 'foo' and then had to go sideways to do 'bar' which I am now in
> the middle of" kind of thing.

It's just a stack, so I think you could implement it as a linked
list, with STATE being the head of the list, and each STATE file you
write pointing to the previous one (which you rename when pushing).

I might try to work on this, but definitely not tonight.

-Peff
