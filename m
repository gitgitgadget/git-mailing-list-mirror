From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
Date: Mon, 1 Dec 2008 08:20:11 -0800
Message-ID: <20081201162011.GI23984@spearce.org>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com> <1228140775-29212-2-git-send-email-gitster@pobox.com> <1228140775-29212-3-git-send-email-gitster@pobox.com> <1228140775-29212-4-git-send-email-gitster@pobox.com> <1228140775-29212-5-git-send-email-gitster@pobox.com> <1228140775-29212-6-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 17:21:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7BWf-0006TF-BO
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbYLAQUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYLAQUP
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:20:15 -0500
Received: from george.spearce.org ([209.20.77.23]:55758 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015AbYLAQUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 11:20:12 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0C4BD38200; Mon,  1 Dec 2008 16:20:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1228140775-29212-6-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102056>

Junio C Hamano <gitster@pobox.com> wrote:
> This implements the server side of protocol extension to show which branch
> the HEAD points at.  The information is sent after the terminating NUL
> that comes after the server capabilities list, to cause older clients to
> ignore it, while allowing newer clients to make use of that information

Ok, not to paint the bikeshed another color or anything ... but
can we do something to make this slightly more extensible?  I like
the "lets hide it behind the NUL" bit a lot better than the prior
iteration, but I wonder if we shouldn't do something slightly
different.

Maybe we put on the first capability line a flag that lets the
client know we have symref data in the advertised list, and then
instead of sticking only HEAD into that first ref we put the names
of the symrefs after the ref they point to.

So we might see something like:

  xxxx......................... refs/heads/boo\0with-symref\0
  xxxx......................... refs/heads/master\0HEAD\0
  xxxx......................... refs/remotes/origin/HEAD\0refs/remotes/origin/master\0

etc.  Its probably harder to produce the output for, but it permits
advertising all of the symrefs on the remote side, which may be good
for --mirror, among other uses.  It also should make it easier to put
multiple symrefs down pointing at the same real ref, they could just
be a space delimited list stored after the ref name, and if its the
first ref in the stream, after the other capability advertisement.

Actually, since the capability line is space delimited and space is
not valid in a ref name, we could just include into the capability
line like "symref=HEAD", but I still like the idea of listing it
after each ref, to reduce the risk of running into pkt-line length
limitations.

-- 
Shawn.
