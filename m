From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/19] bash prompt: use bash builtins to check whether
 inside git dir
Date: Wed, 09 May 2012 13:06:24 -0700
Message-ID: <7vvck5qfun.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-13-git-send-email-szeder@ira.uka.de>
 <4FAA25B9.3010208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 09 22:06:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSD9e-00077O-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760936Ab2EIUG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:06:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760879Ab2EIUG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:06:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B7E8EA8;
	Wed,  9 May 2012 16:06:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j8VBqOLyGtQdokNlkj2ANU51SpU=; b=PSQFuz
	hmxX2TaRYa93oQelz3FY7AshANQDSuN3tBBZXwuLxb5IpoysVIeDDCK2bnCpK+Xw
	z722TJJ0zgbeaVuo8R9zEmnJVrJlWayrZo6r0joAoPbpAFuIO0kl8DT1q7evexK7
	cn1UotpgbvdmdtRCYpY4aE5mxuigzhga0vfOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cc6qJvPlhCdGhXV6Erfw2xzInHcR//3G
	6EPYayRVUMd/CzRX6NUak/uq3uardnOlQZiOFZ42wT4IBnQEy8BW3109XoeacwJ5
	lK5zwUlNIVyZxl/unis07XoxFFflMaSg/loPl9QEq6oAB3V8QL7nUhEbn3k7yHC7
	XNQgAaGG1/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 506358EA7;
	Wed,  9 May 2012 16:06:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 167A48EA4; Wed,  9 May 2012
 16:06:25 -0400 (EDT)
In-Reply-To: <4FAA25B9.3010208@viscovery.net> (Johannes Sixt's message of
 "Wed, 09 May 2012 10:07:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7502B868-9A12-11E1-90EE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197501>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> __git_ps1() runs the '$(git rev-parse --is-inside-git-dir)' command
>> substitution to check whether we are inside a .git directory and the
>> bash prompt needs to be adjusted accordingly (i.e. display 'BARE!' or
>> 'GIT_DIR!').  This imposes the overhead of fork()ing a subshell and
>> fork()+exec()ing a git process.
>> 
>> Perform this check by comparing the path to the repository and the
>> current directory using only bash builtins, thereby sparing all that
>> fork()+exec() overhead.
>
>> -	if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
>> +	local pwd_p
>> +	__git_pwd_p pwd_p
>> +	# inside .git dir?
>> +	if [ "$__git_dir" = "." -o \
>> +			"${pwd_p#$__git_dir}" != "$pwd_p" ]; then
>
> At this point, $__git_dir is c:/dir style, whereas $pwd_p is /c/dir style,
> and the intended prefix check does not trigger.
>
> As long as $__git_dir is only used to access files, it does not matter
> whether it is Windows style or POSIX style. But if $__git_dir is used in a
> comparison, then you must make 100% sure that the involved paths are of
> the same vintage.
>
> What would be lost if this patch were dropped?

One loss of fork/exec is what would be lost, I would guess, and that seems
to be the primary point of this entire series, so...

At the conceptual level, I think the optimization in this patch makes
sense, but if the assumed primary beneficiary (i.e. Windows) cannot
benefit from this particular optimization due to two different path
representations, it wouldn't help being conceptually sound X-<.
