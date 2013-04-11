From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] Documentation: add caveats about I/O buffering
 for check-{attr,ignore}
Date: Thu, 11 Apr 2013 11:09:28 -0700
Message-ID: <7vsj2xhrc7.fsf@alter.siamese.dyndns.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-5-git-send-email-git@adamspiers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:09:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLwH-0002Ie-HQ
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188Ab3DKSJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:09:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43165 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598Ab3DKSJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:09:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F06915183;
	Thu, 11 Apr 2013 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SXTpE230QL7Uxh/SvHLZe7PqYF0=; b=fzF5xs
	7IY4oQd3c4HjAQwuBaVx1kt/Ti8B805Xg60Fmvj4w9Qa4CX/TZZOhHICaf16UbJo
	Zh2cRZXT1WgGRr2SWvYGH88lPMy8bpOzhLkaSGd2x2RB5qsqOml5kIRkVLAIImWB
	8xgVDyaEwa8hAk6NlPpsHytvNPJ9qk552QxB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=peah7PNz9PJyfLZ523ZYw74PnUebQnMK
	lzfLnTMgpczWjWnMw22TDoX59y2IX4e1cElKpQPIndyKBZtPQdofRttLA/4TrZCk
	Tru/4L3zNyv+8BWkQG4GViwmpvS5a1oy7tLfW/HHKTOjdNJUfW5a/hdco/hXTyRn
	z2yxO2PSyUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 150ED15182;
	Thu, 11 Apr 2013 18:09:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71CD51517F; Thu, 11 Apr
 2013 18:09:30 +0000 (UTC)
In-Reply-To: <1365681913-7059-5-git-send-email-git@adamspiers.org> (Adam
 Spiers's message of "Thu, 11 Apr 2013 13:05:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F49461B6-A2D2-11E2-8D4C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220902>

Adam Spiers <git@adamspiers.org> writes:

> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index 7e3cabc..8e1f7ab 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -81,6 +81,11 @@ not.  (Without this option, it would be impossible to tell whether the
>  absence of output for a given file meant that it didn't match any
>  pattern, or that the output hadn't been generated yet.)
>  
> +Buffering happens as documented under the `GIT_FLUSH` option in
> +linkgit:git[1].  The caller is responsible for avoiding deadlocks
> +caused by overfilling an input buffer or reading from an empty output
> +buffer.
> +
>  EXIT STATUS
>  -----------
>  
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 6a875f2..eecdb15 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -808,13 +808,15 @@ for further details.
>  
>  'GIT_FLUSH'::
>  	If this environment variable is set to "1", then commands such
> -	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
> -	and 'git whatchanged' will force a flush of the output stream
> -	after each commit-oriented record have been flushed.   If this
> -	variable is set to "0", the output of these commands will be done
> -	using completely buffered I/O.   If this environment variable is
> -	not set, Git will choose buffered or record-oriented flushing
> -	based on whether stdout appears to be redirected to a file or not.
> +	as 'git blame' (in incremental mode), 'git rev-list', 'git
> +	log', 'git check-attr', 'git check-ignore', and 'git
> +	whatchanged' will force a flush of the output stream after
> +	each commit-oriented record have been flushed.  If this
> +	variable is set to "0", the output of these commands will be
> +	done using completely buffered I/O.  If this environment
> +	variable is not set, Git will choose buffered or
> +	record-oriented flushing based on whether stdout appears to be
> +	redirected to a file or not.

Reflowing of the text is very much unappreciated X-<.  

It took me five minutes to spot that you only added check-attr and
check-ignore and forgot to adjust that "commit-oriented record" to
an updated reality, where you now have commands that produce
non-commit-oriented record to the output.

It would have been far simpler to review if it were like this, don't
you think?

>  	If this environment variable is set to "1", then commands such
> 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
> -	and 'git whatchanged' will force a flush of the output stream
> -	after each commit-oriented record have been flushed.   If this
> +	'git check-attr', 'git check-ignore', and 'git whatchanged' will
> +	force a flush of the output stream
> +     after each record have been flushed.   If this
> 	variable is set to "0", the output of these commands will be done
> 	using completely buffered I/O.   If this environment variable is
>  	not set, Git will choose buffered or record-oriented flushing
>  	based on whether stdout appears to be redirected to a file or not.
