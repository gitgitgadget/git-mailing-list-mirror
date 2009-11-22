From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/3] git rerere unresolve file
Date: Sat, 21 Nov 2009 18:53:56 -0800
Message-ID: <7v6393mfqz.fsf@alter.siamese.dyndns.org>
References: <200911211958.40872.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 03:54:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NC2aa-0001rW-3J
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 03:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbZKVCx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 21:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZKVCx7
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 21:53:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbZKVCx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 21:53:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4803EA0385;
	Sat, 21 Nov 2009 21:54:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iq43+lq30jABvxAv/PyGcd/E+Aw=; b=kFy20e
	jTN1WPXPrIKSBYt/86xWZXr4fAir/df8rrcAXMniagf+eJI4XUCKssRX+9u9A3Y/
	dy9Xv2frEPEAbB3Z8DsprrkEqR23A5V+P7842DaJMbO1SGLOeAXhcXEl3ZPY+8Vl
	1otqSi6DPGQsIMrrlOB5xAuduK/+VQ9rpCXZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BeIv08LPETYTz4Vfu78dZd5pITxGKykJ
	uW+InaytKkSDdMzxHS/+JxEdLpB6PwarB/71oiV+dQQNe+gy9L/wI+1CSTu/JOp8
	MGfY3v6lnxx0if9iqwTftScsh+Ja1j2EEIj9+K4GrT2Mg37vhTae31zgt2LpADax
	LH7c8pw1TDw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 24E10A0384;
	Sat, 21 Nov 2009 21:54:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9E66EA0383; Sat, 21 Nov 2009
 21:53:58 -0500 (EST)
In-Reply-To: <200911211958.40872.j6t@kdbg.org> (Johannes Sixt's message of
 "Sat\, 21 Nov 2009 19\:58\:40 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4A25B890-D712-11DE-B857-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133419>

Johannes Sixt <j6t@kdbg.org> writes:

> ... But 
> there is no other way to remove an incorrect resolution short of purging the 
> whole rr-cache.

No, no no, no.  You do not have to.

As long as you can find out the <preimage,postimage> pair, iow, the
subdirectory used by .git/rr-cache/, you can remove only "postimage" from
there and redo your merge.  "ls -t1 .git/rr-cache/*/thisimage | head"
would be one way to manually find out which one it is.

For example, let's take this merge as an example.

commit 697eb20061dfa00838df32ac24c414dfb4a1f920
Merge: bba637b 46b77a6
Author: Junio C Hamano <gitster@pobox.com>

    Merge branch 'jk/1.7.0-status' into jch

You may not have rerere entries for this, so follow me along for a while.

 $ git checkout bba637b
 $ git merge 46b77a6

This will have a conflict.  We are priming your rerere database, so we
cheat (notice the last dot ".").

 $ git checkout 697eb200 -- .
 $ git rerere

Now reset it away, and redo the merge

 $ git reset --hard
 $ git checkout bba637b
 $ git merge 46b77a6

It will autoresolve the way I resolved in 697eb200

Suppose you do not like the resolution; you can do:

    $ git checkout --conflict=merge Documentation/git-commit.txt
    $ git rerere

to force updating "thisimage".  The newest one is the entry you are
looking for.

    $ ls -1t .git/rr-cache/*/thisimage | head -n 1
    .git/rr-cache/02aac459b0c777f92a8ca6f1e449e6760d366c20/thisimage

I can remove "postimage" from the directory, recreate conflict again,
run rerere to remember it anew, resolve and have rerere remember the new
resolution.

A tool support to compute the conflict hash would be part of a nice
solution.

    $ git checkout --conflict=merge Documentation/git-commit.txt
    $ git rerere hash
    02aac459b0c777f92a8ca6f1e449e6760d366c20 Documentation/git-commit.txt    

Instead of giving "hash" subcommand and having the user to remove
postimage from the directory, the tool can remove it, of course.

    $ git checkout --conflict=merge Documentation/git-commit.txt
    $ git rerere forget Documentation/git-commit.txt
    02aac459b0c777f92a8ca6f1e449e6760d366c20 Documentation/git-commit.txt    
    $ edit Documentation/git-commit.txt ;# come up with a better resolution 
    $ git rerere ;# record it

The attached are rough sketch of such "hash/forget" subcommands.

I however think the best user experience would go like this:

 * Run "git merge"; rerere replays an earlier resolution.

   $ git merge ...

   User decides that it is not a desirable one.

 * User fixes it and creates a better resolution in the work tree.  The
   user may fix-up the autoresolution or the user may first do "checkout
   --conflict=merge" and resolves the conflict from scratch.

   It does not matter how the updated resolution is prepared in the work
   tree.

 * Then the user tells rerere that "this is the corrected resolution",
   perhaps

   $ git rerere update Documentation/git-commit.txt

   This will

   - Internally recompute the original conflicted state, i.e. run
     "checkout --conflict=merge Documentation/git-commit.txt" in-core;

   - feed it to rerere.c::handle_file() to learn the conflict hash;

   - read the user's updated resolution from the work tree, and update
     "postimage" with it.

There is no need to change MERGE_RR at all if you did it the way outlined
in the above.

My "hash" would be more-or-less a useless command.  It still might be
useful as a plumbing command, but it is mostly for debugging.

The "forget" subcommand may be useful, but the real implementation should
be the first half of the "update", iow, recreate conflict in-core in order
to compute the conflict hash, and drop existing "postimage", without
replacing it from the work tree.  We should leave it up to the user using
"checkout --conflict" to reproduce the conflict in the work tree.

 builtin-rerere.c |    4 +++
 rerere.c         |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rerere.h         |    2 +
 3 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 343d6cd..8865313 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -108,6 +108,10 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 
 	if (!strcmp(argv[1], "-h"))
 		usage(git_rerere_usage);
+	else if (!strcmp(argv[1], "hash"))
+		return rerere_report_hash();
+	else if (!strcmp(argv[1], "forget"))
+		return rerere_forget(argv + 2);
 
 	fd = setup_rerere(&merge_rr);
 	if (fd < 0)
diff --git a/rerere.c b/rerere.c
index 29f95f6..4899219 100644
--- a/rerere.c
+++ b/rerere.c
@@ -392,3 +392,61 @@ int rerere(void)
 		return 0;
 	return do_plain_rerere(&merge_rr, fd);
 }
+
+int rerere_forget(const char **path)
+{
+	struct string_list conflict = { NULL, 0, 0, 1 };
+	int i;
+
+	find_conflict(&conflict);
+
+	/*
+	 * Note note note.  I am being lazy here.  The loop should not
+	 * iterate over "path" like this.
+	 *
+	 * It should instead iterate over conflict entries, using "path"
+	 * as pathspec to filter, so that you can say "I am done with
+	 * all the conflict in Documentation/ area".
+	 */
+	for (i = 0; path[i]; i++) { 
+		unsigned char sha1[20];
+		const char *postimage;
+		int ret;
+
+		if (!string_list_has_string(&conflict, path[i])) {
+			error("No such conflicted path %s\n", path[i]);
+			continue;
+		}
+		ret = handle_file(path[i], sha1, NULL);
+		if (ret < 1) {
+			error("No conflict in work tree %s\n", path[i]);
+			continue;
+		}
+		postimage = rerere_path(sha1_to_hex(sha1), "postimage");
+		if (!unlink(postimage))
+			fprintf(stderr, "forgot resolution for %s\n", path[i]);
+		else if (errno == ENOENT)
+			error("no remembered resolution for %s", path[i]);
+		else
+			error("cannot unlink %s: %s", postimage, strerror(errno));
+	}
+	return 0;
+}
+
+int rerere_report_hash(void)
+{
+	struct string_list conflict = { NULL, 0, 0, 1 };
+	int i;
+
+	find_conflict(&conflict);
+	for (i = 0; i < conflict.nr; i++) {
+		const char *path = conflict.items[i].string;
+		unsigned char sha1[20];
+		int ret;
+		ret = handle_file(path, sha1, NULL);
+		if (ret < 1)
+			continue;
+		printf("%s %s\n", sha1_to_hex(sha1), path);
+	}
+	return 0;
+}
diff --git a/rerere.h b/rerere.h
index 13313f3..a10dea9 100644
--- a/rerere.h
+++ b/rerere.h
@@ -7,5 +7,7 @@ extern int setup_rerere(struct string_list *);
 extern int rerere(void);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
+extern int rerere_report_hash(void);
+extern int rerere_forget(const char **path);
 
 #endif
