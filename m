From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 11:11:35 -0700
Message-ID: <xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
	<1431019501-30807-3-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 07 20:11:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQGs-0006L7-MT
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbbEGSLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:11:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751190AbbEGSLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:11:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C24F4E67F;
	Thu,  7 May 2015 14:11:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cJ7Hr2Fnr9XGr3FnQ5fsV8grHuQ=; b=xIb+q4
	CFzq9lnpkqj80xpTDt6+FqFYh9NHuaW2T0EBvgvPPsYqLi91hWsGXFhaM4DkCllX
	tdQ9e2jYHy34PzgefpjVlVIhxDvimBKrkqjNe6es2k/JSjaL5R0iC076+2L3vPPF
	ubMGLHImpiOZ1RT4N0jYwT1Y+kiep0jdrv8Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W79xlfo2oRieETAZ/laJWLQ591G7f5DS
	eSoFS+Clezykk/sh+XyaTPgi/dp8j6YsyWpUHdULDIoIGBxjZHHrP5UKL8b+PboN
	2cWle1S2SeuHD/eNqSA87uDDJ6cb9cqpdgx34ZsXt+cERRuCzhfToWZ+6TX+lj+u
	4AsPrpxyrlg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 230EB4E67C;
	Thu,  7 May 2015 14:11:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 897AF4E67B;
	Thu,  7 May 2015 14:11:36 -0400 (EDT)
In-Reply-To: <1431019501-30807-3-git-send-email-luke@diamand.org> (Luke
	Diamand's message of "Thu, 7 May 2015 18:25:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8009855E-F4E4-11E4-BD92-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268566>

Luke Diamand <luke@diamand.org> writes:

> This teaches git-p4 to pass the P4EDITOR variable to the
> shell for expansion, so that any command-line arguments are
> correctly handled. Without this, git-p4 can only launch the
> editor if P4EDITOR is solely the path to the binary, without
> any arguments.

Does the real Perforce, when spawning P4EDITOR, behave the same way?

If not, this patch would be breaking not just the expectation of
existing git-p4 users (which we cannot avoid and which we are
willing to do) but also breaking things for people who _will_ come
to us in the future, expecting that

	export P4EDITOR="/Users/me/My Programs/my-editor"

to work as they expect.  If they already have to do

	export P4EDITOR="'/Users/me/My Programs/my-editor'"

then there is no problem, but because I am not a P4EDITOR user, I am
merely double checking.

>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
>  git-p4.py                         | 2 +-
>  t/t9820-git-p4-editor-handling.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 41a77e6..ca6bb95 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1248,7 +1248,7 @@ class P4Submit(Command, P4UserMap):
>              editor = os.environ.get("P4EDITOR")
>          else:
>              editor = read_pipe("git var GIT_EDITOR").strip()
> -        system([editor, template_file])
> +        system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
>  
>          # If the file was not saved, prompt to see if this patch should
>          # be skipped.  But skip this verification step if configured so.
> diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
> index e0a3c52..c178bd7 100755
> --- a/t/t9820-git-p4-editor-handling.sh
> +++ b/t/t9820-git-p4-editor-handling.sh
> @@ -17,9 +17,9 @@ test_expect_success 'init depot' '
>  	)
>  '
>  
> -test_expect_failure 'EDITOR has options' '
>  # Check that the P4EDITOR argument can be given command-line
>  # options, which git-p4 will then pass through to the shell.
> +test_expect_success 'EDITOR has options' '
>  	git p4 clone --dest="$git" //depot &&
>  	test_when_finished cleanup_git &&
>  	(
