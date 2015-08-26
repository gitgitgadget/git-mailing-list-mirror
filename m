From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Delete additional From message body
Date: Wed, 26 Aug 2015 15:38:42 -0700
Message-ID: <xmqqk2sh1xql.fsf@gitster.dls.corp.google.com>
References: <1440581120-14156-1-git-send-email-brilliantov@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: brilliantov@inbox.ru
X-From: git-owner@vger.kernel.org Thu Aug 27 00:38:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUjLI-0006y4-D9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 00:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194AbbHZWip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 18:38:45 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36734 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbbHZWio (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 18:38:44 -0400
Received: by pacgr6 with SMTP id gr6so1834348pac.3
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Z23+jV6N3XEcxuFY9XaqXYf7hRL8u4pFZx08r7qZmBQ=;
        b=OyYV3UCz6AaUiC9pKy2XdLWxIokUqShBbB/xHlWimDi3QGvkpksYCyZIPBQnIqd7Lr
         7Y2ZZjaF62ohFdYWTY8IdlLo/AzgOAFDFAHClIfBWkcV6PBhqoj0Sr2feSMdXFr9gwIv
         wwFNAl+Vp4ZR5RcBX7lxIt8HolJTJcfulPSvD6LVcWgJrk0y3FyKYRtctaoDlBitelG4
         uY21FlDkud2V4u7fTdPnGRd5ppY71LTxom9eVbnvxByyVFslxbC7cDm+mzxKKyiQsMjM
         2ogkrSh4nB513Y7MQKP0qNH44CWM0J0zchJDsQNGFYT1N9TbLnK3NMuQqYPbqJU958Tj
         mHzA==
X-Received: by 10.66.154.167 with SMTP id vp7mr519175pab.147.1440628723470;
        Wed, 26 Aug 2015 15:38:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id kl6sm77495pdb.79.2015.08.26.15.38.42
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 15:38:42 -0700 (PDT)
In-Reply-To: <1440581120-14156-1-git-send-email-brilliantov@inbox.ru>
	(brilliantov@inbox.ru's message of "Wed, 26 Aug 2015 12:25:20 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276646>

brilliantov@inbox.ru writes:

> Additional From added to message body if git-send-email run
> with --from parameters
>
> Signed-off-by: Brilliantov Kirill Vladimirovich <brilliantov@inbox.ru>
> ---
>  git-send-email.perl | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index b660cc2..92ec74a 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1522,24 +1522,21 @@ foreach my $t (@files) {
>  		$subject = quote_subject($subject, $auto_8bit_encoding);
>  	}
>  
> -	if (defined $sauthor and $sauthor ne $sender) {
> -		$message = "From: $author\n\n$message";

This condition attempts to say "Look at the author taken from the
From: line of the message, and if that is different from the sender
(which will be recorded in the header of the resulting e-mail), then
we do need to add an additional in-body From: line to record the
author of the commit, who may be different from the name that would
appear in the e-mail."

In other words, the "Additional From" is very much deliberate when
the "--from" option is used and is different from the patch author.
And I do not see this "add in-body header if the author and the
sender are different" you are removing from here appear anywhere in
the added text of your patch.  So one consequence of this patch is
to _never_ use the in-body From: line.

That needs a serious justification.

Now, it is entirely possible that what you wanted to do (and what
you are doing) in this patch may be different from "unconditionally,
remove the in-body From: line".  Perhaps the code mistakenly
declares that the sender given via "--from" and the author are
different, possibly due to a bug in rfc2047 unquoting code or
something, and you are only trying to make sure that the code
notices they are really the same.  But I somehow have a feeling that
that is not what is going on, because in such a patch, there still
will be some code that adds "From: $author" at the very beginning of
outgoing message body; such a fix might update the "if ()" condition
used to guard it (e.g. $sauthor and $sender may have to get further
cleansed before comparing), but I do not see anything of that sort,
either.  Also all the changes below do not have anything to do with
the additional in-body "From: " line.

So, I dunno.  I cannot tell what you are trying to do, and the only
immediate effect of the change I can read is that in-body "From:"
line is unconditionally disabled, which is certainly not something
we would want to do.

Puzzled...


> -		if (defined $author_encoding) {
> -			if ($has_content_type) {
> -				if ($body_encoding eq $author_encoding) {
> -					# ok, we already have the right encoding
> -				}
> -				else {
> -					# uh oh, we should re-encode
> -				}
> +	if (defined $author_encoding) {
> +		if ($has_content_type) {
> +			if ($body_encoding eq $author_encoding) {
> +				# ok, we already have the right encoding
>  			}
>  			else {
> -				$xfer_encoding = '8bit' if not defined $xfer_encoding;
> -				$has_content_type = 1;
> -				push @xh,
> -				  "Content-Type: text/plain; charset=$author_encoding";
> +				# uh oh, we should re-encode
>  			}
>  		}
> +		else {
> +			$xfer_encoding = '8bit' if not defined $xfer_encoding;
> +			$has_content_type = 1;
> +			push @xh,
> +			  "Content-Type: text/plain; charset=$author_encoding";
> +		}
>  	}
>  	if (defined $target_xfer_encoding) {
>  		$xfer_encoding = '8bit' if not defined $xfer_encoding;
