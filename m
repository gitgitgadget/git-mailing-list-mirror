Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D4E8FDB0
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240895AbjJCUAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJCUAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:00:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC26E9E
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:00:19 -0700 (PDT)
Received: (qmail 14276 invoked by uid 109); 3 Oct 2023 20:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:00:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14308 invoked by uid 111); 3 Oct 2023 20:00:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:00:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:00:18 -0400
From:   Jeff King <peff@peff.net>
To:     Jesse Hopkins <jesse.hops@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Possible to update-ref remote repository?
Message-ID: <20231003200018.GB1562@coredump.intra.peff.net>
References: <CAL3By--HowOL1ffKBPfmwnfUdJd4KXcnkpS2BgkbO=9E2WnHKw@mail.gmail.com>
 <xmqqo7hjfumj.fsf@gitster.g>
 <CAL3By-_jrYDenCc8HSrtnR3cZD19z7bvwVOOoO4XG+6aNFxyeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL3By-_jrYDenCc8HSrtnR3cZD19z7bvwVOOoO4XG+6aNFxyeQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2023 at 04:03:29PM -0600, Jesse Hopkins wrote:

> Thanks for the reply.  Would you be able to point me to some
> breadcrumbs for the "required protocol messages"?  I might try to
> tinker in some spare time.

Try "git help protocol-pack" in a recent version of Git (this used to be
in Documentation/technical/ of the repository, but much of that content
was moved into manpages around the v2.38 timeframe).

For a local or ssh connection, I think it is as simple as:

  # you somehow happen to know this commit exists on the server,
  # and what the current value of the ref is. If you don't know the
  # current value, you can pull it from receive-pack's ref
  # advertisement (I'll leave that as an exercise for the reader).
  old=1234abcd...
  new=5678cdef...
  ref=refs/heads/main

  # we'll use a local repository here, but you can replace receive-pack
  # invocation below with with "ssh $host git receive-pack $repo"
  repo=/path/to/repo.git

  {
    # git's pkt-line format is a 4-byte header with the ascii hex size of
    # the packet, followed by N-4 bytes of data. Each ref update is
    # in its own pkt, but we have just one.
    cmd="$old $new $ref"
    printf "%04x%s" $((${#cmd} + 4)) "$cmd"

    # An all-zero flush packet indicates the end of the list of updates.
    printf "0000"

    # the server insists that we send a valid packfile, even if it is
    # empty. This is from "git help format-pack" (the section on .pack
    # files), though you could also generate it with "git pack-objects
    # --stdout </dev/null".
    printf 'PACK' ;# packfile
    printf '\0\0\0\2' ;# version 2
    printf '\0\0\0\0' ;# zero objects
    # checksum, which is the sha1 of the rest of the pack
    printf "\2\235\10\202\73\330\250\352\265\20\255\152\307\134\202\74\375\76\323\36"
  } |
  git receive-pack "$repo"

You can get fancier by specifying capabilities (you might want
"report-status", for example).

That will work for local or ssh repos. For http, it gets a little more
complicated. See the section "smart service git-receive-pack" of "git
help protocol-http".

All that said, I do think it might be reasonable for git-push to support
this directly. It is basically:

  1. Let the command run in a non-repo, skipping anything that requires
     it. This _might_ be a maintenance headache, but as a fallback you
     could always run from an empty local repository.

  2. Tell it to always generate an empty pack (basically, a "trust me,
     the other side will be OK with it" option).

The second part looks like something like this:

diff --git a/send-pack.c b/send-pack.c
index 89aca9d829..c54463c181 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -58,6 +58,9 @@ static void feed_object(const struct object_id *oid, FILE *fh, int negative)
 	putc('\n', fh);
 }
 
+/* obviously this should be passed down somehow in a real patch */
+#define SPECIAL_EMPTY_PACK_OPTION 1
+
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
@@ -103,17 +106,19 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *advertised,
 	 * parameters by writing to the pipe.
 	 */
 	po_in = xfdopen(po.in, "w");
-	for (i = 0; i < advertised->nr; i++)
-		feed_object(&advertised->oid[i], po_in, 1);
-	for (i = 0; i < negotiated->nr; i++)
-		feed_object(&negotiated->oid[i], po_in, 1);
-
-	while (refs) {
-		if (!is_null_oid(&refs->old_oid))
-			feed_object(&refs->old_oid, po_in, 1);
-		if (!is_null_oid(&refs->new_oid))
-			feed_object(&refs->new_oid, po_in, 0);
-		refs = refs->next;
+	if (!SPECIAL_EMPTY_PACK_OPTION) {
+		for (i = 0; i < advertised->nr; i++)
+			feed_object(&advertised->oid[i], po_in, 1);
+		for (i = 0; i < negotiated->nr; i++)
+			feed_object(&negotiated->oid[i], po_in, 1);
+
+		while (refs) {
+			if (!is_null_oid(&refs->old_oid))
+				feed_object(&refs->old_oid, po_in, 1);
+			if (!is_null_oid(&refs->new_oid))
+				feed_object(&refs->new_oid, po_in, 0);
+			refs = refs->next;
+		}
 	}
 
 	fflush(po_in);

Come to think of it, you could probably fake it by wrapping
git-pack-objects with a script that throws away its input. Maybe hard to
do because its a builtin (and we run it as "git pack-objects", which
executes it directly in-process).

-Peff
