From: Jeff King <peff@peff.net>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Thu, 4 Dec 2014 16:58:05 -0500
Message-ID: <20141204215805.GD19953@peff.net>
References: <547C8610.8080301@cs.uni-saarland.de>
 <20141201233515.GV6527@google.com>
 <xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
 <5480C60E.3070903@cs.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Christoph Mallon <mallon@cs.uni-saarland.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwePd-0002it-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082AbaLDV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:58:09 -0500
Received: from cloud.peff.net ([50.56.180.127]:48561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932905AbaLDV6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 16:58:08 -0500
Received: (qmail 22561 invoked by uid 102); 4 Dec 2014 21:58:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 15:58:08 -0600
Received: (qmail 9816 invoked by uid 107); 4 Dec 2014 21:58:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Dec 2014 16:58:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Dec 2014 16:58:05 -0500
Content-Disposition: inline
In-Reply-To: <5480C60E.3070903@cs.uni-saarland.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260807>

On Thu, Dec 04, 2014 at 09:37:34PM +0100, Christoph Mallon wrote:

> Am 04.12.14 21:18, schrieb Junio C Hamano:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >> Could you make a test script that illustrates and reproduces the
> >> problem?  I.e., a patch to a file like t/t1410-reflog.sh, such that
> >> if I run
> >>
> >> 	cd git
> >> 	make
> >> 	cd t
> >> 	./t1410-reflog.sh
> >>
> >> then I can reproduce the bug?
> > 
> > Amen to that.  I am getting the same thing.
> 
> I ran reproduce it reliably on multiple machines (OS X, FreeBSD, ia32,
> amd64), a friend of mine can, too.

Thanks, I was able to reproduce this easily on an OS X machine.

Does this patch fix your problem?

diff --git a/refs.c b/refs.c
index f1afec5..42e3a30 100644
--- a/refs.c
+++ b/refs.c
@@ -3052,7 +3052,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	int tz;
 
 	/* old SP new SP name <email> SP time TAB msg LF */
-	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
+	if (sb->len < 83 ||
 	    get_sha1_hex(sb->buf, osha1) || sb->buf[40] != ' ' ||
 	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
 	    !(email_end = strchr(sb->buf + 82, '>')) ||


I think the bug is in the reverse-reflog reader in
for_each_reflog_ent_reverse. It reads BUFSIZ chunks of the file in
reverse order, and then parses them individually. If the trailing
newline for a line falls directly on the block boundary, we may not have
it in our current block, and pass the line to show_one_reflog_ent
without a trailing newline. That function is picky about making sure it
got a full line.

So this is a long-standing bug in for_each_reflog_ent_reverse. It just
showed up recently because we started using that function for
read_ref_at_ent.

I haven't confirmed yet, but I suspect the problem shows up on OS X and
FreeBSD but not Linux because of the definition of BUFSIZ (so it is
really probably glibc versus BSD libc). The same bug exists on Linux,
but you would need different input to stimulate the newline at the right
spot.

The above is a workaround. I think the right solution is probably to
teach for_each_reflog_ent_reverse to makes sure the trailing newline is
included (either by tweaking the reverse code, or conditionally adding
it to the parsed buffer).

-Peff
