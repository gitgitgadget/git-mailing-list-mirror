From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Wed, 23 Feb 2011 03:43:29 -0500
Message-ID: <20110223084329.GA10738@sigill.intra.peff.net>
References: <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie>
 <20110222155637.GC27178@sigill.intra.peff.net>
 <7v4o7vdfz2.fsf@alter.siamese.dyndns.org>
 <20110223045143.GA11846@sigill.intra.peff.net>
 <20110223082929.GB30485@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 09:43:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsAJv-0005ra-DG
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 09:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085Ab1BWIne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 03:43:34 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39415 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083Ab1BWInd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 03:43:33 -0500
Received: (qmail 10337 invoked by uid 111); 23 Feb 2011 08:43:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 08:43:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 03:43:29 -0500
Content-Disposition: inline
In-Reply-To: <20110223082929.GB30485@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167679>

On Wed, Feb 23, 2011 at 02:29:29AM -0600, Jonathan Nieder wrote:

>     If the project grows too much, all those "make" calls start to
>     take time.  It is possible for parallel "make" invocations to
>     trample on each other's work if they are not well coordinated.

Aren't there cases where no amount of coordination will help? E.g.,
let's say I have two subdirs, lib/ and cmds/. From the top-level I do
"make -j". This invokes two recursive sub-makes, one per directory. The
make in cmds/ sees that we haven't built stuff in lib/ yet. So it
invokes a recursive make in lib/. Now we have two parallel makes running
in lib/, stomping on each other. The problem is that no single make was
allowed to see the whole dependency tree.

I know GNU make does have some magic for communicating between recursive
makes. Does it handle this situation?

You can fix this with a rule like "only invoke recursive makes on
directories _below_ you, never above or to the side". But then you can't
run "make" from inside cmds/.

You could have a dependency in the top-level that says recursing into
cmds/ depends on having finished recursing into libs/. But that's not
strictly correct. You want to be working on part of what's in cmds/
(building .o files) in parallel with what's going on in lib/, and then
wait on lib/ only for the linking portion.

Those are all things that are trivial to handle in a single Makefile.

>  B. top-level Makefile slurps in Makefiles from subdirs.  Other
>     Makefiles would

I like this better, but...

>      - keep careful track of what directory "make" was run from; [*]
> [...]
>     [*] is a little hazy and sounds hackish.

Yeah, you have to be careful with paths. I think a more sane way would
be a single top-level Makefile that either contains everything, or
sources tidbits from subdirectories. But in either case, assumes it's
running from the top-level.

A dummy Makefile in each subdir that cd's to the toplevel and runs a
specific target. So from the top-level, "make" would build everything,
"make lib" would build stuff in the lib directory, and the Makefile in
lib/ would just do "cd .. && make lib".

It's not perfect, but it's simple and predictable.

-Peff
