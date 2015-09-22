From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 14:31:04 -0700
Message-ID: <CAGZ79kYwMrpU-gW6FsbH1W4TRPisZH9GJoyZ6hoimXdxz4HCYQ@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-7-git-send-email-sbeller@google.com>
	<xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbUkUSAP+muhYxTwHZdD+ojJYXjogZfRXs0PemEdcqfbA@mail.gmail.com>
	<xmqqtwqm2puk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 23:31:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeV9o-0003Es-EX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 23:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935002AbbIVVbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 17:31:08 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35514 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934883AbbIVVbF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 17:31:05 -0400
Received: by ykdz138 with SMTP id z138so23540436ykd.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 14:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jcqgccnIELL7fvg8859TU7AzzVoAy7TLsBd99buPHXw=;
        b=a9wliXIcZAWyFq69eNCJvpp2wX6m9+1w3SW2snxxlb0nLrYh5NcURUMaOjR9Pze5gs
         D2IC2l1AjMKK/8xvk5pV0nyq1SSu8N+WkRw+8Ae8qwspcPO4nWgH/3vIttrr1lRFdORL
         6ubq95b6dy2dRbJ6wpWZwWSxiv4Kof3y35D4qzQksEXwjJv0N91xzpJeThA7c2y8DGeH
         htS1xOlSsOGj5vTfp9N1pklkGviqIbRRs/8gwa8RJhAWQlaZMXcfRYg58jJbO2vn27M2
         laQYZQ2cx//1pl7VQQDoKhdU/ZAJxTowD5Gsf3p8gHejCFL0W2EXlAF9wC5SkStYdkyw
         Q/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jcqgccnIELL7fvg8859TU7AzzVoAy7TLsBd99buPHXw=;
        b=N9pSKJc/kUurH0ezr1yv/tdhYq91tYrgVbjh4LJeDkCd6l3MY7fRgFIwA2piIbZ188
         nxnud82bJ0hbM6hfhui4jd31MT8+mOx1tNspbSq/wymVNGjVDplxHR8iGkG5pZ35KESp
         JHJsmeGz2+igtoVMcp/nPHsMnhbx7z56fsKj6U22xIUCP1qMRT79mMIEAyaNITlSm0lG
         V5CxRxdWAz+znlk1dOvikpTU1oFKhQ73b3P6ZPAsMDaWjFeGTffwSAooK5XfszFtutay
         OekYKg/dTmbmCE8OUG/mNOHeLi6hrhfCZ3/8DmeuY3RadvR69p3a68inBvTnyhFoL4AG
         bMaA==
X-Gm-Message-State: ALoCoQnefgk1DCaBQjgJNgYtxCRHDbkoiOwYDi5SDOXju1Lmb9UZaatEGFOa8SRp4ljzT8r0CAiU
X-Received: by 10.170.190.133 with SMTP id h127mr23430183yke.115.1442957464790;
 Tue, 22 Sep 2015 14:31:04 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 22 Sep 2015 14:31:04 -0700 (PDT)
In-Reply-To: <xmqqtwqm2puk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278439>

On Tue, Sep 22, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So how would you find out when we are done?
>
>         while (1) {
>                 if (we have available slot)
>                         ask to start a new one;
>                 if (nobody is running anymore)
>                         break;
>                 collect the output from running ones;
>                 drain the output from the foreground one;
>                 cull the finished process;
>         }
>

Personally I do not like the break; in the middle of
the loop, but that's personal preference, I'd guess.
I'll also move the condition for (we have available slot)
back inside the called function.

So I am thinking about using this in the reroll instead:

    run_processes_parallel_start_as_needed(&pp);
    while (pp.nr_processes > 0) {
        run_processes_parallel_buffer_stderr(&pp);
        run_processes_parallel_output(&pp);
        run_processes_parallel_collect_finished(&pp);
        run_processes_parallel_start_as_needed(&pp);
    }


This eliminates the need for the flag and also exits the loop just
after the possible startup of new processes.
