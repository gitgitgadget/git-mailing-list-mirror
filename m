From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Tue, 7 Feb 2012 16:09:07 +0100
Message-ID: <CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
	<201202061814.58346.jnareb@gmail.com>
	<CALKQrgcUdigB5zB_bqgpW8=o-TuGChs+q2nYoXu5YdyWu+oWZw@mail.gmail.com>
	<201202071531.08385.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 16:09:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rumfe-0004j0-Co
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 16:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab2BGPJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 10:09:17 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:58672 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab2BGPJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 10:09:13 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1RumfP-000Lb4-8i
	for git@vger.kernel.org; Tue, 07 Feb 2012 16:09:11 +0100
Received: by iacb35 with SMTP id b35so10232638iac.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 07:09:07 -0800 (PST)
Received: by 10.42.155.70 with SMTP id t6mr22178967icw.11.1328627347911; Tue,
 07 Feb 2012 07:09:07 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Tue, 7 Feb 2012 07:09:07 -0800 (PST)
In-Reply-To: <201202071531.08385.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190177>

(we are pretty much in violent agreement, so I will only comment where
I find it necessary)

On Tue, Feb 7, 2012 at 15:31, Jakub Narebski <jnareb@gmail.com> wrote:
> Also, when thinking about different scenarios of why one would like to
> mark commit as 'secret', we might want to be able to mark commit as
> secret / unpublishable with respect to _subset_ of remotes, so e.g.
> I am prevented from accidentally publishing commits marked as 'secret'
> to public repository, or to CI/QA repository, but I can push (perhaps
> with warning) to group repository, together with 'secret'-ness state
> of said commit...
>
> ... though it wouldn't be as much 'secret' as 'confidential' ;-)

Another way to achieve this would be to have a config flag to control
whether Git checks for the 'secret' flag before pushing. This config
flag could be set at the system/user level (to enable/disable the
feature as a whole), at the repo level (to enable/disable it in a
given repo), at the remote level (to enable/disable it on a given
repo), and finally at the branch level (to enable-disable it for a
given branch (and its upstream)). Thus you could have a .git/config
that looked like this:

  [core]
  refusePushSecret = true

  [remote "foo"]
  refusePushSecret = false
  url = ...
  fetch = ...

  [branch "baz"]
  remote = foo
  merge = refs/heads/baz
  refusePushSecret = true

This config would:

 - refuse to push 'secret' commits from branch 'baz'
(branch.baz.refusePushSecret == true)

 - but allow to push other branches with 'secret' commits to remote
'foo' (remote.foo.refusePushSecret == false)

 - but refuse to push 'secret' commits to other remotes
(core.refusePushSecret == true)

(The order of precedence would be: branch config > remote config >
repo config > user config > system config > default when unset)

I am unsure whether the 'secret'-ness of a commit should follow across
the push, but if you do (assuming we store the 'secret' flag using
git-notes) this is simply a matter of synchronizing the
refs/notes/secret to the same remote.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
