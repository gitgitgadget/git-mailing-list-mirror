From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Salvaging borked project history
Date: Thu, 26 Feb 2015 13:28:47 -0800
Message-ID: <xmqqioeol5v4.fsf@gitster.dls.corp.google.com>
References: <54EB5DD7.7050202@free.fr>
	<xmqq7fv8to7e.fsf@gitster.dls.corp.google.com>
	<54EF098B.4080803@free.fr>
	<xmqqh9u8mrha.fsf@gitster.dls.corp.google.com>
	<54EF814D.1020105@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Mason <slash.tmp@free.fr>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:28:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5zL-0004jw-UG
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbbBZV2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:28:51 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753475AbbBZV2u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:28:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C628C3CE46;
	Thu, 26 Feb 2015 16:28:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gSddmFgmxloZmhjiIo7N2F975e4=; b=vyPSq8
	2aJWW2hTroecAl+pb0dMs2uZN9ryP3z3/ZcUsEq6qABBgSE7/2Yy5mgSBLqmGam7
	q64KuWveRc/N7T+HkSfaBm7AW4c6fxHDX/kFwljyAxiSx8rmFBWZcwNamr5I60YM
	8IyugfInACgfxmGvmZcNNux0k22f+q9hKOEaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eNC1aY4F6qHYpOFUZWse5b60WyZOU6BT
	2lV7B9t5sAzJC4A6yw2q2JjYv+0eghvDjic/4M5HxDAefZD3ZLgP+NKV8/J3bHmW
	QGi9WW60c8iNwQHYPG+1pwo3qrYnrZTE2sjoCWpwoS28CHECq5vRuVNYF83wdRmV
	d99ZgZ6zT3U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD3C73CE45;
	Thu, 26 Feb 2015 16:28:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CDD13CE44;
	Thu, 26 Feb 2015 16:28:49 -0500 (EST)
In-Reply-To: <54EF814D.1020105@free.fr> (Mason's message of "Thu, 26 Feb 2015
	21:25:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73E951A4-BDFE-11E4-B1D5-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264465>

Mason <slash.tmp@free.fr> writes:

>> Not just passing
>> these options, the code in "git am" to react to the result of patch
>> application to avoid the issue you observed when these options are
>> passed need to be adjusted by changes that started passing them, but
>> I do not think they did, cf. 77e9e496 (am: pass exclude down to
>> apply, 2011-08-03).
>
> Sorry, I could not parse that paragraph :-)

Heh, paraphrasing.

77e9e496 and others tried to teach --exclude/--include to "git am".
For "git am" to be able to claim that these options are properly
supported, you need two things:

 - The options can be given from the command line and they are
   passed to the underlying "git apply", instead of complaining with
   "no such option".

 - After calling "git mailsplit", "git mailinfo", and "git apply"
   and then these helper programs return, "git am" needs to inspect
   what happened and react.  The patch application may have failed
   due to conflicts, in which case it may have to ask the user to
   resolve.  A patch application may have resulted in no-change,
   which often is a sign that there is something wrong and "am"
   would want to stop and ask the user for confirmation.  If use of
   --include/--exclude introduces a new failure mode (e.g. mailsplit
   and mailinfo may find a patch text and happy without complaint,
   but passing --exclude to apply may cause the remaining patch to
   become essentially empty, which never happens before "am" started
   accepting these options), that codepath needs to be updated to
   cope with the new failure mode it has introduced.

And I think 77e9e496 and the other one that added --include only did
the former without doing the latter.

> Here is the use-case:
>
> if diff -q A B; then do_X; else do_Y; fi
> ...
> I was planning to write 'git diff -q commit^ commit'
> to test for empty commits.

s/-q/--quiet/ and all is well, no?

"git diff --quiet" doesn't abbreviate down to "git diff -q"
primarily because "-q" for the underlying "git diff-files" means
something different from "--quiet".
