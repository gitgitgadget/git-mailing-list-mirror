From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix "inside work tree" detection on case-insensitive
 filesystems
Date: Fri, 1 Jan 2016 15:58:53 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601011554240.14434@virtualbox>
References: <ac9733a6b922572ec10f09f89e07cde37ba43f13.1443456630.git.johannes.schindelin@gmx.de> <56829D08.1060107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 01 15:59:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF1BD-0001iw-4g
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 15:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbcAAO7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 09:59:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:54720 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbcAAO7H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 09:59:07 -0500
Received: from virtualbox ([37.24.143.189]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LcVOE-1Zmrft3d0Y-00jqJS; Fri, 01 Jan 2016 15:58:55
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56829D08.1060107@alum.mit.edu>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:F/GujgjXbFdMrsBQtxORTY8d9cUm3ripp81Jr5o6M6yoQp5ifyY
 ivgT2nl3my2Y+onX1kaAJA41UiK30eUJlfLL7D9eXR0yCQ4P46cOs6YVnBip8maZ5lTp75p
 hv4aALXteYqVBeKyZIkWa+qDVYsO87/dez7bX4hCY2UbkPdrlIawFn0oj0LM3mDOoXK09AP
 RSz1s8wo1lybiyq7xTjiQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kl8GeCppz6M=:jrYTdcwYlAEquCMvJXK7+b
 0dTzzFXTl2c1DaS0I8kpNP+28LOA0nkYD2S37p42+KpyRHBmUaSpxPsV/QxZ4Bro84ERBx62L
 6AJQqQ+YUVbosEZT2rGOzu5oJ16r7QxRzSaEQrJ6bEKuHQGVqxXgGf0OEgmJKWOAS16JoDZ5r
 lb0dtRv2anjAO+5/l4xXPGFpU4Iq9IQlHdZUx8CfJo7NFalWKeDSgwyra0AKZgYZR2lZbf/ja
 x5OPBq58AELqkQhlZ67IKppfWs582NaD2ucoWcr5ZuiyGWgdn1O2PPTkXjLA5kdxtUNClVkFL
 bcVvBdNgjpVkJzyWmtC2IjQfPMzcCWPnPPmu5giL/avaNiVYy8qlgmIVOXM9lzuxJyfJu/PEw
 JoFgWhQ/nLEYIXArI10euDb0zAgSpH6KiEeAt1ap9hQYACjnqxeBMN1JeS43NfUmjcJ7KHQLz
 fuMjYfzPkrYaxtcyLyCVFlNZFdtKVpuvxtjhW3wQfNvXh5NH1n85tSzXGsTDwHxASGFKKC/FE
 KRc+TxwUy5EPfuzE1Lc4r3dwyqTBkg8L5hLO+f/jnGOyEmvwBh6hp3ZgNwa8oyhzHuxPiac3I
 66xA0gcBphYdbLZyU9uqThE1kgDYH21Ca3Z+uR8itsOwA70RSrOS4tvdllTM5b+hxuqKZJ1Mc
 kNrm1wig7vayZbbWi9ruwgiDntN1fXmRIqECyhEGC64VfMRm3Xayhp7OQOZVfmZTs1EzW2o3E
 vVFgS3whG1g0Y8RTuD95IuTLAPH8M6HzQN8nxuJdzY3j2JdnttoRly+sztxvNTH/czDlz9ih 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283253>

Hi Michael,

On Tue, 29 Dec 2015, Michael Haggerty wrote:

> On 09/28/2015 06:12 PM, Johannes Schindelin wrote:
> > Git has a config variable to indicate that it is operating on a file
> > system that is case-insensitive: core.ignoreCase. But the
> > `dir_inside_of()` function did not respect that. As a result, if Git's
> > idea of the current working directory disagreed in its upper/lower case
> > with the `GIT_WORK_TREE` variable (e.g. `C:\test` vs `c:\test`) the
> > user would be greeted by the error message
> > 
> > 	fatal: git-am cannot be used without a working tree.
> > 
> > when trying to run a rebase.
> > 
> > This fixes https://github.com/git-for-windows/git/issues/402 (reported by
> > Daniel Harding).
> 
> I was just going through the 2.7 release notes when I saw this patch.

Thanks for your diligence!

> My understanding was that many of the case-insensitive filesystems also
> support Unicode. Is the byte-oriented code in this patch adequate? I
> would have thought it necessary to use a Unicode-aware algorithm here,
> that knows:
> 
> * that bytes != characters

I am not sure that we can in general assume that the file name is UTF-8...
Or does Git always assume that?

> * how to do a case-insensitive comparison of strings that include
> non-ASCII characters

I was worrying about that, too, but decided to punt on it when I realized
that no other case-insensitive code in Git bothers about those characters.

> * (possibly) insensitivity to NFC vs. NFD vs. non-normalized forms

Whoa... I really would like to stay away from that collection of
potholes...

> I suppose that such OSs have built-in functions for deciding whether two
> paths are equivalent. Possibly these could be used?

We could, in theory, try to do that, but what about the OSes that do *not*
have those functions? We would need our own fallback anyway, so why not
guarantee consistency and use our own functions only?

Ciao,
Dscho
