From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Mon, 05 Dec 2011 10:58:23 -0800
Message-ID: <7vbormn8vk.fsf@alter.siamese.dyndns.org>
References: <4EDBF4D5.6030908@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Dec 05 19:58:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXdkH-0001KC-0Q
	for gcvg-git-2@lo.gmane.org; Mon, 05 Dec 2011 19:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab1LES62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 13:58:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756171Ab1LES61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 13:58:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 205635DAB;
	Mon,  5 Dec 2011 13:58:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/Lfep7Ueh2kOGiaZdTHCL11IKuo=; b=r1bOpI
	aSq3hmqWgyMVCKtECJCx4uykTgUcShdl6MOmYpMxcdD1iYbTp3cXEo1XLgIPpzY6
	pMMVLKPL+e9mgP6uI9bFJrgkLJ72DGGfQEJ50cOOwbjuYaykCLoN0z9vFZoXEKhv
	/CiA+eWI8TBQzMZFXQs4sy/lStyGTPh7NS+L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GHS+0Zs4OzXtCEwSR2Rz8vcYtx1G+1oW
	5chh80g4oV6fBFXBnaChIljL8FWHVzQ1hzyfqHduy4gM3gZ9eN0wr1ddkbdD0Scg
	Vg5fsHRvpT2I61r6mn/3Q/04j3wAXTjDBmz7f+tReaCiQGBoSycs4VnCOLI4awR3
	ULiY9sdtDW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 179845DA9;
	Mon,  5 Dec 2011 13:58:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57D945DA8; Mon,  5 Dec 2011
 13:58:25 -0500 (EST)
In-Reply-To: <4EDBF4D5.6030908@pcharlan.com> (Pete Harlan's message of "Sun,
 04 Dec 2011 14:31:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C4358BE-1F73-11E1-B3E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186284>

Pete Harlan <pgit@pcharlan.com> writes:

> But this only works if there's a base version; if foo.c was added in
> each branch, we get:
>
>    error: path 'foo.c' does not have all three versions
>
> Git didn't need all three versions to create the original conflicted
> file, so why would it need them to recreate it?

Because the original "merge" was a bit more carefully written but
"checkout -m" was written without worrying too much about "both sides
added differently" corner case and still being defensive about not doing
random thing upon getting an unexpected input state.

IOW, being lazy ;-)

How does this look?

-- >8 --
checkout -m: no need to insist on having all 3 stages

The content level merge machinery ll_merge() is prepared to merge
correctly in "both sides added differently" case by using an empty blob as
if it were the common ancestor. "checkout -m" could do the same, but didn't
bother supporting it and instead insisted on having all three stages.

Reported-by: Pete Harlan
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c |   60 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a80772..923d040 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -114,16 +114,21 @@ static int check_stage(int stage, struct cache_entry *ce, int pos)
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
-static int check_all_stages(struct cache_entry *ce, int pos)
+static int check_stages(unsigned stages, struct cache_entry *ce, int pos)
 {
-	if (ce_stage(ce) != 1 ||
-	    active_nr <= pos + 2 ||
-	    strcmp(active_cache[pos+1]->name, ce->name) ||
-	    ce_stage(active_cache[pos+1]) != 2 ||
-	    strcmp(active_cache[pos+2]->name, ce->name) ||
-	    ce_stage(active_cache[pos+2]) != 3)
-		return error(_("path '%s' does not have all three versions"),
-			     ce->name);
+	unsigned seen = 0;
+	const char *name = ce->name;
+
+	while (pos < active_nr) {
+		ce = active_cache[pos];
+		if (strcmp(name, ce->name))
+			break;
+		seen |= (1 << ce_stage(ce));
+		pos++;
+	}
+	if ((stages & seen) != stages)
+		return error(_("path '%s' does not have all necessary versions"),
+			     name);
 	return 0;
 }
 
@@ -150,18 +155,27 @@ static int checkout_merged(int pos, struct checkout *state)
 	int status;
 	unsigned char sha1[20];
 	mmbuffer_t result_buf;
+	unsigned char threeway[3][20];
+	unsigned mode;
+
+	memset(threeway, 0, sizeof(threeway));
+	while (pos < active_nr) {
+		int stage;
+		stage = ce_stage(ce);
+		if (!stage || strcmp(path, ce->name))
+			break;
+		hashcpy(threeway[stage - 1], ce->sha1);
+		if (stage == 2)
+			mode = create_ce_mode(ce->ce_mode);
+		pos++;
+		ce = active_cache[pos];
+	}
+	if (is_null_sha1(threeway[1]) || is_null_sha1(threeway[2]))
+		return error(_("path '%s' does not have necessary versions"), path);
 
-	if (ce_stage(ce) != 1 ||
-	    active_nr <= pos + 2 ||
-	    strcmp(active_cache[pos+1]->name, path) ||
-	    ce_stage(active_cache[pos+1]) != 2 ||
-	    strcmp(active_cache[pos+2]->name, path) ||
-	    ce_stage(active_cache[pos+2]) != 3)
-		return error(_("path '%s' does not have all 3 versions"), path);
-
-	read_mmblob(&ancestor, active_cache[pos]->sha1);
-	read_mmblob(&ours, active_cache[pos+1]->sha1);
-	read_mmblob(&theirs, active_cache[pos+2]->sha1);
+	read_mmblob(&ancestor, threeway[0]);
+	read_mmblob(&ours, threeway[1]);
+	read_mmblob(&theirs, threeway[2]);
 
 	/*
 	 * NEEDSWORK: re-create conflicts from merges with
@@ -192,9 +206,7 @@ static int checkout_merged(int pos, struct checkout *state)
 	if (write_sha1_file(result_buf.ptr, result_buf.size,
 			    blob_type, sha1))
 		die(_("Unable to add merge result for '%s'"), path);
-	ce = make_cache_entry(create_ce_mode(active_cache[pos+1]->ce_mode),
-			      sha1,
-			      path, 2, 0);
+	ce = make_cache_entry(mode, sha1, path, 2, 0);
 	if (!ce)
 		die(_("make_cache_entry failed for path '%s'"), path);
 	status = checkout_entry(ce, state, NULL);
@@ -252,7 +264,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 			} else if (stage) {
 				errs |= check_stage(stage, ce, pos);
 			} else if (opts->merge) {
-				errs |= check_all_stages(ce, pos);
+				errs |= check_stages((1<<2) | (1<<3), ce, pos);
 			} else {
 				errs = 1;
 				error(_("path '%s' is unmerged"), ce->name);
