From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 7/7] Improve error handling when parsing dirstat
 parameters
Date: Thu, 28 Apr 2011 21:06:33 -0700
Message-ID: <7vfwp13dme.fsf@alter.siamese.dyndns.org>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
 <1303953442-26536-8-git-send-email-johan@herland.net>
 <7vhb9i43sl.fsf@alter.siamese.dyndns.org>
 <201104290113.26481.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 06:07:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFeyu-0004xR-Iq
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 06:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734Ab1D2EGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 00:06:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab1D2EGp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 00:06:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49A2A579D;
	Fri, 29 Apr 2011 00:08:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O4xLJn4By9sXLRTbl/fIDnNskno=; b=xUjsW3
	Kw33V0fna0GjGPSKaLyZDC+BY5Yglvy1OBkT+gZv/O0C7EJ8Utiuk4jdVfAbq77q
	jP8XW/iMvqz7p9SdDnujYNVKIn5m03jjAr4PSQWmmlLJed7dJitapJgd/JaTg8XH
	RJL18i22txbVeZ9eTRsUEcDz+Rd2xZGSzDijI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WKxO8Jlh+RaTjBk6lXnIIiCijXmk3egH
	wnIwbRjgYejGgCMQl7tYbt7xE2n8A01HnecHgbHAzfSIdygpmROPf/nMRO2IRBmy
	Mrn1BD49+C1+gj+8KJPJQw4t4taVP0Xwlh+RCA07AnNb2apC7tf8oCMcuTZeQAio
	8X+bQDsJCjE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CF46579C;
	Fri, 29 Apr 2011 00:08:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9F952579B; Fri, 29 Apr 2011
 00:08:37 -0400 (EDT)
In-Reply-To: <201104290113.26481.johan@herland.net> (Johan Herland's message
 of "Fri, 29 Apr 2011 01:13:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E63F0BA-7216-11E0-8EF8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172423>

Johan Herland <johan@herland.net> writes:

> Not sure what you mean here. You want the caller to supply a
> string_list, to which parse_dirstat_params() appends error messages, and
> then the caller determines how to display those error messages to the
> user after parse_dirstat_params() has returned?

A rough outline of what I had in mind was:

	struct dirstat_param_error {
        	enum {
                	ERR_DIRSTAT_PERCENT = 1,
                        ERR_DIRSTAT_UNKNOWN
		} kind;
                strbuf msg;
	};

	static int parse_dirstat_params(struct diff_options *options,
		        	const char *params,
				struct dirstat_param_error *errinfo)
	{
		while (...) {
                        ...
                        else if (isdigit(*p)) {
                                ...
                                if (end - p == p_len)
                                        options->dirstat_permille = permille;
                                else {
                                        errinfo->kind = ERR_DIRSTAT_PERCENT;
                                        strbuf_add(&errinfo->msg, p, p_len);
                                        ret = -1;
                                }
                        } else {
                                errinfo->kind = ERR_DIRSTAT_UNKNOWN;
                                strbuf_add(&errinfo->sb, p, p_len);
                                ret = -1;
                        }
                        p += p_len;
                        if (*p)
                                p++;
                }
                return ret;
	}

and then the caller can extract the information to format.

But you produce more than one one error messages, so a single errinfo
approach would not work.  Instead, we should be able to pass in the
pointer to a single strbuf errmsg, and accumulate the errors in it by
calling strbuf_addf() for the same effect.  The format string given to
strbuf_addf() may probably need to be marked with _().

The caller can then check errmsg->len to see if there was an error.
