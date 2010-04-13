From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/9] Setup cleanup, chapter one
Date: Mon, 12 Apr 2010 21:11:54 -0500
Message-ID: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:12:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Vbx-0004Fp-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab0DMCL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 22:11:59 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:46034 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0DMCL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:11:58 -0400
Received: by gxk9 with SMTP id 9so3800422gxk.8
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=7yDjw5MORpGKLVwaJA8YVc1c/zEvuvLzOuNS/uHkfEI=;
        b=lj8CRH98l1cVsoyecpbzbHTiptBElmqU2iccufXE9KFnPYTx9iVzMR0Hjuhfm/Ebrg
         lQ370wOAuN/0CbSej7BIIDK3hIAGKwo3TScFFlQdxkfhC4ys3z7OcIWodmtDjdtUHZj/
         yFUAmyGF+ngf5zAgjepj/nZaf3GUxg7t9fo8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=dB98Ev8g+oagQlsdyVtjQHFeUyn2ofPpLHUt/vQnOmJv1NzJMeF41OadilwNccCv+v
         qTtHzHpeVoQNuHYFdkIlMF7gCErwDzgpelrbUArU7bm2EZ+2kA/XGZt8ETvLUet1RJSu
         hvZorTsiYQtPHNqEnhniT8GTHX5jFH2S0UiBs=
Received: by 10.150.188.18 with SMTP id l18mr4867396ybf.166.1271124716972;
        Mon, 12 Apr 2010 19:11:56 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 22sm4487507iwn.4.2010.04.12.19.11.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:11:56 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144778>

These patches are designed to make people who want the pager.<cmd>
configuration to be more reliable a little happier.  More importantly,
they bring the setup procedure closer to doing the Right Thing=E2=84=A2=
=2E

More precisely:

The pager configuration procedure does not always do as much as one
would like:

A. Unless one runs check_pager_config() first, the pager.<cmd>
   configuration is ignored.  The setup procedure does not run
   check_pager_config() for commands that do not use RUN_SETUP.

B. Unless one runs setup_repository_gently() first, functions that
   check configuration expect to find configuration in ./.git/config.
   This is wrong for two reasons: some commands should ignore the
   per-repository configuration, and most commands should be walking
   parent parent directories to find an appropriate .git or foo.git
   dir.  The upshot is that the per-repository configuration is
   ignored for pager.<cmd> and core.pager when git is run from the
   toplevel of a repository.

These patches are a modest attempt to start to ameliorate these
problems.  Patches 1, 2, and 4 introduce new tests to make sure
we are not making things worse.

Patch 3 delays startup of the pager.  By the time we actually need
to start a pager for commands with the RUN_SETUP option, the .git
directory will already have been found, addressing problem (B) for
those commands.

Patches 5 and 6 are something of a trojan horse: they introduce
infrastructure that I expect to be more widely useful after this
modest patch series.  That infrastructure is a collection of global
variables representing the state of the current repository, for
built-in commands only (for now).  The main benefit now is that it
lets us pass more data to builtins without changing the builtin API.

Patches 7 gives builtins the option to search for a repository
early even if they do not require a repository to work.  The benefits
of patch 3 will accrue to such commands just as though they used
RUN_SETUP.  Patch 8 addresses problem (A) for builtins using this new
RUN_SETUP_GENTLY option.

And patch 9 is an example command taking advantage of the opportunity.
I don=E2=80=99t imagine anyone was eagerly awaiting the ability to make=
 their
=E2=80=98git config=E2=80=99 automatically paginate.  The secondary ben=
efits
(especially UI consistency) are in my opinion more important.

This series would not be possible without the hard work of Nguy=E1=BB=85=
n Th=C3=A1i
Ng=E1=BB=8Dc Duy.  It consists mostly of patches by him.  A footnote [1=
] contains
some context if you would like it.

Thoughts?

Jonathan Nieder (4):
  t7006: GIT_DIR/config should be honored in subdirs of toplevel
  t7006: test pager configuration for several git commands
  t7006: test pager.<cmd> configuration
  builtin: check pager.<cmd> configuration if RUN_SETUP_GENTLY is used

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  builtins: do not commit pager choice early
  builtin: introduce startup_info struct
  builtin: remember whether repository was found
  builtin: Support RUN_SETUP_GENTLY to set up repository early if found
  config: run setup before commiting pager choice

 builtin/config.c |    6 +-
 cache.h          |    6 ++
 environment.c    |    1 +
 git.c            |   23 +++++--
 setup.c          |   12 ++++-
 t/t7006-pager.sh |  168 +++++++++++++++++++++++++++++++++++++++++-----=
--------
 6 files changed, 165 insertions(+), 51 deletions(-)

[1] I warned that something like this was coming at
<http://thread.gmane.org/gmane.comp.version-control.git/144090>.

I will send a rebased version of the rest of the nd/setup series to
the list as a follow-up.  But beware: after perhaps introducing all
kinds of bugs through repeated rebasing, I didn=E2=80=99t give the late=
r
patches of the series another glance.
