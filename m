From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Does cloning a shallow repo require special setting in the cloned
 one?
Date: Thu, 26 Feb 2009 12:17:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902261216110.6258@intel-tinevez-2-302>
References: <1235620146513-2387799.post@n2.nabble.com> <87tz6hn1tg.fsf@iki.fi> <20090226104657.GB4226@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>, roylee17 <roylee17@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 12:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LceGj-0003c1-1U
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 12:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbZBZLRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 06:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbZBZLRl
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 06:17:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:51194 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751484AbZBZLRk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 06:17:40 -0500
Received: (qmail invoked by alias); 26 Feb 2009 11:17:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 26 Feb 2009 12:17:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Z6c8MJB8ZNa0MoxAyVUOkkcYHFcTBHXaejxrGif
	OnzmG2Nld7NJu5
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090226104657.GB4226@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111553>

Hi,

On Thu, 26 Feb 2009, Jeff King wrote:

> On Thu, Feb 26, 2009 at 08:34:51AM +0200, Teemu Likonen wrote:
> 
> > On 2009-02-25 19:49 (-0800), roylee17 wrote:
> > 
> > > $ git clone --depth 1 git-full git-shallow2
> > > 'git log' still gives a full history
> > >
> > > Why can't I clone a shallow repo from the git-full?
> > > Does it requires some settings in the git-full repo?
> > 
> > I don't know the "why" part but using file:// URL should work:
> > 
> >     git clone --depth 1 file:///path/to/git-full git-shallow2
> 
> I don't think the behavior is intentional, but a side effect of the
> fact that git takes some shortcuts when cloning locally. In particular,
> it will try to copy or hardlink the object database rather than
> transmitting over the git protocol locally. Using file:// has always
> been the way to suppress that shortcut.
> 
> Perhaps to avoid surprise, that optimization should be turned off for
> options which cause it to behave differently (like --depth). But I have
> to wonder what the point of --depth is locally; if you are worried about
> space, hardlinks (the default) or alternates ("clone -s") are a better
> solution.

I think it is way better to warn, since "--depth" is usually passed out of 
concerns about disk space.  And --shared should shut that concern up 
rather nicely.

diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..5831034 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -511,8 +511,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec.src = src_ref_prefix;
 	refspec.dst = branch_top.buf;
 
-	if (path && !is_bundle)
+	if (path && !is_bundle) {
+		if (option_depth)
+			warning("Ignoring --depth for local clone");
 		refs = clone_local(path, git_dir);
+	}
 	else {
 		struct remote *remote = remote_get(argv[0]);
 		transport = transport_get(remote, remote->url[0]);

Lacks tests,
Dscho
