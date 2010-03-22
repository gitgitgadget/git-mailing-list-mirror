From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Improve documentation for git-remote-helpers
Date: Sun, 21 Mar 2010 20:06:36 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003211951360.14365@iabervon.org>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com>  <f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com>  <alpine.LNX.2.00.1003211907390.14365@iabervon.org> <fabb9a1e1003211635w27f0b22em73c7c6431c3998af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 01:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtVAK-00088V-7F
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 01:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0CVAGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 20:06:38 -0400
Received: from iabervon.org ([66.92.72.58]:43262 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298Ab0CVAGh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 20:06:37 -0400
Received: (qmail 17136 invoked by uid 1000); 22 Mar 2010 00:06:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Mar 2010 00:06:36 -0000
In-Reply-To: <fabb9a1e1003211635w27f0b22em73c7c6431c3998af@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142876>

On Mon, 22 Mar 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Mon, Mar 22, 2010 at 00:29, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > Yup. Or maybe these should be documented as a list of capabilities which
> > mean that the helper supports the command with the same name, since that's
> > a common pattern, and documenting it as a pattern makes it obvious that,
> > if we have a new 'export' command, and it needs a capability, it'll fit
> > the pattern.
> 
> Speaking of which, I have uploaded a preliminary version of the export
> capability to my github repository [0] since Ramkumar wanted to have a
> look at it. Sadly I have not been able to test it yet, I wanted to
> work on that today but instead spent hours on getting the first
> argument to the helper to be 'origin' (or whatever the user sets it to
> with the --origin option), something that's been bothering me forever.
> No documentation yet though, working on that ;).
> 
> [0] http://github.com/SRabbelier/git

Looks generally right, but I think you need to do 
"finish_command(&exporter);" first, and actually get some feedback from 
the helper. I think the right thing is actually to put the output of the 
helper into fast-import again, and have that give one of three 
conclusions:

 - We tried to send sha1 A to the foreign system, and it rejected us 
   entirely.
 - We tried to send sha1 A to the foreign system, and reimporting what it 
   put in for us actually gives us sha1 A, so the transformation is 
   lossless.
 - We tried to send sha1 A to the foreign system, but reimporting what it
   put in for us gives us sha1 B instead. This means B is as close to a 
   replacement for A as we can get in this case, and the git core should 
   know about the situation (although, for now, it doesn't have anything 
   to do about it).

At the least, in the third case, we should update any tracking branches to 
match what the foreign system now contains, not to match what we tried to 
put there.

But even without considering the third case (IIRC, hg and git can 
interoperate losslessly), you need to get feedback in some way if the 
remote entirely rejected us.

	-Daniel
*This .sig left intentionally blank*
