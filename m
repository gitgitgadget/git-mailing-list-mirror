From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 04 Apr 2013 22:34:49 -0700
Message-ID: <7vobdtee12.fsf@alter.siamese.dyndns.org>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
 <1365091293-23758-1-git-send-email-jkoleszar@google.com>
 <7v6202jjhx.fsf@alter.siamese.dyndns.org>
 <CAAvHm8NyJ3nRZPygy+grMw5BLhLe8eWfEBNfK1tkC8Y34jRynA@mail.gmail.com>
 <20130405023516.GA32290@leaf> <20130405025655.GA25970@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@joshtriplett.org>,
	John Koleszar <jkoleszar@google.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 07:35:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNzJI-0005dY-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 07:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289Ab3DEFey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 01:34:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55772 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161033Ab3DEFex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 01:34:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15D2C128F1;
	Fri,  5 Apr 2013 05:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xQX0VjDIE6E1J/c8YDLBCZIjRNY=; b=CB5qC8
	WItFk57ycCFk9HMwCSn+hWiR0r4UbszWmFpztJ1UuAVhFacHF0wG2MQs8HtsXRaw
	yblocM1SxKKBMauPhdO6ajZ+lo0zr8cr0zxoCzn6Ejja2gXTK/qijXSjV+xr/6f8
	5b+lgewKy1pi3EahDAinopy/g0yFt0HNbq6t0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CLKpHs+CluVPE3BnuWJJlcKhTCVOymvQ
	nWhjxMn5MI8C7U5/+HK2CYYHtP0RN8LDh7uF2Cew5FWw6E155HUgiSwqkZyXOqzA
	Xd2lfKbQLW9DNFXHk5OSkiyRMdhR/e/EeW+ZMsV7bDJjw7fdWBAN3HcEbMlDNWKb
	HZPn8G/r5eU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BFA2128F0;
	Fri,  5 Apr 2013 05:34:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8255C128ED; Fri,  5 Apr
 2013 05:34:51 +0000 (UTC)
In-Reply-To: <20130405025655.GA25970@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 22:56:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89C14F9A-9DB2-11E2-8070-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220145>

Jeff King <peff@peff.net> writes:

> Yeah, that makes sense. I think we'd want something like the (totally
> untested) patch below. And the tests I provided for t5551 should be
> amended to set up a HEAD within the namespace, should make the resulting
> clone non-bare, and should confirm that we check out the correct HEAD.
>
> diff --git a/http-backend.c b/http-backend.c
> index 8144f3a..84ba7f9 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -376,6 +376,14 @@ static int show_text_ref(const char *name, const unsigned char *sha1,
>  	return 0;
>  }
>  
> +static void get_head(char *arg)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	head_ref_namespaced(show_text_ref, &buf);
> +	send_strbuf("text/plain", &buf);
> +	strbuf_release(&buf);
> +}

You identified the right place to patch, but I think we need a bit
more than this.

The show_text_ref() function gives "SHA-1 <TAB> refname". It is
likely that the dumb client will ignore the trailing part of that
output, but let's avoid a hack that we would not want see other
implementations imitate.

One advantage dumb clients has over smart ones is that they can read
HEAD that is a textual symref from a dumb server and learn which
branch is the default one (remote.c::guess_remote_head()) without
guessing.  I think this function should:

 - Turn "HEAD" into a namespaced equivalent;

 - Run resolve_ref() on the result of the above;

 - Is it a symbolic ref?

   . If it is, then format "ref: <target>\n" into a strbuf and send
     it (make sure <target> is without the namespace prefix);

   . Otherwise, HEAD is detached. Prepare "%s\n" % sha1_to_hex(sha1),
     and send it.
