From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] run-command: Fix early shutdown
Date: Tue, 20 Oct 2015 11:41:19 -0700
Message-ID: <xmqqa8rd8jsg.fsf@gitster.mtv.corp.google.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
	<1445279086-31066-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:41:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zobqi-0003yZ-1e
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 20:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbbJTSlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 14:41:23 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35078 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbbJTSlV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 14:41:21 -0400
Received: by pasz6 with SMTP id z6so28847057pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3Gg17Egcs1gQPUHq6A8SYH+8hK3lBNCHNkKwgruH078=;
        b=J3qFVWkRN0p/DRXmYjhjsvAvqK1nClf+mAkVe8IKy7HxKsU7hM2ezg1muBQVoJR/jL
         uFkyrXq7kMZ0KQrXuS913xYQvhp9MwVO87HUyAuaLcfJX2oSO16U5XPiZPX10ZjkVGtV
         VPXLlDbBSoVTMCZsem8qcKbKN4YQibTR24U6287+ChUQ+fS3MMLU64AWP2f2N9XSW5qs
         pOLGqMA4cmOBmpmRLiC6877x0Gch7BkYB68L+jEd9UuN/AD7+i6A1EWM4UQyMg3LSUka
         SA99so/xdV+udfS6YRUz4kRviREreKZg5vxS3PGVRhUmGGRtkhQ4nk9nwflra/6/LMkB
         TeFQ==
X-Received: by 10.66.121.195 with SMTP id lm3mr5607705pab.84.1445366480528;
        Tue, 20 Oct 2015 11:41:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:e1b1:e6e0:dc10:8032])
        by smtp.gmail.com with ESMTPSA id yg2sm5006318pbb.79.2015.10.20.11.41.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 11:41:19 -0700 (PDT)
In-Reply-To: <1445279086-31066-2-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 19 Oct 2015 11:24:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279931>

Stefan Beller <sbeller@google.com> writes:

> The return value of `pp_collect_finished` indicates if we want to shutdown
> the parallel processing early. Both returns from that function should
> return any accumulated results.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Makes sense.  The code could "break" out of the loop, leaving only
one return site in the function, which would be a way to ensure that
we'd consistently return the accumulated result, but this would also
do.

Thanks.

>  run-command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index ef3da27..8f47c6e 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1077,7 +1077,7 @@ static int pp_collect_finished(struct parallel_processes *pp)
>  	while (pp->nr_processes > 0) {
>  		pid = waitpid(-1, &wait_status, WNOHANG);
>  		if (pid == 0)
> -			return 0;
> +			return result;
>  
>  		if (pid < 0)
>  			die_errno("wait");
