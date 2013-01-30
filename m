From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: "sha1 information is lacking or useless" when rebasing
	with a submodule pointer conflict
Date: Wed, 30 Jan 2013 23:49:04 +0100
Message-ID: <20130130224904.GB1053@book.hvoigt.net>
References: <CAFyOhY8YAO4zx6jKQxrEW=-Vbo-TTjU6wJ7UgNVEjA7B2dasng@mail.gmail.com> <20130130215615.GA1053@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Michael Sims <michael.h.sims@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 23:49:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0gTG-0003Oq-FA
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 23:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756281Ab3A3WtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 17:49:12 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:45229 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004Ab3A3WtM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 17:49:12 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1U0gSn-00063x-AB; Wed, 30 Jan 2013 23:49:05 +0100
Content-Disposition: inline
In-Reply-To: <20130130215615.GA1053@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215078>

Hi,

On Wed, Jan 30, 2013 at 10:56:15PM +0100, Heiko Voigt wrote:
> On Wed, Jan 30, 2013 at 12:43:31PM -0600, Michael Sims wrote:
> > I'm seeing what might be a bug that was introduced in git 1.7.12 (also
> > observed in 1.8.1.2).  If not a bug, it's a changed behavior from
> > previous versions that I don't understand.
> > 
> > Here's the scenario:
> > * I have a remote repo containing a pointer to a submodule.
> > * Developer A and Developer B clone this repo, and both make a commit
> > to first the submodule, and then the parent repo, changing some files
> > and also the submodule pointer at the same time.
> > * Developer A pushes his changes to both the submodule and the parent
> > module to the shared remote
> > * Developer B either does a "git pull --rebase" or a "git fetch && git
> > rebase origin/master"
> 
> Thanks for the detailed bug report and the demo script. I can reproduce
> the behavior here and will have a look into it. The submodule should be
> marked as conflict.

Bisect identified the following commit:

commit a230949409f4a650c6a1a9a5879e2a8b993ba695 (HEAD)
Author: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Date:   Tue Jun 26 07:51:56 2012 -0700

    am --rebasing: get patch body from commit, not from mailbox
    
    Rebasing a commit that contains a diff in the commit message results
    in a failure with output such as
    
      First, rewinding head to replay your work on top of it...
      Applying: My cool patch.
      fatal: sha1 information is lacking or useless
      (app/controllers/settings_controller.rb).
      Repository lacks necessary blobs to fall back on 3-way merge.
      Cannot fall back to three-way merge.
      Patch failed at 0001 My cool patch.
    
    The reason is that 'git rebase' without -p/-i/-m internally calls 'git
    format-patch' and pipes the output to 'git am --rebasing', which has
    no way of knowing what is a real patch and what is a commit message
    that contains a patch.
    
    Make 'git am' while in --rebasing mode get the patch body from the
    commit object instead of extracting it from the mailbox.
    
    Patch by Junio, test case and commit log message by Martin.
    
    Reported-by: anikey <arty.anikey@gmail.com>
    Helped-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Maybe Martin or Junio immediately see whats going wrong here? I would
need to further dig into the git-am code to find out how to fix it.

Cheers Heiko
