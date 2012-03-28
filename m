From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 17:25:27 -0400
Message-ID: <20120328212526.GA10795@sigill.intra.peff.net>
References: <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
 <20120328184014.GA8982@burratino>
 <20120328193909.GB29019@sigill.intra.peff.net>
 <20120328194516.GD8982@burratino>
 <20120328201851.GA29315@sigill.intra.peff.net>
 <20120328204221.GE8982@burratino>
 <20120328205144.GA10174@sigill.intra.peff.net>
 <20120328210145.GG8982@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>,
	Frans Klaver <fransklaver@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:25:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0N6-0002Zc-3K
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073Ab2C1VZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:25:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36411
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933045Ab2C1VZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:25:29 -0400
Received: (qmail 22215 invoked by uid 107); 28 Mar 2012 21:25:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 17:25:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 17:25:27 -0400
Content-Disposition: inline
In-Reply-To: <20120328210145.GG8982@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194200>

On Wed, Mar 28, 2012 at 04:01:45PM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > That is the cost of using the mkpath convenience function (otherwise,
> > the compiler will complain that ".*" expects an int). We can do it
> > manually, but in practice, do you really expect your PATH environment
> > variable to overflow an int?
> 
> I'd think a check like
> 
> 	if (end - p > INT_MAX)
> 		die("holy cow your PATH is big");
> 
> would be good enough.  Or even
> 
> 	assert(end - p <= INT_MAX);
> 
> if there is some environment limit I forgot about that makes that
> always true.

You can generally only pass a limited amount through execve. In theory
we could putenv() an arbitrarily large string, but I'm not sure we need
to worry about that. The execve limitation ranges from a few pages to a
few dozen pages by default. On recent versions of linux, it is based on
the stack rlimit. But my reading of execve(2) says that individual items
are still capped at 32 pages.

However, you have a much bigger problem with giant PATH elements, which
is that the whole thing is generally going to get stuck in a PATH_MAX
buffer and truncated. I would expect ENAMETOOLONG or EINVAL from execvp
in that case. That's what dietlibc will do. But glibc being glibc, it's
dynamically allocated there.

-Peff
