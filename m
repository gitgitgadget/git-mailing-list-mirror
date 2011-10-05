From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 5 Oct 2011 18:23:36 -0400
Message-ID: <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com>
References: <4E8C6F2F.1070306@6wind.com>
	<7v8voz8hgq.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
	<7vpqib5ciw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, nicolas.dichtel@6wind.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 00:23:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBZsM-0006yp-5w
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 00:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935347Ab1JEWXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 18:23:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58374 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757829Ab1JEWXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 18:23:37 -0400
Received: by yxl31 with SMTP id 31so2043707yxl.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PBhzlLxKlTyz36nsu1jCBhG3Ud/vNvYfa9JERX1JH2U=;
        b=YAlLawoeSTZjZlVDbJG2yvHRg5VTZ0/fHkw9mo7IVK2sVoSp+YGIGQhTzD1QSbs2+0
         CJcnSEIOz3GDCwZx5iKwPcIbkX8dde6OCvbptmJNwMBJ6BetvliLcdBqO8xGpWYa+90W
         9kjmjb5mwavQjC1uN31cRWifwcwBLEt6nWxM4=
Received: by 10.147.30.12 with SMTP id h12mr2519304yaj.21.1317853416736; Wed,
 05 Oct 2011 15:23:36 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 15:23:36 -0700 (PDT)
In-Reply-To: <7vpqib5ciw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182896>

On Wed, Oct 5, 2011 at 5:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think the sequencer state needs to be removed when the command aborts.

Or written later in do_pick_commit().

> This needs to be fixed before 1.7.7.1.

Something like this?

diff --git i/builtin/revert.c w/builtin/revert.c
index 3117776c2c..f7fcc88871 100644
--- i/builtin/revert.c
+++ w/builtin/revert.c
@@ -384,6 +384,7 @@ static int do_pick_commit(void)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
+	int record_cherry_pick_head = 0;

 	if (no_commit) {
 		/*
@@ -477,7 +478,7 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			write_cherry_pick_head();
+			record_cherry_pick_head = 1;
 	}

 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -514,6 +515,9 @@ static int do_pick_commit(void)
 	free_message(&msg);
 	free(defmsg);

+	if (record_cherry_pick_head)
+		write_cherry_pick_head();
+
 	return res;
 }
