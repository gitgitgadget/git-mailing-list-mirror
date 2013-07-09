From: Jeff King <peff@peff.net>
Subject: Re: Git --file doesn't override $HOME in version 1.8.1.2
Date: Tue, 9 Jul 2013 15:24:55 -0400
Message-ID: <20130709192455.GC5153@sigill.intra.peff.net>
References: <C8A88C530F38AE47B22BDC434090CBB0ED26E0@IT-EXMB01-HKI.it.local>
 <87mwpweywu.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Saraj=C3=A4rvi?= Tony <Tony.Sarajarvi@digia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:25:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwdX6-0004qo-6B
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486Ab3GITZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:25:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:41287 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114Ab3GITY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:24:59 -0400
Received: (qmail 11339 invoked by uid 102); 9 Jul 2013 19:26:15 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Jul 2013 14:26:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jul 2013 15:24:55 -0400
Content-Disposition: inline
In-Reply-To: <87mwpweywu.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229983>

On Tue, Jul 09, 2013 at 01:49:21PM +0200, Thomas Rast wrote:

> Rather, it's very strange that 'git config --file foo' tries to look at
> any config file other than 'foo'.  In a git repo:
> 
>   $ strace git config --file fooconfig test.var 2>&1 | grep 'open.*config'
>   open("/home/thomas/.gitconfig", O_RDONLY) = 3
>   open(".git/config", O_RDONLY)           = 3
>   open("/home/thomas/.gitconfig", O_RDONLY) = 3
>   open(".git/config", O_RDONLY)           = 3
>   open("fooconfig", O_RDONLY)             = 3
> 
> I haven't looked into the code yet.  Probably it's simply following the
> usual code paths to discover a repo and read its config.  However, with
> the --file option, it shouldn't.

I'm not so sure. It is (in theory) OK to read the usual config files to
find out _how_ git-config should behave, but then return results from a
specific file. The former should read the "normal" files, and the latter
should read whatever is specified by the options ("--file", a specific
level like "--global", or the usual set of files).

There are probably not many config options that can affect git-config's
behavior. The few I can think of are:

  1. core.editor should affect "git config --edit"

  2. pager.config would auto-start a pager. I am not sure if that is a
     sane thing to do or not.

  3. In theory you could have advice.* affect git-config, but I do not
     think any currently do.

  4. Currently git-config does not read objects, but there are patches
     proposed to do so. In that case, things like core.packedGitWindowSize
     might be important.

So I think you could probably drop the config parsing, special-case (1),
and ignore (2) as silly. But I think (3) and (4) show that it isn't the
right thing to do; you will never know which config options affect
git-config's behavior in the future.

The real issue here is not the "extra" normal config parsing; it is that
the normal parsing does not work in some cases. And that has already
been fixed by Jonathan's 4698c8f (config: allow inaccessible
configuration under $HOME, 2013-04-12).

-Peff
