From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Sun, 18 Nov 2007 10:10:20 -0800
Message-ID: <7v7ikfwhkj.fsf@gitster.siamese.dyndns.org>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 19:10:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItobX-0008Ly-61
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXKRSK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbXKRSK2
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:10:28 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39507 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbXKRSK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:10:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 842CB2FB;
	Sun, 18 Nov 2007 13:10:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EDC38962EC;
	Sun, 18 Nov 2007 13:10:43 -0500 (EST)
In-Reply-To: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
	(Jon Smirl's message of "Sun, 18 Nov 2007 10:12:10 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65378>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> What's causing this? I'm using stgit on the master branch.
> I'm fixing it each time on the remote server by deleting the ref to master.
>
> jonsmirl@terra:~/ds$ git push digispeaker
> To ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git
>  ! [rejected]        master -> master (non-fast forward)
> error: failed to push to
> 'ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git'
> jonsmirl@terra:~/ds$

A "non-fast forward" means that you had this history earlier:

         o---o---A
        /
    ---o

pushed "A" to the remote's 'master', then built this history:

         o---o---A
        /
    ---o---o---o---o---A'

by rewinding and rebuilding, and the tip of the branch now
points at A', which you tried to push to the remote.

Which often causes troubles for people who are fetching from the
branch you are pushing into, and forbidden by default as a
safety measure.

As long as the people who fetch from the branch knows that you
will regularly rewinding the tip of the branch, there is no
confusion, and you can "force" a non-fast forward update.  There
are two independent safety mechanisms:

 - the sending end safety can be overriden by "git push --force"
   and/or by using a refspec prefixed with a '+');

 - the receiving end safety can be overriden by the config
   variable receive.denynonfastworwards of the repository you
   are pushing into.

The latter defaults to "unsafe", but if the safety is activated
in the repository, forcing from the sending side will not
deactivate it.  IOW, both ends need to agree to allow the unsafe
behaviour.

> On the server I have:
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = true
>         logallrefupdates = true
>
> bare was set false, I just flipped it to true. The server repo was
> originally created via a clone from kernel.org and then renamed to be
> a bare repo. Why do we need a 'bare' attribute?

There are a few things that change behaviour depending on the
bareness of the repository.  One example is that "git fetch"
that updates to the current branch (i.e. what HEAD points at) by
having it as the RHS of a refspec is accepted only for bare
repositories (for non-bare repositories such a fetch would make
the HEAD and the work tree go out-of-sync).
