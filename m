From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: pass empty buffer to index empty file
Date: Tue, 19 May 2015 11:35:08 -0700
Message-ID: <xmqq1tic8lgj.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x4fjf5.fsf@gitster.dls.corp.google.com>
	<1431806796-28902-1-git-send-email-gjthill@gmail.com>
	<xmqqegmfds1n.fsf@gitster.dls.corp.google.com>
	<xmqqvbfrc952.fsf@gitster.dls.corp.google.com>
	<20150519063716.GA22771@peff.net>
	<xmqqk2w48mjp.fsf@gitster.dls.corp.google.com>
	<xmqqd21w8mal.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jim Hill <gjthill@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 20:35:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YumMk-0000Oi-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 20:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbbESSfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 14:35:12 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36741 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbESSfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 14:35:10 -0400
Received: by igbpi8 with SMTP id pi8so83225343igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4t9N4tO6xGan1MVsvvviTLBgBhnf//rLwIZfL2VC9Us=;
        b=IqprANgxsQl3m+5QN/xO+kSS5PFbGtIYnetNO8TmjlVwQML+JR9egogKbFLeZRcGsZ
         QKMfBbp27I7ZHALzAKPwNz3qOEtbfk5Wv5HPoZLyBmwtyOUDUqxFR6x/l7Mkz+jUbpy5
         RwzbDScKWg/aFaACaLY+1gziClb75bIvfB7TgI0Hqx5tOTyf2A/pzuJvAPChDFxgUh6/
         FLzLwUKS6tHWPA5XW+M04O3WstG+EjynIqcMCV39xQyULwED0xM6of5+snRKOfcYijLy
         1Rjbg+j+kDk8u0TV4MXEJEavV9Ke3m4XwWignSF1C9/Cy/x/KOzRJafoFmNcJSLlQFuF
         dxbQ==
X-Received: by 10.42.128.84 with SMTP id l20mr43455922ics.21.1432060509930;
        Tue, 19 May 2015 11:35:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id ot6sm8386815igb.11.2015.05.19.11.35.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 11:35:09 -0700 (PDT)
In-Reply-To: <xmqqd21w8mal.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 May 2015 11:17:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269385>

Junio C Hamano <gitster@pobox.com> writes:

> Subject: [PATCH 2/2] filter_buffer_or_fd(): ignore EPIPE
>
> We are explicitly ignoring SIGPIPE, as we fully expect that the
> filter program may not read our output fully.  Ignore EPIPE that
> may come from writing to it as well.

Yuck; please discard the previous one.  write_in_full() side is also
writing into that process, so we should do the same.

-- >8 --
Subject: [PATCH v2 2/2] filter_buffer_or_fd(): ignore EPIPE

We are explicitly ignoring SIGPIPE, as we fully expect that the
filter program may not read our output fully.  Ignore EPIPE that
may come from writing to it as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 convert.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index 9a5612e..f3bd3e9 100644
--- a/convert.c
+++ b/convert.c
@@ -356,9 +356,14 @@ static int filter_buffer_or_fd(int in, int out, void *data)
 	sigchain_push(SIGPIPE, SIG_IGN);
 
 	if (params->src) {
-		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
+		write_err = (write_in_full(child_process.in,
+					   params->src, params->size) < 0);
+		if (errno == EPIPE)
+			write_err = 0;
 	} else {
 		write_err = copy_fd(params->fd, child_process.in);
+		if (write_err == COPY_WRITE_ERROR && errno == EPIPE)
+			write_err = 0;
 	}
 
 	if (close(child_process.in))
-- 
2.4.1-413-ga38dc94
