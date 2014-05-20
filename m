From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-prompt.sh: don't assume the shell expands the value of PS1
Date: Tue, 20 May 2014 11:38:17 -0700
Message-ID: <xmqqbnusz46e.fsf@gitster.dls.corp.google.com>
References: <1400540137-29994-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, caleb@calebthompson.io
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Tue May 20 20:39:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmowR-0000PH-V0
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbaETSjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:39:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63983 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbaETSjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:39:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DA1118084;
	Tue, 20 May 2014 14:39:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8sL8l5WjtG1VVOMfKywyYonV82k=; b=qAR2n9
	tGcw1A4CvazIMFKBafSk66tVXEKqQkw9I6y4PcQEIzAXfzisiYkoSCzxD1UVwbEm
	TVWnpqwqgxNa9KZ7XXZaXh+QAOEwke4dEhrIYZOrygy4GSm4fnjWTLvXaZ6h88og
	PwKzcaQfBr2IZR5LZrR1WkFcTYMNlE1MwLqm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EZbtWlKwUr9yioEP+KYtCWliCBNJkuzo
	IO9GiIEak6jQxJCxi2mQOtmhYx0h8oEj0hUieErBMz7aqerkO2AErGiJYjqxxBt9
	HctV/Z2HG0H621G5e1YP72AzFSpHDwCueXhN3jINzCDDX+CvTnAHgZH1tp0csv6L
	vh1y0PTysFM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85A9318083;
	Tue, 20 May 2014 14:39:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 02FCF18056;
	Tue, 20 May 2014 14:38:18 -0400 (EDT)
In-Reply-To: <1400540137-29994-1-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Mon, 19 May 2014 18:55:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9C3024C-E04D-11E3-8CC6-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249723>

Richard Hansen <rhansen@bbn.com> writes:

> Not all shells subject the prompt string to parameter expansion.  Test
> whether the shell will expand the value of PS1, and use the result to
> control whether raw ref names are included directly in PS1.
>
> This fixes a regression introduced in commit 8976500 ("git-prompt.sh:
> don't put unsanitized branch names in $PS1"):  zsh does not expand PS1
> by default, but that commit assumed it did.  The bug resulted in
> prompts containing the literal string '${__git_ps1_branch_name}'
> instead of the actual branch name.
>
> Reported-by: Caleb Thompson <caleb@calebthompson.io>
> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---

Thanks, applied.

> To prevent a regression like this from happening again, I plan on
> adding new zsh test cases and expanding the bash test cases (to test
> the behavior with 'shopt -u promptvars').  I'd like the zsh tests to
> cover the same stuff as the bash tests.  These are the steps I am
> considering:
>
>   1. delete the last test case in t9903 ("prompt - zsh color pc mode")
>   2. add two new functions to t/lib-bash.sh:
>          ps1_expansion_enable () { shopt -s promptvars; }
>          ps1_expansion_disable () { shopt -u promptvars; }
>   3. loop over the relevant test cases twice:  once after calling
>      ps1_expansion_enable and once after calling ps1_expansion_disable
>      (with appropriate adjustments to the expected output)
>   4. move the test cases in t9903 to a separate library file and
>      source it from t9903-bash-prompt.sh
>   5. create two new files:
>        * t/lib-zsh.sh (same as t/lib-bash.sh but tweaked for zsh)
>        * t/t9904-zsh-prompt.sh (same as t/t9903-bash-prompt.sh but
>          tweaked for zsh)
>
> Does this approach sound reasonable?

Sounds like a plan, especially if step 4 does a reasonable job of
factoring out as much common stuff as possible.
