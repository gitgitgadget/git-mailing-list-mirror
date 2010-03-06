From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: Support running with set -u in bash 4.0
Date: Sat, 06 Mar 2010 11:29:54 -0800
Message-ID: <7vtystfdu5.fsf@alter.siamese.dyndns.org>
References: <20100306181655.GA2261@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>,
	Thomas Nilsson <thomas.nilsson@unixangst.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No174-0004YU-BN
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab0CFTaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 14:30:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0CFTaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 14:30:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B09709F4CB;
	Sat,  6 Mar 2010 14:30:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g3oh0w128jDgzoG+Uv8ikJjRlNM=; b=ARYmim
	QzO1UJIqHFwqvyo8iClxrjz8f1FEckmFZXS9amiXZ8FAPHPxQLNKfoGksekyvn0E
	dpzbzMQBKTMhFpCY5QXqb+OijZPM/3/PJTWgLEhP3VnWTPMNtpM5h61qvMdKR5Ya
	1sOOSfgBCGZSI9Vitc/QCa+D9G2NeP9p8IwPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uestcTaz27BNkzIUq40zqe7PCzJpoqQx
	yHdB6s/puPjSVli0JOPuW3KO2L7Ilv0rAREhzAZH/S/dN8F7Iu0FAoUAAx/1oUBK
	2uZDZKNTe9nvbEyse+MB5fiqpM6zxAxyQDWSPpWAuV6HEQa1GvEGa+H4D3VchR7O
	6J9jWQcPSJo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B1F49F4C7;
	Sat,  6 Mar 2010 14:30:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 753729F4BA; Sat,  6 Mar
 2010 14:29:55 -0500 (EST)
In-Reply-To: <20100306181655.GA2261@progeny.tock> (Jonathan Nieder's message
 of "Sat\, 6 Mar 2010 12\:16\:55 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8637AD2-2956-11DF-9BDE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Thomas Nilsson <thomas.nilsson@unixangst.com>
> Date: Tue, 23 Feb 2010 12:13:00 +0100
>
> Starting with bash 4.0-beta, under "set -u" semantics, accessing
> undefined local variables is now an error.  Some user environments
> enable this setting in the interactive shell, with unpleasant results:

Unfortunate but necessary, it seems.

> @@ -2181,7 +2181,7 @@ _git ()
>  		c=$((++c))
>  	done
>  
> -	if [ -z "$command" ]; then
> +	if [ -z "${command-}" ]; then
>  		case "${COMP_WORDS[COMP_CWORD]}" in
>  		--*)   __gitcomp "
>  			--paginate

Why not this patch, instead of the above hunk?

Also if we initialize __git_dir with an empty string on the same line, I
think we can lose "${__git_dir-}" ugliness in __gitdir () function.

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fe93747..3a65156 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2167,7 +2167,7 @@ _git_tag ()
 
 _git ()
 {
-	local i c=1 command __git_dir
+	local i c=1 command="" __git_dir
 
 	while [ $c -lt $COMP_CWORD ]; do
 		i="${COMP_WORDS[c]}"
