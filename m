From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Sun, 25 Mar 2012 20:11:48 -0500
Message-ID: <20120326011148.GA4428@burratino>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, peff@peff.net, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 26 03:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SByU8-0006ga-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 03:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333Ab2CZBL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 21:11:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44053 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2CZBL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 21:11:57 -0400
Received: by iagz16 with SMTP id z16so7468703iag.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=E5Tas/w1MuQUuP4xd6a5Wy9qP7ZlKkhLeBst0R3Rz0k=;
        b=tsnDT1nNYu0HyeiDmF6rVkMMHvQC3aqyz6ptY+0/xFhxQU6t0zzSBFvEWbLhdUJHGX
         Hp8+WxRzlZ5JAG6wkIgSBg3g8A2EdYo97OkrmdGEDqidn0ZDeMNlcawexrUV2P6hTUvv
         wr5tZFTOPpgTaoSSFYe+5p0dqxuY6fbFP4nQ3paPUkJUXvInzsPAs/3VXjrh03UQDIXa
         LXLCrFvsoBb95G1W1Ix9duLtALAjPAyDLzbJrThI9o5URD4jwoIh8pGIxbxlSDQaB4eu
         tun4jTer9hr5/qBXkkLWuV4GeP9kZV3dkBuz0cgyFcXd9Gqa1yCphWGay8IvJ8WxJDpH
         ekNQ==
Received: by 10.42.141.72 with SMTP id n8mr11698850icu.47.1332724316612;
        Sun, 25 Mar 2012 18:11:56 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id md6sm13088408igc.0.2012.03.25.18.11.55
        (version=SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 18:11:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193888>

Hi Ben,

Good catch.  A few comments:

Ben Walton wrote:

> In this case, the failing test was t7006-pager:command-specific
> pager.  That test (and some subsequent ones) were setting the pager
> command used by git log to "sed s/^/foo:/ >actual" which is fine in a
> POSIX-compliant sh, but not in Solaris' sh.  If the user PATH at
> runtime happened to allow the broken system sh used instead of a sane
> sh, the ^ is interpreted the same as[1] | and this caused sed to fail
> with incomplete s/ command and a "command not found: /foo:" from the
> other forked process.

When I first read the corresponding patch without reading this cover
letter I was mystified.  Until I saw the above paragraph, I did not
even see what problem was being solved.  The above paragraph should
probably be part of the commit message.

Ok, on to the proposed solution. ;-)

My first reaction was to suspect the series is solving the problem in
the wrong place.  The core of the bug might be t7006 itself, which
assumes that the shell used to interpret the GIT_PAGER setting is a
POSIX-style shell rather than an ancient Bourne shell or cmd.exe.
In the far long term, we should probably skip this test on some
platforms using an appropriate test prerequisite.

To put it another way, the RUN_USING_SHELL magic is just supposed to
be a more featureful way to do what system() normally does.  What
shell does system() use on Solaris?

A second reaction was to wonder why the usual fixup from
v1.6.4-rc0~66^2~1 (Makefile: insert SANE_TOOL_PATH to PATH before /bin
or /usr/bin, 2009-07-08) didn't apply.  Should the git wrapper prepend
the same magic to $PATH that git-sh-setup.sh does to make the behavior
of scripted and unscripted commands a little more consistent?

A third reaction was that git_pager in the sh-setup library uses the
eval builtin, so we are already assuming that GIT_PAGER is appropriate
input for a POSIX-style shell.  So maybe the approach you've adopted
is appropriate after all, at least in the short term while we require
a POSIX-style shell elsewhere in git.

A few added words in the commit message could save the next reader
from going through so long a thought process before seeing why what
the patch does is the right thing to do.

A more minor comment: patch 1/2 was even more mysterious.  Combining
the two patches would be enough to avoid confusion there.  I haven't
checked the makefile changes and interaction with GIT-CFLAGS carefully
yet and hope to do so in the next round.

Thanks for working on this.

Sincerely,
Jonathan
