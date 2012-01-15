From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix
 regression)
Date: Sat, 14 Jan 2012 18:29:45 -0800
Message-ID: <7vsjjhwvdy.fsf@alter.siamese.dyndns.org>
References: <20120114152030.GX30469@goldbirke>
 <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Jan 15 03:29:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmFqz-0007W5-Ci
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 03:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab2AOC3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 21:29:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44021 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab2AOC3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 21:29:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7934F6E80;
	Sat, 14 Jan 2012 21:29:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9g0PJZZ7qdclGjL/O3wQ9EmooNs=; b=jTjb2n
	dBrNSA559F7q61ZeaNAnk/0MeXyak7tmgN7FNOz4HObEhqrPz/Opr3B0juRIWIgc
	cihnBXwNSpXNV6kqiYugzWvBo+niv9cujRwFPYcDbpeELimOTlqFVWeSvDmBWvxj
	5F7/mnqv5NRiCw5CUrIB7uFNREY1/qsf2BYjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sokF6M2CkVFXlEZGqXOKdlhGyXliwRQh
	LMqRa+QauSaddPv1s0dXHsERBG8EcsAAptVfYVn/JUbToTIE2DdK76iKTpMqXj10
	Pgd2VQRgDcx3i5TcJJDskQus5iRcasl7SJrmDwmSTG7P17E4BPwXc2d2CJ3tWKS2
	pretDdf9BW8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70B9B6E7F;
	Sat, 14 Jan 2012 21:29:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 052526E7E; Sat, 14 Jan 2012
 21:29:46 -0500 (EST)
In-Reply-To: <1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sat, 14 Jan 2012 19:55:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAB6FE56-3F20-11E1-A274-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188585>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index b0062ba..488e1f4 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -534,6 +534,12 @@ __gitcomp_nl ()
>  		fi
>  	fi
>  
> +	# ZSH would quote the trailing space added with -S. bash users
> +	# will appreciate the extra space to compensate the use of -o nospace.
> +	if [ -n "${ZSH_VERSION-}" ] && [ "$suffix" = " " ]; then
> +		suffix=""
> +	fi

This should take care of the SP set by the beginning of the helper
function

        local cur_="$cur" suffix=" "

but is that the right thing to do if suffix came from "$4"?

As far as I can see, "$4" is used to append "." in very limited cases, and
nobody explicitly passes SP as "$4" when calling this, so it may be easier
to read if you moved this before that "if we have 3 or more args, use the
fourth one as the suffix" block, i.e. something like this?

 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b0062ba..4ad75ed 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -525,7 +525,10 @@ __gitcomp ()
 __gitcomp_nl ()
 {
 	local s=$'\n' IFS=' '$'\t'$'\n'
-	local cur_="$cur" suffix=" "
+	local cur_="$cur"
+	# Because we use '-o nospace' under bash, we need to compensate
+	# for it by appending SP after completed word ourselves.
+	local suffix="${BASH_VERSION+ }"
 
 	if [ $# -gt 2 ]; then
 		cur_="$3"
