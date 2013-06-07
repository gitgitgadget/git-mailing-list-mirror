From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or upstream
Date: Fri, 7 Jun 2013 19:41:07 +0530
Message-ID: <CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
References: <20130607124146.GF28668@sociomantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Leandro Lucarella <leandro.lucarella@sociomantic.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 16:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkxOS-0003n3-7T
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 16:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691Ab3FGOLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 10:11:48 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52589 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab3FGOLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 10:11:47 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so2152925ieb.10
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qoZxNwu1pS20IqiqOPHPH+JZZYqmQAQf3T870832POE=;
        b=jO7YXlSspo7Nct5FCpwp9hJIIOhnDINCu/gYpX2iphI1+613mU3BDunfxAil09iDWS
         gY5DeVWU9zlA/WeNPtWihiSaNpA7NeZmD09ZjHbTbpDU3ynrvwd0+reEwxFaomc2lPuh
         WVgnOU1M81dCZtd4jUQy7yfnbVxPlAnx1vDjcs19GmpsoVAflq+RzVxUvtsKdotw0MXZ
         jU9Ojls7uRHVBl2lUlnFxXo4NFdcdNipeL4vgY1FY+/5POvJ85q06q0TCBeJ5CijPnUC
         YBnSu6khyIl1m2JTfvKsyU1RBwWL+2gVB23z/dKlIuH0guJDYpUWF7WdRbB+22lECsTf
         xYnA==
X-Received: by 10.50.70.101 with SMTP id l5mr1236818igu.104.1370614307222;
 Fri, 07 Jun 2013 07:11:47 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 07:11:07 -0700 (PDT)
In-Reply-To: <20130607124146.GF28668@sociomantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226629>

[+CC: jc, jk]

Leandro Lucarella wrote:
> I changed branch.master.remote to upstream and set
> branch.master.pushremote to origin, but when I do I git push I get an
> error:
>
> $ git push --dry-run --verbose
> fatal: You are pushing to remote 'origin', which is not the upstream of
> your current branch 'master', without telling me what to push
> to update which remote branch.

Yes, this is a defect: both remote.pushdefault and
branch.<name>.pushremote suffer from it.

Let me explain what's happening.  The error is triggered off in
setup_push_upstream() in builtin/push.c (which both simple and
upstream use).  It's exactly the same error that will be reported if
you do the following without a branch.master.pushremote or
remote.pushdefault configured:

  $ git push origin --dry-run --verbose
  fatal: You are pushing to remote 'origin', which is not the upstream of
  your current branch 'master', without telling me what to push
  to update which remote branch.

You should therefore be able to infer that remote.pushdefault/
branch.<name>.pushremote is simply saving you from remembering/ typing
out that "origin" on the command-line.  The error precisely describes
the problem.  To understand what this "upstream" the error is talking
about, see:

   $ git rev-parse --symbolic-full-name @{u}
   refs/remotes/upstream/master

So, if you are pushing to upstream, the push knows what to do: push to
the refspec <branch>:<branch>@{u} (see builtin/push.c:148).  If you're
pushing to origin, it has no idea _what_ to push, and hence errors
out.  By design, upstream/ simple assume that you push to the same
place that you pull from: the description clearly says that it is
intended to make the push and pull symmetric.

Finally, the reason remote.pushdefault/ branch.<name>.pushremote works
in the other modes is simple: in matching and current, the push
refspec is not dependent on the current branch's upstream.  In
matching, the refspec it is the constant ":", and in current, it is
the constant "HEAD" (will subtly change with rr/push-head).

I think the correct fix is to change the semantics of upstream/simple
to dictate a refspec independent of remote.  So, if:

1. branch.master.merge is configured to refs/heads/rr/master
2. branch.master.remote is configured to origin
3. remote.pushdefault is configured to ram
4. push.default is configured to upstream

Then, the a push should push the refspec master:rr/master to the
remote ram.  Let's see what the others have to say before proceeding.

Thank you for reporting this problem.  It is indeed very serious,
especially since simple is going to be default in Git 2.0.
