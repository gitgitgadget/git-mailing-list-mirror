From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 03:44:53 +0200
Message-ID: <1216604693.3673.20.camel@pc7.dolda2000.com>
References: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com>
	 <alpine.DEB.1.00.0807210310330.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:46:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKkTT-0000oe-2V
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522AbYGUBpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756542AbYGUBpB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:45:01 -0400
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:59027 "EHLO
	nerv.dolda2000.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbYGUBpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:45:00 -0400
Received: from [IPv6:2002:52b6:8514:200:21d:7dff:fea1:197] ([IPv6:2002:52b6:8514:200:21d:7dff:fea1:197])
	(authenticated bits=0)
	by nerv.dolda2000.com (8.13.8/8.13.8/Debian-3) with ESMTP id m6L1ircB031352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2008 03:44:54 +0200
In-Reply-To: <alpine.DEB.1.00.0807210310330.3305@eeepc-johanness>
X-Mailer: Evolution 2.22.3.1 
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (nerv.dolda2000.com [IPv6:2002:52b6:8514:200::1]); Mon, 21 Jul 2008 03:44:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89293>

On Mon, 2008-07-21 at 03:15 +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 21 Jul 2008, Fredrik Tolf wrote:
> 
> > I'm following my previous SSH patch up with this one, which should at
> > least solve the problems discussed, and probably some more. If anything,
> > it might be considered a bit overkill for the problem at hand.
> 
> I am not assuming it is overkill, but since you do not reuse functions 
> such as strbuf_expand() and split_cmdline(), your patch ends up pretty 
> large.

Thanks! I didn't know that there was a split_cmdline. I will use it and
resubmit.

> And since you use very short and undescriptive variable names, with ugly 
> assignments inside arithmetic expressions, I will be less likely 
> reviewing it in detail.

I actually use those assignments for clarity. IMO, it is more clear to
have one line which clearly initializes a buffer (and from which the
exact details of the buffer initialization can still be read), than to
litter an algorithm with lots of auxiliary lines that obfuscate what the
code really does.

Seeing how you disagree, though, I'll change that too when I'm at it.

> > I assume it might have to be documented as well, if people approve of it.
> 
> Catch 22.  Since you have not documented what %P should be useful for, 
> people might not approve of the patch, because they do not understand what
> it is supposed to do.

Yes, that would be a problem. Here's some makeshift documentation:

The string specified in core.sshcommand is first checked if it matches
any of the built-in templates, in which case it is expanded (I've added
the templates "openssh" and "plink" by default). When used, the string
is split into words, each of which is processed as follows:

* If a word is %p, it is replaced by the port number, if specified.
  If the port number is not specified, the word is deleted.
* If a word is %h, it is replaced by the remote host name.
* If a word begins with %P, it is deleted if no port number is
  specified. This is to allow for specifying different port number
  flags for different SSH implementations. The syntax is a bit ugly,
  but I cannot really think of anything that would look better.
  If a port number has been specified, the leading %P is simply deleted.

The result is used, along with the command to run on the remote side, as
the SSH command line.

Fredrik Tolf
