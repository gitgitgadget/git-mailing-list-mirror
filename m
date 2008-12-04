From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH - DONTUSE] git-am: propagate -C/-p as well
Date: Thu, 04 Dec 2008 15:36:12 -0800
Message-ID: <7vmyfbbjir.fsf_-_@gitster.siamese.dyndns.org>
References: <49382612.3010207@fs.ei.tum.de>
 <7vhc5jeo60.fsf@gitster.siamese.dyndns.org> <49385908.5020202@fs.ei.tum.de>
 <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org>
 <7vy6yvbki6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:37:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8NlJ-0007IT-Gf
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 00:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYLDXgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 18:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbYLDXgT
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 18:36:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbYLDXgT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 18:36:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7D2984A51;
	Thu,  4 Dec 2008 18:36:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0AFA84A50; Thu,
  4 Dec 2008 18:36:14 -0500 (EST)
In-Reply-To: <7vy6yvbki6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 04 Dec 2008 15:14:57 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 59251FC8-C25C-11DD-B75B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102376>

Junio C Hamano <gitster@pobox.com> writes:

> I think this fixes the --whitespace=* one, although I obviously haven't
> tried to use it myself extensively.

This one comes on top of it *if* you want to propagate -C/-p as well, but
I think it might be a wrong idea to propagate these to begin with.

Just like --3way is a one-shot option to deal with a single unapplicable
patch (because it was based on an old version) in the whole series, and is
designed not to get propagated, I suspect that people use -C<n> to fix a
single broken patch and they may expect it not to apply to the whole
series.

The breakage --whitespace deals with is an attribute of the submitter (use
of a broken editor and lack of diligence).  You most often feed a single
series from the same submitter in the same mbox to "git am", preserving
the --whitespace=fix option during the same "am" run makes sense, and
somewhat more importantly, even though the option indeed modifies what you
received, the change the option causes and the risk of breaking the
semantics of the patch is minimum.  I am not sure the breakage --3way
deals with falls into the exactly the same category, but it is similar (if
the first patch in the series was based on an old version, it is very
likely that the subsequent ones are also based on the same old version).
So after all it might be better to propagate --3way as well (which this
patch does not do).

If we decide that propagating --3way is a good thing, then it would be
equally good to propagate -C, -p and --directory options.

I dunno.

 git-am.sh |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git c/git-am.sh w/git-am.sh
index 1bf70d4..a35e07a 100755
--- c/git-am.sh
+++ w/git-am.sh
@@ -121,7 +121,7 @@ It does not apply to blobs recorded in its index."
 
 prec=4
 dotest="$GIT_DIR/rebase-apply"
-sign= utf8=t keep= skip= interactive= resolved= rebasing= abort= ws=
+sign= utf8=t keep= skip= interactive= resolved= rebasing= abort=
 resolvemsg= resume=
 git_apply_opt=
 
@@ -155,9 +155,7 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace)
-		ws="--whitespace=$2"; shift ;;
-	-C|-p)
+	-C|-p|--whitespace)
 		git_apply_opt="$git_apply_opt $1$2"; shift ;;
 	--)
 		shift; break ;;
@@ -247,10 +245,10 @@ else
 		exit 1
 	}
 
-	# -s, -u, -k and --whitespace flags are kept for the
-	# resuming session after a patch failure.
+	# -s, -u, -k, --whitespace, -C and -p flags are kept
+	# for the resuming session after a patch failure.
 	# -3 and -i can and must be given when resuming.
-	echo " $ws" >"$dotest/whitespace"
+	echo " $git_apply_opt" >"$dotest/apply_opt_extra"
 	echo "$sign" >"$dotest/sign"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
@@ -283,7 +281,7 @@ if test "$(cat "$dotest/keep")" = t
 then
 	keep=-k
 fi
-ws=$(cat "$dotest/whitespace")
+apply_opt_extra=$(cat "$dotest/apply_opt_extra")
 if test "$(cat "$dotest/sign")" = t
 then
 	SIGNOFF=`git var GIT_COMMITTER_IDENT | sed -e '
