From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Tue, 29 Apr 2014 15:46:54 -0400
Message-ID: <20140429194654.GC11832@sigill.intra.peff.net>
References: <20140428161630.GA9435@sigill.intra.peff.net>
 <xmqqvbtskqjv.fsf@gitster.dls.corp.google.com>
 <20140429180210.GB11832@sigill.intra.peff.net>
 <xmqqwqe8j7id.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 21:47:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfDzY-0002l8-M7
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 21:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbaD2Tq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 15:46:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:41508 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965044AbaD2Tq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 15:46:56 -0400
Received: (qmail 25982 invoked by uid 102); 29 Apr 2014 19:46:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Apr 2014 14:46:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Apr 2014 15:46:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwqe8j7id.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247607>

On Tue, Apr 29, 2014 at 11:49:30AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think we have a "str_utf8_cmp" that ignores normalizations (or
> > maybe strcoll will do this?). But in theory we could use it everywhere
> > we use strcasecmp for ignore_case. And then we would not need to have
> > our readdir wrapper, maybe? I admit I haven't thought that much about
> > _either_ approach. But aside from some bugs in the hash system, I do not
> > recall seeing any design problems in the ignorecase code.
> 
> Our diffs and merges depend on walking two (or more) sorted lists,
> and that sort order is baked in the tree objects when they are
> created.  Using "normalized comparison" only when comparing the
> earliest elements picked from these sorted lists would not give you
> the correct comparison or merge results, would it?

Right, but we do not do normalized comparisons on that side. Not for
precompose, and not for ignorecase. The entry in the index _is_
case-sensitive[1], and we compare it as such to the tree side.

It is only when comparing the filesystem side to the index that we need
to care about such normalizations. And there we have the name-hash code
to handle ignorecase, but nothing to handle precompose.

-Peff

[1] This works because you typically get the case-sensitive entry via
    `git read-tree`, and then further update it from the filesystem. If
    you were to add a new entry "makefile", and somebody else added
    "Makefile", they would conflict.

    When you do "git add makefile" and "Makefile" _does_ exist, I am not
    sure, though, if it is git who handles making sure we find the
    correct entry, or if it is simply the fact that case insensitive
    filesystems are typically case-preserving (so you generally ask for
    "Makefile" anyway). If it is the latter, then that is a problem for
    precompose. HFS's NFD normalization is non-preserving.
