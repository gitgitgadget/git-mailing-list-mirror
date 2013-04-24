From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH 1/1] templates: pre-push hook: check for missing GPG signatures
 (was: Re: [PATCH] Add .gitconfig variable commit.gpg-sign)
Date: Wed, 24 Apr 2013 19:30:37 +0200
Message-ID: <517816BD.3030203@physik.tu-berlin.de>
References: <5177AB10.30209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: joel@trustly.com, gitster@pobox.com, git@drmicha.warpmail.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 19:30:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV3WT-0000Cp-6f
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 19:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427Ab3DXRaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 13:30:19 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:51337 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab3DXRaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 13:30:17 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1UV3WK-0004zv-B7; Wed, 24 Apr 2013 19:30:16 +0200
Received: from [141.23.96.137] (wlan-141-23-96-137.tubit.tu-berlin.de [141.23.96.137])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id E2BDA11402;
	Wed, 24 Apr 2013 19:30:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130403 Thunderbird/17.0.5
In-Reply-To: <5177AB10.30209@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222275>


On 04/24/2013 11:51 AM, Michael J Gruber wrote:
> Sebastian G=F6tte venit, vidit, dixit 24.04.2013 10:53:
>>                                          What could be nice would be=
 a
>> config option that makes "git push" warn/abort in case I try to push=
 an
>> unsigned head commit to a repo where I want to have signed commits:
>>> remote.<name>.abortUnsigned
>> This of course needs a command line override switch.
>=20
> This appears to be more suited for a server side hook (update), or a =
new
> pre-push hook.
Ok, here it is ;)
I replaced the previous sample hook code because it did only check for =
commits
containing "WIP" in their messages which I think is not terribly useful=
 (and
can easily be added to this script. I also added a missing colon that c=
aused my
shell to complain about an empty if.
This patch applies to the current master as it requires the new GPG %G?=
 pretty
placeholder output.

Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
---
 templates/hooks--pre-push.sample | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-pu=
sh.sample
old mode 100644
new mode 100755
index 15ab6d8..08a72df
--- a/templates/hooks--pre-push.sample
+++ b/templates/hooks--pre-push.sample
@@ -16,20 +16,19 @@
 #
 #   <local ref> <local sha1> <remote ref> <remote sha1>
 #
-# This sample shows how to prevent push of commits where the log messa=
ge starts
-# with "WIP" (work in progress).
+# This sample shows how to prevent pushing commits without good GPG si=
gnatures
=20
 remote=3D"$1"
 url=3D"$2"
=20
 z40=3D0000000000000000000000000000000000000000
+ec=3D0
=20
-IFS=3D' '
 while read local_ref local_sha remote_ref remote_sha
 do
 	if [ "$local_sha" =3D $z40 ]
 	then
-		# Handle delete
+		: # Handle delete
 	else
 		if [ "$remote_sha" =3D $z40 ]
 		then
@@ -40,14 +39,13 @@ do
 			range=3D"$remote_sha..$local_sha"
 		fi
=20
-		# Check for WIP commit
-		commit=3D`git rev-list -n 1 --grep '^WIP' "$range"`
-		if [ -n "$commit" ]
-		then
-			echo "Found WIP commit in $local_ref, not pushing"
-			exit 1
-		fi
+		commits=3D`git log --format=3D"%G? %h" "$range" | grep -v '^G' | cut=
 -d\  -f2`
+		for commit in $commits
+		do
+			echo "Commit $commit does not have a good GPG signature"
+			ec=3D1
+		done
 	fi
 done
=20
-exit 0
+exit $ec
--=20
1.8.2
