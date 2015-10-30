From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCHv2 1/8] run_processes_parallel: Add output to tracing messages
Date: Thu, 29 Oct 2015 21:10:16 -0400
Message-ID: <CAPig+cToAFAPhhFhOd_MF+EUcvRUjWOooeZH4uDy3-d9GEq73g@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-2-git-send-email-sbeller@google.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 02:10:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZryDA-0002Di-Fq
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 02:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474AbbJ3BKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 21:10:20 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35285 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451AbbJ3BKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 21:10:17 -0400
Received: by vkex70 with SMTP id x70so2905644vke.2
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jefcBnNX6aDuMx7kmixObRuhrxlnwK4ciiDX02lL0IQ=;
        b=DJs3qTHC1+qCMpcAqeOkM2q3w2WXCnh0Ndxjb4F8EBAbQkPuR8k7ILZsvEHI2MPRGR
         67Fz32EYKP8Vu474HcfdWPS4s7iLkfl6/kenWwvOgLCWdgf9J3vdVD2MHyOPYATshKVM
         Vq8eHODFqMAVlE5FWqehT9kVMlpIEzw+prEP0uU3s5X41cNC+aFAooqcvJiacoIqsBcJ
         srdPLz4dngU34MfHmX/lfOtYblVmzE4ZRMNaMnHAp5NzjKQXgtYnCeJGP3+PJNCD+wVR
         GCUlyOaQ6ksnty/H1EGLRT9tLVlfX8B4PQ+5RnehRBQ7sgmTV6328Q6Zc8qNtHNuVG+w
         CSxg==
X-Received: by 10.31.52.73 with SMTP id b70mr3557860vka.45.1446167416832; Thu,
 29 Oct 2015 18:10:16 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Thu, 29 Oct 2015 18:10:16 -0700 (PDT)
In-Reply-To: <1446074504-6014-2-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280468>

On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> run_processes_parallel: Add output to tracing messages

This doesn't really say much. I guess you mean that the intention is
to delimit a section in which output from various tasks may be
intermixed. Perhaps:

    run_processes_parallel: delimit intermixed task output

or something.

> This commit serves 2 purposes. First this may help the user who
> tries to diagnose intermixed process calls. Second this may be used
> in a later patch for testing. As the output of a command should not
> change visibly except for going faster, grepping for the trace output
> seems like a viable testing strategy.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/run-command.c b/run-command.c
> index 82cc238..49dec74 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -959,6 +959,9 @@ static struct parallel_processes *pp_init(int n,
>                 n = online_cpus();
>
>         pp->max_processes = n;
> +
> +       trace_printf("run_processes_parallel: preparing to run up to %d children in parallel", n);

s/children/tasks/ maybe?

Minor: Perhaps drop "in parallel" since the parallelism is already
implied by the "run_processes_parallel" prefix.

> +
>         pp->data = data;
>         if (!get_next_task)
>                 die("BUG: you need to specify a get_next_task function");
> @@ -988,6 +991,7 @@ static void pp_cleanup(struct parallel_processes *pp)
>  {
>         int i;
>
> +       trace_printf("run_processes_parallel: parallel processing done");

Minor: Likewise, perhaps just "done" rather than "parallel processing
done" since the "run_processes_parallel" prefix already implies
parallelism.

>         for (i = 0; i < pp->max_processes; i++) {
>                 strbuf_release(&pp->children[i].err);
>                 child_process_deinit(&pp->children[i].process);
> --
> 2.5.0.281.g4ed9cdb
