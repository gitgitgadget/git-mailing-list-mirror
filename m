From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch.autosetupmerge: allow boolean values, or "all"
Date: Mon, 9 Jul 2007 12:28:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091025250.4248@racer.site>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>
 <7vhcof2rur.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707081336020.4248@racer.site>
 <7vzm2620wp.fsf@assigned-by-dhcp.cox.net> <46919692.5020708@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 09 13:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7rWu-0001r3-Qi
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 13:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbXGILfq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 07:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbXGILfp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 07:35:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:33004 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752629AbXGILfo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 07:35:44 -0400
Received: (qmail invoked by alias); 09 Jul 2007 11:35:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 09 Jul 2007 13:35:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dtM0wRVVdSHCm2akK/JDO2Mry8n2AfKYkWgf0Kn
	bx7IWfblrHXTlj
X-X-Sender: gene099@racer.site
In-Reply-To: <46919692.5020708@gnu.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51980>

Hi,

On Sun, 8 Jul 2007, Paolo Bonzini wrote:

> [Paolo tried to hide the fact that it was Junio who wrote this:]
>
> > Having prepared the patch below, I do not think if the original patch 
> > even wanted to have 'all' semantics.  The surrounding text only talks 
> > about "off a remote branch" and I strongly suspect that nobody wanted 
> > to do this for a local branch case at all.
> 
> If I remember correctly, the problem was that you are not sure that 
> remote branches are in refs/remotes.

Then you code is incorrect.

Basically, you use a confusing set of four functions to do the following:

- read the config, and
- write the branch.<name>.{remote,merge} variables

Two functions would have been sufficient, and easier to read.  And as I 
fully expect with non-simple code, a bug was lurking.  This time in 
set_branch_defaults():

you check if neither config_repo nor config_remote (which is a misnomer, 
as it does not contain a "remote", but a "remote branch") is set.  But 
that happens when there was no information in the config, too!

Also you miss the case that there is ambiguous information:

[remote "hello"]
	url = git://blub/x.git
	fetch = refs/heads/master:refs/heads/origin

[remote "bello"]
	url = git://yaddayadda/x.git
	fetch = refs/heads/master:refs/heads/origin

See? Your code just uses "bello".

Will send out a fix shortly.

Ciao,
Dscho
