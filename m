From: Elijah Newren <newren@gmail.com>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 13:21:00 -0700
Message-ID: <51419b2c0901301221n45cde1abw7a57a13bfa74b34@mail.gmail.com>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com>
	 <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com>
	 <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com>
	 <20090130194727.GA31927@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 21:22:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSzsq-0007Wg-VZ
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 21:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbZA3UVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 15:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbZA3UVD
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 15:21:03 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:2823 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbZA3UVB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 15:21:01 -0500
Received: by yx-out-2324.google.com with SMTP id 8so245289yxm.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 12:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I0KkDo4T4QhyH83QQV0E7o5C+YD0m8wx3DNl8k9Dy90=;
        b=wHbcAP0dkfSTImBzHN0IFoffm+Ses348ylWST6Mvy1JicS8S3rgslDy0izsXNy8Rrl
         I96HkytQz3PYGWa92G/hrIw6C17T+YIT3CmXCfiCUXkedx2zmdDuenq1BXSlO5r14ts0
         7X5Dpv1TMJs7c7NhntT58lJ2dgaCyxVtTl8Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Epri7C3ge0JBa82SQVXhds4G3F56Wqxja8PutFfA5Zp9ufDrD3TKX0hZGDHX80y/do
         tf8uvB/5tTkQoWi/iYZ39+Ajwqvo40U1OlmaxdIwAC4+42zZiVy1pRiutx6ka0lowPPa
         BpX1O/c8TpQhaInVUyKfUgXPy5+ZoYx8IxkwI=
Received: by 10.150.92.10 with SMTP id p10mr1539454ybb.34.1233346860165; Fri, 
	30 Jan 2009 12:21:00 -0800 (PST)
In-Reply-To: <20090130194727.GA31927@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107869>

On Fri, Jan 30, 2009 at 12:47 PM, Jeff King <peff@peff.net> wrote:
> As an aside, I found some related weirdness. In my git repo, if I do
> this:
>
>  $ git checkout next
>  $ eg log -p
>
> I get log output, but the diff is not colorized (and I have color.diff
> set to "auto" in my ~/.gitconfig). But if I detach my HEAD and show the
> log:
>
>  $ git checkout next^0
>  $ eg log -p
>
> then I _do_ get color in the patch. I also get this error:

Hmm, I had never turned color on before; I guess other eg users hadn't
either.  Anyway, the difference can be explained pretty easily:  eg
log tries to provide user-meaningful names for how commits relate to
the active branch (like git-name-rev but implemented internally in eg
to allow the common case to be fast); if there is no active branch
there's no special naming to do so I simply run git log without
reading and modifying its output.

Essentially, the difference in coloring here is much like the
difference you see between

$ git log
$ git log | less

Whenever I try to load the output in perl, git won't show the
colorization.  I guess I could manually add it when I am printing the
information, but it'd be nicer to just have git do the colorization
despite the fact that its output is not a tty.  Is there an easy way
to do that (without mucking with the user's config file)?

(It looks like eg status is also affected, for similar reasons.)

>  Use of uninitialized value $branch in concatenation (.) or string at
>  /home/peff/eg line 2854.
>  eg: command (git rev-parse refs/heads/) failed
>  eg: received signal 13
>
> The error is easy to explain. The offending code is:
>
>    my $branch = RepoUtil::current_branch();
>    my ($ret, $revision) =
>      ExecUtil::execute_captured("git rev-parse refs/heads/$branch");

Indeed, the latter two lines should have been after the if (!$branch) check.


Thanks,
Elijah
