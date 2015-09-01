From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pkt-line: show packets in async processes as "sideband"
Date: Tue, 01 Sep 2015 15:13:25 -0700
Message-ID: <xmqq1tehrdoa.fsf@gitster.mtv.corp.google.com>
References: <20150901202215.GA17370@sigill.intra.peff.net>
	<20150901202412.GA8020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:13:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWto3-00009s-3m
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbbIAWN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:13:27 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32973 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbIAWN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:13:27 -0400
Received: by paap5 with SMTP id p5so1490044paa.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/PyvBdPe51f3ktyQeTyfrHqaQ1GGi3/0uMdMhomCGo8=;
        b=NtNFLaFAhXfW5eVQveF5EVDCjH5DV0fpu/4cAylFuWkDszvpIguiagzXBwm471mgEe
         U3GvttqMnufCWs6Ag7HOj+I746q2XG0g33V0t3jTUtsQf6abKvxSmFyiIJjG0hs9spOy
         PS51oFBdwZ7kgrvokkhcv6y44jyokBEtCWH4PFp8cJvF3ke0TCTnBpBGf0JXjdYgMLZw
         VX2miaZOANWj9xj7kRtIOB4nEKSFi8XtP5/w9y65gL6aVokGXlK2kyNI67d+vW8sGSiI
         koVshLArFOpECxaPZafA6MWxjsF9moSm2UHiOTEXXptQhg23Tj74H7OVPePnQ7AXJeZt
         QT4w==
X-Received: by 10.68.65.47 with SMTP id u15mr50451080pbs.127.1441145606746;
        Tue, 01 Sep 2015 15:13:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id cs6sm5046201pdb.40.2015.09.01.15.13.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 15:13:26 -0700 (PDT)
In-Reply-To: <20150901202412.GA8020@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Sep 2015 16:24:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277051>

Jeff King <peff@peff.net> writes:

> What we really need is thread-local storage for
> packet_trace_identity. But the async code does not provide
> an interface for that, and it would be messy to add it here
> (we'd have to care about pthreads, initializing our
> pthread_key_t ahead of time, etc).

True.

> So instead, let us just assume that any async process is
> handling sideband data. That's always true now, and is
> likely to remain so in the future.

Hmm, does Stefan's thread-pool thing interact with this decision in
any way?
>
> The output looks like:
>
>    packet:  sideband< \1000eunpack ok0019ok refs/heads/master0000
>    packet:      push< unpack ok
>    packet:      push< ok refs/heads/master
>    packet:      push< 0000
>    packet:  sideband< 0000
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pkt-line.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index 08a1427..62fdb37 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -1,5 +1,6 @@
>  #include "cache.h"
>  #include "pkt-line.h"
> +#include "run-command.h"
>  
>  char packet_buffer[LARGE_PACKET_MAX];
>  static const char *packet_trace_prefix = "git";
> @@ -11,6 +12,11 @@ void packet_trace_identity(const char *prog)
>  	packet_trace_prefix = xstrdup(prog);
>  }
>  
> +static const char *get_trace_prefix(void)
> +{
> +	return in_async() ? "sideband" : packet_trace_prefix;
> +}
> +
>  static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
>  {
>  	if (!sideband) {
> @@ -57,7 +63,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  	strbuf_init(&out, len+32);
>  
>  	strbuf_addf(&out, "packet: %12s%c ",
> -		    packet_trace_prefix, write ? '>' : '<');
> +		    get_trace_prefix(), write ? '>' : '<');
>  
>  	/* XXX we should really handle printable utf8 */
>  	for (i = 0; i < len; i++) {
