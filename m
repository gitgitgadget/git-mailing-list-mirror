From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Tue, 7 Aug 2012 10:18:37 +0800
Message-ID: <CALUzUxoKHSw_8U0S_jmrhW3fWF0OPL39+4q7385-_34xq8MXqQ@mail.gmail.com>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
	<7vboio231n.fsf@alter.siamese.dyndns.org>
	<1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
	<20120806193958.GA10039@sigill.intra.peff.net>
	<1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
	<20120806213404.GA14320@sigill.intra.peff.net>
	<1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
	<20120806223113.GA16298@sigill.intra.peff.net>
	<m2pq73zkmu.fsf@igel.home>
	<20120807002318.GA17498@sigill.intra.peff.net>
	<20120807003541.GA18219@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyZOF-0001qe-8t
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 04:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab2HGCSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 22:18:39 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:56753 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757030Ab2HGCSi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 22:18:38 -0400
Received: by ghrr11 with SMTP id r11so3218487ghr.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 19:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wyqfcge0Z0r2dKzJNSzQ2CKrUGoypzCFpltT9Bh2A14=;
        b=dVbhkoxSDM7xeeesuPDDKzq1Ssi1cSmQULKi0w47WWzMmGq0AwwWpNg8EnqQEJNX+i
         P0172TA2sXFGqobt5Qsa3p6VvAGF180g4gZJioHTeCyOhyr3AyUCOnKITonM/Fa6zKVK
         XZx5l4VH8TOj5kS/w7bwg7GHAOZyn+ThqFHNNtuio1yv93wctSU7NRTRTI3wQTMyeDy+
         51ZhRYqnZ6Cn2DwtfGwqzmDZplVrh4M4eOa/fD1XlgdLbBWWoDvHGGYc77k7mIANAk5n
         qmgQ75XF2nvAbfvMo5uHb6Uw60hSTD7enmPz6D9Ge12NaS8I8ic8Id/FFyUMGW5CU2t+
         Ph7A==
Received: by 10.50.94.231 with SMTP id df7mr7138402igb.74.1344305917128; Mon,
 06 Aug 2012 19:18:37 -0700 (PDT)
Received: by 10.43.110.202 with HTTP; Mon, 6 Aug 2012 19:18:37 -0700 (PDT)
In-Reply-To: <20120807003541.GA18219@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203005>

On Tue, Aug 7, 2012 at 8:35 AM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] terminal: seek when switching between reading and writing
>
> When a stdio stream is opened in update mode (e.g., "w+"),
> the C standard forbids switching between reading or writing
> without an intervening positioning function. Many
> implementations are lenient about this, but Solaris libc
> will flush the recently-read contents to the output buffer.
> In this instance, that meant writing the non-echoed password
> that the user just typed to the terminal.
>
> Fix it by inserting a no-op fseek between the read and
> write.
>
> The opposite direction (writing immediately followed by
> reading) is also disallowed, but our fflush immediately
> after printing the prompt is sufficient to satisfy the
> standard.
> ---
>  compat/terminal.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 6d16c8f..bbb038d 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -59,6 +59,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
>
>         r = strbuf_getline(&buf, fh, '\n');
>         if (!echo) {
> +               fseek(fh, SEEK_CUR, 0);
>                 putc('\n', fh);
>                 fflush(fh);
>         }

This works. Ben, does this work for you too?

-- 
Cheers,
Ray Chuan
