From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Wed, 2 Sep 2009 00:33:52 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909020024270.28290@iabervon.org>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net> <vpqskf8z0rj.fsf@bauges.imag.fr> <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com> <20090831164146.GA23245@coredump.intra.peff.net> <vpqocpvevzx.fsf@bauges.imag.fr>
 <20090831191032.GB4876@sigill.intra.peff.net> <20090831201911.GA24989@atjola.homenet> <20090831224749.GA24190@sigill.intra.peff.net> <fabb9a1e0908311550r1b549eb2k2df65c188a0ea6a0@mail.gmail.com> <20090901010833.GA4033@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 06:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MihXm-0001KE-BO
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 06:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZIBEdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 00:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZIBEdw
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 00:33:52 -0400
Received: from iabervon.org ([66.92.72.58]:52057 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752231AbZIBEdv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 00:33:51 -0400
Received: (qmail 8366 invoked by uid 1000); 2 Sep 2009 04:33:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Sep 2009 04:33:52 -0000
In-Reply-To: <20090901010833.GA4033@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127576>

On Mon, 31 Aug 2009, Jeff King wrote:

> On Tue, Sep 01, 2009 at 12:50:25AM +0200, Sverre Rabbelier wrote:
> 
> > 2009/9/1 Jeff King <peff@peff.net>:
> > > AFAICT, this problem goes back to v1.6.2, the first version which
> > > handled empty clones. So I blame Sverre. ;)
> > 
> > Eep :(. Any idea what is going on?
> 
> Yeah. We call upload-pack on the remote side, realize there are no refs,
> and then we just stop talking. Meanwhile upload-pack is waiting for a
> packet to say "these are the refs that I want". So the client really
> needs to send an extra packet saying "list of refs is finished".
> 
> The patch below seems to work for me, but I'm a little concerned how it
> might impact other transports.

Does putting a "transport_disconnect(transport);" after the 
"transport_unlock_pack(transport);" in builtin-clone.c also work for you? 
I think that's a cleaner solution, and should future-proof it in case we 
have a future transport that both doesn't disconnect itself after a fetch 
and gives an error message if the connection is dropped suddenly.

It's kind of just an accident that the only transport that cares about 
disconnect very much doesn't care if you've fetched after getting the 
refs.

	-Daniel
*This .sig left intentionally blank*
