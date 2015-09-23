From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 23:47:41 -0700
Message-ID: <xmqqa8sdzl6a.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 08:47:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZedqG-0004Gy-7x
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 08:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbbIWGro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 02:47:44 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34668 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbbIWGrn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 02:47:43 -0400
Received: by padhy16 with SMTP id hy16so32204067pad.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 23:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uhrKU/PI9HgvmrNJSAU9cdEjDqScpAwkBDYSWt1fBvM=;
        b=ejWrDsvBIDyMSj64+CjO/o1RvWfQhCcKZRfRivRGfIACa+FebZmOfRfcyjl6VGKJPT
         AVLwtIcSgF8D80viyXnaUNJXWufoGRqx2aXDSHz0bVWeax1cZu+UC/Q/rsf4B95j+sPn
         P8V/mcsqRZ4XFm+UqJzG4rydUXT88kT+3F1PGRbabTEagcJIVs4Tvq4GZw8XR405DqLX
         grDsvj46hlOIu/P3TeisfcA/9jfYlAq1DxsVO+FzQrk375xfGenyexgjEInH+sPpYIGh
         nffvP1wGrDJKXXX6sIj1fvHr0ktWtLnUA3c/qB22P7NNboiTVAuI3d8zTM8GTA4AJwsB
         pVkA==
X-Received: by 10.68.197.97 with SMTP id it1mr35974485pbc.4.1442990862860;
        Tue, 22 Sep 2015 23:47:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id xa4sm1788753pac.28.2015.09.22.23.47.41
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 23:47:42 -0700 (PDT)
In-Reply-To: <1442972732-12118-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 22 Sep 2015 18:45:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278470>

Stefan Beller <sbeller@google.com> writes:

> +static void pp_buffer_stderr(struct parallel_processes *pp)
> +{
> +	int i;
> +
> +	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
> +		if (errno == EINTR)
> +			continue;
> +		pp_cleanup(pp);
> +		die_errno("poll");
> +	}
> +
> +	/* Buffer output from all pipes. */
> +	for (i = 0; i < pp->max_processes; i++) {
> +		if (pp->children[i].in_use &&
> +		    pp->pfd[i].revents & POLLIN)
> +			if (strbuf_read_once(&pp->children[i].err,
> +					     pp->children[i].process.err, 0) < 0)
> +				if (errno != EAGAIN)
> +					die_errno("read");
> +	}
> +}

I think it is a good thing that the caller is passing the whole pp
to this function.  One thing you may want to consider is to adjust
the poll(2) timeout longer when the process slots are full.

There is nothing you can gain by returning early due to timeout
without doing anything from this function when you know you cannot
start a new process (here, I am assuming that your poll(2) would be
unblocked for a disconnect when one of the processes exits, letting
you return and letting the caller call collect_finished(), which in
turn would allow us to make some progress).

On the other hand, during the early ramp-up period, you may want to
use a shorter poll(2) timeout to give the caller a chance to spawn
more processes sooner.  But that falls into performance tuning that
can and should be left to a later follow-up patch after we get the
basic machinery right.
