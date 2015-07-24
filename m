From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/18] rerere: explain the rerere I/O abstraction
Date: Fri, 24 Jul 2015 13:42:38 -0700
Message-ID: <xmqqio99l22p.fsf@gitster.dls.corp.google.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-1-git-send-email-gitster@pobox.com>
	<1437171880-21590-9-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 22:42:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIjnq-00084D-FH
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 22:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbbGXUml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 16:42:41 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33769 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbbGXUmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 16:42:40 -0400
Received: by padck2 with SMTP id ck2so19566863pad.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9fr2flNf1CKVxGQXD4X+7l9NBaMAsaBPzwGY7KuLhBU=;
        b=VJxhoRGjtJ3wNg+rKa5pdA8R9FE8GWf69fZTzudrqIw0sIKVH4i1LBJPP00gkWssWP
         UNGLgWkvN4wwgjQoBAL+pU7N1x9x2D8TubPO1zqmioO9quzebl2dm03XwTzplPtVK0Mi
         D6MS0/8BXubrcisq90xiI6SD+lqLQEsNXvpKnqqgWK/1LnejGOI1xThcTk7teNHWZHIC
         ZnVl+wq1K0IAxOyjB1utbeYUbNAEmehQqx1loA5PmZDY6vyKPnvojCIFROAGx5mk3cCn
         O5YvHPkTsiMaJS7WGuAtT0xJCvBvnpaQrFZ6BDn41H7PPnQVFzieqWLbSRaIn8CU67lO
         Lwjw==
X-Received: by 10.70.109.162 with SMTP id ht2mr34569959pdb.101.1437770559835;
        Fri, 24 Jul 2015 13:42:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id fy5sm16107216pdb.93.2015.07.24.13.42.38
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 13:42:39 -0700 (PDT)
In-Reply-To: <1437171880-21590-9-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Fri, 17 Jul 2015 15:24:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274599>

Junio C Hamano <gitster@pobox.com> writes:

> +/*
> + * Write a conflict marker to io->output (if defined).
> + */
>  static void rerere_io_putconflict(int ch, int size, struct rerere_io *io)
>  {
>  	char buf[64];

This is unrelated to the topic of this step, but this function seems
to be very poorly put together with duct tape.

> static void rerere_io_putconflict(int ch, int size, struct rerere_io *io)
> {
> 	char buf[64];
> 
> 	while (size) {
> 		if (size < sizeof(buf) - 2) {
> 			memset(buf, ch, size);
> 			buf[size] = '\n';
> 			buf[size + 1] = '\0';
> 			size = 0;

The if() guarding this block has an off-by-one error in the benign
direction.  When size is 62, the marker with terminating LF and NUL
should still fit within the buf[], so it should use "<=", not "<",
to compare.

> 		} else {
> 			int sz = sizeof(buf) - 1;
> 			if (size <= sz)
> 				sz -= (sz - size) + 1;
> 			memset(buf, ch, sz);
> 			buf[sz] = '\0';
> 			size -= sz;

This is an even more awkward construct.  sz is what we have to work
with the substring that we cannot emit with a single call (because
buf[] is too small), so naturally I would expect it to be more like

	int to_emit = size;
        if (sz <= size)
        	to_emit = sz;
	memset(buf, ch, to_emit);
        buf[to_emit] = '\0';
	size -= to_emit;

which makes the "if (size <= sz)" in the code look very suspicious.

But rewriting it to the "more natural" version would make it buggy.
At a right boundary condition, i.e. size == 63, we may find that the
conflict marker is too long with LF and NUL to fit in buf[] and come
here, and then fill the full conflict marker with NUL just fine in
buf[], decrementing size to 0, emit that 63-byte long marker.  The
next iteration will exit the loop without emitting the LF.

The unnatural is what is saving us from such a bug.

	if (size <= sz)
		sz -= (sz - size) + 1;

It ensures that subtraction of sz (i.e. "to_emit") from size before
the next iteration will never brings size down to zero by reducing
sz by one too much, forcing another iteration, which will then have
size smaller than "sizeof(buf) - 2" and have us emit the LF.

Not buggy, but ugly.

> 		}
> 		rerere_io_putstr(buf, io);
> 	}
> }
