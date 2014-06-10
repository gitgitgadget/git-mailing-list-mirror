From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule.sh: avoid "test <cond> -a/-o <cond>"
Date: Tue, 10 Jun 2014 08:32:57 -0700
Message-ID: <xmqqy4x4aifq.fsf@gitster.dls.corp.google.com>
References: <1402403313-22468-1-git-send-email-gitter.spiros@gmail.com>
	<53971BBE.8030108@web.de>
	<xmqq38fcbxf8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, jrnieder@gmail.com
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:33:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuO2w-0003Ty-7x
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 17:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbaFJPdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 11:33:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64140 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbaFJPdE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2014 11:33:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7A20C1D1A9;
	Tue, 10 Jun 2014 11:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3Y+adeoYzuHI
	zcu/17TvF50dX5Y=; b=lwR5iSmkHMnVKomHZUGdn/vXlXRXYf6JHKxDi2P4U1X3
	Oq2/tCXzy5x47QkN+4mQju49qTAeOd7tWNkGPA9Xu4jEtcP2m/oxzaW2uZjA+0p+
	8/J+mLCfuod4RvYfHQpHxNhahWDFZCM8I3PypEyJeH71qocsrC3+7medv59fcIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZPFjgX
	OhaBhOk5EMARccrJ7JUOD9HAmjI5EEN76YOuBK99ieGx5zCvePh03bN8yFxlerJa
	4iBziXQ1mXhmbA1bGfSXZaXoFQ815HzP9iv9R2DbpAcYutXGw/DBtQys4BGNn8c5
	/kH8y6D+oHwTSC/aBJj+gmIsR1iTjPnoMWzzM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F9451D1A7;
	Tue, 10 Jun 2014 11:33:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC9ED1D1A0;
	Tue, 10 Jun 2014 11:32:58 -0400 (EDT)
In-Reply-To: <xmqq38fcbxf8.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 10 Jun 2014 08:23:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8056797A-F0B4-11E3-93EE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251199>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> On 2014-06-10 14.28, Elia Pinto wrote:
>> []
>>>  		# before the first commit: compare with an empty tree
>>>  		head=3D$(git hash-object -w -t tree --stdin </dev/null)
>>> @@ -1056,13 +1056,17 @@ cmd_summary() {
>>>  		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>>>  		do
>>>  			# Always show modules deleted or type-changed (blob<->module)
>>> -			test $status =3D D -o $status =3D T && echo "$sm_path" && conti=
nue
>>> +			case "$status" in
>>> +			([DT])
>> Does this look strange? ^
>> Should it be
>> case "$status" in
>> D|T)
>
> Actually POSIX allows matching parentheses for case arm labels
> (surprise!).
>
> And some shells misparse
>
> 	var=3D$( ... case arm) action ;; esac ... )
>
> as if the ')' after the arm label closes the whole command
> substitution.
>
> Having said that, I'd prefer to see the following squashed into that
> patch.
> ...
> I would also have preferred to see the echo to printf substitution
> left out of this patch.  There are other places where $sm_path is
> echoed and fixing only one of them in an otherwise unrelated patch
> feels wrong---it should be a separate follow-up patch, I would
> think.

=2E.. which may look like this (after removing s/echo/printf/ in that
hunk from this "test -a/-o" patch).

 git-submodule.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d0d9b58..9245abf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -235,7 +235,7 @@ module_name()
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
 	test -z "$name" &&
 	die "$(eval_gettext "No submodule mapping found in .gitmodules for pa=
th '\$sm_path'")"
-	echo "$name"
+	printf '%s\n' "$name"
 }
=20
 #
@@ -305,10 +305,10 @@ module_clone()
 	b=3D${b%/}
=20
 	# Turn each leading "*/" component into "../"
-	rel=3D$(echo $b | sed -e 's|[^/][^/]*|..|g')
-	echo "gitdir: $rel/$a" >"$sm_path/.git"
+	rel=3D$(printf '%s\n' "$b" | sed -e 's|[^/][^/]*|..|g')
+	printf '%s\n' "gitdir: $rel/$a" >"$sm_path/.git"
=20
-	rel=3D$(echo $a | sed -e 's|[^/][^/]*|..|g')
+	rel=3D$(printf '%s\n' "$a" | sed -e 's|[^/][^/]*|..|g')
 	(clear_local_git_env; cd "$sm_path" && GIT_WORK_TREE=3D. git config c=
ore.worktree "$rel/$b")
 }
=20
@@ -389,7 +389,7 @@ cmd_add()
 	sm_path=3D$2
=20
 	if test -z "$sm_path"; then
-		sm_path=3D$(echo "$repo" |
+		sm_path=3D$(printf '%s\n' "$repo" |
 			sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 	fi
=20
@@ -1058,7 +1058,7 @@ cmd_summary() {
 			# Always show modules deleted or type-changed (blob<->module)
 			if test "$status" =3D D || test "$status" =3D T
 			then
-				echo "$sm_path"
+				printf '%s\n' "$sm_path"
 				continue
 			fi
 			# Respect the ignore setting for --for-status.
@@ -1070,7 +1070,7 @@ cmd_summary() {
 			fi
 			# Also show added or modified modules which are checked out
 			GIT_DIR=3D"$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &=
&
-			echo "$sm_path"
+			printf '%s\n' "$sm_path"
 		done
 	)
=20
@@ -1311,7 +1311,7 @@ cmd_sync()
 		./*|../*)
 			# rewrite foo/bar as ../.. to find path from
 			# submodule work tree to superproject work tree
-			up_path=3D"$(echo "$sm_path" | sed "s/[^/][^/]*/../g")" &&
+			up_path=3D"$(printf '%s\n' "$sm_path" | sed "s/[^/][^/]*/../g")" &&
 			# guarantee a trailing /
 			up_path=3D${up_path%/}/ &&
 			# path from submodule work tree to submodule origin repo
