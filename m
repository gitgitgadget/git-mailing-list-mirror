From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: [PATCH 2/2] status: don't ignore submodules added to index
Date: Sat, 29 Mar 2014 23:56:02 +0100
Message-ID: <53374F82.3020800@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 23:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WU2Ae-0005X0-JD
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 23:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbaC2W4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 18:56:07 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47889 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbaC2W4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 18:56:05 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so5299085eei.19
        for <git@vger.kernel.org>; Sat, 29 Mar 2014 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SveRGZnC4/wrtuRTXpRP85skY0CO8qzknJOd5x5jOHs=;
        b=UDp1QYWuHEqtBFn80Pa2DmltmZWK6mmCD5xX5xD8y5kIYK91Ju/1dJ+sCncH17L+P9
         n1Pyqoy1lGW0TMPjffCfg0IgjqrnCOEAGVVt6prKJAbntPewAB7FYEXagZcWAyWWSETe
         00dMKLnfhFg6sO4EB6ESISmonomtlEVAu/G9AWxGFYMWeKYiGknEs15+KWMtDYKldPoN
         wcj8O/iucPuegXLyTPCrkNZizmdgPodWUVZJcgHY/elZuhj3CSxiKzNlKnUaFTACBdV+
         So7Rj6pNPS6A2zAs89ZXP9ADGpOgTe0KnoU2ycI++yItiM5ZYvYnESXWdJZDga1WpN+n
         UCqw==
X-Received: by 10.14.246.1 with SMTP id p1mr19610315eer.20.1396133763524;
        Sat, 29 Mar 2014 15:56:03 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id e42sm21628457eev.32.2014.03.29.15.56.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 29 Mar 2014 15:56:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245445>

Submodules explicitly added to index by user should be never hidden in
status output.

This also fixes a bug in commit, where submodules with configured ignore
setting (in .gitmodules or .git/config), added to index by user, are not
displayed in the commit message as being commited, but they still are
commited. Unless the changed submodules are the only changes in the index,
in such case commit fails immediately with "no changes", which is even
worse.

Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
---
 wt-status.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index a452407..108a048 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -486,10 +486,8 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
-	if (s->ignore_submodule_arg) {
-		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
-		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
-	}
+	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	DIFF_OPT_CLR(&rev.diffopt, IGNORE_SUBMODULES);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_collect_updated_cb;
-- 
1.9.0
 
