From: Jeff King <peff@peff.net>
Subject: Re: regression in multi-threaded git-pack-index
Date: Sat, 16 Mar 2013 07:41:19 -0400
Message-ID: <20130316114118.GA1940@sigill.intra.peff.net>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 16 12:42:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGpUu-0005TB-91
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 12:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab3CPLlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 07:41:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab3CPLlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 07:41:23 -0400
Received: (qmail 1757 invoked by uid 107); 16 Mar 2013 11:43:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 07:43:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 07:41:19 -0400
Content-Disposition: inline
In-Reply-To: <20130315224240.50AA340839@wince.sfo.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218298>

On Fri, Mar 15, 2013 at 03:42:40PM -0700, Stefan Zager wrote:

> We have uncovered a regression in this commit:
> 
> b8a2486f1524947f232f657e9f2ebf44e3e7a243
> 
> The symptom is that 'git fetch' dies with:
> 
> error: index-pack died of signal 10
> fatal: index-pack failed
> 
> I have only been able to reproduce it on a Mac thus far; will try
> ubuntu next.  We can make it go away by running:
> 
> git config pack.threads 1

I couldn't reproduce the problem on Linux with the instructions you
gave. I did try running it under valgrind and it produced:

  ==2380== Conditional jump or move depends on uninitialised value(s)
  ==2380==    at 0x441631: resolve_delta (index-pack.c:837)
  ==2380==    by 0x4419D6: find_unresolved_deltas_1 (index-pack.c:898)
  ==2380==    by 0x441A45: find_unresolved_deltas (index-pack.c:914)
  ==2380==    by 0x4427CA: fix_unresolved_deltas (index-pack.c:1232)
  ==2380==    by 0x4421F5: conclude_pack (index-pack.c:1111)
  ==2380==    by 0x443A5C: cmd_index_pack (index-pack.c:1604)
  ==2380==    by 0x4058A2: run_builtin (git.c:281)
  ==2380==    by 0x405A35: handle_internal_command (git.c:443)
  ==2380==    by 0x405C01: main (git.c:532)

but the line in question is:

  if (deepest_delta < delta_obj->delta_depth)

And in the debugger, both of those variables appear to have sane values
(nor should either impacted by the patch you bisected to). On top of
that, running with pack.threads=1 produces the same error. So I think it
may be a false positive from valgrind, and unrelated to your issue.

Other than that, it seems to run fine for me.

-Peff
