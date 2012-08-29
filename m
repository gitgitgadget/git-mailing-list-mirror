From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 16:37:06 -0700
Message-ID: <7vligxuv6l.fsf@alter.siamese.dyndns.org>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <gregkh@linuxfoundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 01:37:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6rp0-00031W-SO
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 01:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab2H2XhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 19:37:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45078 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754642Ab2H2XhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 19:37:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 661C290D5;
	Wed, 29 Aug 2012 19:37:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DjD6PhvjCqwluAJAg4Y5NAS8GJg=; b=WXTBiN
	akY9r9ykrQjslgJueCPhzJSIHmB9GJQtZy3cI59Zq85ju9CYdoOoA8nxic2uazlU
	VG8GFSOgjbC62xAkenjcq6Q8QKf6XJ4sZEZRdzG9Oj+SPD9bamKcxJpnR57+Cg5x
	vmSJSJ/i4upZcz7bVuK+4xkzz28VZP97VRnHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eHXVpjKFJyaTRoU9bjb/vEnfWyrPBdvA
	5DngM3U8nKpTBUNUfvwAoyf0/QMVkKHFHcj/2PjQrK9diPXmj4bECNchQYnlLGee
	8GWO3YV2sr0yNhozXSEpoAknKA/JXxteMqUM7BqZacjHX9PvPsu1Z6KGIjADdgBd
	+IaPKbXGg10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5426890D4;
	Wed, 29 Aug 2012 19:37:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 842AE90D2; Wed, 29 Aug 2012
 19:37:07 -0400 (EDT)
In-Reply-To: <1346275044-10171-4-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 29 Aug 2012 14:17:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 722A4FB6-F232-11E1-B846-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204507>

Junio C Hamano <gitster@pobox.com> writes:

> Note that this is fairly expensive (see NEEDSWORK comment in the
> code).

And this is with the "notes-cache".

    (priming the cache from scratch)
    $ rm .git/refs/notes/name-rev-weight 
    $ /usr/bin/time ../git.git/git-name-rev --weight --tags 0136db586c
    0136db586c tags/v3.5-rc1~83^2~81^2~76
    6.06user 0.46system 0:06.54elapsed 99%CPU (0avgtext+0avgdata 1861456maxresident)k
    8inputs+16outputs (0major+128576minor)pagefaults 0swaps

    (with valid cache)
    $ /usr/bin/time ../git.git/git-name-rev --weight --tags 0136db586c
    0136db586c tags/v3.5-rc1~83^2~81^2~76
    0.50user 0.22system 0:00.72elapsed 100%CPU (0avgtext+0avgdata 244224maxresident)k
    0inputs+0outputs (0major+16062minor)pagefaults 0swaps

    (the old "shortest path" version)
    $ /usr/bin/time git name-rev --tags 0136db586c
    0136db586c tags/v3.6-rc1~59^2~56^2~76
    0.31user 0.01system 0:00.32elapsed 100%CPU (0avgtext+0avgdata 243488maxresident)k
    0inputs+0outputs (0major+16000minor)pagefaults 0swaps


 builtin/name-rev.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git c/builtin/name-rev.c w/builtin/name-rev.c
index 69da41d..fdd087c 100644
--- c/builtin/name-rev.c
+++ w/builtin/name-rev.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
+#include "notes-cache.h"
 
 #define CUTOFF_DATE_SLOP 86400 /* one day */
 
@@ -32,10 +33,6 @@ struct rev_name {
  */
 static int use_weight;
 
-/*
- * NEEDSWORK: the result of this computation must be cached to
- * a dedicated notes tree, keyed by the commit object name.
- */
 static int compute_tip_weight(struct commit *commit)
 {
 	struct rev_info revs;
@@ -50,6 +47,31 @@ static int compute_tip_weight(struct commit *commit)
 	return weight;
 }
 
+static struct notes_cache weight_cache;
+static int weight_cache_updated;
+
+static int get_tip_weight(struct commit *commit)
+{
+	struct strbuf buf = STRBUF_INIT;
+	size_t sz;
+	int weight;
+	char *note = notes_cache_get(&weight_cache, commit->object.sha1, &sz);
+
+	if (note && !strtol_i(note, 10, &weight)) {
+		free(note);
+		return weight;
+	}
+	free(note);
+
+	weight = compute_tip_weight(commit);
+	strbuf_addf(&buf, "%d", weight);
+	notes_cache_put(&weight_cache, commit->object.sha1,
+			buf.buf, buf.len);
+	strbuf_release(&buf);
+	weight_cache_updated = 1;
+	return weight;
+}
+
 static int tip_weight(const char *tip, size_t reflen)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -69,7 +91,7 @@ static int tip_weight(const char *tip, size_t reflen)
 	if (!name)
 		die("Internal error: a tip without name '%s'", tip);
 	if (!name->weight)
-		name->weight = compute_tip_weight(commit);
+		name->weight = get_tip_weight(commit);
 	return name->weight;
 }
 
@@ -346,6 +368,9 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	if (all || transform_stdin)
 		cutoff = 0;
 
+	if (use_weight)
+		notes_cache_init(&weight_cache, "name-rev-weight", "2012-08-29");
+
 	for (; argc; argc--, argv++) {
 		unsigned char sha1[20];
 		struct object *o;
@@ -401,5 +426,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				  always, allow_undefined, data.name_only);
 	}
 
+	if (use_weight && weight_cache_updated)
+		notes_cache_write(&weight_cache);
+
 	return 0;
 }
