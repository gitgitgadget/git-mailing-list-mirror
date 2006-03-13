From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Trivial warning fix for imap-send.c
Date: Sun, 12 Mar 2006 22:38:05 -0500
Message-ID: <20060313033805.GB14601@coredump.intra.peff.net>
References: <20060311192954.GQ16135@artsapartment.org> <slrne17urp.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.64.0603120847500.3618@g5.osdl.org> <slrne18of5.fr9.mdw@metalzone.distorted.org.uk> <4414747B.7040700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 13 04:41:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIdsp-00035a-90
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 04:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWCMDiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 22:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWCMDiI
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 22:38:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:49884 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S1750712AbWCMDiH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 22:38:07 -0500
Received: (qmail 74459 invoked from network); 13 Mar 2006 03:38:05 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 13 Mar 2006 03:38:05 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2006 22:38:05 -0500
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4414747B.7040700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17541>

On Sun, Mar 12, 2006 at 11:20:27AM -0800, A Large Angry SCM wrote:

> >No!  You can still get bitten.  You're lucky that on common platforms
> >all pointers look the same, but if you find one where `char *' (and
> >hence `void *') isn't the same as `struct foo *' then, under appropriate
> >circumstances you /will/ unless you put the casts in.
> 
> Please explain how malloc() can work on such a platform. My reading of 
> the '89 ANSI C spec. finds that _ALL_ (non function) pointers _are_ 
> cast-able to/from a void * and that NULL should be #defined as (void *). 
> See 3.2.2.3 and 4.1.5 if interested.

I think Linus has cut to the heart of the discussion (that it's worth
git maintainers' sanity not to worry about such problems). However, for
pedantry's sake, this is how malloc works:

A void pointer is guaranteed to be able to hold any type of pointer
(either char * or struct foo * or whatever). The declaration of malloc
indicates a return of void *. On a platform where it matters, the
compiler generates code so that 
  struct foo *bar = malloc(100);
converts the void * pointer into the correct size (in the same way that
assigning between differently sized integers works).

This breaks down with variadic functions, which have no typing
information. So doing this:
  execl("foo", "bar", my_struct_foo);
doesn't give the compiler a chance to do the implicit cast and you get
subtle breakage (in the same way that you would if you passed a long to
a variadic function expecting a short).

-Peff
