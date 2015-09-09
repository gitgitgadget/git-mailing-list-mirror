From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am --skip/--abort: merge HEAD/ORIG_HEAD tree into index
Date: Wed, 09 Sep 2015 14:29:07 -0700
Message-ID: <xmqqlhcf5ljw.fsf@gitster.mtv.corp.google.com>
References: <0000014fb15e897e-4f1178b9-69d9-4015-808b-e073c134281c-000000@eu-west-1.amazonses.com>
	<1da3956b12c7d20fcd90ebffea9c8f68@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Kim Gybels <kgybels@infogroep.be>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 09 23:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZmvb-0001OL-46
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 23:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbbIIV3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 17:29:11 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33112 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbbIIV3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 17:29:09 -0400
Received: by pacex6 with SMTP id ex6so21289252pac.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nkkOH3cl5Nrj0yi8jOmP4w81bC98dosTvnW+sLdIwc4=;
        b=B7gF6FisxJUSPOrdmVsK1bkSujDBoXCCsy28z9n7V4pHFr09aH1V+ufvPIWLV97+Vg
         D1rIRGlgqlg7xfwBIZSP3v1qruFJPZ0F5CF/Vi4l1XtdUqE+lxoe6BJ0WPbL7UuvvrGd
         oz3wD2hTT2tIk6iPF9hrGKJGeQ/vnjamJbGwNRzRi8UHdJEblNuGDpGqBapnGCfWkPaq
         5Z89UMiNbTRQ4DaUfQmSPn/o7LT9As+QDDFDOJtOY/O/GN7XBf+OV4icDGlVyr8Vuuqk
         3APXgXQxyKo9XsOG/oiCffsNTvlBPwKT3mrMpp/QspKPQU0ktrJbSSYuCc6+/0EWpl8q
         nzfA==
X-Received: by 10.66.235.226 with SMTP id up2mr35820729pac.89.1441834148715;
        Wed, 09 Sep 2015 14:29:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:31c8:2790:408d:8446])
        by smtp.gmail.com with ESMTPSA id pp9sm8054017pdb.40.2015.09.09.14.29.07
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 09 Sep 2015 14:29:07 -0700 (PDT)
In-Reply-To: <1da3956b12c7d20fcd90ebffea9c8f68@dscho.org> (Johannes
	Schindelin's message of "Wed, 09 Sep 2015 13:45:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277566>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> On 2015-09-09 11:10, Johannes Schindelin wrote:
>> This is a backport of the corresponding patch to the builtin am in 2.6:
>> 3ecc704 (am --skip/--abort: merge HEAD/ORIG_HEAD tree into index,
>> 2015-08-19).
>> 
>> Reportedly, it can make a huge difference on Windows, in one case a `git
>> rebase --skip` took 1m40s without, and 5s with, this patch.
>> 
>> Reported-and-suggested-by: Kim Gybels <kim.gybels@engilico.com>
>> Original report: https://github.com/git-for-windows/git/issues/365
>> Acked-by: Paul Tan <pyokagan@gmail.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  contrib/examples/git-am.sh | 2 +-
>
> Of course this should be `git-am.sh` in the 2.5.x branch... Could you
> adjust that on your side?

"git am -3" is smart enough that applying this patch on a branch
that contains the performance regression does the right thing
without me having to think.  The most time-consuming part on my part
was to figure out which exact commit this change is fixing and then
find out to which maintenance tracks contains that breakage.

Here is what I'll queue on top of maint-2.4 series.

Thanks.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Wed, 9 Sep 2015 09:10:07 +0000
Subject: [PATCH] am --skip/--abort: merge HEAD/ORIG_HEAD tree into index

f8da6801 (am --skip: support skipping while on unborn branch,
2015-06-06) introduced a performance regression to "git am --skip",
where it used "read-tree" to reconstruct the index from scratch
without reusing the cached stat information.

This is a backport of the corresponding patch to the builtin am in 2.6:
3ecc704 (am --skip/--abort: merge HEAD/ORIG_HEAD tree into index,
2015-08-19).

Reportedly, it can make a huge difference on Windows, in one case a `git
rebase --skip` took 1m40s without, and 5s with, this patch.

cf. https://github.com/git-for-windows/git/issues/365

Reported-and-suggested-by: Kim Gybels <kgybels@infogroep.be>
Acked-by: Paul Tan <pyokagan@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index 3103c0f..4ab1f21 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -509,7 +509,7 @@ then
 		git read-tree --reset -u $head_tree $head_tree &&
 		index_tree=$(git write-tree) &&
 		git read-tree -m -u $index_tree $head_tree
-		git read-tree $head_tree
+		git read-tree -m $head_tree
 		;;
 	,t)
 		if test -f "$dotest/rebasing"
-- 
2.6.0-rc1-125-gb648220
