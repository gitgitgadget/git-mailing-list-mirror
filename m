From: Junio C Hamano <gitster@pobox.com>
Subject: Merging "merge-in-c" to next.
Date: Wed, 09 Jul 2008 14:20:10 -0700
Message-ID: <7vej627o1h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGh6I-00082y-HQ
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbYGIVUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYGIVUY
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:20:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbYGIVUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:20:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AAB381A9F1;
	Wed,  9 Jul 2008 17:20:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 860ED1A9F0; Wed,  9 Jul 2008 17:20:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D5E891EA-4DFC-11DD-9793-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87914>

I am preparing to merge the 'merge-in-c' topic from Miklos to 'next'.  The
topic introduces builtin-merge.c to rewrite git-merge.sh script in C.

One interesting aspect of this merge is that 'next' has an enhanced
git-merge that can pass extra options that git-merge itself does not have
to understand to the strategy backends, when the user gives -X<option> to
it.  This is analogous to how gcc uses -Wl,* option to pass options to the
linker.  This new feature comes from a separate merge-theirs topic
developed independently.  Naturally, merge-in-c does not know about it.

The approach I am taking with this integration is to first fork a new
branch (a mini-integration branch) 'xx/merge-in-c-into-next' from
'mv/merge-in-c', and then:

 - Merge 'ph/parseopt-step-blame' topic to it;

 - Convert the use of parse_options() in 'git-merge' to use "incremental
   parsing" that is introduced by the 'ph/parseopt-step-blame' topic;

 - Merge 'jc/merge-theirs' topic, marking "git merge -Xtheirs" feature is
   temporarily broken in the test suite;

 - Add support for -X<option>;

 - And finally merge the whole thing to 'next'.

The idea is that:

 * This would hopefully not break 'next', obviously;

 * If either one of merge-theirs or merge-in-c (but not both) matures
   early and needs to graduate to master, it can do so; this fact is
   indepent from today's merge;

 * After one of these interacting topics graduates to 'master', merging
   the other one to 'master' will need to resolve the same semantic
   conflict as I am resolving today.  Merging this mini-integration topic
   to 'master' instead of mergint the other one would be straightforward
   and much less error prone.

This approach takes the aggregation hostage to ph/parseopt-step-blame; in
order to merge both merge-in-c and merge-theirs to master, we must merge
the incremental option parser to master as well.  But I think that is not
a problem -- the parseopt change in question is something we would want to
have in 'master' fairly soon.

The commit log messages for merge commits in this series are actually
interesting.  Output of "git log --reverse --stat --first-parent" is
attached at the end.


commit 1c7b76be7d620bbaf2e6b8417f04012326bbb9df
Author: Miklos Vajna <vmiklos@frugalware.org>
Date:   Mon Jul 7 19:24:20 2008 +0200

    Build in merge
    
    Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 Makefile                      |    2 +-
 builtin-merge.c               | 1153 +++++++++++++++++++++++++++++++++++++++++
 builtin.h                     |    1 +
 contrib/examples/git-merge.sh |  554 ++++++++++++++++++++
 git-merge.sh                  |  554 --------------------
 git.c                         |    1 +
 t/t7602-merge-octopus-many.sh |    2 +-
 7 files changed, 1711 insertions(+), 556 deletions(-)

commit ff0d8a01410d1d2363dec660fc87b99905691d57
Merge: 1c7b76b... 3f8d520...
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jul 9 11:11:48 2008 -0700

    Merge branch 'ph/parseopt-step-blame' into xx/merge-in-c-into-next
    
    The purpose of this branch is to resolve interactions with the merge-in-c
    and the merge-theirs topics before merging the former into 'next'.  Use of
    parse_options_step() would be a good way to support -X<option> where
    git-merge needs to passes it through to the strategy modules without
    having to understand what <option> is.
    
    This will be needed when merge-in-c is merged to 'next', which already has
    the merge-theirs topic.  We do not merge this mini-integration branch to
    'master' if we later decide to drop merge-theirs, or merge merge-in-c
    first to 'master',  If we are to merge both to 'master', then merging this
    branch would suffice.

commit ffa6e85e1cfca7ce3f41f5bfd420b94a26aa57bf
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jul 9 12:58:22 2008 -0700

    builtin-merge.c: use parse_options_step() "incremental parsing" machinery
    
    This prepares the option parser for "git-merge" to use the incremental
    parsing machinery, so that we can add support for -X<options> passthru
    that is hard to parse with the stop parse_options() machinery.
    
    This is just a conversion; it does not add any new options nor features
    yet.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 builtin-merge.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 40 insertions(+), 5 deletions(-)

commit fd6fd913327812ecce7d638846b88908b350b904
Merge: ffa6e85... 7eda236...
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jul 9 13:00:24 2008 -0700

    Merge branch 'jc/merge-theirs' into xx/merge-in-c-into-next
    
    This is an evil merge that tentatively marks that the "git merge -Xtheirs"
    is broken in the testsuite, because "git merge" reimplementation in C does
    not know about it yet.
    
    * jc/merge-theirs:
      Make "subtree" part more orthogonal to the rest of merge-recursive.
      Teach git-pull to pass -X<option> to git-merge
      Teach git-merge to pass -X<option> to the backend strategy module
      git-merge-recursive-{ours,theirs}
      git-merge-file --ours, --theirs

commit aa85524eacdfa9fa84727dd700265f3a70b8fd01
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Jul 9 13:51:46 2008 -0700

    Teach git-merge -X<option> again.
    
    This fixes the tentative regression of git-merge rewritten in C by
    teaching it to pass -X<option> to the strategy backends.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

 builtin-merge.c              |   55 ++++++++++++++++++++++++++++++-----------
 t/t6034-merge-ours-theirs.sh |    4 +-
 2 files changed, 42 insertions(+), 17 deletions(-)
