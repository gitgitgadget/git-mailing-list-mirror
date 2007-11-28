From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Wed, 28 Nov 2007 23:40:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711282334250.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWWG-0000lg-DJ
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbXK1XkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbXK1XkU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:40:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:43020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755511AbXK1XkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:40:18 -0500
Received: (qmail invoked by alias); 28 Nov 2007 23:40:16 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp047) with SMTP; 29 Nov 2007 00:40:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19eqZUVvxdekcT6XE+Uj7VXUSzAqzxAc2GHb4AAM8
	BMZOTcbtcyNuaF
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66463>

Hi,

On Wed, 28 Nov 2007, Junio C Hamano wrote:

> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
> 
> > On Nov 28, 2007 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> In case somebody is thinking about 36e5e70e0f40 (Start deprecating
> >> "git-command" in favor of "git command"), that is a somewhat different
> >> issue.  What Linus suggested is not installing git-foo link for built-in
> >> commands _anywhere_ on the filesystem.  Not just "out of user's PATH".
> >> That is not deprecating dash form but removing the support for it.  We
> >> need to give ample time for users to adjust to such a change.
> >
> > A little note on this one. I've been using git without builtin links
> > for a while with my git-box port. There are still some builtin fixups
> > needed. And because execv_git_cmd() always uses dash form, so it's
> > impossible to use vanilla git without builtin links.
> 
> Thanks for a heads up.
> 
> Would people agree with a rough roadmap like this?
> 
>  - v1.5.4 will ship with gitexecdir=$(bindir) in Makefile.  But the
>    release notes for the version will warn users that:
> 
>    (1) using git-foo from the command line, and
> 
>    (2) using git-foo from your scripts without first prepending the
>        return value of "git --exec-path" to the PATH
> 
>    is now officially deprecated (it has been deprecated for a long time
>    since January 2006, v1.2.0~149) and upcoming v1.5.5 will ship with
>    the default configuration that does not install git-foo form in
>    user's PATH.

Maybe we can squeeze a step in here where only porcelains are installed in 
the bindir?

FWIW I think that we should fix the problem with the builtins being called 
via their hard links.  But how?  As of now, libgit.a has no idea what the 
builtins are; this information is buried in git.c.

The fundamental problem is that we cannot move handle_internal_command() 
into libgit.a, because it has pointers to all builtin cmd_*() functions.

So maybe the best solution would be to try "git <command>" first, and then 
"git-<command>"?  But this means another exec() call :-(

Ciao,
Dscho
