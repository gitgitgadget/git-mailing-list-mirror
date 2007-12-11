From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Resend PATCH 2/4] Use strbuf in http code
Date: Mon, 10 Dec 2007 22:04:52 -0800
Message-ID: <7vlk81him3.fsf@gitster.siamese.dyndns.org>
References: <7vy7c3ogu2.fsf@gitster.siamese.dyndns.org>
	<1197228659-19459-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yFH-0004hk-Q2
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbXLKGFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbXLKGFK
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:05:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbXLKGFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:05:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 016094504;
	Tue, 11 Dec 2007 01:05:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC964501;
	Tue, 11 Dec 2007 01:04:59 -0500 (EST)
In-Reply-To: <1197228659-19459-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Sun, 9 Dec 2007 20:30:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67796>

Mike Hommey <mh@glandium.org> writes:

> Also, replace whitespaces with tabs in some places
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>
>  While this doesn't fix the problem with symbolic refs, it does fail more
>  cleanly.
>
>  http-push.c   |  187 +++++++++++++++++++--------------------------------------
>  http-walker.c |   60 +++++++------------
>  http.c        |   34 ++++------
>  http.h        |   11 ++--
>  transport.c   |   18 ++----
>  5 files changed, 109 insertions(+), 201 deletions(-)

I like this code reduction, but

> diff --git a/http.h b/http.h
> index fe1b0d1..bf3f12c 100644
> --- a/http.h
> +++ b/http.h
> @@ -6,6 +6,8 @@
>  #include <curl/curl.h>
>  #include <curl/easy.h>
>  
> +#include "strbuf.h"
> +
>  #if LIBCURL_VERSION_NUM >= 0x071000
>  #define USE_CURL_MULTI
>  #define DEFAULT_MAX_REQUESTS 5
> @@ -48,18 +50,17 @@ struct active_request_slot
>  
>  struct buffer
>  {
> -        size_t posn;
> -        size_t size;
> -        void *buffer;
> +	struct strbuf buf;
> +	size_t posn;
>  };

With this definition of "struct buffer", I do not think this can be correct.

> @@ -1267,10 +1257,8 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
>  {
>  	struct active_request_slot *slot;
>  	struct slot_results results;
> -	struct buffer out_buffer;
> -	struct buffer in_buffer;
> -	char *out_data;
> -	char *in_data;
> +	struct buffer out_buffer = { 0, STRBUF_INIT };

How seriously have you proofread and tested this series before sending
it out?
