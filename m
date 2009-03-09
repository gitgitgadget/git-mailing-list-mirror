From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/2] Move push logic to transport.c
Date: Mon, 9 Mar 2009 14:12:51 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903091331290.19665@iabervon.org>
References: <alpine.LNX.1.00.0903082046280.19665@iabervon.org> <alpine.DEB.1.00.0903091033330.10279@pacific.mpi-cbg.de> <alpine.LNX.1.00.0903091200150.19665@iabervon.org> <alpine.DEB.1.00.0903091711180.6358@intel-tinevez-2-302> <alpine.LNX.1.00.0903091230430.19665@iabervon.org>
 <alpine.DEB.1.00.0903091809330.6358@intel-tinevez-2-302> <alpine.LNX.1.00.0903091315440.19665@iabervon.org> <alpine.DEB.1.00.0903091828280.6358@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 09 19:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgjza-0005H3-M4
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 19:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbZCISMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 14:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbZCISMx
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 14:12:53 -0400
Received: from iabervon.org ([66.92.72.58]:42774 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbZCISMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 14:12:53 -0400
Received: (qmail 15908 invoked by uid 1000); 9 Mar 2009 18:12:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2009 18:12:51 -0000
In-Reply-To: <alpine.DEB.1.00.0903091828280.6358@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112728>

On Mon, 9 Mar 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 9 Mar 2009, Daniel Barkalow wrote:
> 
> > On Mon, 9 Mar 2009, Johannes Schindelin wrote:
> > 
> > > On Mon, 9 Mar 2009, Daniel Barkalow wrote:
> > > 
> > > > On Mon, 9 Mar 2009, Johannes Schindelin wrote:
> > > > 
> > > > > On Mon, 9 Mar 2009, Daniel Barkalow wrote:
> > > > > 
> > > > > > On Mon, 9 Mar 2009, Johannes Schindelin wrote:
> > > > > > 
> > > > > > > On Sun, 8 Mar 2009, Daniel Barkalow wrote:
> > > > > > > 
> > > > > > > > It doesn't convert http-push or the rsync transports, largely 
> > > > > > > > because I don't have test setups for rsync or webdav to make sure 
> > > > > > > > that they're still working.
> > > > > > > 
> > > > > > > $ ls t/*http-push*
> > > > > > > t/t5540-http-push.sh
> > > > > > > 
> > > > > > > $ git grep -n test.*rsync t/
> > > > > > > t/t5510-fetch.sh:195:test_expect_success 'fetch via rsync' '
> > > > > > > t/t5510-fetch.sh:206:test_expect_success 'push via rsync' '
> > > > > > > t/t5510-fetch.sh:217:test_expect_success 'push via rsync' '
> > > > > > > 
> > > > > > > It should be just a matter of installing an apache and rsync.
> > > > > > 
> > > > > > And configuring them suitably, yes. That's the part I haven't previously 
> > > > > > done.
> > > > > 
> > > > > If you have to configure apache (or rsync) for the test to run properly, 
> > > > > we have a serious bug in our test suite.  Please share the output in that 
> > > > > case.
> > > > 
> > > > rsync: failed to connect to 127.0.0.1: Connection refused (111)
> > > > rsync error: error in socket IO (code 10) at clientserver.c(104) [receiver=2.6.9]
> > > > fatal: Could not run rsync to get refs
> > > > 
> > > > I mean, I won't need to do anything really special in the configuration, 
> > > > but I do need to have rsyncd running giving access to that directory 
> > > > without any funny mapping on localhost.
> > > 
> > > That is my mistake, I guess.  I tried to be lazy and not change 
> > > transport.c so that it groks "rsync:$(pwd)" style paths.
> > 
> > Oh, I think it's probably not worth allowing rsync:$(pwd) (particularly 
> > since rsync itself seems not to let you say "rsync:" for local paths). 
> 
> This contradicts that:
> 
> > I'll set something up to run rsyncd with an appropriate config, like the 
> > lib-httpd stuff. Oh, and it looks like nobody actually runs the rsync 
> > tests; they're broken by $(pwd) including whitespace, and haven't been 
> > fixed yet.
> 
> If we would support local rsync paths, testing it would be easy.

Ok, I think having transport_get strip off the "rsync:" would make it work 
with the rest of the functions unchanged, which would in turn mean that 
the tests would be a pretty reasonable approximation of the real-world 
code.

	-Daniel
*This .sig left intentionally blank*
