From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP/PATCH 3/3] submodule: helper to run foreach in parallel
Date: Fri, 21 Aug 2015 12:23:37 -0700
Message-ID: <xmqq7foo5tty.fsf@gitster.dls.corp.google.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:23:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSruj-0000qQ-0f
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 21:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbbHUTXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 15:23:40 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33262 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbHUTXj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 15:23:39 -0400
Received: by pdrh1 with SMTP id h1so30149541pdr.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OAaSOC0qEJnfOND8gEUZSYnkVmJWTVqn6T4fCnAxM6M=;
        b=IVIASMsAufdXKibuhKROLqSsb7xKp5curCWbIBHU/16nkOAl57fGimuuG2tdnLW1iJ
         fFNhdhJt+VW+lp287Tans+Jz9Z5RIXw4bY7gmj3357CIXKK/utdLSBeKeG5HLcl7kItc
         hWn025nzmD3w+2MJQV3nnvBflS5SwF3bljmh0MnH3WwHr+SVYcbiW2onLQlkziFeiUMG
         A3UojlvJNerkUrHFZ4o7B9KEVLDb0jZh3kkuQKWn23tsEcK0lPwa+vGTwHr/sNbCYNbi
         yTArnJCJU1RqyqOj/cPekkQ1RMDF2AJ1QGfIwVAJZoFNw7PCKFiIrHaLz8f85bDwab1g
         PD/Q==
X-Received: by 10.70.51.65 with SMTP id i1mr20110802pdo.90.1440185019094;
        Fri, 21 Aug 2015 12:23:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id gh5sm8640318pbc.87.2015.08.21.12.23.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 12:23:38 -0700 (PDT)
In-Reply-To: <1440121237-24576-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 20 Aug 2015 18:40:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276321>

Stefan Beller <sbeller@google.com> writes:

> +struct submodule_args {
> +	const char *name;
> +	const char *path;
> +	const char *sha1;
> +	const char *toplevel;
> +	const char *prefix;
> +	const char **cmd;
> +	struct submodule_output *out;
> +	sem_t *mutex;
> +};

I do not see what submodule_output looks like in the patch, but I
guess you are capturing _all_ output from a task and emitting
everything at the end, after the task is done?

I have to wonder if that is what people would expect and more
importantly if that is the most useful.  I am sympathetic to the
desire to avoid the output totally mixed up from different processes
emitting things in an uncoordinated manner, and "slurp everything
and then show everything in one go" is certainly _one_ way to do so,
but early feedback also counts.  Besides, because the order in which
tasks are dispatched and completed is unpredictable, you cannot
expect a machine parseable output _without_ assuming some help from
the command invoked by each task (e.g. by prefixing the task's output
with some string that identifies which submodule the output is about).

Once you assume that the command is _aware_ that it needs to help
the foreach-parallel infrastructure so that the user can sift their
collective outputs to make sense of them, wouldn't a line-buffered
intermixing also acceptable, and wouldn't it be a much lower impact
approach to solve the same problem?
