From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Tue, 2 Apr 2013 01:01:54 -0400
Message-ID: <20130402050154.GA21328@sigill.intra.peff.net>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
 <1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
 <20130401233313.GB30935@sigill.intra.peff.net>
 <CAMP44s0uJ4ivNLw984CXWYk5HcKevuUJmpYOiyqbT1QJDaYd0Q@mail.gmail.com>
 <20130402023024.GB719@sigill.intra.peff.net>
 <CAMP44s2VcLUE=PHE=iSsgd67_ZV4N6b5Ya76Rc22xtSzK-Xz0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 07:02:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtMZ-00005P-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 07:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758707Ab3DBFB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 01:01:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51651 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755438Ab3DBFB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 01:01:57 -0400
Received: (qmail 6162 invoked by uid 107); 2 Apr 2013 05:03:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 01:03:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 01:01:54 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2VcLUE=PHE=iSsgd67_ZV4N6b5Ya76Rc22xtSzK-Xz0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219734>

On Mon, Apr 01, 2013 at 10:51:20PM -0600, Felipe Contreras wrote:

> > So in fetch_with_import, we have a remote-helper, and we have a
> > bidirectional pipe to it. We then call get_importer, which starts
> > fast-import, whose stdin is connected to the stdout of the remote
> > helper. We tell the remote-helper to run the import, then we wait for
> > fast-import to finish (and complain if it fails).
> >
> > Then what? We seem to do some more work, which I think is what causes
> > the errors you see; but should we instead be reaping the helper at this
> > point unconditionally? Its stdout has presumably been flushed out to
> > fast-import; is there anything else for us to get from it besides its
> > exit code?
> 
> The problem is not with import, since fast-import would generally wait
> properly for a 'done' status, the problem is with export.

Your patch modified fetch_with_import. Are you saying that it isn't
necessary to do so?

> Also, the design is such that the remote-helper stays alive, even
> after fast-export has finished.

So if we expect to be able to communicate with the remote-helper after
fast-export has exited, is it a protocol failure that the helper does
not say "yes, I finished the export" or similar? If so, can we fix that?

I am not too familiar with this protocol, but it looks like we read from
helper->out right after closing the exporter, to get the ref statuses.
Shouldn't we be detecting the error if the helper hangs up there?

-Peff
