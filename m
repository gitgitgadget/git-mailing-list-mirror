From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/4] diffcore-pickaxe: refactor diffcore_pickaxe()
Date: Sat, 28 Feb 2009 00:58:21 +0100
Message-ID: <49A87E1D.3030400@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <4b1358cc6558ec05a134431b603e4781b42deabd.1235629933.git.gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 01:00:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdCdN-00041h-5S
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 01:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbZB0X6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 18:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbZB0X6b
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 18:58:31 -0500
Received: from india601.server4you.de ([85.25.151.105]:35668 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbZB0X6b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 18:58:31 -0500
Received: from [10.0.1.101] (p57B7E8A9.dip.t-dialin.net [87.183.232.169])
	by india601.server4you.de (Postfix) with ESMTPSA id 449452F8045;
	Sat, 28 Feb 2009 00:58:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <4b1358cc6558ec05a134431b603e4781b42deabd.1235629933.git.gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111725>

Junio C Hamano schrieb:
>  void diffcore_pickaxe(const char *needle, int opts)
>  {
>  	struct diff_queue_struct *q = &diff_queued_diff;
> @@ -75,29 +107,14 @@ void diffcore_pickaxe(const char *needle, int opts)
>  		/* Showing the whole changeset if needle exists */
>  		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			if (!DIFF_FILE_VALID(p->one)) {
> -				if (!DIFF_FILE_VALID(p->two))
> -					continue; /* ignore unmerged */
> -				/* created */
> -				if (contains(p->two, needle, len, regexp))
> -					has_changes++;
> -			}
> -			else if (!DIFF_FILE_VALID(p->two)) {
> -				if (contains(p->one, needle, len, regexp))
> -					has_changes++;
> -			}
> -			else if (!diff_unmodified_pair(p) &&
> -				 contains(p->one, needle, len, regexp) !=
> -				 contains(p->two, needle, len, regexp))
> -				has_changes++;
> +			if (pickaxe_match_one(p, needle, len, regexp))
> +				return; /* not munge the queue */
>  		}
> -		if (has_changes)
> -			return; /* not munge the queue */
>  
> -		/* otherwise we will clear the whole queue
> -		 * by copying the empty outq at the end of this
> -		 * function, but first clear the current entries
> -		 * in the queue.
> +		/*
> +		 * otherwise we will clear the whole queue by copying
> +		 * the empty outq at the end of this function, but
> +		 * first clear the current entries in the queue.
>  		 */
>  		for (i = 0; i < q->nr; i++)
>  			diff_free_filepair(q->queue[i]);
> @@ -106,24 +123,8 @@ void diffcore_pickaxe(const char *needle, int opts)
>  		/* Showing only the filepairs that has the needle */
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			has_changes = 0;
> -			if (!DIFF_FILE_VALID(p->one)) {
> -				if (!DIFF_FILE_VALID(p->two))
> -					; /* ignore unmerged */
> -				/* created */
> -				else if (contains(p->two, needle, len, regexp))
> -					has_changes = 1;
> -			}
> -			else if (!DIFF_FILE_VALID(p->two)) {
> -				if (contains(p->one, needle, len, regexp))
> -					has_changes = 1;
> -			}
> -			else if (!diff_unmodified_pair(p) &&
> -				 contains(p->one, needle, len, regexp) !=
> -				 contains(p->two, needle, len, regexp))
> -				has_changes = 1;
>  
> -			if (has_changes)
> +			if (pickaxe_match_one(p, needle, len, regexp))
>  				diff_q(&outq, p);
>  			else
>  				diff_free_filepair(p);

You might want to squash this in, because has_changes is now constantly set
to zero:

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index d27e725..d294d29 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -84,7 +84,7 @@ void diffcore_pickaxe(const char *needle, int opts)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
-	int i, has_changes;
+	int i;
 	regex_t regex, *regexp = NULL;
 	struct diff_queue_struct outq;
 	outq.queue = NULL;
@@ -105,7 +105,7 @@ void diffcore_pickaxe(const char *needle, int opts)
 
 	if (opts & DIFF_PICKAXE_ALL) {
 		/* Showing the whole changeset if needle exists */
-		for (i = has_changes = 0; !has_changes && i < q->nr; i++) {
+		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (pickaxe_match_one(p, needle, len, regexp))
 				return; /* not munge the queue */
