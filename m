From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep --no-index: allow use of "git grep" outside a git
 repository
Date: Mon, 18 Jan 2010 00:57:03 -0500
Message-ID: <20100118055703.GA17879@coredump.intra.peff.net>
References: <20100115223259.6117@nanako3.lavabit.com>
 <7vska71br0.fsf@alter.siamese.dyndns.org>
 <7vzl4fum3r.fsf_-_@alter.siamese.dyndns.org>
 <20100115210854.GA21540@coredump.intra.peff.net>
 <7vwrzin9jt.fsf@alter.siamese.dyndns.org>
 <20100116011512.GA27082@coredump.intra.peff.net>
 <7vpr5ait1m.fsf@alter.siamese.dyndns.org>
 <20100118015140.GB6831@coredump.intra.peff.net>
 <7v8wbwultw.fsf@alter.siamese.dyndns.org>
 <7v3a24ukku.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 06:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWkcC-0006uB-36
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 06:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190Ab0ARF5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 00:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129Ab0ARF5L
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 00:57:11 -0500
Received: from peff.net ([208.65.91.99]:47094 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780Ab0ARF5K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 00:57:10 -0500
Received: (qmail 2766 invoked by uid 107); 18 Jan 2010 06:01:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 18 Jan 2010 01:01:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2010 00:57:03 -0500
Content-Disposition: inline
In-Reply-To: <7v3a24ukku.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137369>

On Sun, Jan 17, 2010 at 08:02:25PM -0800, Junio C Hamano wrote:

> Subject: "log --author=me --grep=it" should find intersection, not union
> 
> Historically, any grep filter in "git log" family of commands were taken
> as restricting to commits with any of the words in the commit log message.
> However, the user almost always want to find commits "done by this person
> on that topic".  With "--all-match" option, a series of grep patterns can
> be turned into a requirement that all of them must produce a match, but
> that makes it impossible to ask for "done by me, on either this or that"
> with:
> 
> 	log --author=me --grep=this --grep=that
> 
> because it will require both "this" and "that" to appear.
> 
> Change the "header" parser of grep library to treat the headers specially.
> When parsing the above, behave as if it was specified like this on the
> command line:
> 
> 	--all-match --author=me '(' --grep=this --grep=that ')'
> 
> Even though the "log" command line parser doesn't give direct access to
> the extended grep syntax to group terms with parentheses, this change will
> cover the majority of the case the users would want.

Hmm. I like the new behavior. The implementation feels a little
hack-ish, like we should really be supporting full-on:

  git log --author=me --and --grep=foo

That gets a little weird, though. We already have "--not" for ref
limiting, so clearly there is some conflict over exactly what logical
operators would be operating on. I guess we could use context to see
that the adjacent arguments were grep-related.

So perhaps, as you say, this is enough as it covers the usual case.

-Peff
