From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ''git submodule sync'' should not add uninitialized submodules
 to .git/config
Date: Thu, 23 Jun 2011 15:28:30 -0700
Message-ID: <7vboxo2ne9.fsf@alter.siamese.dyndns.org>
References: <0D2618D7-0681-4E71-B412-36D490D45B9D@gmail.com>
 <7v7h8c4nv3.fsf@alter.siamese.dyndns.org> <4E0390A7.8040505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maarten Billemont <lhunath@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas =?utf-8?Q?K=C3=B6hler?= <andi5.py@gmx.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 24 00:28:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZsO7-0001Jh-U9
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 00:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760045Ab1FWW2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 18:28:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab1FWW2d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 18:28:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16BA864F2;
	Thu, 23 Jun 2011 18:30:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W388Snl9di9gcOQ0NiHlmOPKTDs=; b=S0uvP2
	T93eTkk+qu6XBKsQfMjdeRCyZ4JG+/x89QMc4AUD5yCet3txfU/InNOU3XxAMytf
	tw7dRzfBGuoiKMBbO2yjIKpbScE0Kak2tLJRV9QjGOt3NykZnSxgYIk2VXD37JtP
	vSaRlfl/f/k0KdNzFyQ2Jue3ed+Tzgk8YADVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rbN/HKy0AtXsVZD3p1vYtLWWNTER4cHe
	Zy6ExhyY1JWL6+rbptrrkHUaX1qeev3UV0DLmirPP/UgWz3oKbLIMujLkqYIreBa
	SCElS0mzmU3kMCJSogupzV72blCwpFMbwVysTIyY2YV5vWui/xRQDlY3XpntbFfD
	Eveku5OhbSQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0719F64F1;
	Thu, 23 Jun 2011 18:30:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 18D6464ED; Thu, 23 Jun 2011
 18:30:43 -0400 (EDT)
In-Reply-To: <4E0390A7.8040505@web.de> (Jens Lehmann's message of "Thu, 23
 Jun 2011 21:14:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E63A066-9DE8-11E0-AB77-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176299>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I agree that 33f072f introduced a regression. One could argue if it was
> a good idea to let "git submodule init" not do the clone itself but defer
> it to "git submodule update" by setting the url in .git/config, but that's
> the way things are done now (and maybe there was a very good reason to do
> it that way I'm not aware of, because I didn't follow the list that closely
> back then).

Actually, shouldn't the fix be more like this patch, which is directly on
top of 33f072f?  I think this is more in line with what the end user wants
to tell the system with "submodule init", namely "I am interested in this
submodule".

-- >8 --
Subject: submodule sync: do not auto-vivify uninteresting submodule

Earlier 33f072f (submodule sync: Update "submodule.<name>.url" for empty
directories, 2010-10-08) attempted to fix a bug where "git submodule sync"
command does not update the URL if the current superproject does not have
a checkout of the submodule.

However, it did so by unconditionally registering submodule.$name.url to
every submodule in the project, even the ones that the user has never
showed interest in at all by running 'git submodule init' command. This
caused subsequent 'git submodule update' to start cloning/updating submodules
that are not interesting to the user at all.

Update the code so that the URL is updated from the .gitmodules file only
for submodules that already have submodule.$name.url entries, i.e. the
ones the user has showed interested in having a checkout.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-submodule.sh          |   23 +++++++++++++----------
 t/t7403-submodule-sync.sh |   13 +++++++++++--
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c291eed..ce65971 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -836,17 +836,20 @@ cmd_sync()
 			;;
 		esac
 
-		say "Synchronizing submodule url for '$name'"
-		git config submodule."$name".url "$url"
-
-		if test -e "$path"/.git
+		if git config "submodule.$name.url" >/dev/null 2>/dev/null
 		then
-		(
-			clear_local_git_env
-			cd "$path"
-			remote=$(get_default_remote)
-			git config remote."$remote".url "$url"
-		)
+			say "Synchronizing submodule url for '$name'"
+			git config submodule."$name".url "$url"
+
+			if test -e "$path"/.git
+			then
+			(
+				clear_local_git_env
+				cd "$path"
+				remote=$(get_default_remote)
+				git config remote."$remote".url "$url"
+			)
+			fi
 		fi
 	done
 }
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index e5b1953..597a06f 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -25,7 +25,8 @@ test_expect_success setup '
 	git clone super super-clone &&
 	(cd super-clone && git submodule update --init) &&
 	git clone super empty-clone &&
-	(cd empty-clone && git submodule init)
+	(cd empty-clone && git submodule init) &&
+	git clone super top-only-clone
 '
 
 test_expect_success 'change submodule' '
@@ -66,7 +67,7 @@ test_expect_success '"git submodule sync" should update submodule URLs' '
 	)
 '
 
-test_expect_success '"git submodule sync" should update submodule URLs if not yet cloned' '
+test_expect_success '"git submodule sync" should update known submodule URLs' '
 	(cd empty-clone &&
 	 git pull &&
 	 git submodule sync &&
@@ -74,4 +75,12 @@ test_expect_success '"git submodule sync" should update submodule URLs if not ye
 	)
 '
 
+test_expect_success '"git submodule sync" should not vivify uninteresting submodule' '
+	(cd top-only-clone &&
+	 git pull &&
+	 git submodule sync &&
+	 test -z "$(git config submodule.submodule.url)"
+	)
+'
+
 test_done
