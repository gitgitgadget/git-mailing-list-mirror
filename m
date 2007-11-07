From: Pierre Habouzit <madcoder@debian.org>
Subject: Preliminary patches to the diff.[hc] parseoptification
Date: Wed,  7 Nov 2007 11:20:25 +0100
Message-ID: <1194430832-6224-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:21:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi2W-0001LP-TW
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbXKGKUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:44 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbXKGKUn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:43 -0500
Received: from pan.madism.org ([88.191.52.104]:35298 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbXKGKUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:35 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id F192323F6D;
	Wed,  7 Nov 2007 11:20:33 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id F2F2FF9B5; Wed,  7 Nov 2007 11:20:32 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63797>

I'm currently working on the very involved task of migrating diff
options to parseopts. It's quite involved because for many reasons I
won't detail here, it needs to migrate those _and_ revisions options at
the same time (most of the diff options users _also_ use the revisions
ones).

So I'm trying to see some preliminary patches that I need to make this
the less disruptive possible: my goal is that people can use those
preliminary series bit by bit, and not a whole 10 to 20 patches (I
believe it will really take this amount in the end) at once with
breakages hard to find in the mess.

So in the coming days I'll probably send my work bit by bit when I feel
it won't change anymore.


Summary:
~~~~~~~

The 3 series are completely independent.

  + this is a patch to fix an issue that begin to irritate me and
    prevents me to build with -Werror.

    [1/1] Make gcc warning about empty if body go away.

  + this series add new features that are needed for the diff options.
    commit 1 implements them (see commit log,
    commits 2 to 4 use them in some commands that benefit from those.

    [1/4] parse-options new features.
    [2/4] Use OPT_SET_INT and OPT_BIT in builtin-branch
    [3/4] Use OPT_BIT in builtin-for-each-ref
    [4/4] Use OPT_BIT in builtin-pack-refs

  + this series does some modifications on the diff_options structure
    and the diff_opt_parse functions. Those are not fundamentally neede=
d
    without parseopt, but parseopt will need them.

    Basically, diff_options had bitfields (the C :1 kind). parseopt can=
not
    grok that portably, so I've converted these into a single
    `unsigned flags` with explicit masks to use (and helper macros to
    avoid overlong lines).

    The obvious goal is that I can use the OPTION_BIT feature from the
    previous series to fill them from parse_options.

    [1/2] Make the diff_options bitfields be an unsigned with explicit =
masks.
    [2/2] Reorder diff_opt_parse options more logically per topics.

Those patches are available on my public repository in the
ph/parseopt-stable branch.

ph/parseopt is my WIP and has many many horrible commits right now, tha=
t
I rebase -i to cleanse them once the big picture pleases me enough,
though people may want to look at diff.h in that branch to see where it
goes. I'm pleased to say that it seems I'll only need 3 diff-specific
callbacks, which is not a lot:

    http://git.madism.org/?p=3Dgit.git;a=3Dblobdiff;f=3Ddiff.h;h=3D0e44=
e5;hp=3D6ff2b0;hb=3Ddef4eb;hpb=3Dbdc1ab

I suppose that the split of this big macro is explanatory enough for th=
e
reason behind commit 2/2 of the third series...


Diff stats:
~~~~~~~~~~

  + gcc issue:
     builtin-diff.c |    2 +-
     1 file changed, 1 insertion(+), 1 deletion(-)

  + parseopt features:
     builtin-branch.c       |   44 ++++++++++++-----------------------
     builtin-for-each-ref.c |   19 ++++++++-------
     builtin-pack-refs.c    |   12 ++-------
     git-compat-util.h      |    1=20
     parse-options.c        |   61 +++++++++++++++++++++++++++++++++++-=
-------------
     parse-options.h        |   15 +++++++++++-
     6 files changed, 88 insertions(+), 64 deletions(-)

  + diff-cleanup:
     builtin-blame.c      |   10 +-
     builtin-diff-files.c |    4 +-
     builtin-diff-index.c |    4 +-
     builtin-diff-tree.c  |    9 +-
     builtin-diff.c       |   12 ++--
     builtin-log.c        |   24 +++---
     combine-diff.c       |   10 +-
     diff-lib.c           |   23 +++---
     diff.c               |  221 ++++++++++++++++++++++++++------------=
------------
     diff.h               |   40 ++++++----
     log-tree.c           |    6 +-
     merge-recursive.c    |    2 +-
     patch-ids.c          |    2 +-
     revision.c           |   22 +++---
     tree-diff.c          |   14 ++--
     15 files changed, 209 insertions(+), 194 deletions(-)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
