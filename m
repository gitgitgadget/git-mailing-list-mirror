From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Mon, 14 Sep 2015 10:56:06 -0700
Message-ID: <xmqqsi6gx4uh.fsf@gitster.mtv.corp.google.com>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
	<1442012994-20374-3-git-send-email-sbeller@google.com>
	<xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaBvVWT1OPMxUAU9N2oaC5TT5wwWew5jS0k_o5J10sKfA@mail.gmail.com>
	<20150914171736.GA1548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:56:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXzC-0005kl-Gx
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbbINR4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:56:10 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35152 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbbINR4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:56:08 -0400
Received: by pacfv12 with SMTP id fv12so153067475pac.2
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4+nVUIcL65JasjA1VY7dCEAEFwyK89fTLFKZx+icw6c=;
        b=iH/dn1o8QPFwaN7WRBsCQ7uy2AbhpjpKzVUsOMgaJ86vz2s4MOqfA6Lu1ZfB7hFHED
         zfwOucPbErmMNjSP9kaXwoa1FeqOJ2tZkbDwVOIFIwNn9hQXDIqEW2r+2eg81GVDg2DR
         mrl3xtK8hO4baSgBaTkiLs2HVQ6mw/aKx982et8NpDiFJzw13JNWr7QtqgXsmaTRTjFW
         4kPk0+OSaYuBi/EFrBWWJPxng1E79XnZDh+idYc3bsZLbvSLPPBaOcq66SLQC9aiu12j
         JTlaWhZkMe7dNr6U4T4SPt/8DwbHwrj4L6CAe4x1YzPJFaN4kTcCCoE6IGI2IcHtzzjx
         tlnQ==
X-Received: by 10.68.213.200 with SMTP id nu8mr37370520pbc.35.1442253367958;
        Mon, 14 Sep 2015 10:56:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id et3sm17503582pad.43.2015.09.14.10.56.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:56:07 -0700 (PDT)
In-Reply-To: <20150914171736.GA1548@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Sep 2015 13:17:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277854>

Jeff King <peff@peff.net> writes:

> I don't think you need exact timing information.  This is no different
> than running the commands themselves, with stdout and stderr writing to
> a pty that your terminal emulator will then read() from. If the program
> produces intermingled stdout/stderr that clogs up the terminal, that is
> its problem.
>
> The only difference is that we're going to save it and later replay it
> all very quickly.  So I think it would be sufficient just to retain the
> original order.
>
>> I will add documentation explaining why the async output case
>> will only deal with one channel. I chose stderr as that's already
>> available and needed in this use case.
>
> I suspect you could just set child->stdout_to_stderr in this case, and
> then you get your ordering for free.

I think we are in agreement; that is exactly what I wanted to say
when I said "I offhand do not think the latter [i.e. the callers
have to dup them together] is unreasonable".  Thanks for stating it
more clearly and explicitly.

> To handle multiple channels, I think you could just do a linked list of
> buffers rather than a single strbuf. Like:
>
>   struct io_chunk {
> 	int channel;
> 	char *buf;
> 	size_t len;
> 	struct io_chunk *next;
>   };
>
> and just keep appending chunks to the list (and to dump them, just walk
> the list, writing each to the appropriate channel descriptor).

Perhaps, but let's not overdesign things before we have a concrete
example codepath that benefits from such a thing.  It is hard to
detect a misdesign without a real usage pattern.
