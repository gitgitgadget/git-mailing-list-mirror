From: Pete Wyckoff <pw@padd.com>
Subject: Re: Bug: git-p4: Sometimes p4 generates Windows-style output on OS X
Date: Sun, 12 May 2013 08:59:39 -0400
Message-ID: <20130512125939.GA1456@padd.com>
References: <5187EF88.6040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Foster <davidfstr@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 14:59:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbVsb-0004gr-67
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 14:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab3ELM7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 08:59:44 -0400
Received: from honk.padd.com ([74.3.171.149]:50745 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab3ELM7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 08:59:43 -0400
Received: from arf.padd.com (unknown [50.55.134.154])
	by honk.padd.com (Postfix) with ESMTPSA id 539925B63;
	Sun, 12 May 2013 05:59:42 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6FAAA22A3C; Sun, 12 May 2013 08:59:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <5187EF88.6040707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224046>

davidfstr@gmail.com wrote on Mon, 06 May 2013 10:59 -0700:
> I've observed that the p4 command that git-p4 delegates to
> occasionally outputs Windows-style line endings even on the OS X
> platform. When this happens, git-p4 gets very confused and crashes
> out.
> 
> I've attached a patch which seems to fix the issue in my case. Now
> this patch is a pretty bad hack, and I don't recommend that it be
> accepted as-is. It is just a starting point.
> 
> A real fix would determine in advance whether Perforce was going to
> emit Windows-style output. Since I don't know the circumstances
> under which this happens on non-Windows platforms, I can't provide a
> better patch. Someone who has intimate knowledge of p4's operating
> modes would be best to examine what's really going on with p4.

You've changed the part where git-p4 reads the submit message
back from the text editor.  There has been no interaction with p4
yet.  The self.isWindows check after your changes is just to
remove "\r" from newlines that many windows editors produce.

Now could be that you're worried not about this message, but
about failing in the later apply when it tries to put the
"\n"-terminated patch onto a workspace full of "\r\n".  There
was a recent thread:

http://thread.gmane.org/gmane.comp.version-control.git/221664/focus=223625

suggesting that core.autocrlf was to blame.  Would be interesting
if this turns out to be your problem too.  Maybe we could look
for that and do something sensible.

The other thing to check is "p4 client -o" and see what LineEnd
setting exists for the backing p4 workspace.

		-- Pete

> From aef963f0c45dea81f3e6f30d3b4185a0983ca4de Mon Sep 17 00:00:00 2001
> From: David Foster <davidfstr@gmail.com>
> Date: Mon, 6 May 2013 10:50:01 -0700
> Subject: [PATCH] Compensate for Windows-style output from the p4 command on
>  non-Windows systems.
> 
> ---
>  git-p4.py |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index 647f110..949d66d 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1454,6 +1454,24 @@ class P4Submit(Command, P4UserMap):
>              tmpFile = open(fileName, "rb")
>              message = tmpFile.read()
>              tmpFile.close()
> +            
> +            # HACK: If Perforce spontaneously generates Windows-style output,
> +            #       compensate by assuming the entire p4 command went into
> +            #       Windows mode.
> +            if separatorLine not in message:
> +                print "WARNING: Perforce has spontaneously decided to generate Windows-style output. Compensating."
> +                
> +                # Assume that Perforce is now inexplicably operating in Windows mode
> +                self.isWindows = True
> +                
> +                # Retroactively rewrite expected output
> +                submitTemplate = submitTemplate.replace("\n", "\r\n")
> +                separatorLine = separatorLine.replace("\n", "\r\n")
> +                newdiff = newdiff.replace("\n", "\r\n")
> +                
> +                if separatorLine not in message:
> +                    raise ValueError('Confused. Thought Perforce went into Windows mode but apparently something else is wrong.')
> +            
>              submitTemplate = message[:message.index(separatorLine)]
>              if self.isWindows:
>                  submitTemplate = submitTemplate.replace("\r\n", "\n")
> -- 
> 1.7.7.5 (Apple Git-26)
> 
