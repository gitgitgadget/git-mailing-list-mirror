From: Jeff King <peff@peff.net>
Subject: Re: 'git add' regression in git-1.7?
Date: Tue, 9 Mar 2010 17:37:30 -0500
Message-ID: <20100309223729.GA25265@sigill.intra.peff.net>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 23:37:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np83W-0001mA-BI
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 23:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab0CIWhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 17:37:34 -0500
Received: from peff.net ([208.65.91.99]:41207 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab0CIWhc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 17:37:32 -0500
Received: (qmail 3399 invoked by uid 107); 9 Mar 2010 22:37:55 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Mar 2010 17:37:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Mar 2010 17:37:30 -0500
Content-Disposition: inline
In-Reply-To: <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141851>

On Sun, Feb 28, 2010 at 06:00:17PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure of the right way to fix this. We can drop further down into
> > the directory hierarchy when doing COLLECT_IGNORED and look for actual
> > files, but that may have a negative performance impact.
> 
> Wouldn't that have negative correctness impact?  I don't see an obvious
> way out, other than perhaps checking the set of pathspecs twice.  One
> thing that might help is to carry the seen[] array a bit longer so that we
> do not have to lose sight of what paths we were given but didn't match.

Sorry for the very late reply. Day-job has kept me busy.

No, we would still be correct if we recurse into the ignored directory
_only_ to collect the ignored bits (so we don't even bother if
COLLECT_IGNORED isn't set). But what I don't like is that you take a
performance hit, because in most cases you won't ever care what's inside
those directories. You need to recurse only when:

  - you actually care about all files. git-add does. git-status does not
    (unless you explicitly told it to show directories). So that would
    probably need a flag passed to fill_directory.

  - you have a pathspec that means the contents of the directory might
    be interesting. Right now we check in_pathspec in treat_one_path.
    But I think we would need to recognize that "subdir/file" is
    means "subdir" is in our pathspec (and that "sub*" means the same
    thing).

Your solution does something similar after the fact, but I am not 100%
satisfied with it. I'll respond separately to that patch.

-Peff
