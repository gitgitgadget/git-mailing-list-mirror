Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45EFC43334
	for <git@archiver.kernel.org>; Sat, 11 Jun 2022 02:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiFKCoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 22:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbiFKCoh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 22:44:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1264E27B9A9
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e11so996856pfj.5
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 19:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vLUWLjYkleWN5BEzzxD8ijf+fH0mXjEytjMMPvFM3Ks=;
        b=fHXFmb4dAOqMyfGSlpY29tUSD7AP9lcoCm3BlIJWxWt4kNdQyT9qohzLNvmTATX8X1
         0IRK9EkketUvOQ+d+m2FhHQ1efEtrER2yYDz4vZUQIllMn3uzaAjwqRH71cO9SpGpetW
         PXiW9jZ/JbysKQY37+8qnYzF2//rNsbEt6N/ZXDaclmYlNWM+Zaf9RlfVeAG55a7/tWp
         WP9hOMgfb2uYwT4a5u8Dw39c9i9WVIj39+194fJ/IlzpDVFagDKeBk/n8dLVjVJC2+vE
         y0jeAr0Na99gFcLikRH/5TC8wwz3C7xTJdZvkTOogAqSi8IXfSVPH6RTzChIBTIfA/cK
         zBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vLUWLjYkleWN5BEzzxD8ijf+fH0mXjEytjMMPvFM3Ks=;
        b=Xi7t4eUhgqZVF+yYoNyQNM4iE41u6+JobL/8iLWTI4JE28RhaOrPoKcVZ/Q2PsfXRJ
         lE1VfWa2iXfJ5KDEZPMGOkFkOhsq5ssg0uHZcsuJ4nSJNAaAGQ+b2aNUnBBaxoDVtQRw
         qU+p3LQHGiEqcnapfMqEyGltzhy12YvmJ81wi9EvkS+ac/aun+Wh44ffcFuvbvSSzMOs
         x1S/44LB5AgDTmYCiHxugNV6qwJeFG5QElK1gqjGJLMIS7vecosTTrfEykFNhvS/9rvL
         qPmv7GOWu81g8VFvO9kYo3WXW8eR8ARNFiRTljDBo9oigzm8NfBVq2M0ko/nEt1uUJkN
         AqLw==
X-Gm-Message-State: AOAM531WlyhdHEKM0JZlFtaE9PPlCMzpSxisZVUgQFyVImOnyDEqbF5r
        yiHhn6LgZSquMN6iVcRm3z8=
X-Google-Smtp-Source: ABdhPJw/qkxaNHCqrCJdBphykpP2+ESH3mQPhFf232LExqLyO9fZKZCpIdPdiB7FsNSPJkoPA/iQAg==
X-Received: by 2002:aa7:8ec6:0:b0:51b:c6ec:5ff5 with SMTP id b6-20020aa78ec6000000b0051bc6ec5ff5mr46752892pfr.5.1654915475421;
        Fri, 10 Jun 2022 19:44:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:80c:ca60:6957:cd88:1852:9438])
        by smtp.gmail.com with ESMTPSA id l13-20020a62be0d000000b0051ba90d55acsm257077pff.207.2022.06.10.19.44.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jun 2022 19:44:34 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     Han Xin <chiyutianyi@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, neerajsi@microsoft.com,
        newren@gmail.com, philipoakley@iee.email, stolee@gmail.com,
        worldhello.net@gmail.com, Neeraj Singh <nksingh85@gmail.com>
Subject: [PATCH v15 0/6] unpack-objects: support streaming blobs to disk
Date:   Sat, 11 Jun 2022 10:44:15 +0800
Message-Id: <cover.1654914555.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654871915.git.chiyutianyi@gmail.com>
References: <cover.1654871915.git.chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes "unpack-objects" capable of streaming large objects
to disk.

As 6/6 shows streaming e.g. a 100MB blob now uses ~5MB of memory
instead of ~105MB. This streaming method is slower if you've got
memory to handle the blobs in-core, but if you don't it allows you to
unpack objects at all, as you might otherwise OOM.

Changes since v14:

* Remove "object-file.c: do fsync() and close() before post-write die()"
  as it's not necessary anymore. It was first introduced in v10 and was
  no longer in the utility function end_loose_object_common() since v12.
  We can see the discussion[1].

* Minor grammar/comment etc. fixes throughout.

1. https://lore.kernel.org/git/0b9bc499-18c7-e8ab-5c89-f9e1a98685bc@web.de/

Han Xin (4):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: use stream_loose_object() to unpack large objects

Ævar Arnfjörð Bjarmason (2):
  object-file.c: factor out deflate part of write_loose_object()
  core doc: modernize core.bigFileThreshold documentation

 Documentation/config/core.txt   |  33 +++--
 builtin/unpack-objects.c        | 106 +++++++++++++--
 object-file.c                   | 233 ++++++++++++++++++++++++++++----
 object-store.h                  |   8 ++
 t/t5351-unpack-large-objects.sh |  76 +++++++++++
 5 files changed, 405 insertions(+), 51 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

Range-diff against v14:
1:  bf600a2fa8 ! 1:  9a776f717d unpack-objects: low memory footprint for get_data() in dry_run mode
    @@ Commit message
         d9545c7f465 (fast-import: implement unpack limit, 2016-04-25).
     
         Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Han Xin <chiyutianyi@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/unpack-objects.c ##
2:  a327f484f7 < -:  ---------- object-file.c: do fsync() and close() before post-write die()
3:  9bc8002282 ! 2:  a1e090d338 object-file.c: refactor write_loose_object() to several steps
    @@ Commit message
     
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Han Xin <chiyutianyi@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     -	ret = git_deflate_end_gently(&stream);
     +	ret = end_loose_object_common(&c, &stream, &parano_oid);
      	if (ret != Z_OK)
    --		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
    --		    ret);
    + 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
    + 		    ret);
     -	the_hash_algo->final_oid_fn(&parano_oid, &c);
    -+		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid), ret);
    - 	close_loose_object(fd, tmp_file.buf);
    - 
      	if (!oideq(oid, &parano_oid))
    + 		die(_("confused by unstable object source data for %s"),
    + 		    oid_to_hex(oid));
4:  7c73815f18 = 3:  0ddf912d47 object-file.c: factor out deflate part of write_loose_object()
5:  28a9588f9c ! 4:  f9e51d3c68 object-file.c: add "stream_loose_object()" to handle large object
    @@ Commit message
         Helped-by: René Scharfe <l.s.r@web.de>
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Han Xin <chiyutianyi@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
6:  dea5c4172b ! 5:  61ae1c1632 core doc: modernize core.bigFileThreshold documentation
    @@ Documentation/config/core.txt: You probably do not need to adjust this value.
     -Common unit suffixes of 'k', 'm', or 'g' are supported.
     +* Stored deflated in packfiles, without attempting delta compression.
     ++
    -+The default limit is primarily set with this use-case in mind. With it
    ++The default limit is primarily set with this use-case in mind. With it,
     +most projects will have their source code and other text files delta
     +compressed, but not larger binary media files.
     ++
     +Storing large files without delta compression avoids excessive memory
     +usage, at the slight expense of increased disk usage.
     ++
    -+* Will be treated as if though they were labeled "binary" (see
    ++* Will be treated as if they were labeled "binary" (see
     +  linkgit:gitattributes[5]). e.g. linkgit:git-log[1] and
    -+  linkgit:git-diff[1] will not diffs for files above this limit.
    ++  linkgit:git-diff[1] will not compute diffs for files above this limit.
     ++
    -+* Will be generally be streamed when written, which avoids excessive
    ++* Will generally be streamed when written, which avoids excessive
     +memory usage, at the cost of some fixed overhead. Commands that make
     +use of this include linkgit:git-archive[1],
     +linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
7:  d236230a4c ! 6:  5a4782d746 unpack-objects: use stream_loose_object() to unpack large objects
    @@ Commit message
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Derrick Stolee <stolee@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
    -    Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Han Xin <chiyutianyi@gmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/config/core.txt ##
     @@ Documentation/config/core.txt: usage, at the slight expense of increased disk usage.
    - * Will be generally be streamed when written, which avoids excessive
    + * Will generally be streamed when written, which avoids excessive
      memory usage, at the cost of some fixed overhead. Commands that make
      use of this include linkgit:git-archive[1],
     -linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
-- 
2.36.1

