From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] completion: ignore chpwd_functions when cding on zsh
Date: Thu, 09 Oct 2014 13:45:21 -0700
Message-ID: <xmqqk34955we.fsf@gitster.dls.corp.google.com>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
	<1412881298-64117-1-git-send-email-bt@brandonturner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Brandon Turner <bt@brandonturner.net>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcKaX-00013T-St
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 22:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaJIUp1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 16:45:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750927AbaJIUpZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2014 16:45:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C008D146D8;
	Thu,  9 Oct 2014 16:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/xPsHeXOTtym
	UHahKTHfCtpf6o8=; b=YvJzSphXFAH7FQQ3JjAtxYiCTlJCbSJlAxhMQOTpejZV
	0x8s7Mtk/bbC59e4Vkp1TPZddvI4jyLTVOarR8JUqhlQcHIwgW2cA68a6TBlRynp
	qhyweeA1BiQt7Jzkih8Y6wZRky1YaII/MnUA9Hv/j2V303SINZ8hF/XqzntBGek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=D6GpMy
	n8Q7Ag38zUymxHbhbvXZXTYJC2T3082bn53EZEbzogOELXRkLGKqNxcBGoMZF5fs
	CEtoDyjHDRiODtzEFRrF1638LKog0j2EMQvkk6/pDDiEWabCTude/XZL0A/AJIvU
	QO6nX0Kx+CKNePSIgAtjUP3kezoXDWoo+0ZWQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B72AC146D7;
	Thu,  9 Oct 2014 16:45:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E366146C5;
	Thu,  9 Oct 2014 16:45:22 -0400 (EDT)
In-Reply-To: <1412881298-64117-1-git-send-email-bt@brandonturner.net> (Brandon
	Turner's message of "Thu, 9 Oct 2014 14:01:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3043E38C-4FF5-11E4-B890-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Turner <bt@brandonturner.net> writes:

> As =C3=98ystein pointed out, on zsh we can use "cd -q" to ignore
> chpwd_functions.
>
> Junio - from my testing, unsetting CDPATH is sufficient on zsh.

Let's do this instead, though.

Bugs are mine; as I do not use zsh myself, some testing is very much
appreciated.

Thanks.

-- >8 --
Subject: [PATCH] completion: use "git -C $there" instead of (cd $there =
&& git ...)

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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index dba3c15..42f7308 100644
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
--=20
2.1.2-464-g5e996a3
