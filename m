From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: warn if git authorship won't be retained
Date: Tue, 10 May 2011 15:51:37 -0700
Message-ID: <7vhb92i2yu.fsf@alter.siamese.dyndns.org>
References: <1305055653-5133-1-git-send-email-luke@diamand.org>
 <1305055653-5133-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed May 11 00:51:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvmT-0006AV-Kv
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab1EJWvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 18:51:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab1EJWvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:51:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EC8F14A49;
	Tue, 10 May 2011 18:53:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ai33v28qHmz2tc2fzHROiyhIp/k=; b=iZT4ng
	JZdAWr1Y3EQNlrsaG1ZBu5FquTxAN248Cb4AjZ0KeS3q4m5l4Nx/VvIqZYR4WYYN
	hOg6ajfKORqjhQ1bJASQUYzAtNiwYpM8v5EasmcZR9kbkVslt54efCzbkiqKsEeh
	0+/LxfJVoMCM5h3CiVUIfOwEU82GZ0KfdxY0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCZ2OZTA8DfuaXS0Ssx+8MZkeuuChgwG
	+YzEzC6kIq8Xpd6qkDe8FgePQvIGTxrU3YegDlFAoBLG63c63YCLIpuzk62Yu7mp
	RIjsh2FQ+A3raub463rrVf1Fmy0o30ZZLAlnDUYP4nimPddFuY6y75XA8cm81esw
	U8m8mP8aP9E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC3B64A48;
	Tue, 10 May 2011 18:53:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 96E454A46; Tue, 10 May 2011
 18:53:45 -0400 (EDT)
In-Reply-To: <1305055653-5133-2-git-send-email-luke@diamand.org> (Luke
 Diamand's message of "Tue, 10 May 2011 20:27:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EAD22EE-7B58-11E0-9F82-B44DF9BAD297-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173378>

Luke Diamand <luke@diamand.org> writes:

> diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
> index 4fb0e24..d6c7d13 100755
> --- a/t/t9800-git-p4.sh
> +++ b/t/t9800-git-p4.sh
> @@ -160,6 +160,15 @@ p4_check_commit_author() {
>      fi
>  }
>  
> +make_change_by_user() {
> +	file=$1
> +	name=$2
> +	email=$3

	file=$1 name=$2 email=$3 &&

> +	echo "username: a change by $name" >> $file &&
> ...
> @@ -213,6 +222,43 @@ test_expect_success 'preserve user where author is unknown to p4' '
>  	rm -rf "$git" && mkdir "$git"
>  '
>  
> +# If we're *not* using --preserve-user, git-p4 should warn if we're submitting
> +# changes that are not all ours.
> +# Test: user in p4 and user unknown to p4.
> +# Test: warning disabled and user is the same.
> +test_expect_success 'not preserving user with mixed authorship' '
> +	"$GITP4" clone --dest="$git" //depot &&
> +	cd "$git" &&
> +	git config git-p4.skipSubmitEditCheck true
> +	p4_add_user derek Derek &&
> + ...
> +	p4_check_commit_author usernamefile3 alice &&
> +	cd "$TRASH_DIRECTORY" &&
> +	rm -rf "$git" && mkdir "$git"
> +'

When the commands in the && chain fails after 'cd "$git"' near the top but
not before 'cd "$TRASH_DIRECTORY"' near the end, you would end up starting
the next test from somewhere different from "$TRASH_DIRECTORY".

Do it like this instead:

	"$GITP4" clone --dest="$git" //depot &&
        (
        	cd "$git" &&
                ...
	) &&
        rm -fr "$git"
