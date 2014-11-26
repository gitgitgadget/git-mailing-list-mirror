From: Adam Williamson <awilliam@redhat.com>
Subject: 'simple' push check that branch name matches does not work if
 push.default is unset (and hence implicitly simple)
Date: Wed, 26 Nov 2014 14:29:28 -0800
Organization: Red Hat
Message-ID: <1417040968.12457.78.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 23:29:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xtl5a-00016P-Eu
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 23:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbaKZW3a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2014 17:29:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaKZW3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 17:29:30 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAQMTT4C022456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 26 Nov 2014 17:29:29 -0500
Received: from mail.happyassassin.net (ovpn-113-42.phx2.redhat.com [10.3.113.42])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAQMTSII013562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 26 Nov 2014 17:29:29 -0500
Authentication-Results: mail.happyassassin.net; dmarc=none header.from=redhat.com
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260315>

Hi, folks. Ran into an unfortunate issue with git which helped me mess
up a Fedora package repo today :/

The problem can be reproduced thus:

1. Create an empty repo, clone it
2. Push its master branch with something in it (just to get started)
3. git branch --track moo origin/master
4. git checkout moo
5. echo moo >> moo && git commit -a -m "create moo"
6. git push
** BUG HAPPENS - CHANGES ARE PUSHED TO origin/master **
7. git config --local push.default simple
8. echo moo2 >> moo && git commit -a -m "update moo"
9. git push
** PUSH IS CORRECTLY REJECTED **

In both those cases, the push behaviour is supposed to be 'simple' - at
step 6 it's *implicitly* set to 'simple' (according to the
documentation), while at step 9 it's *explicitly* set to 'simple'. At
step 6, a warning is printed to the console:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

warning: push.default is unset; its implicit value has changed in
Git 2.0 from 'matching' to 'simple'. To squelch this message
and maintain the traditional behavior, use:

  git config --global push.default matching

To squelch this message and adopt the new behavior now, use:

  git config --global push.default simple

When push.default is set to 'matching', git will push local branches
to the remote branches that already exist with the same name.

Since Git 2.0, Git defaults to the more conservative 'simple'
behavior, which only pushes the current branch to the corresponding
remote branch that 'git pull' uses to update the current branch.

See 'git help config' and search for 'push.default' for further informa=
tion.
(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
'current' instead of 'simple' if you sometimes use older versions of Gi=
t)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If you follow the trail there and look at 'git help config', you find
this:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

           =C2=B7   simple - in centralized workflow, work like upstrea=
m with an
               added safety to refuse to push if the upstream branch=E2=
=80=99s name is
               different from the local one.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

However, at step 6, the changes from branch 'moo' are pushed to 'master=
'
- even though that text clearly says they shouldn't be, as the names
don't match.

After step 7 - *explicitly* setting push.default to simple, rather than
relying on it being set to simple *implicitly* - another git push is
correctly rejected, with this message:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

fatal: The upstream branch of your current branch does not match
the name of your current branch.  To push to the upstream branch
on the remote, use

    git push origin HEAD:master

To push to the branch of the same name on the remote, use

    git push origin moo

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I believe the 'implicit' case was broken by the commit "push: change
`simple` to accommodate triangular workflows":

https://github.com/git/git/commit/ed2b18292bfeedc98c9e2b6bd8a35d8001dab=
2fc

It changes the condition for running the 'does the branch name match'
test from "if (simple)" to "if (push_default =3D=3D PUSH_DEFAULT_SIMPLE=
)".
AFAICS, in the 'implicit' case, push_default =3D=3D
PUSH_DEFAULT_UNSPECIFIED, not PUSH_DEFAULT_SIMPLE, so the 'does the
branch name match' check is not run, even though the behaviour is
supposed (according to the documentation) to be the same as if the
default were explicitly set to 'simple'.

Thanks to this, when I accidentally did 'git push' on a branch of the
=46edora kernel package git repo which only exists in my downstream
checkout, all my changes got pushed to the upstream master branch :( So
it's a bit dangerous.
--=20
Adam Williamson
=46edora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
