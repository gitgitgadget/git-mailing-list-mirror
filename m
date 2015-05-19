From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 11:17:06 -0700
Message-ID: <xmqqd21w8mal.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
	<xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
	<20150519063716.GA22771@peff.net>
	<xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 20:17:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yum4p-0000ny-0C
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 20:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbbESSRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 14:17:10 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34132 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbESSRI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 14:17:08 -0400
Received: by igbhj9 with SMTP id hj9so40869624igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 11:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Guf06BhNEQM0lyo69X/lipSOTcgnb74PeX7UMNsUlLQ=;
        b=vBY0xhkFQZhNIUGfR6FHLL7Vtm7k24e2C8dXAJgZjKXER3SyyjGWjJ/EkJtVSyXuvt
         s05aGgaGDYNqcVWCXt6oXRyqI/uYfbQBEaHNDDAmxYNxwYkO1QWhEWtob4RB8FEXr2Qe
         AkL+8822IDeD3CJRmN61dBxpgPndfDMP2NeKDrZypnG5I1W2OsbqN6lRQKpepweKP1nz
         KtHWTcax6q5Fjq+Zr9TGzrHxFRu0QWNpyX9OzaeecgYnPvL+jfkSPtdG3pFlQgWQ/E5z
         cJIgUun5k3qF8pKpb9BEqTO2NZqW+lPriiwjA1pxfXrYlRNe3YdFEaTYwMS50ns/028M
         iPzQ==
X-Received: by 10.42.203.4 with SMTP id fg4mr41668066icb.52.1432059427990;
        Tue, 19 May 2015 11:17:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id o21sm10504085ioo.31.2015.05.19.11.17.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 11:17:07 -0700 (PDT)
In-Reply-To: <xmqqk2w48mjp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 May 2015 11:11:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269383>

Junio C Hamano <gitster@pobox.com> writes:

>> Hmm, I thought we turned off SIGPIPE when writing to filters these days.
>> Looks like we still complain if we get EPIPE, though. I feel like it
>> should be the filter's business whether it wants to consume all of the
>> input or not[1], and we should only be checking its exit status.
>>
>> -Peff
>>
>> [1] As a practical example, consider a file format that has a lot of
>>     cruft at the end. The clean filter would want to read only to the
>>     start of the cruft, and then stop for reasons of efficiency.
>
> Yes.  Let's do these two.  The preparatory patch is larger than the
> real change.

And this is the second one.

While preparing these, I noticed a handful of system calls whose
return values are not checked in the codepaths involved.  We should
clean them up, but I left them out of these two patches, as they are
separate issues.

-- >8 --
Subject: [PATCH 2/2] filter_buffer_or_fd(): ignore EPIPE

We are explicitly ignoring SIGPIPE, as we fully expect that the
filter program may not read our output fully.  Ignore EPIPE that
may come from writing to it as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/convert.c b/convert.c
index 9a5612e..0f20979 100644
--- a/convert.c
+++ b/convert.c
@@ -359,6 +359,8 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
 	} else {
 		write_err = copy_fd(params->fd, child_process.in);
+		if (write_error == COPY_WRITE_ERROR && errno == EPIPE)
+			write_error = 0; /* we are ignoring it, right? */
 	}
 
 	if (close(child_process.in))
-- 
2.4.1-413-ga38dc94
