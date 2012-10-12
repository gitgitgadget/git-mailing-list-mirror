From: Brad Hein <linuxbrad@gmail.com>
Subject: Re: [PATCH 2/2] http: do not set up curl auth after a 401
Date: Fri, 12 Oct 2012 09:39:17 -0400
Message-ID: <CAJa+X0OHsmQakhMr8QRwO6n9Ni9gXvXWnFTKFdb7X_qoDmEsvQ@mail.gmail.com>
References: <20121012073053.GC17026@sigill.intra.peff.net>
	<20121012073559.GB16441@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 12 15:39:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMfSc-0002gQ-RM
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 15:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970Ab2JLNjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 09:39:20 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:61547 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311Ab2JLNjT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 09:39:19 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1996928lag.19
        for <git@vger.kernel.org>; Fri, 12 Oct 2012 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=85x7Y40TJsiL3iu7hKOrmtShMHCNAhSrdIkleFnASEQ=;
        b=XFDXiAZwV2ULwx70qm2cpXh5ORgEXJg/y64x4s6MnYj1Pgbt+vCWomY8oAZMy0Rbg7
         9j6qeOjaUvIv13mV2WYQ54L6LG55YCJGUs8wx4IRrfg+hC00Pyen3g0z1qY06KXBW4Py
         G5csqPEia+eFqsU6a5jehGi8tI22EHgsS7f9d47q7gAjc7oojiMzZDCwBMddUIvs4/B0
         IesRDeA4Dw+evtdc8KtQlsGj7Nh+1+wAtFB/BeRkV7wRf8GfCjZt3zdnxlEEzlOw5FHy
         LSxVyah7udhA0vJoqOZCCebVpBJlxfVk0xpodLcxgrvjdtm2r19w1duQ1z0+/US3LjXO
         /eBw==
Received: by 10.112.38.137 with SMTP id g9mr1751386lbk.79.1350049157963; Fri,
 12 Oct 2012 06:39:17 -0700 (PDT)
Received: by 10.112.112.38 with HTTP; Fri, 12 Oct 2012 06:39:17 -0700 (PDT)
In-Reply-To: <20121012073559.GB16441@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207544>

Nice work sorting this out. I don't see the commit on github
(https://github.com/git/git/commits/master) yet but once the code is
available I'll be happy to re-test if needed.


On Fri, Oct 12, 2012 at 3:35 AM, Jeff King <peff@peff.net> wrote:
> When we get an http 401, we prompt for credentials and put
> them in our global credential struct. We also feed them to
> the curl handle that produced the 401, with the intent that
> they will be used on a retry.
>
> When the code was originally introduced in commit 42653c0,
> this was a necessary step. However, since dfa1725, we always
> feed our global credential into every curl handle when we
> initialize the slot with get_active_slot. So every further
> request already feeds the credential to curl.
>
> Moreover, accessing the slot here is somewhat dubious. After
> the slot has produced a response, we don't actually control
> it any more.  If we are using curl_multi, it may even have
> been re-initialized to handle a different request.
>
> It just so happens that we will reuse the curl handle within
> the slot in such a case, and that because we only keep one
> global credential, it will be the one we want.  So the
> current code is not buggy, but it is misleading.
>
> By cleaning it up, we can remove the slot argument entirely
> from handle_curl_result, making it much more obvious that
> slots should not be accessed after they are marked as
> finished.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c        | 6 ++----
>  http.h        | 3 +--
>  remote-curl.c | 2 +-
>  3 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/http.c b/http.c
> index 9334386..0a74345 100644
> --- a/http.c
> +++ b/http.c
> @@ -744,8 +744,7 @@ char *get_remote_object_url(const char *url, const char *hex,
>         return strbuf_detach(&buf, NULL);
>  }
>
> -int handle_curl_result(struct active_request_slot *slot,
> -                      struct slot_results *results)
> +int handle_curl_result(struct slot_results *results)
>  {
>         if (results->curl_result == CURLE_OK) {
>                 credential_approve(&http_auth);
> @@ -758,7 +757,6 @@ int handle_curl_result(struct active_request_slot *slot,
>                         return HTTP_NOAUTH;
>                 } else {
>                         credential_fill(&http_auth);
> -                       init_curl_http_auth(slot->curl);
>                         return HTTP_REAUTH;
>                 }
>         } else {
> @@ -817,7 +815,7 @@ static int http_request(const char *url, void *result, int target, int options)
>
>         if (start_active_slot(slot)) {
>                 run_active_slot(slot);
> -               ret = handle_curl_result(slot, &results);
> +               ret = handle_curl_result(&results);
>         } else {
>                 error("Unable to start HTTP request for %s", url);
>                 ret = HTTP_START_FAILED;
> diff --git a/http.h b/http.h
> index 0bd1e84..0a80d30 100644
> --- a/http.h
> +++ b/http.h
> @@ -78,8 +78,7 @@ extern void finish_all_active_slots(void);
>  extern void run_active_slot(struct active_request_slot *slot);
>  extern void finish_active_slot(struct active_request_slot *slot);
>  extern void finish_all_active_slots(void);
> -extern int handle_curl_result(struct active_request_slot *slot,
> -                             struct slot_results *results);
> +extern int handle_curl_result(struct slot_results *results);
>
>  #ifdef USE_CURL_MULTI
>  extern void fill_active_slots(void);
> diff --git a/remote-curl.c b/remote-curl.c
> index 4281262..aefafd3 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -369,7 +369,7 @@ static int run_slot(struct active_request_slot *slot)
>         slot->curl_result = curl_easy_perform(slot->curl);
>         finish_active_slot(slot);
>
> -       err = handle_curl_result(slot, &results);
> +       err = handle_curl_result(&results);
>         if (err != HTTP_OK && err != HTTP_REAUTH) {
>                 error("RPC failed; result=%d, HTTP code = %ld",
>                       results.curl_result, results.http_code);
> --
> 1.8.0.rc2.3.g303f317
