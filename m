From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 08:39:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607140828250.5623@g5.osdl.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org> 
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
  <1152840456.31372.75.camel@shinybook.infradead.org> 
 <Pine.LNX.4.64.0607132251310.5623@g5.osdl.org> <1152869915.3191.12.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 17:40:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Plf-0001Bb-Pt
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 17:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWGNPjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWGNPjt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 11:39:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161123AbWGNPjs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 11:39:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6EFdPnW025794
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 14 Jul 2006 08:39:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6EFdOiB016870;
	Fri, 14 Jul 2006 08:39:25 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152869915.3191.12.camel@pmac.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.86__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23892>



On Fri, 14 Jul 2006, David Woodhouse wrote:
> On Thu, 2006-07-13 at 22:52 -0700, Linus Torvalds wrote:
> > Btw, I'm actually surprised that my path simplification didn't filter out 
> > the "." and make it mean exactly the same as not giving a path at all. I 
> > thought I had done that earlier, but if you say "-- ." matters, then it 
> > obviously does..
> 
> In this specific case where I have a whole bunch of commits which don't
> actually change anything, it definitely does make a difference...

Yes, I'm looking at "get_pathspec()", and noting that it really isn't able 
to optimize away the ".".

It does turn it into an empty string (which is correct - git internally 
does _not_ ever understand the notion of "." as the current working 
directory), but it doesn't ever do the optimization of noticing that a 
pathspec that consists solely of an empty string is "equivalent" to an 
empty pathspec.

Which is exactly what you _want_ in this case, of course, but maybe we 
should add a test-case for that, so that we never do that trivial 
optimization by mistake.

Maybe something like

	git init-db
	echo Hello > a
	git add a
	git commit -m "Initial commit" a

and then:

	commit=$(echo "Unchanged tree" | git-commit-tree "HEAD^{tree}" -p HEAD)
	git-rev-list $commit | wc -l 
	git-rev-list $commit -- . | wc -l

where the first git-rev-list should return 2, and the second one should 
return 1.

Anybody want to write that as a test, verify it, and send Junio a patch?

		Linus
