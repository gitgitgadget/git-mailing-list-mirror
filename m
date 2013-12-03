From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] submodule: do not copy unknown update mode from .gitmodules
Date: Tue, 03 Dec 2013 13:48:54 -0800
Message-ID: <xmqqwqjlli18.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 22:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnxsx-0006FJ-3o
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 22:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab3LCVvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 16:51:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143Ab3LCVvw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 16:51:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7471256EA3;
	Tue,  3 Dec 2013 16:51:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=W
	TT0Y4aNf2K+OzIq93g6PDL+BVg=; b=lS7cWJiszJZ9FQtv6VxBRiQje1h5XWLiw
	Foe82lKFkm7JwQrZkh4v158Q+ZZ/pgkYVsN50DWAI8u+y97/7edeUEqFQPnFvMGv
	SiGWc5RO6YZUiVD7LzsRRrAkjpuHhV3aIHJdQqf1Wle6XRbaLor6BaX5c2xGJUFd
	FfC2ciGbwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Vn9
	T3R+nmpQa1oNZlmSOcjwrVmup/awD9sjPCDaTt3iXxYbtHzh7CZHxL1SFWQuhMqL
	Q6tQ9bBz0niMfryh0Bj49YLfC9ZYGE+oOQvvR4WhwENkfc2e0tWNhwqaj5cMCe/S
	dSqD/BFgwlUjfLYcwQgOlq8Mt+xOPiQ2uWkZH6zk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D8DB56E9F;
	Tue,  3 Dec 2013 16:51:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1763D56E9D;
	Tue,  3 Dec 2013 16:51:49 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1C83F816-5C65-11E3-98F3-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238740>

When submodule.$name.update is given as hint from the upstream in
the .gitmodules file, we used to blindly copy it to .git/config,
unless there already is a value defined for the submodule.

However, there is no reason to expect that the update mode hinted by
the upstream is available in the version of Git the user is using,
and a really custom "!cmd" prepared by an upstream person running on
Linux may not even be available to a user on Windows.  It is simply
irresponsible to copy the setting blindly and to attempt to use it
during a later "submodule update" without validating it first.

Just show the suggested value to the diagnostic output, and set the
value to 'none' in the configuration, if it is not one of the ones
that are known to be supported by this version of Git.

Helped-by: Jens Lehmann <Jens.Lehmann@web.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh            | 20 +++++++++++++++-----
 t/t7406-submodule-update.sh | 15 +++++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..83917d8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -612,11 +612,21 @@ cmd_init()
 		fi
 
 		# Copy "update" setting when it is not set yet
-		upd="$(git config -f .gitmodules submodule."$name".update)"
-		test -z "$upd" ||
-		test -n "$(git config submodule."$name".update)" ||
-		git config submodule."$name".update "$upd" ||
-		die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
+		if upd="$(git config -f .gitmodules submodule."$name".update)" &&
+		   test -n "$upd" &&
+		   test -z "$(git config submodule."$name".update)"
+		then
+			case "$upd" in
+			rebase | merge | none)
+				;; # known modes of updating
+			*)
+				echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
+				upd=none
+				;;
+			esac
+			git config submodule."$name".update "$upd" ||
+			die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
+		fi
 	done
 }
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f0b3305..0825a92 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -323,6 +323,21 @@ test_expect_success 'submodule update - command in .git/config catches failure'
 	)
 '
 
+test_expect_success 'submodule init does not copy command into .git/config' '
+	(cd super &&
+	 H=$(git ls-files -s submodule | cut -d" " -f2) &&
+	 mkdir submodule1 &&
+	 git update-index --add --cacheinfo 160000 $H submodule1 &&
+	 git config -f .gitmodules submodule.submodule1.path submodule1 &&
+	 git config -f .gitmodules submodule.submodule1.url ../submodule &&
+	 git config -f .gitmodules submodule.submodule1.update !false &&
+	 git submodule init submodule1 &&
+	 echo "none" >expect &&
+	 git config submodule.submodule1.update >actual &&
+	 test_cmp expect actual
+	)
+'
+
 test_expect_success 'submodule init picks up rebase' '
 	(cd super &&
 	 git config -f .gitmodules submodule.rebasing.update rebase &&
-- 
1.8.5.1-400-gbc1da41
