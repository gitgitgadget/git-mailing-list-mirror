From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv15 2/5] run_processes_parallel: add LF when caller is sloppy
Date: Wed, 24 Feb 2016 12:07:37 -0800
Message-ID: <xmqqa8mpub1y.fsf@gitster.mtv.corp.google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
	<1456284017-26141-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 21:07:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYfiv-0003wy-SS
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 21:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbcBXUHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 15:07:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751750AbcBXUHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 15:07:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99BCD455BC;
	Wed, 24 Feb 2016 15:07:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZHQLNddt8WIsy3BtLog9OQCHjNg=; b=f94Yoe
	pUFK9h/40krMZYTmn8AFoHWfzjKDpEtj9Jp5o+20jKs6O0arlCE0LudG4Lvx8Xm8
	geeTj2n2N1JIWOUTOLYaniSpDpLpKSaPGe8f6sjJ6M2EKQPfOGNdgDLQkwt98rNL
	XmZKU2h/JG0WwQ0cZQQm+cij5CM7mdcrzJL3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p9E87VTneL/4AztCRrA/NvVhwjx+4wWG
	St/5qpkPNJlE92MSADdCoO7ZG9J5u58UAggcaidmxOGRpesz5BJumaNwULSi/Alg
	yLPtNQkWiepykYrDl/VMdCk3XwJBPJkJ+MEHkaFQWb8gFQ9Vk1BQv1p0h3Ry6PYI
	d11ELLLSjwA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 90F00455BB;
	Wed, 24 Feb 2016 15:07:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0715D455B7;
	Wed, 24 Feb 2016 15:07:39 -0500 (EST)
In-Reply-To: <1456284017-26141-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 23 Feb 2016 19:20:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 41109B0A-DB32-11E5-87F8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287220>

Stefan Beller <sbeller@google.com> writes:

> @@ -1095,9 +1098,11 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>  static void pp_output(struct parallel_processes *pp)
>  {
>  	int i = pp->output_owner;
> -	if (pp->children[i].state == GIT_CP_WORKING &&
> -	    pp->children[i].err.len) {
> +	size_t len = pp->children[i].err.len;
> +	if (pp->children[i].state == GIT_CP_WORKING && len) {
>  		fputs(pp->children[i].err.buf, stderr);
> +		pp->ended_with_newline =
> +			(pp->children[i].err.buf[len - 1] == '\n');
>  		strbuf_reset(&pp->children[i].err);
>  	}
>  }

The child->err thing is treated as a counted byte array when the
code determines where the end of the buffer is, but is treated as a
nul-terminated string when it is output with fputs().

The inconsistency may not hurt as long as (1) the producers of the
message will never stuff a NUL in the middle, and (2) strbuf always
has the guard NUL after its contents.  Even though we know that the
latter will hold true for the foreseeable future, it also is easy to
do the right thing here, too, so why not?
