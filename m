From: Johannes Sixt <j6t@kdbg.org>
Subject: jc/rerere-multi (was: What's cooking in git.git (Jan 2016, #04; Wed,
 20))
Date: Thu, 21 Jan 2016 13:09:01 +0100
Message-ID: <56A0CA5D.8080407@kdbg.org>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 13:09:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aME3O-0005Xu-KY
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 13:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759236AbcAUMJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 07:09:06 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:31419 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758886AbcAUMJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 07:09:05 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pmMvf2l6Wz5tlF;
	Thu, 21 Jan 2016 13:09:02 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A0AE551D6;
	Thu, 21 Jan 2016 13:09:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284514>

Am 21.01.2016 um 00:33 schrieb Junio C Hamano:
> * jc/rerere-multi (2015-09-14) 7 commits
>   - rerere: do use multiple variants
>   - t4200: rerere a merge with two identical conflicts
>   - rerere: allow multiple variants to exist
>   - rerere: delay the recording of preimage
>   - rerere: handle leftover rr-cache/$ID directory and postimage files
>   - rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
>   - rerere: split conflict ID further
> 
>   "git rerere" can encounter two or more files with the same conflict
>   signature that have to be resolved in different ways, but there was
>   no way to record these separate resolutions.
> 
>   Needs review.

I finally found some time to test and review this series. I have one
case where there are many identical conflicts (up to 15!) that rerere
was unable to resolve. But with this series applied, all of them are
now resolved automatically and correctly. That's a nice achievement!

Tested-by: Johannes Sixt <j6t@kdbg.org>

I don't have the original submission anymore. So, I'm responding here.

Generally, the patches make sense.

Except for 510936082eb4 "handle leftover rr-cache/$ID directory and
postimage files": After the subsequent e2a6344cca47 "delay the
recording of preimage" is in place, nothing of what the former patch
changed (except test cases) remains, and the problem that the former
solved is still solved, and in addition the NEEDSWORK that the former
introduced is resolved by the latter. I think the two should be
squashed together.

e2a6344cca47 (rerere: delay the recording of preimage) needs this
fixup, I think:

diff --git a/rerere.c b/rerere.c
index c0482b8..33b1348 100644
--- a/rerere.c
+++ b/rerere.c
@@ -765,7 +765,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 			const char *path = rerere_path(id, "postimage");
 			if (unlink(path))
 				die_errno("cannot unlink stray '%s'", path);
-			id->collection->status &= ~RR_HAS_PREIMAGE;
+			id->collection->status &= ~RR_HAS_POSTIMAGE;
 		}
 		id->collection->status |= RR_HAS_PREIMAGE;
 		fprintf(stderr, "Recorded preimage for '%s'\n", path);

and perhaps this change:

diff --git a/rerere.c b/rerere.c
index fbdade8..df6beb9 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1005,11 +1005,6 @@ static void unlink_rr_item(struct rerere_id *id)
 	unlink(rerere_path(id, "thisimage"));
 	unlink(rerere_path(id, "preimage"));
 	unlink(rerere_path(id, "postimage"));
-	/*
-	 * NEEDSWORK: what if this rmdir() fails?  Wouldn't we then
-	 * assume that we already have preimage recorded in
-	 * do_plain_rerere()?
-	 */
 	rmdir(rerere_path(id, NULL));
 }
 
