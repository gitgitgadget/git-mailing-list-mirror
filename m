From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 5 Feb 2012 21:46:56 +0100
Message-ID: <201202052146.56458.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202051715.38896.jnareb@gmail.com> <CALKQrgcPW5VnVtGYDo6i00bvmWr6PvnWfEdWW+9ttG4hVQm58A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 05 21:47:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru8zE-0007er-10
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 21:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103Ab2BEUqz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 15:46:55 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61493 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab2BEUqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 15:46:55 -0500
Received: by eaah12 with SMTP id h12so2236378eaa.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 12:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=C3BV9/S1k9hDUrRzfvwI9PyusOmtW6luIVjAcxEUTUE=;
        b=apO24g0cQ17JA93CdOMoSOm41y3WkYxK6DNWgoTmVZy0tFTSJZR7S/Tj+5HtnGmFmq
         UlU4TAfPDDs1c3Z1/a1bZaf2DAOqnLLauLqmQ9uLNVllVQWofY4KPdKupkhpjixZAWOm
         DgKxyanDTzRCBEw+yT5uOAPtcTn2cOOlHsh1M=
Received: by 10.213.2.67 with SMTP id 3mr917833ebi.114.1328474813992;
        Sun, 05 Feb 2012 12:46:53 -0800 (PST)
Received: from [192.168.1.13] (abvp235.neoplus.adsl.tpnet.pl. [83.8.213.235])
        by mx.google.com with ESMTPS id a58sm52565366eeb.8.2012.02.05.12.46.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 12:46:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CALKQrgcPW5VnVtGYDo6i00bvmWr6PvnWfEdWW+9ttG4hVQm58A@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189957>

On Sun, 5 Feb 2012, Johan Herland wrote:
> 2012/2/5 Jakub Narebski <jnareb@gmail.com>:

> > > Being able to mark temporary, out of sequence or other hacks as S=
ecret could
> > > be useful, as would recording where Public commits had been sent.
> >
> > Marking as 'secret' must I think be explicit, but I think 'public' =
phase
> > should be inferred from remote-tracking branches. =C2=A0The idea of=
 phases is
> > to allow UI to ask about status of commits: can we amend / rebase i=
t or
> > not, can we push it or not.
>=20
> I agree that the 'public' state should (by default) be automatically
> inferred from remote-tracking branches. As it stands, we can do this
> with current git, by writing a pre-rebase hook that checks if any of
> the commits to-be-rebased are reachable from any remote-tracking
> branch.

It is nice that we can achieve a large part of this feature with existi=
ng
infrastructure.  It would be nice if we ship such pre-rebase hook with
git, so people can just enable it if they want to use this functionalit=
y,
like the default pre-commit hook that checks for whitespace errors.
=20
> Unfortunately, the pre-rebase hook only affects 'git rebase', and in
> order to do the same check on 'git commit --amend' you'd have to writ=
e
> a similar pre-commit hook (don't know how easy it is to find the
> amended commit from within the hook). Maybe we should add a
> pre-rewrite hook that trigger in the same situations as the
> post-rewrite hook.

pre-rewrite hook would be a really nice to have, especially that it wou=
ld
(I hope) cover third party tools like various GUIs for git; and also
git-filter-branch.

Note however that the safety net, i.e. refusing or warning against atte=
mpted
rewrite of published history is only part of issue.  Another important =
part
is querying and showing "phase" of a commit.  What I'd like to see is
ability to show among others in "git log" and "git show" output if comm=
it
was already published or not (and if it is marked 'secret').

> This should take care of the simplest 'public' use case in a
> push-based workflow. If you publish commits by other means
> (send-email, bundles, pulling directly from your repo), you need some
> other way to mark the 'public' commits. One solution would be using
> 'git notes' to annotate the 'public' commits on a 'refs/notes/public'
> notes ref. Your pre-rebase/pre-rewrite hook should then check if any
> of the commits to-be-rewritten are reachable from any commit annotate=
d
> as 'public'.

Another solution would be to create "fake" remote-tracking branches
by git-bundle and git-send-email.
=20
> Also, if you want to record where 'public' commits have been sent
> (other than what can be inferred from the remote-tracking branches),
> you could write this into the refs/notes/public annotation.

I wonder if this too can be done by hook...
=20
> As for 'secret' commits, you could annotate these on a
> refs/notes/secret notes ref, and then teach 'git push' (or whatever
> other method for publishing commits you use) to refuse to publish
> commits annotated on this notes ref. Possibly we would want to add a
> "pre-push" or "pre-publish" hook.

Well, addition of pre-push / pre-publish was resisted on the grounds
that all it does is something that can be as easy done by hand before
push.  Perhaps this new use case would help bring it forward, don't
you think?

Thanks for all the comments.
--=20
Jakub Narebski
Poland
