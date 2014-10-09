From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] completion: ignore chpwd_functions when cding on zsh
Date: Thu, 09 Oct 2014 15:11:54 -0700
Message-ID: <xmqqbnpk6ggl.fsf@gitster.dls.corp.google.com>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
	<1412881298-64117-1-git-send-email-bt@brandonturner.net>
	<xmqqk34955we.fsf@gitster.dls.corp.google.com>
	<CAMUzdX=SmeEFmxd_LPPaB9qkwqXfkiC=CU7DnMf_gR=007xcbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Brandon Turner <bt@brandonturner.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 00:12:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcLwI-0001B2-RF
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 00:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbaJIWL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 18:11:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751298AbaJIWL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2014 18:11:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 099FF15C68;
	Thu,  9 Oct 2014 18:11:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ujagn9OLOOwm
	jzzGdoS7kcV3Eyk=; b=H1ztK24ACcxqWaudtpYKubloHs4sCVrjMJ5wtn9F06z7
	7R771Asfkfc/4m+llYEeHPVyFIsI9/5gQjxkAVEB74Xb6F/RQPmBTtOat8RsexSt
	q03urzvQnXUzqSa3LqTIJoCppSh28QwdUfxDKsdhCogCiXZcdpPUjeTdGBBXVmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e599D5
	euj8DQ4zIRAVJP5mas3ylZt7+DnzU9AnLzzzzF4ex87gbXPwcNSli1QEw0Aqs5au
	Vi3FOy7f4Q43CwWnFqlIdNse+3lbRSy2uezil2kZP+MFWHeBiUv+4qaQEYXUoiAf
	mWa6cxDqo2Q7Xr4xsyELGhnsz/lnoJm1iAsBU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0144115C67;
	Thu,  9 Oct 2014 18:11:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B4ED15C66;
	Thu,  9 Oct 2014 18:11:55 -0400 (EDT)
In-Reply-To: <CAMUzdX=SmeEFmxd_LPPaB9qkwqXfkiC=CU7DnMf_gR=007xcbQ@mail.gmail.com>
	(Brandon Turner's message of "Thu, 9 Oct 2014 17:04:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 479B0A90-5001-11E4-B6F8-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Turner <bt@brandonturner.net> writes:

> On Thu, Oct 9, 2014 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>
>> Bugs are mine; as I do not use zsh myself, some testing is very much
>> appreciated.
>
> I've tested this patch in zsh and it fixes the original problem.  I'v=
e
> also tested various scenarios in bash and zsh (CDPATH set, different
> places within repos, etc.) and see no problems.
>
> Thanks for all of the help Junio and =C3=98ystein.

Actually the patch was slightly wrong.  It did not quite matter as
"cd ''" is a no-op, but "git -C '' cmd" is not that lenient (which
may be something we may want to fix) and breaks t9902 by exposing
an existing breakage in the callchain.

Here is a replacement.

-- >8 --
=46rom: Junio C Hamano <gitster@pobox.com>
Date: Thu, 9 Oct 2014 13:45:21 -0700
Subject: [PATCH] completion: use "git -C $there" instead of (cd $there =
&& git
 ...)
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

We have had "git -C $there" to first go to a different directory
and run a Git command without changing the arguments for quite some
time.  Use it instead of (cd $there && git ...) in the completion
script.

This allows us to lose the work-around for misfeatures of modern
interactive-minded shells that make "cd" unusable in scripts (e.g.
end users' $CDPATH taking us to unexpected places in any POSIX
shell, and chpwd functions spewing unwanted output in zsh).

Based on =C3=98ystein Walle's idea, which was raised during the
discussion on the solution by Brandon Turner for a problem zsh users
had with RVM which mucks with chpwd_functions in users' environments
(https://github.com/wayneeseguin/rvm/issues/3076).

As $root variable, which is used to direct where to chdir to, is set
to "." based on if $2 to __git_index_files is set (not if it is empty),
the only caller of the function is fixed not to pass the optional $2
when it does not want us to switch to a different directory.  Otherwise
we would end up doing "git -C '' command...", which would not work.

Maybe we would want "git -C '' command..." to mean "do not chdir
anywhere", but that is a spearate topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index dba3c15..6077925 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -263,16 +263,12 @@ __gitcomp_file ()
 # argument, and using the options specified in the second argument.
 __git_ls_files_helper ()
 {
-	(
-		test -n "${CDPATH+set}" && unset CDPATH
-		cd "$1"
-		if [ "$2" =3D=3D "--committable" ]; then
-			git diff-index --name-only --relative HEAD
-		else
-			# NOTE: $2 is not quoted in order to support multiple options
-			git ls-files --exclude-standard $2
-		fi
-	) 2>/dev/null
+	if [ "$2" =3D=3D "--committable" ]; then
+		git -C "$1" diff-index --name-only --relative HEAD
+	else
+		# NOTE: $2 is not quoted in order to support multiple options
+		git -C "$1" ls-files --exclude-standard $2
+	fi 2>/dev/null
 }
=20
=20
@@ -504,7 +500,7 @@ __git_complete_index_file ()
 		;;
 	esac
=20
-	__gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
+	__gitcomp_file "$(__git_index_files "$1" ${pfx:+"$pfx"})" "$pfx" "$cu=
r_"
 }
=20
 __git_complete_file ()
--=20
2.1.2-466-g338ee7a
