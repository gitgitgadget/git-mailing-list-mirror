From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 04 Apr 2013 10:25:30 -0700
Message-ID: <7v6202jjhx.fsf@alter.siamese.dyndns.org>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
 <1365091293-23758-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNnvG-00015F-I7
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763989Ab3DDRZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 13:25:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763982Ab3DDRZc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 13:25:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44C3B1399D;
	Thu,  4 Apr 2013 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=25o/7+cNFtybq0UjSIxoUmFSKYs=; b=nGDiPO
	Uc/Coc9TAmEwHpBKEBMdAodH2gBsAzTO4nEQjykqU/9M9rGBc/5Ykf8juReag4kC
	eVRftN/OgrBF47BwmSsWbRYBYTIn4iaEtuBQXFDOBMRdS8Q6B2P7qy3EUPOtC9FH
	kZQIajyx+IW2Gfe+5QpfAYnonXfTVi7nVF8g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wH8ZqsHD6TWqV86lBq6xrHqXLKpTCT9L
	PZa/5tUcQTGzToXig6yvX+lrqopu2JhCHMKCenoRMwFLBsv63N+sJTC6OCrU8iVv
	EZE3n0Uvu0hZjy5dTZHDQ4MB6CNggZ6sDTjfEeU56WHtduECYuCvH75zC9Dd0ft4
	nDtLw9Z0Osk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39EB21399C;
	Thu,  4 Apr 2013 17:25:32 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B17C31399B; Thu,  4 Apr
 2013 17:25:31 +0000 (UTC)
In-Reply-To: <1365091293-23758-1-git-send-email-jkoleszar@google.com> (John
 Koleszar's message of "Thu, 4 Apr 2013 09:01:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6E0D868-9D4C-11E2-A299-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220038>

John Koleszar <jkoleszar@google.com> writes:

> @@ -402,7 +404,8 @@ static void get_info_refs(char *arg)
>  
>  	} else {
>  		select_getanyfile();
> -		for_each_ref(show_text_ref, &buf);
> +		head_ref_namespaced(show_text_ref, &buf);
> +		for_each_namespaced_ref(show_text_ref, &buf);
>  		send_strbuf("text/plain", &buf);
>  	}

Whether we are namespaced or not, we used to do for_each_ref() here,
not advertising the HEAD (outside refs/ hierarchy), but we now do,
and as the first element in the output.

Am I reading the patch correctly?

Is that an unrelated but useful bugfix even for people who do not
use server namespaces?

> diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
> index ef98d95..85a5625 100755
> --- a/t/t5560-http-backend-noserver.sh
> +++ b/t/t5560-http-backend-noserver.sh
> @@ -26,6 +26,13 @@ GET() {
>  	test_cmp exp act
>  }
>  
> +GET_BODY() {
> +	REQUEST_METHOD="GET" && export REQUEST_METHOD &&
> +	run_backend "/repo.git/$1" &&
> +	sane_unset REQUEST_METHOD &&
> +	tr '\015' Q <act.out | sed '1,/^Q$/d'
> +}
> +

These "export/unset" in &&-chains will allow a failing test to
affect the next test, but that is not a new problem (existing POST
already has that problem).  Just highlighting, so that interested
people may notice and want to clean it up on top of this patch.

>  POST() {
>  	REQUEST_METHOD="POST" && export REQUEST_METHOD &&
>  	CONTENT_TYPE="application/x-$1-request" && export CONTENT_TYPE &&

Thanks, will queue.
