From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: respect "core.ignorecase"
Date: Sun, 09 Sep 2012 12:45:02 -0700
Message-ID: <7v1uibq8u9.fsf@alter.siamese.dyndns.org>
References: <1347210113-27435-1-git-send-email-ralf.thielow@gmail.com>
 <7v7gs3q9rp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 21:45:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAnRX-0005rU-Tt
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 21:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab2IITpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 15:45:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548Ab2IITpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 15:45:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B224C8B1D;
	Sun,  9 Sep 2012 15:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IrstiLo594TicU7mZtFbVLW6/w4=; b=SuSOFX
	QoayPJe6DCVpMQ5huuWxpgReO68z2U9j46fpCPkOMO/5iwQEWuS0d2yeFKd+VvOO
	AyUm6DuoNu1ptRvnCM7vagZuJPkPh6qjcDM9OhublkZlbVPc56NLh9nmzNqShdoS
	natfYX1y4c71Qs+Gu4PUeBfTkifY5wJEq7naA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nmpImg3Jy2CBRdZw7iDVW6knGKrQCeYq
	VKLz13nqfyCFq1qeqSXil4UB4yj+cIvYgQOir/IpmLkHJ8rJitI5axO3AG1XY+b6
	WkiwHFv6+2cVeJaoiOc6TGHtb5QenNUR1iduoVPbUdyQM4u/i8qcC9zT3hoTQiTl
	yx68KuYh9hs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F6888B1C;
	Sun,  9 Sep 2012 15:45:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB3D68B1A; Sun,  9 Sep 2012
 15:45:03 -0400 (EDT)
In-Reply-To: <7v7gs3q9rp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 09 Sep 2012 12:24:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D99C34C0-FAB6-11E1-BA12-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205089>

Junio C Hamano <gitster@pobox.com> writes:

> If we were to do anything, I would think the most sane thing to do
> is a smaller patch to fix fake_working_tree_commit() where it calls
> lstat() and _should_ die with "Cannot lstat MakeFILE" on a sane
> filesystem.  It does not currently make sure the path exists in the
> HEAD exactly as given by the user (i.e. without core.ignorecase
> matching), and die when it is not found.
>
> And that can be done regardless of core.ignorecase.  Currently on a
> case sensitive filesystem without core.ignorecase, this will give a
> useless result:
>
>     $ git rm Nakefile || :;
>     $ git commit --allow-empty -m 'Made sure there is no Nakefile'
>     $ >Nakefile
>     $ git blame -- Nakefile
>     00000000 (Not Committed Yet 2012-09-09 12:21:42 -0700 1) 
>
> and such a change to verify that the path exists in HEAD will give
> us "No such path Nakefile in HEAD" in such a case.
>
> It is a behaviour change, but I think it is a good change,
> regardless of the "What I have is Makefile, but my filesystem lies
> to us saying yes when I ask if MAKEFILE exists" issue.

Perhaps like this (again, totally untested).

A few points to note:

 - If the "Nakefile" is a "new file" with substantial contents, the
   result I labelled as "useless" in the previous message _might_
   have been seen as useful by some user; it might be a regression
   in that sense, but then there is fundamentally no way to give
   sensible behaviour to core.ignorecase users.

 - We used to say get_sha1("HEAD"), but that is not a very good
   practice; even though we know DWIM will find the .git/HEAD, make
   it clear that we are not DWIMming by calling resolve_ref().

 builtin/blame.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git i/builtin/blame.c w/builtin/blame.c
index 0e102bf..395dfbc 100644
--- i/builtin/blame.c
+++ w/builtin/blame.c
@@ -2069,6 +2069,19 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
+static void verify_working_tree_path(unsigned char *head_sha1, const char *path)
+{
+	unsigned char blob_sha1[20];
+	unsigned mode;
+
+	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+		die("no such ref: HEAD");
+	if (get_tree_entry(head_sha1, path, blob_sha1, &mode))
+		die("no such path '%s' in HEAD", path);
+	if (sha1_object_info(blob_sha1, NULL) != OBJ_BLOB)
+		die("path '%s' in HEAD is not a blob", path);
+}
+
 /*
  * Prepare a dummy commit that represents the work tree (or staged) item.
  * Note that annotating work tree item never works in the reverse.
@@ -2087,8 +2100,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	struct cache_entry *ce;
 	unsigned mode;
 
-	if (get_sha1("HEAD", head_sha1))
-		die("No such ref: HEAD");
+	verify_working_tree_path(head_sha1, path);
 
 	time(&now);
 	commit = xcalloc(1, sizeof(*commit));
