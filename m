From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] commit.c: Replace starts_with() with skip_prefix()
Date: Thu, 06 Mar 2014 11:42:22 -0800
Message-ID: <xmqqfvmvxgf5.fsf@gitster.dls.corp.google.com>
References: <1394125521-9341-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:42:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLeBp-0003jr-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaCFTmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:42:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaCFTm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:42:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF57870285;
	Thu,  6 Mar 2014 14:42:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V2awdgY7rO3ABBWxRvgZxeMoTUY=; b=MB+L5n
	RSd20XBsJ3fG4hHP+/5at1S79jI+XEXCpEhvLmIee0ihQG8jmzqhvznoLAxnrdTM
	55rBdWC229pkgi5MKROwwegyQbBXJbQk/HwZTVkbt1xvHQAejy7UK4r/pxNvnmzW
	rjlpQMvME6ekFm15qwsP4EM5fO5AF/isswuqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CRpiiAvECI++oEvCjO51W1Hdk0NoCr6C
	KU9gm3z7Ma2lKUQak3fyF4Ok2AXp9DWWJXbbCjnsDBO7JGYFKLO4Xca6uWkO0Eu4
	iWVxy3tsGDRvKS/s2/MwjqdY+hysnzSzp8ZBcZaSgoDGYdxwjEi5dj6JgA1eueKT
	2gOEfJsrY0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCF5170284;
	Thu,  6 Mar 2014 14:42:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC0DD70281;
	Thu,  6 Mar 2014 14:42:24 -0500 (EST)
In-Reply-To: <1394125521-9341-1-git-send-email-karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 6 Mar 2014 22:35:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 711B926C-A567-11E3-A8BC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243541>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -1098,6 +1099,7 @@ int parse_signed_commit(const unsigned char *sha1,
>  	char *buffer = read_sha1_file(sha1, &type, &size);
>  	int in_signature, saw_signature = -1;
>  	char *line, *tail;
> +	const char *gpg_sig;
>  
>  	if (!buffer || type != OBJ_COMMIT)
>  		goto cleanup;
> @@ -1113,9 +1115,9 @@ int parse_signed_commit(const unsigned char *sha1,
>  		next = next ? next + 1 : tail;
>  		if (in_signature && line[0] == ' ')
>  			sig = line + 1;
> -		else if (starts_with(line, gpg_sig_header) &&
> -			 line[gpg_sig_header_len] == ' ')
> -			sig = line + gpg_sig_header_len + 1;
> +		else if ((gpg_sig = skip_prefix(line, gpg_sig_header))
> +			  && gpg_sig[0] == ' ')
> +			sig = gpg_sig + 1;

I am not sure if this hunk is a great improvement, as we know the
length of what we are skipping in the gpg_sig_header_len constant
that is used throughout this file.
