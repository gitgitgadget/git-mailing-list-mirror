From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] git submodule -b ... of current HEAD fails
Date: Thu, 09 Dec 2010 00:19:46 +0100
Message-ID: <4D001292.3020503@web.de>
References: <20101201171814.GC6439@ikki.ethgen.de> <20101201185046.GB27024@burratino> <4CF80B71.3010309@web.de> <7vipz5nqd0.fsf@alter.siamese.dyndns.org> <4CFFFA05.6070609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Klaus Ethgen <Klaus@Ethgen.de>,
	Sven Verdoolaege <skimo@kotnet.org>, mlevedahl@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 00:21:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQTJz-0000NK-FO
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 00:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141Ab0LHXVE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 18:21:04 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56585 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab0LHXVD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 18:21:03 -0500
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 961DB1812468D;
	Thu,  9 Dec 2010 00:19:46 +0100 (CET)
Received: from [93.246.38.49] (helo=[192.168.178.51])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PQTIY-0003ET-00; Thu, 09 Dec 2010 00:19:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <4CFFFA05.6070609@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/BHyYUAKM0xBrom/4VQK2wjD2Jdxp8EYjp3fLJ
	oD5DrtlmAUsKaL6CRKXzc7X2oH/84bOwlR3RstlR9LRainMVfd
	fWhnferrVahS3YqV3KsA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163242>

	git submodule add -b $branch $repository

fails when HEAD already points to $branch in $repository.

When the freshly cloned submodules HEAD is the same as the checked out
branch, it doesn't make sense to update it again as "git checkout -b"
would fail with =BBfatal: git checkout: branch $branch already exists=AB=
=2E

Reported-by: Klaus Ethgen <Klaus@Ethgen.de>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 08.12.2010 22:35, schrieb Jens Lehmann:
> Am 07.12.2010 23:57, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>> Nope, these lines date back to the time before I got involved in th=
e
>>> submodule business ... Seems like this "git checkout" was added in
>>> March 2008 by Mark Levedahl (CCed), maybe he can shed some light on
>>> that.
>>>
>>> But to me your change looks good, so feel free to add:
>>> Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
>>
>> Does either of you want to add a test for this?
>=20
> Will do.

And as it happens from time to time, while writing the test you find
out that the first attempt to fix the bug didn't work as expected ...

 git-submodule.sh           |    4 +++-
 t/t7400-submodule-basic.sh |    7 +++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 33bc41f..bf2803f 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -241,7 +241,9 @@ cmd_add()
 			# ash fails to wordsplit ${branch:+-b "$branch"...}
 			case "$branch" in
 			'') git checkout -f -q ;;
-			?*) git checkout -f -q -b "$branch" "origin/$branch" ;;
+			?*) if [ "$(git branch)" !=3D "* $branch"  ]; then
+				git checkout -f -q -b "$branch" "origin/$branch"
+			fi ;;
 			esac
 		) || die "Unable to checkout submodule '$path'"
 	fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 782b0a3..e224da4 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -131,6 +131,13 @@ test_expect_success 'submodule add --branch' '
 	test_cmp empty untracked
 '

+test_expect_success 'submodule add --branch succeeds even when branch =
is at HEAD' '
+	(
+		cd addtest &&
+		git submodule add -b master "$submodurl" submod-existing-branch
+	)
+'
+
 test_expect_success 'submodule add with ./ in path' '
 	echo "refs/heads/master" >expect &&
 	>empty &&
--=20
1.7.3.3.580.ged75d
