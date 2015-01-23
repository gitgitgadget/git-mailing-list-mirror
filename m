From: Mike Hommey <mh@glandium.org>
Subject: Re: Should copy/rename detection consider file overwrites?
Date: Sat, 24 Jan 2015 07:37:15 +0900
Message-ID: <20150123223715.GB22303@glandium.org>
References: <20150123012908.GA8558@glandium.org>
 <20150123110418.GA10028@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 23:37:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEmr3-0004YW-US
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 23:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbbAWWh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 17:37:26 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:49526 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717AbbAWWhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 17:37:25 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YEmqp-0006s9-Gj; Sat, 24 Jan 2015 07:37:15 +0900
Content-Disposition: inline
In-Reply-To: <20150123110418.GA10028@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262972>

On Fri, Jan 23, 2015 at 06:04:19AM -0500, Jeff King wrote:
> On Fri, Jan 23, 2015 at 10:29:08AM +0900, Mike Hommey wrote:
> 
> > While fooling around with copy/rename detection, I noticed that it
> > doesn't detect the case where you copy or rename a file on top of
> > another:
> > 
> > $ git init
> > $ (echo foo; echo bar) > foo
> 
> If I replace this with a longer input, like:
> 
>   cp /usr/share/dict/words foo
> 
> > $ git add foo
> > $ git commit -m foo
> > $ echo 0 > bar
> > $ git add bar
> > $ git commit -m bar
> > $ git mv -f foo bar
> > $ git commit -m foobar
> > $ git log --oneline --reverse
> > 7dc2765 foo
> > b0c837d bar
> > 88caeba foobar
> > $ git blame -s -C -C bar
> > 88caebab 1) foo
> > 88caebab 2) bar
> 
> Then the blame shows me the initial "foo" commit. So I think it is
> mainly that your toy example is too small (I think we will do
> exact rename detection whatever the size is, but I expect we are getting
> hung up on the break detection between "0\n" and "foo\nbar\n").

Err, I was afraid my testcase was too small. And that all boils down to
this:

    <num> is optional but it is the lower bound on the number of
    alphanumeric characters that Git must detect as moving/copying
    between files for it to associate those lines with the parent
    commit. And the default value is 40.

> > I can see how this is not trivially representable in e.g. git diff-tree,
> > but shouldn't at least blame try to tell that those lines actually come
> > from 7dc2765?
> 
> diff-tree can show this, too, but you need to turn on "break detection"
> which will notice that "bar" has essentially been rewritten (and then
> consider its sides as candidates for rename detection). For example
> (with the longer input, as above):
> 
>   $ git diff-tree --name-status -M HEAD
>   c6fe146b0c73adcbc4dbc2e58eb83af9007678bc
>   M       bar
>   D       foo
> 
>   $ git diff-tree --name-status -M -B HEAD
>   c6fe146b0c73adcbc4dbc2e58eb83af9007678bc
>   R100    foo     bar
> 
> Presumably if you set the break score low enough, your original example
> would behave the same way, but I couldn't get it to work (I didn't look
> closely, but I imagine it is just so tiny that we hit the internal
> limits on how low you can set the score).o

Oh. Good to know, thanks.

Mike
