From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] run-command: add an asynchronous parallel child processor
Date: Tue, 29 Sep 2015 20:12:31 -0700
Message-ID: <xmqqa8s4a9cw.fsf@gitster.mtv.corp.google.com>
References: <1443482046-25569-1-git-send-email-sbeller@google.com>
	<1443482046-25569-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 05:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zh7ot-0001lH-6k
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 05:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbbI3DMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2015 23:12:35 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34789 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbI3DMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 23:12:34 -0400
Received: by padhy16 with SMTP id hy16so25060923pad.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2015 20:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cxm6ZFc1seuiQ3b/bQx674/3MJ7abdht6Cz0Fc+z4o4=;
        b=NsjAcWtPZtsnfBegv/4GskUWzlwz823rb6aax6H0tc+mpYjkJmpjRxFohMpThh8WsX
         v7aDx/eVig6aa9MxiThzONBcAPHf1Mx4Mx2lDzMkeBV6R63DVlLm5RwVboLZBBgACCNK
         hbVf0HPlyh9xZYkssDPCuUfch7YGUdIlKcTu4VH3Fa54Z2TrTtyJSVioJmw+rIEtURnj
         RIvYUPlT9QMref69yOj+S65uj1B5J6O2R/TriaLvHJYQUZLRo9W1x2XSSbuOrjAiVAqL
         Ild8QRF3Taincw4Wc2WzWziSxDutNHLrk9Fww4QP0LUEUJRp1hBD6bV0q4gZTMOXu0GC
         PNWQ==
X-Received: by 10.68.100.36 with SMTP id ev4mr1822651pbb.119.1443582753901;
        Tue, 29 Sep 2015 20:12:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2c4a:a656:af73:8140])
        by smtp.gmail.com with ESMTPSA id rb8sm28235016pbb.63.2015.09.29.20.12.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 29 Sep 2015 20:12:32 -0700 (PDT)
In-Reply-To: <1443482046-25569-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 28 Sep 2015 16:14:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278838>

Stefan Beller <sbeller@google.com> writes:

> +	while (1) {
> +		int i;
> +		int output_timeout = 100;
> +		int spawn_cap = 4;
> +
> +		if (!no_more_task) {
> +			for (i = 0; i < spawn_cap; i++) {
> +				int code;
> +				if (pp->nr_processes == pp->max_processes)
> +					break;
> +
> +				code = pp_start_one(pp);
> +				if (!code)
> +					continue;
> +				if (code < 0) {
> +					pp->shutdown = 1;
> +					kill_children(pp, SIGTERM);
> +				}
> +				no_more_task = 1;
> +				break;
> +			}
> +		}
> +		if (no_more_task && !pp->nr_processes)
> +			break;

I may have comments on other parts of this patch, but I noticed this
a bit hard to read while reading the end result.

Losing the outer "if (!no_more_task)" and replacing the above with

	for (no_more_task = 0, i = 0;
             !no_more_task && i < spawn_cap;
             i++) {
        	... do things that may or may not set
                ... no_more_task
	}
	if (no_more_task && ...)
        	break;

would make it clear that regardless of spawn_cap, no_more_task is
honored.

Also I think that having the outer "if (!no_more_task)" and not
having "no_more_task = 0" after each iteration is buggy.  Even when
next_task() told start_one() that it does not have more tasks for
now, as long as there are running processes, it is entirely plausible
that next call to next_task() can return "now we have some more task
to do".

Although I think it would make it unsightly, if you want to have the
large indentation that protects the spawn_cap loop from getting
entered, the condition would be 

	if (!pp->shutdown) {
		for (... spawn_cap loop ...) {
                	...
		}
	}

That structure could make sense.  But even then I would probably
write it more like

	...
	int spawn_cap = 4;

	pp = pp_init(...);
        while (1) {
        	int no_more_task = 0;

                for (i = 0;
                     !no_more_task && !pp->shutdown && i < spawn_cap;
                     i++) {
			...
                        code = start_one();
                        ... set no_more_task to 1 as needed
                        ... set pp->shutdown to 1 as needed
		}
                if (no_more_task && !pp->nr_processes)
			break;
		buffer_stderr(...);
                output(...);
                collect(...);
	}

That is, you need to have two independent conditions that tell you
not to spawn any new task:

 (1) You called start_one() repeatedly and next_task() said "nothing
     more for now", so you know calling start_one() one more time
     without changing other conditions (like draining output from
     running processes and culling finished ones) will not help.

     Letting other parts of the application that uses this scheduler
     loop (i.e. drain output, cull finished process, etc.) may
     change the situation and you _do_ need to call start_one() when
     the next_task() merely said "nothing more for now".

     That is what no_more_task controls.

 (2) The application said "I want the system to be gracefully shut
     down".  next_task() may also have said "nothing more for now"
     and you may have set no_more_task in response to it, but unlike
     (1) above, draining and culling must be done only to shut the
     system down, the application does not want new processes to be
     added.  You do not want to enter the spawn_cap loop when it
     happens.

     That is what pp->shutdown controls.
