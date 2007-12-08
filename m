From: Junio C Hamano <gitster@pobox.com>
Subject: [OT] perhaps we want to support copied-context diff output
Date: Sat, 08 Dec 2007 00:18:56 -0800
Message-ID: <7vmyslwqdr.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.99999.0712072357050.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:19:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0uuU-0000CZ-7L
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbXLHITV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbXLHITV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:19:21 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:60783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbXLHITU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:19:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 36497425F;
	Sat,  8 Dec 2007 03:19:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA267425E;
	Sat,  8 Dec 2007 03:19:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67527>

The patch looks correct, but I have an offtopic comment that does not
have anything to do with the problem being discussed right now.

Nicolas Pitre <nico@cam.org> writes:

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 4f44658..5002cc6 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1245,28 +1245,37 @@ static void get_object_details(void)
> ...
>  static int type_size_sort(const void *_a, const void *_b)
>  {
>  	const struct object_entry *a = *(struct object_entry **)_a;
>  	const struct object_entry *b = *(struct object_entry **)_b;
>  
> -	if (a->type < b->type)
> -		return -1;
>  	if (a->type > b->type)
> -		return 1;
> -	if (a->hash < b->hash)
>  		return -1;
> -	if (a->hash > b->hash)
> +	if (a->type < b->type)
>  		return 1;
> -	if (a->preferred_base < b->preferred_base)
> +	if (a->hash > b->hash)
>  		return -1;
> -	if (a->preferred_base > b->preferred_base)
> +	if (a->hash < b->hash)
>  		return 1;
> -	if (a->size < b->size)
> +	if (a->preferred_base > b->preferred_base)
>  		return -1;
> +	if (a->preferred_base < b->preferred_base)
> +		return 1;
>  	if (a->size > b->size)
> +		return -1;
> +	if (a->size < b->size)
>  		return 1;
> -	return a > b ? -1 : (a < b);  /* newest last */
> +	return a < b ? -1 : (a > b);  /* newest first */
>  }

Before being able to understand what was going on, I had to shuffle the
above patch by duplicating the context lines, prefix them with '-' and
then '+', and grouping preimage lines and postimage lines together, to
come up with this patch:

 static int type_size_sort(const void *_a, const void *_b)
 {
 	const struct object_entry *a = *(struct object_entry **)_a;
 	const struct object_entry *b = *(struct object_entry **)_b;
 
-	if (a->type < b->type)
-		return -1;
-	if (a->type > b->type)
-		return 1;
-	if (a->hash < b->hash)
-		return -1;
-	if (a->hash > b->hash)
-		return 1;
-	if (a->preferred_base < b->preferred_base)
-		return -1;
-	if (a->preferred_base > b->preferred_base)
-		return 1;
-	if (a->size < b->size)
-		return -1;
-	if (a->size > b->size)
-		return 1;
-	return a > b ? -1 : (a < b);  /* newest last */
+	if (a->type > b->type)
+		return -1;
+	if (a->type < b->type)
+		return 1;
+	if (a->hash > b->hash)
+		return -1;
+	if (a->hash < b->hash)
+		return 1;
+	if (a->preferred_base > b->preferred_base)
+		return -1;
+	if (a->preferred_base < b->preferred_base)
+		return 1;
+	if (a->size > b->size)
+		return -1;
+	if (a->size < b->size)
+		return 1;
+	return a < b ? -1 : (a > b);  /* newest first */
 }

Perhaps we may want to add "diff -c" (copied context) output format as
an option, which may be easier to read.

A possible alternative with much less impact to our toolset would be to
stay with unified context format but employ some heuristics (e.g. "a
hunk has many small context lines between preimage and postimage pairs")
and rewrite the diff output automatically like what I did by hand above.

The problematic region has 26 lines, among which 9 lines are deleted
material and 9 lines are added material, and it contains 8 isolated
groups of unchanged material, one line each.  A heuristics to notice
such excessively large number of groups of unchanged lines compared to
the size of the hunk itself would be reasonably easy to implement.
