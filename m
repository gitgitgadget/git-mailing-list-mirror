From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 7/7] grep: honor --textconv for the case rev:path
Date: Fri, 10 May 2013 11:31:40 -0700
Message-ID: <7v38tu1yb7.fsf@alter.siamese.dyndns.org>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
	<cover.1368197380.git.git@drmicha.warpmail.net>
	<dd973eae534bed5f7106d54e06c7c2172595f402.1368197380.git.git@drmicha.warpmail.net>
	<7v7gj61z9h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 10 20:31:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uas6f-00079A-73
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 20:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab3EJSbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 14:31:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997Ab3EJSbo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 14:31:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AC921D568;
	Fri, 10 May 2013 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y55R8ppdApxxGIYhKdrI53K/ybU=; b=e/kynP
	a+wQ2OP4+e+hmo4EidsZXXmfJ43rip925vjMLTU7gJQXtQ9xdzIDuKtNxHPciKyK
	uccoY7fk/ELgu6m7TNn4sAEZS9uP8KCqrPNfmPBy9Nn3e0AdEB+n2uK1D/+EX8L2
	RccOxjVl0tTdu9QTlw3p7QZ0yp0zGa+nTZFNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F1kgCDfwEWYo7maICfYJJC/TZP8nkkid
	4HDsxtDbv0bEwq99i3K2NIwVZjzS0vwLqpS4YB2LReH0QpR8TaMtxDaacc/VFrf4
	+49/zfrUCikh0V0HlR30LAasQSPKj0zz9syzpxMFNltnlzhjAqW/41NGi+dYW0xe
	mPfAkN5Ydmw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 827A41D567;
	Fri, 10 May 2013 18:31:43 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBFB01D565;
	Fri, 10 May 2013 18:31:42 +0000 (UTC)
In-Reply-To: <7v7gj61z9h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 10 May 2013 11:11:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCB72554-B99F-11E2-94FE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223891>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> diff --git a/object.h b/object.h
>> index 97d384b..695847d 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -13,6 +13,7 @@ struct object_array {
>>  		struct object *item;
>>  		const char *name;
>>  		unsigned mode;
>> +		struct object_context *context;
>>  	} *objects;
>>  };
>
> fsck has to hold this for each and every objects in the repository
> it has found but hasn't inspected (i.e. pending), doesn't it? Do we
> really want to add 8 bytes for each of them?

Perhaps fsck does not even want "name" and "mode" for that matter.

I wonder what improvement, if any, we would see with a change like
this patch in a large-ish repository.

 builtin/fsck.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb9a2cd..c1de2a9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -73,7 +73,32 @@ static int fsck_error_func(struct object *obj, int type, const char *err, ...)
 	return (type == FSCK_WARN) ? 0 : 1;
 }
 
-static struct object_array pending;
+static struct pending_object {
+	unsigned int nr;
+	unsigned int alloc;
+	struct object **objects;
+} pending;
+
+static int max_pending;
+
+static void add_pending(struct object *object)
+{
+	unsigned nr = pending.nr;
+	unsigned alloc = pending.alloc;
+	struct object **objects = pending.objects;
+
+	if (nr >= alloc) {
+		alloc = (alloc + 32) * 2;
+		objects = xrealloc(objects, alloc * sizeof(*objects));
+		pending.alloc = alloc;
+		pending.objects = objects;
+	}
+	objects[nr] = object;
+	pending.nr = ++nr;
+
+	if (max_pending < nr)
+		max_pending = nr;
+}
 
 static int mark_object(struct object *obj, int type, void *data)
 {
@@ -112,7 +137,7 @@ static int mark_object(struct object *obj, int type, void *data)
 		return 1;
 	}
 
-	add_object_array(obj, (void *) parent, &pending);
+	add_pending(obj);
 	return 0;
 }
 
@@ -148,15 +173,15 @@ static int traverse_reachable(void)
 	if (show_progress)
 		progress = start_progress_delay("Checking connectivity", 0, 0, 2);
 	while (pending.nr) {
-		struct object_array_entry *entry;
-		struct object *obj;
+		struct object **entry, *obj;
 
 		entry = pending.objects + --pending.nr;
-		obj = entry->item;
+		obj = *entry;
 		result |= traverse_one_object(obj);
 		display_progress(progress, ++nr);
 	}
 	stop_progress(&progress);
+	fprintf(stderr, "max# pending objects = %d\n", max_pending);
 	return !!result;
 }
 
