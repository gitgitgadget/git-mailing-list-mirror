From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] combine-diff: Optimize combine_diff_path sets intersection
Date: Tue, 28 Jan 2014 13:55:09 -0800
Message-ID: <xmqqbnyvlqki.fsf@gitster.dls.corp.google.com>
References: <cover.1390234183.git.kirr@mns.spb.ru>
	<b97e63128093f6c5f5cab854b9b9487c4e6b955a.1390234183.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Jan 28 22:55:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8Gcu-000581-3d
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 22:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755654AbaA1VzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 16:55:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755606AbaA1VzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 16:55:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DCD968CC0;
	Tue, 28 Jan 2014 16:55:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d24rmbHvpu5aYrdrz9VTSZP/o+c=; b=Riwkcn
	O2SzR74BNR8EUIxDDhf2UAxIPka0TDPApoJH08//kHHvEz+6q0L5f825ZZn8qfwr
	zUBOUYcmEUcbDI6jcq88gLIjNQU0I2tEqHDMRUmYGjIz7fz/ar3m3toGQ6v5aIpT
	JzjOGKEBt6vXChB+nxQW+IFmyAKYIO2311sgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f/im45zOmgOHadYtp6m2AsBpNLHlNe9R
	tlDHiYOApgJDyvbOiowy3hKrYoqAhe7Ix+omXIaXLFYJkVn1F3D1qAazMwU2FOko
	BTAkTGU8c8YBx0515JIhradP7yYo8CPY80vYlrW68SfQ2oMBcelqk6OkqPMEjQop
	+AapiI0BSh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4884968CBF;
	Tue, 28 Jan 2014 16:55:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E4B968CBE;
	Tue, 28 Jan 2014 16:55:14 -0500 (EST)
In-Reply-To: <b97e63128093f6c5f5cab854b9b9487c4e6b955a.1390234183.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 20 Jan 2014 20:20:40 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DDEDEE44-8866-11E3-975B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241194>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> diff --git a/combine-diff.c b/combine-diff.c
> index 3b92c448..98c2562 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -15,8 +15,8 @@
> ...
> +	while (1) {
> ...
> +		if (cmp < 0) {
> +			if (pprev)
> +				pprev->next = p->next;
> +			ptmp = p;
> +			p = p->next;
> +			free(ptmp);
> +			if (curr == ptmp)
> +				curr = p;
>  			continue;
> ...
> +		if (cmp > 0) {
> +			i++;
> +			continue;
>  		}
> ...
> +
> +		pprev = p;
> +		p = p->next;
> +		i++;
>  	}
>  	return curr;
>  }

Thanks. I very much like the approach.

I was staring at the above part of the code, but couldn't help
recalling this gem (look for "understand pointers" in the article):

  http://meta.slashdot.org/story/12/10/11/0030249/linus-torvalds-answers-your-questions

How about doing it this way (on top of your patch)?  It reduces 7
lines even though it adds two comment lines ;-)

 combine-diff.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 2d79312..0809e79 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -15,11 +15,10 @@
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	struct combine_diff_path *p, *pprev, *ptmp;
+	struct combine_diff_path *p, **tail = &curr;
 	int i, cmp;
 
 	if (!n) {
-		struct combine_diff_path *list = NULL, **tail = &list;
 		for (i = 0; i < q->nr; i++) {
 			int len;
 			const char *path;
@@ -43,35 +42,30 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 			*tail = p;
 			tail = &p->next;
 		}
-		return list;
+		return curr;
 	}
 
 	/*
-	 * NOTE paths are coming sorted here (= in tree order)
+	 * paths in curr (linked list) and q->queue[] (array) are
+	 * both sorted in the tree order.
 	 */
-
-	pprev = NULL;
-	p = curr;
 	i = 0;
+	while ((p = *tail) != NULL) {
+		cmp = ((i >= q->nr)
+		       ? -1 : strcmp(p->path, q->queue[i]->two->path));
 
-	while (1) {
-		if (!p)
-			break;
-
-		cmp = (i >= q->nr) ? -1
-				   : strcmp(p->path, q->queue[i]->two->path);
 		if (cmp < 0) {
-			if (pprev)
-				pprev->next = p->next;
-			ptmp = p;
-			p = p->next;
-			free(ptmp);
-			if (curr == ptmp)
-				curr = p;
+			/* p->path not in q->queue[]; drop it */
+			struct combine_diff_path *next = p->next;
+
+			if ((*tail = next) != NULL)
+				tail = &next->next;
+			free(p);
 			continue;
 		}
 
 		if (cmp > 0) {
+			/* q->queue[i] not in p->path; skip it */
 			i++;
 			continue;
 		}
@@ -80,8 +74,7 @@ static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr,
 		p->parent[n].mode = q->queue[i]->one->mode;
 		p->parent[n].status = q->queue[i]->status;
 
-		pprev = p;
-		p = p->next;
+		tail = &p->next;
 		i++;
 	}
 	return curr;
