Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A4AC2022D
	for <e@80x24.org>; Tue, 28 Feb 2017 07:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbdB1H0x (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 02:26:53 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34263 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdB1H0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 02:26:52 -0500
Received: by mail-io0-f170.google.com with SMTP id 90so4138906ios.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 23:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to:cc;
        bh=ZzNvKRdMmjLoIetmM/JI3YmXwtDW+Nqy8Eo8Mi/TAHc=;
        b=hkOCNO0RSTALdHG5NbcielihZktWsz9AojwVJvlwzBAuvdihWAo7rTmfxvhwgYNWIi
         sW5CX+tU+ZTY93H90/X+vDmdVNC2feOqO9KIR31758D/0PtVsF/SydXMzad4BoFBCM32
         BMeaxNpXcn7R7skrIabh67sdaELb8DCK/R7io9in/0LeL9YlxiNHFELwPOfDnQnc+5e9
         MCpNG3+u027Cro+NhdcmiulQdP6PGZyO5Fst34v8EjD0NJHTS+1aVdLozBpbh3MfNWnx
         SDufzYOItHrP2TiXNNYap0ub6DAhtsglYaWeE9AA4CgzWOCA8uwTbzwC0K78PU6fNsY4
         VEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:cc;
        bh=ZzNvKRdMmjLoIetmM/JI3YmXwtDW+Nqy8Eo8Mi/TAHc=;
        b=OJOCD6ImfogCwhYLwkUhtC90vSMXAI7zkXho8PMQtm0kongJEO+CTj1cIgCWVKL/AS
         cJ68KEXWlvh4Ts1KN3u78rsXB3Mx7iEYw8fFdYvpTvUZy+Uf2pQ5KwYxryTUbJQTHLTZ
         PQWOL0NJAQhLb7pLZviv1FZuH6buv+F85WpClqAcAjMEG+PnpRWHm8rDHmPhW3iy/zf/
         cZ6vi1gMpHndtTkeLYQBaCKfvmr5XN5v97aOvZOfOk2CLB/SfO30HVt//65H2C9HPbeb
         YKGRZh1FJvq2V7eMtDkzFE+MYg/kJhIKmhf6J7fGXw6nGSYUmu1BWB+WBccisnWdpGHr
         6npQ==
X-Gm-Message-State: AMke39k2LnltX/avmm+FFirL/aWJlmmvT7n7gNhQ9yQ9wLkBJBg+FiVTIXqQIo9K0lmqTkFX1Ho2vthEgYV4/A==
X-Received: by 10.107.136.93 with SMTP id k90mr1119321iod.224.1488265156051;
 Mon, 27 Feb 2017 22:59:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Mon, 27 Feb 2017 22:59:15 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2017 22:59:15 -0800
X-Google-Sender-Auth: vJ-oHdmJ3XQD-UucbUIXfqbygA4
Message-ID: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
Subject: Typesafer git hash patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So because of the whole SHA1 discussion, I started looking at what it
would involve to turn

    unsigned char *sha1

style arguments (and various structure members) in the git source into

   typedef struct { ... } hash_t;

   hash_t *hash;

The answer is that it's pretty painful - more so than I expected (I
looked at it _looong_ ago and decided it was painful - and it has
become more painful as git has grown).

But once I got started I just continued through the slog.

Having the hashes be more encapsulated does seem to make things better
in many ways. What I did was to also just unify the notion of "hash_t"
and "struct object_id", so the two are entirely interchangeable. That
actually can clean up some code, because right now we have duplicate
interfaces for some things that take an oid pointer and others take a
"const unsigned char *sha1", and that duplication essentially can go
away. I didn't do any of that, I tried to keep it as as brute-force
stupid conversion.

I saw that somebody is actually looking at doing this "well" - by
doing it in many smaller steps. I tried. I gave up. The "unsigned char
*sha1" model is so ingrained that doing it incrementally just seemed
like a lot of pain. But it might be the right approach.

It might particularly be the right approach considering the size of the patch:

 216 files changed, 4174 insertions(+), 4080 deletions(-)

which is pretty nasty. The good news is that my patch passes all the
tests, and while it's big it's mostly very very mindless, and a lot of
it looks like cleanups, and the lines are generally shorter, eg

-               const unsigned char *mb = result->item->object.oid.hash;
-               if (!hashcmp(mb, current_bad_oid->hash)) {

turns into

+               const hash_t *mb = &result->item->object.oid;
+               if (!hashcmp(mb, current_bad_oid)) {

but I ended up also renaming a lot of common "sha1" as "hash", which
adds to the noise in that patch.

NOTE! It doesn't actually _fix_ the SHA1-centricity in any way, but it
makes it a bit more obvious where the bigger problems are. Not that
anybody would be surprised by what they are, but as part of writing
the patch it did kind of pinpoint most of them, and about 30 of those
new lines are added

 /* FIXME! Hardcoded hash sizes */
 /* FIXME! Lots of fixed-size hashes */
 /* FIXME! Fixed 20-byte hash usage */

with the rest of the added lines being a few helper functions and
splitting cache.h up a bit.

And as part of the type safety, I do think I may have found a bug:

show_one_mergetag():

                strbuf_addf(&verify_message, "tag %s names a non-parent %s\n",
                                    tag->tag, tag->tagged->oid.hash);

note how it prints out the "non-parent %s", but that's a SHA1 hash
that hasn't been converted to hex. Hmm?

Anyway, is anybody interested?  I warn you - it really is one big
patch on top of 2.12.

                   Linus

PS. Just for fun, I tried to look what it does when you then merge pu
or next.. You do get a fair number of merge conflicts because there's
just a lot of changes all around, but they look manageable. So merging
something like that would be painful, but it appears to not entirely
break other development.
