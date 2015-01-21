From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: print message if there are no untracked files
Date: Wed, 21 Jan 2015 13:11:33 -0800
Message-ID: <xmqqmw5bx2ii.fsf@gitster.dls.corp.google.com>
References: <1421867004-31672-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 22:11:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE2Yv-0003sy-KE
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 22:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbbAUVLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 16:11:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751975AbbAUVLg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 16:11:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1582A30955;
	Wed, 21 Jan 2015 16:11:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PLXUZ1sh8X8tjcZ2HKJREh9CDDQ=; b=holx8X
	swxg01EL5L8oOOK1yK7lL0vVNBX2XKqiRIuTs8k/zlmey+spgD28UePdu2gm+8Kq
	7x4S9U9N5PNc4I5QceqFCSSEExc5qrOnF3ig8hImKJQdZrSfkQHPR+zo+aXRZUdQ
	ILVRqGoMQQI42xK6F3r1SaTMoM4aLM70ZTNJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NDByxR6OsHfhCAWSd0skmhALgIinUQs/
	9H0K+IXGac4LQwiqJluOoFcefo1t3DC63wy5+Y+2JqtOpxQsNHOeQjKFrBTGmezr
	Tln6KeCuhdO3MTQZq9mWPoXf6kvcQMTSjFJBW1Kd1zQVL+l142WnEeHVtXbFDEQm
	M2U3chpBYP0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BC2530952;
	Wed, 21 Jan 2015 16:11:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5771330951;
	Wed, 21 Jan 2015 16:11:35 -0500 (EST)
In-Reply-To: <1421867004-31672-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Thu, 22 Jan 2015 01:03:24 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14D454EC-A1B2-11E4-862A-D3749F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262768>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> If user selects 'add untracked' and there are no untracked files,
> "Add untracked>>" opens. But it does not make sense in this case,
> because there are no untracked files. So let's print message and
> exit from "add untracked" mode.

That reasoning makes perfect sense.

> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  git-add--interactive.perl | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index 94b988c..1a6dcf3 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -724,11 +724,15 @@ sub revert_cmd {
>  }
>  
>  sub add_untracked_cmd {
> -	my @add = list_and_choose({ PROMPT => 'Add untracked' },
> -				  list_untracked());
> -	if (@add) {
> -		system(qw(git update-index --add --), @add);
> -		say_n_paths('added', @add);
> +	if (system(qw(git ls-files --others --exclude-standard --))) {

But this ls-files invocation that knows too much about how
list_untracked() computes things does not.

Why not

	my @add = list_untracked();
        if (@add) {
        	@add = list_and_choose({...}, @add);
	}
        if (!@add) {
		Nothing to do;
	} else {
		Run update-index
	}

or something instead?

> +		my @add = list_and_choose({ PROMPT => 'Add untracked' },
> +					  list_untracked());
> +		if (@add) {
> +			system(qw(git update-index --add --), @add);
> +			say_n_paths('added', @add);
> +		}
> +	} else {
> +		print "No untracked files.\n";
>  	}
>  	print "\n";
>  }
