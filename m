From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] completion: ignore chpwd_functions when cding on zsh
Date: Thu, 09 Oct 2014 13:01:00 -0700
Message-ID: <xmqqwq8957yb.fsf@gitster.dls.corp.google.com>
References: <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
	<1412881298-64117-1-git-send-email-bt@brandonturner.net>
	<loom.20141009T214418-680@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:01:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJtj-0003LZ-CU
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 22:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbaJIUBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 16:01:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751971AbaJIUBJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2014 16:01:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 896571399F;
	Thu,  9 Oct 2014 16:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U2UgSL/wgTJC
	Pzs93YKP0yvl7dA=; b=a/lNJ9M90z9erfy+0lCxYsLo5VHdqQBk/qLm6R1U3ywP
	Aci/bsfzM9H88tnXSx+CEcfjjAkKLo9Ctff6mqPSSIR9l9mokOejiLfEI13ZUTVm
	ZVUxHl39ztRqmPGXbop2qmGIDsJsNRLmSq79Xmor41P7336cf++xoasdiVTStu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=r218ou
	cWpcOPgWQ2fOirPpF1EYPKsqREHtVLI0HwmUgV7fFa9ntDQOIopGIP7QzUAWhSwp
	I70y7aw8vM3FfPZPSiyW63DvOTBDPMhN6TV8OLH2n/dt1ze3RaIvDb289jehqtGt
	RP2GKVW7tLo8sob/cT54CRoJTIWF6RjvJ4qUU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81EA61399E;
	Thu,  9 Oct 2014 16:01:02 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6CD21399A;
	Thu,  9 Oct 2014 16:01:01 -0400 (EDT)
In-Reply-To: <loom.20141009T214418-680@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Thu, 9 Oct 2014 19:47:08 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE84C6C8-4FEE-11E4-B0D5-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> BUT: Over a year ago Git learned the -C argument. Couldn't we use tha=
t
> here? That way we would not have to unset CDPATH and can get rid of t=
he
> subshell and cd -q. If we allow the other functions to use several
> arguments to pass options with we can get rid of the whole seperation
> between bash and zsh altogether.

Wow, that is an excellent suggestion.  It would look like the
attached, right?

By stepping away further and further from the originally proposed
solution and trying to identify the real problem that needs to be
solved, you reached a better solution ;-).

 contrib/completion/git-completion.bash | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 5ea5b82..f22de9d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -281,16 +281,12 @@ __gitcomp_file ()
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
