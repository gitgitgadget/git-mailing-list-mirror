From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull --no-ff documentation
Date: Sun, 30 Sep 2012 21:42:26 -0700
Message-ID: <7vsj9yerbh.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6ROuyCg9WK79igJ=a=6pwT+7TjOJLCNwe454oW3hiJETg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 06:42:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIXq4-0007nk-DL
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 06:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809Ab2JAEma convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Oct 2012 00:42:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708Ab2JAEma convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Oct 2012 00:42:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2883E8C3B;
	Mon,  1 Oct 2012 00:42:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jixx5mCvOCbA
	Fg3xXh1glYZyzTI=; b=dAxSj897OvpsEP1pbUmCfzzfdnJu1Le3zTlRtUVLg/z7
	hshchgs6CoQPAKqzfBKo7l4PnrY/Se6b8znRZp9j3LaSjYgTgU8wQqtk2cTuDkGy
	ioU7S9gUeeFgf2I6FkSmQnSqmxucgvEy+TRXr8M1glbzsUuTLWsMkIp/XeImo6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cdCfUf
	Kan0gIdv+EdfuO4IzvQlfD8UKxoHImMk4xuGE/FEyn5UjOhGOI+fANvt/jWEmxyS
	KRsUvUvDJdWYBF6VnERE4bIcrZA8FnCy69oxDgRGCRXasevZpek7QSeuV7MXXj8m
	RBS4fpTc8LetxgYt4XSYbngl6qsTHsgosEHR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15D958C3A;
	Mon,  1 Oct 2012 00:42:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 520208C39; Mon,  1 Oct 2012
 00:42:28 -0400 (EDT)
In-Reply-To: <CAHtLG6ROuyCg9WK79igJ=a=6pwT+7TjOJLCNwe454oW3hiJETg@mail.gmail.com>
 (=?utf-8?B?IuS5memFuOmLsCIncw==?= message of "Mon, 1 Oct 2012 11:36:16
 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 676DB6F8-0B82-11E2-AB37-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206711>

=E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:

> The order of options in git pull is not clear in the documentation
> It only says
> git pull [options] [<repository> [<refspec>...]]
> So we have no idea which options should come first
>
> I tried
> git pull -v --no-tags --progress --no-ff origin
> but failed with unknown option 'no-ff'.
>
> But if I ran
> git pull -v --no-ff  --no-tags --progress origin
> it succeeded.

This actually is not about --no-ff but about --no-tags.  Any option
that "pull" itself does not care about stops the command line parser
and the remainder of the command line is fed to underlying "fetch".

Perhaps something like this?  But you should trace the codepath
involved to see if this covers all uses of the --tags before using
it for real projects, as I didn't.

 git-pull.sh | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git i/git-pull.sh w/git-pull.sh
index 2a10047..a53c1e5 100755
--- i/git-pull.sh
+++ w/git-pull.sh
@@ -39,7 +39,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge
=20
 strategy_args=3D diffstat=3D no_commit=3D squash=3D no_ff=3D ff_only=3D
-log_arg=3D verbosity=3D progress=3D recurse_submodules=3D
+log_arg=3D verbosity=3D progress=3D recurse_submodules=3D fetch_tags=3D
 merge_args=3D edit=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D"${curr_branch#refs/heads/}"
@@ -62,6 +62,8 @@ do
 		progress=3D--no-progress ;;
 	-n|--no-stat|--no-summary)
 		diffstat=3D--no-stat ;;
+	-t|--t|--ta|--tag|--tags|--no-tags)
+		fetch_tags=3D"$1" ;;
 	--stat|--summary)
 		diffstat=3D--stat ;;
 	--log|--no-log)
@@ -141,15 +143,12 @@ done
=20
 error_on_no_merge_candidates () {
 	exec >&2
-	for opt
-	do
-		case "$opt" in
-		-t|--t|--ta|--tag|--tags)
-			echo "Fetching tags only, you probably meant:"
-			echo "  git fetch --tags"
-			exit 1
-		esac
-	done
+	case "$fetch_tags" in
+	-t|--t|--ta|--tag|--tags)
+		echo "Fetching tags only, you probably meant:"
+		echo "  git fetch --tags"
+		exit 1
+	esac
=20
 	if test true =3D "$rebase"
 	then
@@ -213,7 +212,7 @@ test true =3D "$rebase" && {
 	done
 }
 orig_head=3D$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run $recurse_submodules --update-h=
ead-ok "$@" || exit 1
+git fetch $verbosity $progress $dry_run $recurse_submodules $fetch_tag=
s --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
=20
 curr_head=3D$(git rev-parse -q --verify HEAD)
