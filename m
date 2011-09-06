From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] remote: write correct fetch spec when renaming
 remote 'remote'
Date: Tue, 06 Sep 2011 15:58:51 -0700
Message-ID: <7vaaah6zx0.fsf@alter.siamese.dyndns.org>
References: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 00:59:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R14bc-0001ua-M0
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 00:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab1IFW6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 18:58:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32856 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab1IFW6y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 18:58:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CA314A67;
	Tue,  6 Sep 2011 18:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x7b38GO0dcZ13RiZeFRn2vMKq/k=; b=NiYT6/
	vVUU8h4eet//vzvTO5I5unKcBKuw0mOhBlfOBmIKCSWTOfJqiV5oj+sgYD8YXlZh
	opqp4Kft5KB7E00Z/5gsUA8DlFfz1SBPNmcXaZgBfVmjvsmArGMb2eY3aYQGCGHu
	7f3vt2AVmrp9I+USHsdCYqX0Y+hDTkyeIWROE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g1UePog4YTIlC2hbMV5o3Ye41t0vUkVe
	VrIod6aaiZISKeOspDj8tyzuwYqG0uE5YeZgWoG7D/BT9l6EM12wYgrkqVdznFH5
	pGUDm1j//T/jXwl43/AwlpNQHzknegW/w6ZtZaCWinNRh1ujMpkGmCEXE4zKcgZw
	6x9FQtSY9XE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9351D4A66;
	Tue,  6 Sep 2011 18:58:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 278B94A65; Tue,  6 Sep 2011
 18:58:53 -0400 (EDT)
In-Reply-To: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Thu, 1 Sep 2011 20:50:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAB9FE90-D8DB-11E0-A825-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180845>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> @@ -659,15 +660,18 @@ static int mv(int argc, const char **argv)
>  	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
>  	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
>  		return error("Could not remove config section '%s'", buf.buf);
> +	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
>  	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
>  		char *ptr;
>  
>  		strbuf_reset(&buf2);
>  		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
> -		ptr = strstr(buf2.buf, rename.old);
> +		ptr = strstr(buf2.buf, old_remote_context.buf);
>  		if (ptr)
> -			strbuf_splice(&buf2, ptr-buf2.buf, strlen(rename.old),
> -					rename.new, strlen(rename.new));
> +			strbuf_splice(&buf2,
> +				      ptr-buf2.buf + strlen(":refs/remotes/"),
> +				      strlen(rename.old), rename.new,
> +				      strlen(rename.new));
>  		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
>  			return error("Could not append '%s'", buf.buf);
>  	}

It is somewhat bothering that we do not say "we didn't do any magic" here
when we did not move the tracking branch specifications, but that is not a
new problem, so I am OK with this change.

I however suspect that you would want to keep the record of what you
changed here, so that the renaming of actual refs done in [PATCH 2/2] is
limited to those that you updated the specifications for, no?
