From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Abort mergetool on read error from stdinput
Date: Fri, 03 Dec 2010 11:45:22 -0800
Message-ID: <7vwrnqod2l.fsf@alter.siamese.dyndns.org>
References: <1291271301-12511-1-git-send-email-robin.rosenberg@dewire.com>
 <20101202063851.GA1407@burratino>
 <70B726FD-EC6A-47B2-9AB1-1CDA3B19358A@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, junkio@cox.net,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 20:45:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObZd-0002xE-IA
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 20:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab0LCTpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 14:45:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0LCTpf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 14:45:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 91D4829E3;
	Fri,  3 Dec 2010 14:45:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rgROcBVBfsXjlySRhPmgBFlRQ2M=; b=oKVFoL
	a68XBp2vG0bajwU5MLdaIDr13pglB9kiOm+kNwUGILvX4auurI96mgkzPTO6k8DK
	XnU9PKdI6PRuwBEGepKKAIM3ibbAJNETWS0DN4sxZrUng0RhVNzNsvoCeXPGR8LH
	E8HOSQB9JWwZC+DEONdIF6Ae2PqPjVtrmi1cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nblf3QGjLRImR4TgBWbAHPjrWHjtegDW
	SlwbZ58gIYqNiGdAGRTIn+fPkmIx9UndoV728VI/k5K/Rj8Na5hil1kTJYfBbLFT
	ESwxriMValYCJlr/hPiMA4a10rGHlkcs2xgApWOmGNdmjArWSzInetZR5ksgD22r
	tonT9fl5twU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4CDF429DF;
	Fri,  3 Dec 2010 14:45:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BCB2E29DC; Fri,  3 Dec 2010
 14:45:44 -0500 (EST)
In-Reply-To: <70B726FD-EC6A-47B2-9AB1-1CDA3B19358A@dewire.com> (Robin
 Rosenberg's message of "Fri\, 3 Dec 2010 10\:05\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE5B15FA-FF15-11DF-98DC-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162840>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

>> What platform are you on?  ^C kills the entire process group here.
>
> Here is a better version and motivation.
>
> -- robin
>
> From 3aa3793a4d1dff940ca6b698a9c01a1fc9bdb9b3 Mon Sep 17 00:00:00 2001
> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> Date: Fri, 3 Dec 2010 09:23:23 +0100
> Subject: [PATCH] Abort mergetool on read error from stdinput
>
> If the mergetool has not quit (by mistake like pressing
> Command-W instead of Command-Q) and the user pressed Ctrl-C
> in the shell that runs mergetool, bash goes into an infinite
> look, at least on Mac OS X. Ctrl-C kills the diff program
> but not the mergetool script.

Interesting.  Perhaps the way the script is spawned need to be improved so
that \C-c will do the right thing to avoid this infinite "loop"?

Is "exit 1" the best thing to do here?  Doesn't the caller of this
function (or the caller of that caller) want to perform some clean-up
action depending on the answer that comes back from it?

What I am wondering is if it would futureproof us better to set $status to
an appropriate value and break out of the loop, pretending that the end
user gave a reasonable answer (probably "n" but I am just guessing) to
"read answer", instead of dying.

> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  git-mergetool--lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 77d4aee..1d1413d 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -35,7 +35,7 @@ check_unchanged () {
>  		while true; do
>  			echo "$MERGED seems unchanged."
>  			printf "Was the merge successful? [y/n] "
> -			read answer
> +			read answer || exit 1
>  			case "$answer" in
>  			y*|Y*) status=0; break ;;
>  			n*|N*) status=1; break ;;
> -- 
> 1.7.3.2.452.gb3012.dirty
