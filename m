From: Jeff King <peff@peff.net>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Thu, 14 Nov 2013 03:14:56 -0500
Message-ID: <20131114081456.GC16327@sigill.intra.peff.net>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
 <51A963B7.6060002@alum.mit.edu>
 <20130601050355.GA23408@sigill.intra.peff.net>
 <CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
 <20130601090934.GA13904@sigill.intra.peff.net>
 <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
 <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com>
 <CALkWK0=SqCh-82F4ud+AxuzzEezyMWqMvc6HAPoxOk32vUND7A@mail.gmail.com>
 <528416EA.1070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 09:15:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgs4s-0004BS-4u
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 09:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3KNIO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 03:14:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:38972 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751863Ab3KNIO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 03:14:57 -0500
Received: (qmail 29559 invoked by uid 102); 14 Nov 2013 08:14:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 02:14:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 03:14:56 -0500
Content-Disposition: inline
In-Reply-To: <528416EA.1070307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237818>

On Thu, Nov 14, 2013 at 05:48:50AM +0530, Sitaram Chamarty wrote:

> Is there *any* way we can preserve a reflog for a deleted branch,
> perhaps under logs/refs/deleted/<timestamp>/full/ref/name ?

I had patches to do something like this here:

  http://thread.gmane.org/gmane.comp.version-control.git/201715/focus=201752

but there were definitely some buggy corners, as much of the code
assumed you needed to have a ref to have a reflog. I don't even run with
it locally anymore.

At GitHub, we log each change to an "audit log" in addition to the
regular reflog (we also stuff extra data from the environment into the
reflog message). So even after a branch is deleted, its audit log
entries remain, though you have to pull out the data by hand (git
doesn't know about it at all, except as an append-only sink for
writing). And git doesn't use the audit log for connectivity, either, so
eventually the objects could be pruned.

> Just some basic protection -- don't delete the reflog, and instead,
> rename it to something that preserves the name but in a different
> namespace.

That part is easy. Accessing it seamlessly and handling reflog
expiration are a little harder. Not because they're intractable, but
just because there are some low-level assumptions in the git code. The
patch series I mentioned above mostly works. It probably just needs
somebody to go through and find the corner cases.

-Peff
