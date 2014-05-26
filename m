From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC 1/3] sequencer: Signal failed ff as an aborted, not a conflicted
 merge
Date: Tue, 27 May 2014 00:19:16 +0200
Message-ID: <5383BDE4.9000704@gmail.com>
References: <533C913C.20106@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 00:19:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3Es-000169-KA
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbaEZWTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:19:22 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:64195 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbaEZWTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:19:20 -0400
Received: by mail-lb0-f179.google.com with SMTP id c11so4466336lbj.38
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OY8+smF/kNOvYTbRUkbe+t4tHOi8FEF6u7WwTLmNtOY=;
        b=SBK1VR0t+pMEg9aGsg4L3owq82NjQN8k8HzPMGKPPyJfM9Pe5mT5ZoxLnt91hZWabv
         w38gFpaIQypKdOXT4cmY55M6luxjCCLjagJZi+cQfJ/be05wR3hIcVQyCM8OWID3RGEU
         vSahIebI2OHBYU1SFgqeNHgowNbpL4+6M27WaNIT64632tub+m5eL7RWjYJsQT52DBlH
         VperGqxONKh5Mq8uMrg5l9z1SCak2YdSj+f4GAav+bO0WJtyOW0TRWuv8w/mT6jsfO39
         1V3R1eN6aMayV0PBwZ/f8XHzCqPA4SPbSE6Ig+/xF2tSGcIAosLjnjzkVCs1rQYMTrch
         XuWQ==
X-Received: by 10.152.37.229 with SMTP id b5mr19737891lak.40.1401142758950;
        Mon, 26 May 2014 15:19:18 -0700 (PDT)
Received: from client.googlemail.com (dhcp-185073.eduroam.chalmers.se. [129.16.185.73])
        by mx.google.com with ESMTPSA id zn1sm13256019lbb.17.2014.05.26.15.19.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 May 2014 15:19:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <533C913C.20106@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250125>

`do_pick_commit` handles three situations if it is not fast-forwarding.
In order for `do_pick_commit` to identify the situation, it examines the
return value of the selected merge command.

1. return value 0 stands for a clean merge
2. 1 is passed in case of a failed merge due to conflict
3. any other return value means that the merge did not even start

So far, the sequencer returns 1 in case of a failed fast-forward, which
would mean "failed merge due to conflict". However, a fast-forward
either starts and succeeds or does not start at all. In particular, it
cannot fail in between like a merge with a dirty index due to conflicts.

In order to signal the three possible situations (not only success and
failure to complete) after a pick through porcelain commands such as
`cherry-pick`, exit with a return value that is neither 0 nor 1. -1 was
chosen in line with the other situations in which the sequencer
encounters an error.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 90cac7b..97cecca 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -278,7 +278,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
-		exit(1); /* the callee should have complained already */
+		exit(-1); /* the callee should have complained already */
 	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
 					   0, NULL);
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-- 
1.9.3
