From: Owen Taylor <otaylor@redhat.com>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Mon, 14 Sep 2009 22:38:49 -0400
Message-ID: <1252982329.11581.111.camel@localhost.localdomain>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
	 <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
	 <1252895719.11581.53.camel@localhost.localdomain>
	 <alpine.LNX.2.00.0909141745410.14907@iabervon.org>
	 <1252970294.11581.71.camel@localhost.localdomain>
	 <7v7hw19gr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 04:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnNwf-0005Vr-0h
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 04:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934142AbZIOCi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 22:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758021AbZIOCiz
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 22:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020AbZIOCiz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 22:38:55 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8F2cpmK027370;
	Mon, 14 Sep 2009 22:38:51 -0400
Received: from [127.0.0.1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8F2coW2005724;
	Mon, 14 Sep 2009 22:38:50 -0400
In-Reply-To: <7v7hw19gr5.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128505>

On Mon, 2009-09-14 at 17:46 -0700, Junio C Hamano wrote:
> Owen Taylor <otaylor@redhat.com> writes:
> 
> > If I can figure out the rest of it, I'll look at adding a hook on top as
> > a sweetener :-)
> 
> Please don't.
> 
> I seriously suggest you start from, and stick to, nothing but a hook.
> 
> The pre-push codepath is conceptually very simple --- something needs to
> inspect a list of <ref, old, new> and say yes or no.  But what the users
> want needs great customizability (e.g. Daniel's sign-off validation
> example).  It's the prime example of codepath that should have a hook and
> no built-in policy logic.

Let me back up on this a little bit.

Is confirmation a general need?

In the context of the kernel or git personal repository workflows,
probably not. If you push something wrong, and discover it quickly, you
can just push over it and nobody is wiser. But a large fraction of the
projects listed on the front page of git-scm.com are using shared
repositories. And with a shared repository, a messed up push is more of
an issue: there may be notifications sent out over email or IRC, the
repository may be configured with denyFastForward true, people may
quickly pull your accidental push, etc.

It's also a sticky point for first using git. The push syntax and
behavior is a bit cryptic until you are used to it. Is it going to push
all branches or just the one I'm on? Is 'git push --tags' a superset of
'git push'? etc. If the first repository you are pushing to is public
and shared, heavy use of --dry-run at first is certainly advisable. But
repeating with --dry-run and without is pretty awkward.

How would the quality of use be as a hook?

Probably good enough. The broad outlines are achievable anyways. There
are some aspects of my patches that wouldn't be there. A few that come
to mind:

 - The --show-subjects option applied to all displays of push
   references, not just for --confirm.

 - In the case of a successful push when the updates are exactly what
   was confirmed, outputting them again after the push is suppressed.

How would ease of configuration be for a hook?

> E.g. perhaps in $HOME/.gitconfig, you may want to allow
> 
> 	[hook]
>         	prePush = $HOME/.githooks/my-pre-push-hook
>                 preCommit = $HOME/.githooks/my-pre-commit-hook

This is certainly better than having to set it up per-repo, but if I
wanted to tell GNOME contributors how to turn it on, I'd have to provide
a gnome-contributor-git-setup.sh. Even if the hooks were shipped with
git, there's not going to be a cross-distro path to the where they are
installed.

Maybe if a there was a "hook path" that included ~/.githooks and a
system directory? Though:

 git-config --global hook.prePush git-pre-push-confirm

could still overwrite something that they already have configured; it
wouldn't be an "orthogonal tip" that you could find on a web page and
apply blindly.

Providing a gnome-contributor-git-setup.sh is generally an approach of
last resort. I don't think there is anything unique or special about how
we do we do git on gnome.org that makes it different from other
shared-repository workflows. I'd like the knowledge that people get
using Git with GNOME to carry over to other work they do with Git and
vice-versa.

- Owen
