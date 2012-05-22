From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] sequencer: release a strbuf used in save_head()
Date: Tue, 22 May 2012 09:17:35 -0500
Message-ID: <20120522141735.GA6660@burratino>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.61154.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 22 16:17:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWpuK-0001jq-IS
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 16:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005Ab2EVORr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 10:17:47 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48847 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab2EVORq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 10:17:46 -0400
Received: by yenm10 with SMTP id m10so5402461yen.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0RLnvfFCBpLcxm3e8B+8f2O1hcTg07yZ/iahMyZNAUs=;
        b=bnkdt0BvtQM7gOi3NNO4I9KN3lyvg2nntKLQD+8P5zKCE0dFM2MIrWomfddSHcP/D6
         5dlv+tyhF8WaTOxSiHWoMjXAwrNe3BMhnPi2d14uRRjyeqneOiZ0d5H82iq8ikY4zgui
         2zyyx9IO4BUvmrAupT1FA2ir83JLO5+Bx9uR8GF5RhR5f0mxW3HqTqFHdJKs9Th6RQiQ
         SWG1zQPT3vYuJowzXWbWBjq0HnJZ6FrBm4jXcAA/M+0z83RekXtEr37qfoqSXfCL5kEc
         +aTnb8yLThxZb1Vb+cjB/SHSgX4fGKsa9VfpL1djR+cFYI6O4pYxllsQhgkBCoUVLWSx
         t4bw==
Received: by 10.50.186.196 with SMTP id fm4mr1506954igc.34.1337696265433;
        Tue, 22 May 2012 07:17:45 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wh8sm17680761igb.11.2012.05.22.07.17.42
        (version=SSLv3 cipher=OTHER);
        Tue, 22 May 2012 07:17:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120521145610.1911.61154.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198200>

Hi,

Christian Couder wrote:
 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  sequencer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sequencer.c b/sequencer.c
> index 762c527..ad1bbea 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -741,6 +741,7 @@ static void save_head(const char *head)
>  		die_errno(_("Could not write to %s"), head_file);
>  	if (commit_lock_file(&head_lock) < 0)
>  		die(_("Error wrapping up %s."), head_file);
> +	strbuf_release(&buf);

Makes good sense.  Actually, I'm not sure why this allocation is
needed in the first place.  Would something like the following work?

-- >8 --
Subject: sequencer: avoid a one-time leak in save_head()

This function uses the lockfile API to make its change to the
.git/sequencer/head file effectively atomic, so there is no need to
gather output intended for that file in a new buffer to write it in
one go.

Noticed with valgrind.

Reported-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
By the way, the lockfile API usage looks fishy.  What kind of races is
the locking meant to prevent?  What happens if someone tries "git
cherry-pick --abort" in another window after my multipick has started
and before it finishes?

 sequencer.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git i/sequencer.c w/sequencer.c
index 3c384b94..75b6a995 100644
--- i/sequencer.c
+++ w/sequencer.c
@@ -732,12 +732,11 @@ static void save_head(const char *head)
 {
 	const char *head_file = git_path(SEQ_HEAD_FILE);
 	static struct lock_file head_lock;
-	struct strbuf buf = STRBUF_INIT;
 	int fd;
 
 	fd = hold_lock_file_for_update(&head_lock, head_file, LOCK_DIE_ON_ERROR);
-	strbuf_addf(&buf, "%s\n", head);
-	if (write_in_full(fd, buf.buf, buf.len) < 0)
+	if (write_in_full(fd, head, strlen(head)) < 0 ||
+	    write_in_full(fd, "\n", 1) < 0)
 		die_errno(_("Could not write to %s"), head_file);
 	if (commit_lock_file(&head_lock) < 0)
 		die(_("Error wrapping up %s."), head_file);
