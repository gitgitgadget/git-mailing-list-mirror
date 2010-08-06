From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/paginate-fix 0/12] Re: git --paginate: do not commit
 pager choice too early
Date: Thu, 5 Aug 2010 21:35:29 -0500
Message-ID: <20100806023529.GB22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 04:37:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhCo3-0006Ow-30
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 04:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935260Ab0HFChG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 22:37:06 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64797 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390Ab0HFChC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 22:37:02 -0400
Received: by gwb20 with SMTP id 20so2668718gwb.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 19:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f0dnnFzlD3EoErFHr0Uh3LHh8yO5moRjXZoxgOYa4YQ=;
        b=xQhYfQn/Y8T5nW50rftmH2kKNyT6yT2tQUwBOyRrDi6R2J9JXJ4DOQnpYnHu6FWuXy
         j2wzATzHwnYQsKFidvZmowTMDJPtX8Mb+xDDYdlNpOtTUmw/6MJB9NWZNdvlJ90R1WSd
         1irv3yfHgzo17IsFrbZHEXyRo56ObtX+uDzn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ZIiYo3ub7+QxPA4RytN1/8yfIsCICMm5gMc1isvdCYWbl9OQlqmsJ4kP4jrIrdyKMt
         QKULySANo89c8ST5/Tc/2DGaRzD1svVxtlf622VhneEDdQMGacWvT1tqdadcDx6MbZAR
         /N9jOoNbN5Ux5YPNkUDazPiyXGwCovxSs/y2k=
Received: by 10.150.203.3 with SMTP id a3mr3690565ybg.355.1281062220697;
        Thu, 05 Aug 2010 19:37:00 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id w3sm899256ybl.9.2010.08.05.19.36.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 19:36:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v630hyf5r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152745>

Junio C Hamano wrote:

>     So delay the pager startup when possible:
>    =20
>     1. run_argv() already commits pager choice inside run_builtin() i=
f a
>        command is found.  For commands that use RUN_SETUP, waiting un=
til
>        then fixes the problem described above: once git knows where t=
o
>        look, it happily respects the core.pager setting.
>=20
> ... and for commands that do not use RUN_SETUP, what happens?

Let=E2=80=99s help some of them out a little.

These patches teach a few more built-ins to do something like
RUN_SETUP; more precisely, a RUN_SETUP_GENTLY facility is introduced
to run setup_git_directory_gently() early just like NEEDS_PREFIX has
always caused setup_git_directory() to be run early.

This series wouldn=E2=80=99t be possible without Duy=E2=80=99s recent e=
fforts to roll
out other fixes from the famous nd/setup topic --- thanks!
The patches should be familiar[1] and I think they are better
justified now.

The first 8 patches apply on top to jn/paginate-fix from pu.  Between
patch 8 and 9 I have a merge of jn/maint-setup-fix^, with the
following explanation:

	Merge branch 'jn/maint-setup-fix' (early part) into jn/paginate-fix

	That topic includes a fix for =E2=80=9Cgit index-pack=E2=80=9D (which =
used
	to save the cwd before the repository search to work around
	a bug) which is needed before the repository search can be
	safely run earlier.

That merge involves a trivial conflict between adding the
RUN_SETUP_GENTLY flag for this topic and removing USE_PAGER for
grep -O.  The conflict is only nominal --- the two changes do not
interfere with each other.

One final note: this series is deliberately very conservative, in that
it does not touch commands like diff (which has a --no-index mode
suppressing the repository search).  Such commands are neither
helped nor hindered by this series, and I think that during this
transition time we should be opportunistic rather than rigid: the rule
is to run the repository search as soon as can be easily justified but
no sooner.

Thoughts welcome, as always.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  git wrapper: introduce startup_info struct
  setup: remember whether repository was found
  git wrapper: allow setup_git_directory_gently() be called earlier
  shortlog: run setup_git_directory_gently() sooner
  grep: run setup_git_directory_gently() sooner
  apply: run setup_git_directory_gently() sooner
  bundle: run setup_git_directory_gently() sooner
  config: run setup_git_directory_gently() sooner
  index-pack: run setup_git_directory_gently() sooner
  ls-remote: run setup_git_directory_gently() sooner
  var: run setup_git_directory_gently() sooner
  merge-file: run setup_git_directory_gently() sooner

[1] http://thread.gmane.org/gmane.comp.version-control.git/144000/focus=
=3D144110
