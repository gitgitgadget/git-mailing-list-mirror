From: Jeff King <peff@peff.net>
Subject: Re: "git -c web.browser=w3m help -w help" still kicks firefox
Date: Mon, 23 Aug 2010 14:38:58 -0400
Message-ID: <20100823183857.GA22386@coredump.intra.peff.net>
References: <7viq3119yn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 20:39:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnbvJ-0005su-L6
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 20:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab0HWSjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 14:39:04 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35035 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805Ab0HWSjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 14:39:03 -0400
Received: (qmail 12422 invoked by uid 111); 23 Aug 2010 18:39:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Mon, 23 Aug 2010 18:39:00 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Aug 2010 14:38:58 -0400
Content-Disposition: inline
In-Reply-To: <7viq3119yn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154242>

On Mon, Aug 23, 2010 at 11:05:04AM -0700, Junio C Hamano wrote:

> A "trivial fix" would be to pass this info through the execv_git_cmd()
> interface by either exporting it via an environment variable or by
> modifying the command line options, but I am not sure about the possible
> fallouts from such a change.  For example, does "git -c var=value config ..."
> work sensibly when what "config" is told to do (say, remove a section)
> contradicts with having the named var with a given value?
> 
> I am wondering if this is worth fixing it in the first place.

IMHO, it needs to be fixed. This bug means "git -c foo=bar X" silently
ignores the new value of "foo" if "X" is an external or a shell script.
For something like "help" it is a minor inconvenience, but I can
certainly see this causing data loss. Just in 30 seconds of grepping, I
see that "git -c mergetool.keepbackup=true mergetool" would be silently
ignored. Oops.

The environment is the only sensible way to pass this down, because we
need to hit not just externals, but things like "git config" invocations
from shell scripts. IOW, "git -c" really is about executing in a
sub-environment that pretends that config is set. Obviously we would
need to quote and unquote when using the environment as a transport (or
do something horrible like making a temporary config file and pointing
at it through the environment).

As for "git config", I would assume that "-c" parameters impact how
config itself behaves, but have no bearing at all on actual
configuration that it writes. I don't know if that is the case now,
though.

-Peff
