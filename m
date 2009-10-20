From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Tue, 20 Oct 2009 00:00:33 -0700
Message-ID: <7vbpk2sg6m.fsf@alter.siamese.dyndns.org>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git List" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 09:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N08iA-0002Sa-Vr
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 09:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbZJTHAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 03:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbZJTHAl
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 03:00:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbZJTHAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 03:00:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 626945FB41;
	Tue, 20 Oct 2009 03:00:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UN/6rPAmDtDjIapJvdDcY3SP3Vg=; b=ecIp9z
	39Zsv/QRTjpRkh2zVD8P1UG0D/ro00uQVgNffD5ZYYplfrRfmXjGndQeWc8A7ETu
	dXsUDxC5UMeHARCGkb3wY8kXQ5TMCvE5kQmaBBkW/YSyRmcHn18iOYy8+o6AtK3V
	HSPq19DNSaooNB+MfNNWqxyPcP4Zri5qRZ/5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e0cta6+X+TFsgtmby5ZIRVvj0IzwJXk8
	VT8wfAnEvOgujqHDCYxYtn1L8TDsLeNcYbcIQrDAxBhJe6/Siud09UzNOPytvkuO
	Kmq9R0qmNommIyBwP/Kvmp5SNVsEwbJCv15jkWFFIUtrvBeuHF98El89/uZNSp1/
	xWHcRaCxeU4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BF5D5FB3E;
	Tue, 20 Oct 2009 03:00:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC4F75FB3B; Tue, 20 Oct
 2009 03:00:35 -0400 (EDT)
In-Reply-To: <1256007988-13321-1-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Mon\, 19 Oct 2009 22\:06\:28 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 476C4B40-BD46-11DE-907F-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130767>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Currently the parsing is difficult when not all files have a newline
> at EOF, this patch ensures that even such files have a newline at the
> end of the blame output.

Thanks.  This clearly shows that blame was somewhat sloppily written in
that it never considered to be fed anything but well formed text files.

My knee-jerk reaction to the issue is that there are two reasonable
approaches to the problem:

 (1) Admit that the code is not prepared to take anything but well formed
     text files.  This will lead to adding the necessary LF after reading
     a blob and if it does not end with LF.  After all, I do not trust the
     code (iow, "me") if it is not prepared to take a blob with incomplete
     line to handle the internal comparison between blobs with incomplete
     lines.

 (2) Do the right thing, by coming up with a notation to show that the
     final line is incomplete, perhaps similar to "\No newline ..."
     notation used by "diff".

To put the last sentence of (1) differently, does the code assign blame
correctly around the last line of the original blob?  What if an older
version ended with an incomplete line and a later version changed the line
(without adding the terminating LF)?  What if a later version changed the
line and added the terminating LF?  What if a later version only added the
terminating LF and did nothing else?  Are these three cases handled
correctly?

After thinking issues like the above, I read the patch and I see it does
not take neither approach.  That makes me feel nervous.

By tweaking only the output routine you _might_ be getting correct output,
but even then it looks to me like the end result is working correctly not
by design but by accident.  IOW, the patch may be better than nothing, but
somehow it just feels like it is papering over the real issue than being a
proper fix.

Or am I worrying too much?

> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> CC: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>     Patch by Dscho, commit message by me. Apologies to Dscho for
>     taking so long to send it :).
>
>  builtin-blame.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-blame.c b/builtin-blame.c
> index 7512773..dd16b22 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -1604,6 +1604,9 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
>  		} while (ch != '\n' &&
>  			 cp < sb->final_buf + sb->final_buf_size);
>  	}
> +
> +	if (sb->final_buf_size && cp[-1] != '\n')
> +		putchar('\n');
>  }
>  
>  static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
> @@ -1667,6 +1670,9 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
>  		} while (ch != '\n' &&
>  			 cp < sb->final_buf + sb->final_buf_size);
>  	}
> +
> +	if (sb->final_buf_size && cp[-1] != '\n')
> +		putchar('\n');
>  }
>  
>  static void output(struct scoreboard *sb, int option)
> -- 
> 1.6.5.1.123.ge01f7
