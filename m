From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools/meld: do not rely on the output of `meld --help`
Date: Wed, 15 Oct 2014 12:18:54 -0700
Message-ID: <xmqqh9z5w38h.fsf@gitster.dls.corp.google.com>
References: <1413361848-16923-1-git-send-email-davvid@gmail.com>
	<xmqqoatdw3wk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Andrey Novoseltsev <novoselt@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:19:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeU68-0004AZ-UL
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 21:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbaJOTS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 15:18:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750775AbaJOTS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 15:18:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E7D0414C7D;
	Wed, 15 Oct 2014 15:18:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QrI5QvFGH/IUCjGeLXRX8690PtY=; b=E6a+jg
	AVr0+S4++6uRNIYb1Iqi2Y/sr4+8qLfdrceQquuS4iiKknUbggVsZn5RZMn8kGh1
	wa+DQnvpbcrTmSB3m5ujPeeRXWUzU5XUsS/XpvLC4IHSJKh3y5Qwok8mEflSXoL/
	A5zB8k/cKPF5HS0utC7xSOK4N5mQHKDqFUTS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ix+x66Dp8VSgPSL0CTmuQtw5+JnVZOef
	bewgr5E3RwdiojTbTuuLNAuvwvDuD0aMfu/zGGTWWXRuTiwR964rMp6jMPMDmhIX
	y0cRXhTe0oi8tycMXBcXfoSMyzKFq0p5ANxqVbyhlnA5PlPawc1q7VU2LmqlnWiQ
	bK0K3jVO+IQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF1F714C7C;
	Wed, 15 Oct 2014 15:18:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A0F714C7B;
	Wed, 15 Oct 2014 15:18:55 -0400 (EDT)
In-Reply-To: <xmqqoatdw3wk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Oct 2014 12:04:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B1EAA5A-54A0-11E4-9FB7-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This obviously breaks those who have happily been using their
> installed version of meld that understands and shows --output in the
> help text.  Is that a minority that is rapidly diminishing?
>
> I would understand it if the change were
>
>  - a configuration tells us to use or not use --output; when it is
>    set, then we do not try auto-detect by reading --help output
>
>  - when that new configuration is not set, we keep the current code
>    to read --help output, which may fail for recent meld but that is
>    not a regression.
>
> When versions of meld that support --output but do not mention it in
> their --help text are overwhelming majority, we would want to flip
> the fallback codepath from "read --help and decide" to "assume that
> --output can be used", but I do not know if now is the time to do
> so.

In other words, I am wondering if a milder fix would be along this
line of change instead.  Older versions seem to list --output
explicitly, and we assume newer ones including the one reported by
Andrey begin their output like so:

    $ meld --help
    Usage:
      meld [OPTION...]

hence we catch either of these patterns.

 mergetools/meld | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mergetools/meld b/mergetools/meld
index cb672a5..b6169c9 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -23,8 +23,12 @@ check_meld_for_output_version () {
 	meld_path="$(git config mergetool.meld.path)"
 	meld_path="${meld_path:-meld}"
 
-	if "$meld_path" --help 2>&1 | grep -e --output >/dev/null
+	if meld_has_output_option="$(git config --bool mergetool.meld.hasOutput)"
 	then
+		: use whatever is configured
+	elif "$meld_path" --help 2>&1 | grep -e '--output=' -e '\[OPTION\.\.\.\]' /dev/null
+	then
+		: old ones explicitly listed --output and new ones just say OPTION...
 		meld_has_output_option=true
 	else
 		meld_has_output_option=false
