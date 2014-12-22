From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] update_unicode.sh: set UNICODE_DIR only once
Date: Mon, 22 Dec 2014 10:02:16 -0800
Message-ID: <xmqqk31ja7h3.fsf@gitster.dls.corp.google.com>
References: <1419006264-24741-1-git-send-email-dev+git@drbeat.li>
	<1419006264-24741-2-git-send-email-dev+git@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: dev+git@drbeat.li
X-From: git-owner@vger.kernel.org Mon Dec 22 19:02:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37JH-0002jv-KV
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 19:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111AbaLVSCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 13:02:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754503AbaLVSCS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 13:02:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49D1F288D8;
	Mon, 22 Dec 2014 13:02:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fgTLTUCH0INbTV/XqJ8ptCmKqbM=; b=w0N9Af
	TLLoceY3CJYxRQDVsjzKW2kqFgg7Urtx4nI7AyHirSIKpP73oes6L8yLq33tsdI6
	ztC1SJNI1Wj+3kQxCIVQTjvOD2P4B1LzXod9ZLDr16QoHybix0nIJBXLdmaUqF6j
	cJHrbRhNWUP8HU0M1sQS1nGJ4EeaGM3SGwb0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zgti8uHx+cZuYBIxVMGWAooaL+qIHOp0
	GuMJZ72GMmYFPMSm0AiT9TcV1eXVu/QajjKJUSKc42TmauOX6D7PxR9QPsGtCfbV
	MAHAacWRimQT/p01stRYCTGHggpoL/WJxbWkl8Tt9PKu+JHacsG00IAYWIMl24Fx
	P73Ki/5inmw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FCAC288D7;
	Mon, 22 Dec 2014 13:02:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7366288D5;
	Mon, 22 Dec 2014 13:02:17 -0500 (EST)
In-Reply-To: <1419006264-24741-2-git-send-email-dev+git@drbeat.li> (dev's
	message of "Fri, 19 Dec 2014 17:24:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AABC70C2-8A04-11E4-BE78-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261660>

dev+git@drbeat.li writes:

> From: Beat Bolli <dev+git@drbeat.li>
>
> The value is the same on both uniset invocations, so "Don't Repeat
> Yourself" applies.
>
> Since we're in a subshell already, there's no need to unset UNICODE_DIR
> at the end.

Strictly speaking, you are not introducing your own subshell to
prevent the environment from leaking (i.e. you used "{...}" not
"(...)" in the previous step).  The reason you can do this is
because the generation of UNICODEWIDTH_H file is the last thing in
the subshell.

I'll reword it to "Since this is done as the last command, ..."

Thanks.

>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  update_unicode.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/update_unicode.sh b/update_unicode.sh
> index c1c876c..bed8916 100755
> --- a/update_unicode.sh
> +++ b/update_unicode.sh
> @@ -27,12 +27,13 @@ fi &&
>  		fi &&
>  		make
>  	) && {
> +		UNICODE_DIR=. && export UNICODE_DIR &&
>  		echo "static const struct interval zero_width[] = {" &&
> -		UNICODE_DIR=. ./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
> +		./uniset/uniset --32 cat:Me,Mn,Cf + U+1160..U+11FF - U+00AD |
>  		grep -v plane &&
>  		echo "};" &&
>  		echo "static const struct interval double_width[] = {" &&
> -		UNICODE_DIR=. ./uniset/uniset --32 eaw:F,W &&
> +		./uniset/uniset --32 eaw:F,W &&
>  		echo "};"
>  	} >$UNICODEWIDTH_H
>  )
