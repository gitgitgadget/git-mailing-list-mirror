From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Use strbuf in http code
Date: Sun, 09 Dec 2007 10:15:15 -0800
Message-ID: <7vy7c3pwek.fsf@gitster.siamese.dyndns.org>
References: <1197219900-19334-1-git-send-email-mh@glandium.org>
	<1197219900-19334-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Qgw-0001Le-6a
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbXLISP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbXLISP3
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:15:29 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbXLISP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:15:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 437535B99;
	Sun,  9 Dec 2007 13:15:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A408B5B97;
	Sun,  9 Dec 2007 13:15:17 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67639>

Mike Hommey <mh@glandium.org> writes:

> Also, replace whitespaces with tabs in some places
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
>  While testing this, I noticed 3 things:
>  - CURL_MULTI makes the code very racy
>  - a lot of the code doesn't do anything useful without CURL_MULTI
>  - the code is redundant

Yeah, there does seem to be a lot of duplicated code that does common
setup with slightly different request string.

> @@ -1115,16 +1109,11 @@ static char *quote_ref_url(const char *base, const char *ref)
>  
>  int fetch_ref(char *ref, unsigned char *sha1)
>  {
> -        char *url;
> -        char hex[42];
> -        struct buffer buffer;
> +	char *url;
> +	struct strbuf buffer = STRBUF_INIT;
>  	char *base = remote->url;
>  	struct active_request_slot *slot;
>  	struct slot_results results;
> -        buffer.size = 41;
> -        buffer.posn = 0;
> -        buffer.buffer = hex;
> -        hex[41] = '\0';
>  
>  	url = quote_ref_url(base, ref);
>  	slot = get_active_slot();
> @@ -1142,9 +1131,9 @@ int fetch_ref(char *ref, unsigned char *sha1)
>  		return error("Unable to start request");
>  	}
>  
> -        hex[40] = '\0';
> -        get_sha1_hex(hex, sha1);
> -        return 0;
> +	buffer.buf[40] = '\0';
> +	get_sha1_hex(buffer.buf, sha1);
> +	return 0;
>  }

A conversion like this is worrysome and needs to be rethought I think.

At least with the old code, we knew hex[40] was a safe location to make
assignment to, even though we did not check if what it contained made
sense --- the other end might have had a garbage in that URL (but the
caller hopefully would be responsible for noticing that).  But with your
change, I do not think you have that guarantee.  fwrite_buffer() may
have extended the buffer using strbuf API, but it may have received less
than what you are expecting, in which case you may not have buf[40]
touchable for you, no?

I at the same time think the original code is buggy.  It initializes
buffer.buffer to the on-stack storage hex[], but lets fwrite_buffer() to
call xrealloc() on it.
