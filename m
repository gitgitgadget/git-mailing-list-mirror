From: Pierre Habouzit <pierre.habouzit@intersec.com>
Subject: submodules and interaction with GIT
Date: Wed, 09 Jul 2008 15:07:23 +0200
Message-ID: <20080709130723.GG23482@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="5CUMAwwhRxlRszMD";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 15:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGZVl-0001Ki-TZ
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 15:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYGINOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 09:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYGINOK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 09:14:10 -0400
Received: from pan.madism.org ([88.191.52.104]:47213 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbYGINOI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 09:14:08 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jul 2008 09:14:07 EDT
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 73C25346EB;
	Wed,  9 Jul 2008 15:07:25 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E455885E5; Wed,  9 Jul 2008 15:07:23 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <pierre.habouzit@intersec.com>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87880>


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Let's start with a bit of context. We have this __huge__ "put everything
in it"-repository at work, and we want to strip out core modules and
integrate them in our different projects through submodules.  We moved
away one of our core libraries into its separate git repository, and it
became a submodule in our big fat repository. I believe it's the kind of
things we said people should do when they need partial checkouts
(tree-wise) so I assume the workflow I describe here is decent.

Just to make things clearer, we have two branches in this repository,
'maint' and 'master'. Maint is the branch for the production product,
master is the one where devel happens. 'maint' is obviously merged into
'master' on a regular basis.


Problem 1: directory/submodule conflicts (aka D/S)
---------

Our first problem was that git doesn't deal with D/S conflicts well.  To
migrate our repository, I went into 'maint' and did:

  $ git rm -rf corelib
  $ git submodule add -b corelib/master -- <our-repo> corelib
  $ git commit -asm'replace corelib with a submodule'

  Then I went into 'master' and did:

  $ git merge maint

Here it failed horribly because it claimed that the merge would clobber
untracked files like corelib/.gitignore which was a previously tracked
file in the huge repository and is now tracked in the submodule.

I worked that around by having an intermediate commit that removes
'corelib' in 'master'. Unpretty, but works.  Later, when other
developers updated their trees, they had all kinds of really distateful
issues related to D/S conflicts.



Problem 2: integration with git-checkout
---------

When using submodules, when I do updates to the corelib, like fixing a
bug, hence I want it to appear in 'maint', I go to maint and basically
do:

  $ cd corelib
  $ git fetch
  $ git reset --hard origin/corelib/master # so that I have the fix
  $ cd ..
  $ git commit -asm'update corelib for bug#nnn'

When then I `git checkout master`, the corelib submodule had no
modifications in 'maint' but remains in its 'maint' state when I go to
master instead of what I would like: see it be checkout to its 'master'
state, and refuse to checkout if the submodule cannot perform the
checkout.

I'd really like git checkout -m to also perform a git checkout -m in
submodules.

And along the road, one has a lot of frightening errors:
    fatal: cannot read object b8f1177da31281682feb79c9d4290a88edf067ae 'cor=
elib~Updated upstream': It is a submodule!


I quite understand that in presence of submodules git checkout works
becomes quite harder as you have to check for every submodule plus
yourself to know if you can perform the checkout, but I don't really see
why it can't be done.


Problem 3: similar problem with git-reset
---------

Really, I type git reset --hard all the time to undo my local changes.
And I know while typing that it destroys local changes. Really, it
should reset the submodules to their supposed state as well.



Problem 4: merging
---------

When merging two branches, there is a strategy that I believe is
applicable for submodules. If one of the two submodules states is a
direct ancestor from the other, then the merge result shall be the
descendant.

When revisions are not in direct line, then it shall be a conflict.


Problem 5: fetching
---------

`git fetch` should fetch submodules too. Arguably, if you type `git
fetch REMOTE` then any submodule that has a corresponding "REMOTE"
configured should fetch it.


Notes:
-----

When you cannot know something required for conflicts handling e.g.,
(because you haven't enough history for the submodules) the command
shall fail asking the user to fetch the incriminated submodules. IOW
when you perform any action that involves submodules, each submodules
must be queried to know if it can performs the action, and git shall
fail if it's not the case and do nothing.

Wrt most of the behaviours I described, I would be fine if those were
enabled only by a configuration flag in the .gitmodules, and that user
can override in their .git/config. We could have a
submodule.<module>.commandsMustRecurse setting to tell
fetch/reset/checkout/... to behave like I said with this module. I
believe that true should be the default.

Non initialized submodules should be considered as always up to date for
all of this, so that people that don't want to waste bandwidth for this
or this submodule can work peacefully.



Okay, I'm sure there are tons of other uses of submodules out there for
which this is an overkill, but if we really intend seriously to tell
people "do use submodules to avoid having incredibly huge repositories"
like we did in the past, we should really improve the overall usability.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh0uAcACgkQvGr7W6HudhzH7gCfTwZULngpJAU17/WrH3ypu0au
q38An18FBQZVEsiw/9xhWxqrbUYy6jH6
=1U0V
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
