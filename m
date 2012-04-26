From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Thu, 26 Apr 2012 09:13:03 -0700
Message-ID: <xmqq62cma2uo.fsf@junio.mtv.corp.google.com>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
	<87d36uxzfw.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Karlsson <mk@acc.umu.se>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 18:14:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNRLB-0003uE-E6
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 18:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757867Ab2DZQNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 12:13:08 -0400
Received: from mail-ee0-f74.google.com ([74.125.83.74]:47565 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659Ab2DZQNG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 12:13:06 -0400
Received: by eekc41 with SMTP id c41so118378eek.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 09:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=8+V31NG8t6q3oPoH68/hQQ+9CpQJ3T8oGpf3nU2L/aE=;
        b=XGGgrsxcnxGb3l5dSftGBOTx8F8fKQczVzYU1SoAV/acXazMC3jh9HwLqxnXMS3mGl
         T7EbewdfaxSWWu6nZj5iKF353/N+pjY0LChPV37rINBhzqnvBtEx0eZitauexUUaqDMV
         myYH2U63f9lRZxuEXvCsotKFGX65r4pbqUTuoIaoat9gHp4XncsBssK5cB6D/NxJ6DFL
         hFDDCNe3avHudhcfGM3Nw8tFKZtmLCFb+ilq61ktHG926NyajiubMZVG8afDXmv680fn
         bPWNPRErC0WK8zpFJwhgX3KJo18OEyfO2hZ/m2e/XQOg7w9aXniUUp+oXsHdKKUkElzx
         gpDA==
Received: by 10.14.47.80 with SMTP id s56mr2185673eeb.6.1335456784533;
        Thu, 26 Apr 2012 09:13:04 -0700 (PDT)
Received: by 10.14.47.80 with SMTP id s56mr2185654eeb.6.1335456784393;
        Thu, 26 Apr 2012 09:13:04 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id a14si3277706een.0.2012.04.26.09.13.04
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 09:13:04 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 33E8220005C;
	Thu, 26 Apr 2012 09:13:04 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 80011E125C; Thu, 26 Apr 2012 09:13:03 -0700 (PDT)
In-Reply-To: <87d36uxzfw.fsf@rho.meyering.net> (Jim Meyering's message of
	"Thu, 26 Apr 2012 17:52:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlFgu+MVWfzEMXgUxUCKpmrnrpfF1DCMSNhxSANJI8ynkBdxw3Ob341/Q6BmvBIJEaP7HKmla54lAEczGs06jr6uVZ0qHKvEkt8iUtHsFY0vTSLziE3HM4ltQFAzD2nYUia4uOLy7POr9WrsZkklDsC2q92U5fKPtvoF6NRFmbIiwxzino=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196377>

Jim Meyering <jim@meyering.net> writes:

> What do you think about replacing those two append-if-needed two-liners:
>
>     if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
>             strbuf_addch(&buffer2, '/');
>
> by something that readably encapsulates the idiom:
>
>     strbuf_append_if_absent (&buffer2, '/');
>
> (though the name isn't particularly apt, because you might
> take "absent" to mean "not anywhere in the string," so maybe
>   strbuf_append_if_not_already_at_end (ugly) or
>   strbuf_append_uniq
> )

I am not good at names, but strbuf_terminate_with(&buffer2, '/')
perhaps?

> There are several other uses that would benefit from such a transformation:
> To find the easy ones, I ran this:
>
>   git grep -B1 "strbuf_addch.*'"|grep -A1 '!='
>
> I've manually marked/separated the ones that don't apply.
>
> Note how only 2 of the 6 candidates ensure that length is positive
> before using ".len - 1":

Yikes, that is embarrasing ;-)

>
> ------------------------------------
> builtin/branch.c-	if (!buf.len || buf.buf[buf.len-1] != '\n')
> builtin/branch.c:		strbuf_addch(&buf, '\n');
> --
> builtin/fmt-merge-msg.c-		if (out->buf[out->len - 1] != '\n')
> builtin/fmt-merge-msg.c:			strbuf_addch(out, '\n');
> --
> builtin/log.c-		if (filename.buf[filename.len - 1] != '/')
> builtin/log.c:			strbuf_addch(&filename, '/');
> --
> builtin/notes.c-	if (buf.buf[buf.len - 1] != '\n')
> builtin/notes.c:		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
> --
> refs.c-		if (real_pattern.buf[real_pattern.len - 1] != '/')
> refs.c:			strbuf_addch(&real_pattern, '/');
> --
> strbuf.h-	if (sb->len && sb->buf[sb->len - 1] != '\n')
> strbuf.h:		strbuf_addch(sb, '\n');
