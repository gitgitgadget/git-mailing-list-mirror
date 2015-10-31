From: Lukas Fleischer <lfleischer@lfos.de>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Sat, 31 Oct 2015 10:03:11 +0100
Message-ID: <20151031090311.26712.64475@typhoon.lan>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
 <xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
 <20151027053916.3030.8259@typhoon.lan>
 <20151027055911.4877.94179@typhoon.lan>
 <20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
 <xmqqmvv0jb67.fsf@gitster.mtv.corp.google.com>
 <20151030214618.GA11426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 10:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsS4g-00082I-Na
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 10:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbbJaJDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 05:03:39 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:41044 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbbJaJDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2015 05:03:15 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id c20ea84d;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	Sat, 31 Oct 2015 10:03:12 +0100 (CET)
In-Reply-To: <20151030214618.GA11426@sigill.intra.peff.net>
User-Agent: alot/0.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280570>

On Fri, 30 Oct 2015 at 22:46:19, Jeff King wrote:
> On Fri, Oct 30, 2015 at 02:31:28PM -0700, Junio C Hamano wrote:
> 
> > Lukas Fleischer <lfleischer@lfos.de> writes:
> > 
> > > 1. There does not seem to be a way to pass configuration parameters to
> > >    git-shell commands. Right now, the only way to work around this seems
> > >    to write a wrapper script around git-shell that catches
> > >    git-receive-pack commands and executes something like
> > >    
> > >        git -c receive.hideRefs=[...] receive-pack [...]
> > >    
> > >    instead of forwarding those commands to git-shell.
> > 
> > This part we have never discussed in the thread, I think.  Why do
> > you need to override, instead of having these in the repository's
> > config files?
> > 
> > Is it because a repository may host multiple pseudo repositories in
> > the form of "namespaces" but they must share the same config file,
> > and you would want to customize per "namespace"?
> > 

Yes. As I said in the original thread, I want to set receive.hideRefs to
hide everything outside the current namespace, i.e. something equivalent
to

    git -c receive.hideRefs='refs/' -c receive.hideRefs="!refs/namespaces/$foo" receive-pack /some/path

if receive.hideRefs would work with absolute (unstripped) namespaces.

> > For that we may want to enhance the [include] mechanism.  Something
> > like
> > 
> >       [include "namespace=foo"]
> >               path = /path/to/foo/specific/config.txt
> > 
> >       [include "namespace=bar"]
> >               path = /path/to/bar/specific/config.txt
> > 
> > Cc'ing Peff as we have discussed this kind of conditional inclusion
> > in the past...
> 

That would work but it would still be very cumbersome. Imagine that
there is a single repository with 100000 pseudo repositories inside. You
really don't want to create a config file and a indirection in the main
configuration for each of these pseudo repositories, just to build a
configuration equivalent to the single line I described above.

> [...]
> I am slightly confused, though, where the namespace is set in such a
> git-shell example. I have no really used ref namespaces myself, but my
> understanding is that they have to come from the environment. You can
> similarly set config through the environment. I don't think we've ever
> publicized that, but it is how "git -c" works. E.g.:
> 
>   $ git -c alias.foo='!env' -c another.option=true foo | grep GIT_
>   GIT_CONFIG_PARAMETERS='alias.foo='\!'env' 'another.option=true'
> [...]

Yes, the Git namespace is passed through the environment by setting
GIT_NAMESPACE and GIT_CONFIG_PARAMETERS is exactly what I was looking
for! Thanks!
