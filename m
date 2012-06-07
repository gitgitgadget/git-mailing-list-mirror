From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from
 $XDG_CONFIG_HOME/git/config file
Date: Thu, 07 Jun 2012 15:58:35 -0700
Message-ID: <7vpq9aenl0.fsf@alter.siamese.dyndns.org>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 00:58:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sclf9-0001Lp-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 00:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933294Ab2FGW6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 18:58:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48937 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758161Ab2FGW6i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 18:58:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B20C59944;
	Thu,  7 Jun 2012 18:58:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZT4mYGb+IObUiSPpLX7DHVHWnNE=; b=UQbV/E
	HFh+WSZSMz8evEyqNc95j4DVzhVSTJbH4MRQUv0n4fIpLdCBBUJnztDyvFjWlW3s
	ckMzvaX9d761mvsFAvbvdcfN06OKa7CCKhxhxvw3+GvQAe/bWAQxHljp5SCdctzh
	mDe7G/Lenj6sVJ4taWnMeRwZ6czZ+7/Qqe0ZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vtNvZOAzmleaH+rmvyKjcfg6RI72WlJe
	/W7OgX6qzCqw7GxXAFDAggNW1XpoLakBVTi2KWBfUssXgQKGRNP85CXSGnz1qXKz
	VDdAVsPBUHzSUQ1rgVI5gs0QvmkHf95d75b76gbUETppY1IhIGCGCijeCUqG98wD
	ZGMuj6atXrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A837D9943;
	Thu,  7 Jun 2012 18:58:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 095779941; Thu,  7 Jun 2012
 18:58:36 -0400 (EDT)
In-Reply-To: <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 (Huynh Khoi Nguyen NGUYEN's message of "Wed, 6 Jun 2012 15:21:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50BAD6E0-B0F4-11E1-B8F5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199458>

> +char *mkpathdup(const char *fmt, ...)
> +{
> +	char path[PATH_MAX];
> +	va_list args;
> +	unsigned len;
> +
> +	va_start(args, fmt);
> +	len = vsnprintf(path, sizeof(path), fmt, args);
> +	va_end(args);
> +	if (len >= sizeof(path))
> +		return xstrdup(bad_path);
> +	return xstrdup(cleanup_path(path));
> +}

Hrmph. If a new helper is introduced anyway, wouldn't it be a better
idea to get rid of the hardcoded PATH_MAX limitation, perhaps using
strbuf_vaddf() or something in the implementation of this function?

> diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
> new file mode 100755
> index 0000000..5b971d9
> --- /dev/null
> +++ b/t/t1306-xdg-files.sh
> @@ -0,0 +1,70 @@
> ...
> +test_expect_success 'read with --get: xdg file exists and ~/.gitconfig doesn'\''t' '
> +	rm .gitconfig &&

"rm -f .gitconfig"; always consider the possibility that any part of
the previous test could have been omitted or failed.
