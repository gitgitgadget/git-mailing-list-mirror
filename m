From: Roger Leigh <rleigh@codelibre.net>
Subject: Integration of git release workflow with automake "make dist"
Date: Sat, 15 Aug 2009 15:21:18 +0100
Message-ID: <20090815142117.GE22565@codelibre.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 16:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McKGW-00074X-Pd
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 16:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbZHOO3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 10:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754253AbZHOO3o
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 10:29:44 -0400
Received: from nagini.codelibre.net ([80.68.93.164]:45888 "EHLO
	nagini.codelibre.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbZHOO3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 10:29:43 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Aug 2009 10:29:43 EDT
Received: by nagini.codelibre.net (Postfix, from userid 107)
	id 317A4182E0; Sat, 15 Aug 2009 15:21:21 +0100 (BST)
Received: from hardknott (unknown [78.149.60.209])
	by nagini.codelibre.net (Postfix) with ESMTPSA id 781A318278
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 15:21:19 +0100 (BST)
Received: by hardknott (Postfix, from userid 1000)
	id 525A22FC; Sat, 15 Aug 2009 15:21:18 +0100 (BST)
Content-Disposition: inline
X-GPG-Key: 0x25BFB848
X-Debian: testing/unstable
X-OS-Uptime: 09:53:46 up 15:10,  2 users,  load average: 0.14, 0.09, 0.07
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126007>


--Wb5NtZlyOqqy58h0
Content-Type: multipart/mixed; boundary="TD8GDToEDw0WLGOL"
Content-Disposition: inline


--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[I'm not subscribed to the list, so I'd appreciate a CC on reply, thanks!]

Hi folks,

After initially bringing up the idea behind this initial implementation
on the automake mailing list, I want to get some criticism and comments
=66rom automake users who use git (or git experts in general in case my
use of the git plumbing is not correct!).

The initial discussion is here:
http://thread.gmane.org/gmane.comp.sysutils.automake.general/10936

And the current implementation is attached.


Automake has a "dist" target to generate a "release" in the form of a
compressed tarfile or zip file.  This file contains files not normally
kept under version control in the developer's repo (generated autotools
scripts, other generated files such as changelogs etc.) as well as
possibly excluding other bits in the repo not needed by end users.
However, this isn't kept under version control, and it would be
helpful it it was.

The above thread contains most of the rationale behind doing this, so
I won't repeat it all here.

The attached make fragment implements a "dist-git" target.  Instead
of releasing by creating a tarball, it injects the same tree onto a
specified git branch and (optionally) signs both the release and
distribution branches.  Branch and tag names and messages are
configurable.  Note this is just an initial proof of concept;
anything can be changed!

I'd like to make this as generally usable for as many people as
possible, so it would be great to hear how you are managing releases
with automake and git, and if this would be useful for you, and if
there's anything that could be added or changed to better accommodate
you.


Many thanks,
Roger

--=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please GPG sign your mail.

--TD8GDToEDw0WLGOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="automake-dist-git.mk"

ENABLE_DIST_GIT=false

GIT_RELEASE_BRANCH=HEAD
GIT_RELEASE_TAG=true
GIT_RELEASE_TAG_SIGN=true
GIT_RELEASE_TAG_NAME=release/$(PACKAGE)-$(VERSION)
GIT_RELEASE_TAG_MESSAGE="Release of $(PACKAGE)-$(VERSION)"

GIT_DIST_BRANCH=distribution
GIT_DIST_COMMIT_MESSAGE="Distribution of $(PACKAGE) version $(VERSION)"
GIT_DIST_TAG=true
GIT_DIST_TAG_SIGN=true
GIT_DIST_TAG_NAME=distribution/$(PACKAGE)-$(VERSION)
GIT_DIST_TAG_MESSAGE="Distribution of $(PACKAGE)-$(VERSION)"

dist-git: distdir
	if [ "$(ENABLE_DIST_GIT)" != "true" ]; then \
	    echo "$@: ENABLE_DIST_GIT not true; not distributing"; \
	  exit 0; \
	fi; \
	cd "$(abs_top_srcdir)"; \
	if [ ! -d .git ]; then \
	    echo "$@: Not a git repository" 1>&2; \
	    exit 1; \
	fi; \
	if [ "$(GIT_RELEASE_TAG)" = "true" ]; then \
          if git show-ref --tags -q $(GIT_RELEASE_TAG_NAME); then \
	    echo "git release tag $(GIT_RELEASE_TAG_NAME) already exists; not distributing" 1>&2; \
	    exit 1; \
	  fi; \
	fi; \
	if [ "$(GIT_DIST_TAG)" = "true" ]; then \
          if git show-ref --tags -q $(GIT_DIST_TAG_NAME); then \
	    echo "git distribution tag $(GIT_DIST_TAG_NAME) already exists; not distributing" 1>&2; \
	    exit 1; \
	  fi; \
	fi; \
	echo "$@: distributing $(PACKAGE)-$(VERSION) on git branch $(GIT_DIST_BRANCH)"; \
	DISTDIR_INDEX="$(abs_top_builddir)/$(distdir).git.idx"; \
	DISTDIR_TREE="$(abs_top_builddir)/$(distdir)"; \
	rm -f "$$DISTDIR_INDEX"; \
	GIT_INDEX_FILE="$$DISTDIR_INDEX" GIT_WORK_TREE="$$DISTDIR_TREE" git add -A || exit 1; \
	GIT_INDEX_FILE="$$DISTDIR_INDEX" TREE="$$(git write-tree)"; \
	rm -f "$$DISTDIR_INDEX"; \
	[ -n "$$TREE" ] || exit 1; \
	RELEASE_HEAD="$$(git show-ref -s $(GIT_RELEASE_BRANCH))"; \
	COMMIT_OPTS="-p $$RELEASE_HEAD"; \
	DIST_PARENT="$$(git show-ref --heads -s refs/heads/$(GIT_DIST_BRANCH))"; \
	if [ -n "$$DIST_PARENT" ]; then \
	  COMMIT_OPTS="$$COMMIT_OPTS -p $$DIST_PARENT"; \
	fi; \
	COMMIT="$$(echo $(GIT_DIST_COMMIT_MESSAGE) | git commit-tree "$$TREE" $$COMMIT_OPTS)"; \
	[ -n "$$COMMIT" ] || exit 1; \
	git update-ref "refs/heads/$(GIT_DIST_BRANCH)" "$$COMMIT" "$$DIST_PARENT" || exit 1;\
	echo "$@: tree=$$TREE"; \
	echo "$@: commit=$$COMMIT"; \
	if [ "$(GIT_RELEASE_TAG)" = "true" ]; then \
	  RELEASE_TAG_OPTS=""; \
	  if [ "$(GIT_RELEASE_TAG_SIGN)" = "true" ]; then \
	    RELEASE_TAG_OPTS="$$TAG_OPTS -s"; \
	  fi; \
	  git tag -m $(GIT_RELEASE_TAG_MESSAGE) $$RELEASE_TAG_OPTS "$(GIT_RELEASE_TAG_NAME)" "$$COMMIT" || exit 1; \
	    echo "$@: release tagged as $(GIT_RELEASE_TAG_NAME)"; \
	fi; \
	if [ "$(GIT_DIST_TAG)" = "true" ]; then \
	  DIST_TAG_OPTS=""; \
	  if [ "$(GIT_DIST_TAG_SIGN)" = "true" ]; then \
	    DIST_TAG_OPTS="$$TAG_OPTS -s"; \
	  fi; \
	  git tag -m $(GIT_DIST_TAG_MESSAGE) $$DIST_TAG_OPTS "$(GIT_DIST_TAG_NAME)" "$$COMMIT" || exit 1; \
	    echo "$@: distribution tagged as $(GIT_DIST_TAG_NAME)"; \
	fi;
	$(am__remove_distdir)

--TD8GDToEDw0WLGOL--

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREDAAYFAkqGxF0ACgkQVcFcaSW/uEgj/QCfaGyVmTyyiJ8rmI+iZ2p9VqJ7
fe0AoNuy05LBd6xgMo2hcK4I2fjeFKCm
=8aj1
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
