From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Tue, 30 Oct 2012 16:51:50 +0100
Message-ID: <CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
	<20121030102526.GN4891@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 16:52:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTE6n-00076v-22
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 16:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab2J3Pvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 11:51:52 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51216 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab2J3Pvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 11:51:51 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so394238oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7m/cJzYmqxwZfxJ6r3RDUdjoDrEgj/zTAIAWApzP7+k=;
        b=1GI9s2rbHWTPWFoyyurTrCmpcOqmNJFY9wvqumb3ixM+HUUsOophsHdlzV7c7PhZfF
         OgdAOfyYP+phF6sga421B/mW2SKb6GtNJMTbn4BcwxqQld0/pJ0GEtezCQQCSR39YyMr
         CE0CJGev+sdaMo0gOFDSJaAvHihSN1A7tgnXOj+LtInvnejY9J6k3KEhnNvw1yIQLU4D
         M7CfzhRgEAN+zXj/eMST+VfhTr5A01qgOmvjYZZ5NwBqHii4wh3AHsmq5O6AuZawm10r
         inyPbD6Y9k3DgYwi3TyWo4bvM2tFYF2Xa7bSCKjPy2wts1ZA+QAC1psM4IHecGOBiHQi
         kFIQ==
Received: by 10.60.1.164 with SMTP id 4mr11869905oen.96.1351612310605; Tue, 30
 Oct 2012 08:51:50 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 08:51:50 -0700 (PDT)
In-Reply-To: <20121030102526.GN4891@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208705>

On Tue, Oct 30, 2012 at 11:25 AM, Chris Webb <chris@arachsys.com> wrote:
> Hi. I routinely work with projects in both hg and git, so I'm really
> interested in this. Thanks for working on it! I grabbed the latest version
> from
>
>   https://github.com/felipec/git/blob/fc-remote-hg/contrib/remote-hg/git-remote-hg
>
> and have been trying it out. For the most part, it seems to work very nicely
> for the hg repos I have access to and can test against. I've spotted a couple
> of issues along the way that I thought would be worth reporting.

Great!

> The first is really a symptom of a general difference between hg and git: an hg
> repository can have multiple heads, whereas a git repo has exactly one head. To
> demonstrate:

> Now if I try to convert this:
>
>   $ git clone hg::$PWD/hgtest gittest
>   Cloning into 'gittest'...
>   WARNING: Branch 'default' has more than one head, consider merging
>   Traceback (most recent call last):
>     File "/home/chris/bin/git-remote-hg", line 773, in <module>
>       sys.exit(main(sys.argv))
>     File "/home/chris/bin/git-remote-hg", line 759, in main
>       do_list(parser)
>     File "/home/chris/bin/git-remote-hg", line 463, in do_list
>       list_branch_head(repo, cur)
>     File "/home/chris/bin/git-remote-hg", line 425, in list_branch_head
>       tip = get_branch_tip(repo, cur)
>     File "/home/chris/bin/git-remote-hg", line 418, in get_branch_tip
>       return repo.branchtip(branch)
>   AttributeError: 'mqrepo' object has no attribute 'branchtip'

Yes, it seems this is an API issue; repo.branchtip doesn't exist in
python 2.2. I've added a check for that, and it should work fine now.
We'll be picking a random head (the first one), but the user has been
warned anyway.

> The second thing I spotted is the behaviour of bookmarks on push:

> i.e. the development bookmark hasn't been updated by the push. This might be
> connected to the warning message

This is not an API issue, this is a bug; bookmarks are not updated
(only the first creation works). I've fixed this as well, and added a
test with the example you put above:

http://github.com/felipec/git/commit/d006d54fc444484707dffa24d9fad053e574918d

Both issues should be fixed now :)

Cheers.

-- 
Felipe Contreras
