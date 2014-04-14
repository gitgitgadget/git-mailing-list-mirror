From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Mon, 14 Apr 2014 15:51:00 -0700
Message-ID: <xmqqob03le3v.fsf@gitster.dls.corp.google.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 00:51:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZpia-0008OT-7F
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 00:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbaDNWvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 18:51:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbaDNWvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2014 18:51:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B52A27D835;
	Mon, 14 Apr 2014 18:51:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wAv0sfWUSbwhBvF6Hf8QSqF9/P8=; b=NxAhf0
	Ei+QrSGM9OBgssJ9cKaCNZCgse5uXDZct5TFjxKHG18RDIc3xp2UMDBHKNW6uPg4
	9Kcqr6TnwL7lq86cLc66asEQW0jc9ZYEB+oRHrlIbFDYbWsXz3tPz0Gvh7M3z4EQ
	PwwhyE5wVK+ITCauOWzcUXO4H9bQAVUcm/E7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d8YOzEumPpGqzfuMJYL777RdNCuZsupL
	qEn6kd73iKzGf7K1gVqG4D+E0MsNyfFthP7jU8yo3ngfu02dzwskDobWgG8Mz3EE
	xIOSG+3/5qnRWCtRhCj+65JgKLwgCIPVTr7W9hPM2uJiln4YVVBgbXAsoa7gLXQk
	O6WCE61z8+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980A97D834;
	Mon, 14 Apr 2014 18:51:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EE4F7D831;
	Mon, 14 Apr 2014 18:51:02 -0400 (EDT)
In-Reply-To: <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Fri, 11 Apr 2014 01:28:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40D4D3FA-C427-11E3-8EFB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246272>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> For convenience, here are the diffs using -w:
>
> |--- a/git-rebase--am.sh
> |+++ b/git-rebase--am.sh
> |@@ -4,6 +4,7 @@
>  # Copyright (c) 2010 Junio C Hamano.
>  #
>  
> +git_rebase__am() {
>  	case "$action" in
>  	continue)
>  		git am --resolved --resolvemsg="$resolvemsg" &&
> |@@ -73,3 +74,5 @@ then
>  	fi
>  
>  	move_to_original_branch
> +}
> +git_rebase__am

I think we would want to see the actual change formatted this way
(without needing to pass "-w" to "git show"), as it will make it
clear that this artificial extra level of "define the whole thing
inside a function and then make a single call to it" is a workaround
of specific shell's glitch that we would not have to have in an
ideal world ;-)

Besides that would make it less likely to cause conflicts with the
real changes in flight.

Please double check what I queued on 'pu' when I push out today's
integration result.

Thanks.
