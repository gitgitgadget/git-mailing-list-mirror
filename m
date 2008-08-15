From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [RFC PATCH 0/9] Narrow/Sparse checkout round 3: "easy mode"
Date: Fri, 15 Aug 2008 21:24:39 +0700
Message-ID: <20080815142439.GA10609@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:25:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0Fa-0004mF-HL
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbYHOOYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbYHOOYz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:24:55 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:39736 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbYHOOYy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:24:54 -0400
Received: by wa-out-1112.google.com with SMTP id j37so532062waf.23
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=zB39cwImy1I/MVKjCJh4BqKOrP9DJ8x1u21VaqttkaI=;
        b=Q+yGJ091N1Ks7U0wXQEc5Ead3tE6PlR5Pu0yfuPpiGc8CiYHthoCIhwXoQdPk6XgtR
         DUmO5oZP6DwLoyzSEMR3wu4Q6Z8d2zlcq/2sUVtNgL54r0a+QkytL6HMU891Cezys6qK
         E69WOK2A6svjYh0kCS9Tmx0y2ecEkC+9VTVSc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=ahnuNFNJMnzRFpKJH0XdgaJo/d068p5gzj8775AsHbZgTB89wVMkZ91PTkFuF/vM82
         aHbdYQoA/74A79TI03j+KCwDTwrpq/bfHT+4kHlaVrOnhA9DO6izt8q1ALAxJOrZZW4Z
         /l9v1gcbeUCyWKnVG1dtFoZFgnXqwhnZEXNAo=
Received: by 10.115.90.1 with SMTP id s1mr2545520wal.214.1218810293544;
        Fri, 15 Aug 2008 07:24:53 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id q20sm52541pog.7.2008.08.15.07.24.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:24:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:24:39 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92473>

The implementation with insights from Junio turns out smaller and bette=
r
(and I was thinking about applying it for huge maildir).

So there is a bit of changes since the last round. This time I follow
"assume unchanged" code path and relax the rules a bit. There are issue=
s
I will mention later.

=46rom user POV, we can now checkout a single file or a subdirectory (c=
hecking
out subdirectory non-recursively is possible too). You may start with a=
 narrow
clone like:

git clone --path=3D"Documentation/*" git.git

or start from a full checkout and narrow it (very much like the last ro=
und):

git checkout --path=3D"Documentation/*"

However narrow spec is now using wildcards, not prefix, so you can chec=
kout
a single file, or just header files, etc.

git checkout --add-path|--remove-path has been aded to update narrow ar=
eas.
But you don't have to use those. Narrow areas will be widened as needed=
 when
you do something outside of it (e.g "git checkout foo" or "git add foo"=
=2E..)

Another difference from the last round is "narrow rules" will not be pr=
eserved
when switching branches. When you switch branch with no option, you wil=
l get
full checkout. You may want to use --path|--add-path|--remove-path when
switching branches to have narrow checkout again.

Now back to technical POV. I did not reuse CE_VALID (assume unchanged) =
bit
because it has been used for core.ignorestat. So I took another bit, wh=
ich
seems to be the last on-disk bit in ce_flags.

I call this mode "easy mode" because most of constraints have been elim=
inated.
Now your "narrow rules" are like "I don't like those files, remove them=
 if
they are not needed". If some operations
need those files on workdir again, they will be checked out. Those may =
include:

 - "git checkout foo" or "git apply"
 - git add foo (even if foo is marked no-checkout)
 - conflict files after merge
 - new files after merge

"Strict mode" may be added later but then it must clearly define which
operation is allowed to checkout files. There's a problem with strict m=
ode if
it wants to limit checking out new files after merge. Because we don't =
save
"narrow rules" anymore (we applied the rules immediately in checkout/cl=
one
stage, then update narrow areas over time), we will not know how to dea=
l with
new files. Adding [--path|--add-path|--remove-path] to git merge comman=
ds, and
apply "narrow rules" again, looks too cumbersome to me. Comments?

Last bit. "Narrow rules" for --path|--add-path|--remove-path is current=
ly
wildcards separated by colons. While it does the job, it does not allow=
 to
checkout easily a subdirectory non-recusively. I was thinking about '*'=
 as
"match everything except slashes" and '**' as "match everything even sl=
ashes".
Any ideas?

Oh.. and "git grep" may not work correctly (or "as expected") with narr=
ow
checkout. Haven't checked it yet.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  Introduce CE_NO_CHECKOUT bit
  update-index: add --checkout/--no-checkout options to update
    CE_NO_CHECKOUT bit
  ls-files: add --checkout option to show checked out files
  Prevent diff machinery from examining worktree outside narrow
    checkout
  Clear CE_NO_CHECKOUT on checked out entries.
  Add support for narrow checkout in unpack_trees()
  ls-files: add --narrow-match=3Dspec option to test narrow matching
  clone: support narrow checkout with --path option
  checkout: add new options to support narrow checkout

 builtin-checkout.c     |   41 ++++++++++++++++++
 builtin-clone.c        |   13 ++++++
 builtin-ls-files.c     |   23 +++++++++--
 builtin-update-index.c |   40 +++++++++++-------
 cache.h                |   11 +++++
 diff-lib.c             |    5 +-
 diff.c                 |    4 +-
 entry.c                |    1 +
 read-cache.c           |    6 +-
 unpack-trees.c         |  106 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 unpack-trees.h         |    4 ++
 11 files changed, 229 insertions(+), 25 deletions(-)
