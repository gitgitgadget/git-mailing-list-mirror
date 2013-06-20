From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/5] pretty: Add failing tests: user format ignores i18n.logOutputEncoding setting
Date: Thu, 20 Jun 2013 13:23:36 -0700
Message-ID: <7vd2rgsf93.fsf@alter.siamese.dyndns.org>
References: <cover.1371720245.git.Alex.Crezoff@gmail.com>
	<297a5bacde1eb3cbe96a05e8ddf1783c44cba4ac.1371720245.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 22:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UplOR-0002PU-FY
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 22:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965678Ab3FTUXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 16:23:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965473Ab3FTUXj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 16:23:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 962C12A3E5;
	Thu, 20 Jun 2013 20:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O8HvM1iOxBVDZtvoZ/0TT351WJc=; b=hBXb4x
	IM5KCTE3uHz/M9tcY50l8x6JFwlOM05O0WkIaFoaQcgepiv1vFvU2G8nortXIKs7
	tHFCfElaCkQRIs+VTpzYfvg8OpuqlE5pyvorkevlFzFgxBxhOVoG7bfzoO/t0Nff
	dmeIzLd4zy51qmcBIZbfwASG1O8999yDtrPbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UGTThEuABxz9esndd7XOT7yp/ddAqiQW
	BaKy1wKPagIhil2zkeN2G5TIXaKSLZPXzzZ6rpvWN2okP9uPgPCNu3LSjYvqEqAC
	wBRS1pz8VIm1/3yPLhX7IF/WuJ2NmZpaAIfGPkAXcK2BXqRUcAQHXF9QqEUMsFIL
	vGzRbRX2ruY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DB572A3E4;
	Thu, 20 Jun 2013 20:23:38 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00C2E2A3E2;
	Thu, 20 Jun 2013 20:23:37 +0000 (UTC)
In-Reply-To: <297a5bacde1eb3cbe96a05e8ddf1783c44cba4ac.1371720245.git.Alex.Crezoff@gmail.com>
	(Alexey Shumkin's message of "Thu, 20 Jun 2013 13:26:20 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A33910A-D9E7-11E2-AEAF-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228532>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> @@ -19,7 +23,8 @@ add_file () {
>  			echo "$name" >"$name" &&
>  			git add "$name" &&
>  			test_tick &&
> -			git commit -m "Add $name" || exit
> +			msg_added_iso88595=$(echo "Add $name ($added $name)" | iconv -f utf-8 -t iso88595) &&
> +			git -c 'i18n.commitEncoding=iso88595' commit -m "$msg_added_iso88595"

Hmph.  Do we know 8859-5 is available or do these need to be
protected with prereq?

Can these tests be done with 8859-1 i.e. something we already depend
on, by changing that $added message to latin-1, or is there something
very Russian specific breakage we want to test here?

If the former, please redo this entire patch (not just t4041) with
8859-1.

If there is some Russian specific breakage you cannot demonstrate
with 8859-1, then please explain it in the log message.

> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index d32e65e..36e4cc0 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> ...
> -# usage: test_format name format_string <expected_output
> +# usage: test_format [failure] name format_string <expected_output
>  test_format () {
> +	local must_fail=0

This breaks tests for non-bash users.  "local" is not even in POSIX.
