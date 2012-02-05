From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 5 Feb 2012 18:29:14 +0100
Message-ID: <CALKQrgcPW5VnVtGYDo6i00bvmWr6PvnWfEdWW+9ttG4hVQm58A@mail.gmail.com>
References: <201202042045.54114.jnareb@gmail.com>
	<CAFA910035B74E56A52A96097E76AC39@PhilipOakley>
	<201202051715.38896.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 19:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru6aS-0000Ss-An
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 19:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab2BESNL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 13:13:11 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:62780 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700Ab2BESNK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 13:13:10 -0500
X-Greylist: delayed 2629 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Feb 2012 13:13:10 EST
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ru5tu-0001CS-BI
	for git@vger.kernel.org; Sun, 05 Feb 2012 18:29:18 +0100
Received: by iacb35 with SMTP id b35so7294564iac.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 09:29:14 -0800 (PST)
Received: by 10.42.155.70 with SMTP id t6mr14301362icw.11.1328462954851; Sun,
 05 Feb 2012 09:29:14 -0800 (PST)
Received: by 10.42.226.9 with HTTP; Sun, 5 Feb 2012 09:29:14 -0800 (PST)
In-Reply-To: <201202051715.38896.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189949>

2012/2/5 Jakub Narebski <jnareb@gmail.com>:
>> Being able to mark temporary, out of sequence or other hacks as Secr=
et could
>> be useful, as would recording where Public commits had been sent.
>
> Marking as 'secret' must I think be explicit, but I think 'public' ph=
ase
> should be inferred from remote-tracking branches. =C2=A0The idea of p=
hases is
> to allow UI to ask about status of commits: can we amend / rebase it =
or
> not, can we push it or not.

I agree that the 'public' state should (by default) be automatically
inferred from remote-tracking branches. As it stands, we can do this
with current git, by writing a pre-rebase hook that checks if any of
the commits to-be-rebased are reachable from any remote-tracking
branch.

Unfortunately, the pre-rebase hook only affects 'git rebase', and in
order to do the same check on 'git commit --amend' you'd have to write
a similar pre-commit hook (don't know how easy it is to find the
amended commit from within the hook). Maybe we should add a
pre-rewrite hook that trigger in the same situations as the
post-rewrite hook.

This should take care of the simplest 'public' use case in a
push-based workflow. If you publish commits by other means
(send-email, bundles, pulling directly from your repo), you need some
other way to mark the 'public' commits. One solution would be using
'git notes' to annotate the 'public' commits on a 'refs/notes/public'
notes ref. Your pre-rebase/pre-rewrite hook should then check if any
of the commits to-be-rewritten are reachable from any commit annotated
as 'public'.

Also, if you want to record where 'public' commits have been sent
(other than what can be inferred from the remote-tracking branches),
you could write this into the refs/notes/public annotation.

As for 'secret' commits, you could annotate these on a
refs/notes/secret notes ref, and then teach 'git push' (or whatever
other method for publishing commits you use) to refuse to publish
commits annotated on this notes ref. Possibly we would want to add a
"pre-push" or "pre-publish" hook.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
