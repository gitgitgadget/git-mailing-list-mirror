Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D36CE7B08
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 07:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjI1HPX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 28 Sep 2023 03:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjI1HPE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 03:15:04 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12EF9
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 00:14:44 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-65af1037ca8so53944456d6.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 00:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885283; x=1696490083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAAF+jtzYIOiiaduvqWmO8Zoru6eUaIH8TErwaOuH5g=;
        b=aoK5L2eNETb+xeIYT3fB5JtLVnAhnnHRsqdDXBPomm+dQecUmdA+wxWe/nxqcmWHhU
         78lvzBoDv7jY5+JXawLNj0BrDD/Yln0PI0mDFnhsdT7u6xjlj6sVTxW3Gj9/VdvcXljX
         cIf7aGvRsRM0wox0hMgfGAToowk+HM6LnFKi1CrXy/mqvnoEsmm/d5FW4j870Yxs/qq0
         /LDk7VAzIZ2shVBDKYqHTlczF3Jnhad3zadX3nailIqz05c98LS8sdAQA3gL4iIAel9W
         OZ4gD2OlGUU7zvXHk7ZN6DJpnMv0uhlQ0a97hz7wZ+4E8/VZqIBM+raniZJb64Pjawun
         HqnA==
X-Gm-Message-State: AOJu0YyKbWnQUqC91tXCQIWPrs2jSZIyAUwxjsjg5EvKVJSAZziBRo/X
        8dRIO7S1IJwupiik9dO9nZ7YXBjorUpXLWLXynKQ1YJb
X-Google-Smtp-Source: AGHT+IExMLp7Rk38BqvBc+uK04K0LI1rohf4NTTCcdDe/PeU537QAioLqkYtJYgLeko6GfRTkrscupaRfIsM3r5mMwQ=
X-Received: by 2002:a0c:da85:0:b0:651:66c4:cf4e with SMTP id
 z5-20020a0cda85000000b0065166c4cf4emr473171qvj.23.1695885283518; Thu, 28 Sep
 2023 00:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org> <20230927195537.1682-5-ebiederm@gmail.com>
In-Reply-To: <20230927195537.1682-5-ebiederm@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Sep 2023 03:14:31 -0400
Message-ID: <CAPig+cS02ushqgw+u39Tmnoy3rgp8BzqT4T9D=-01m5fsLxC6Q@mail.gmail.com>
Subject: Re: [PATCH 05/30] loose: add a mapping between SHA-1 and SHA-256 for
 loose objects
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2023 at 3:56 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> As part of the transition plan, we'd like to add a file in the .git
> directory that maps loose objects between SHA-1 and SHA-256.  Let's
> implement the specification in the transition plan and store this data
> on a per-repository basis in struct repository.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> diff --git a/loose.c b/loose.c
> @@ -0,0 +1,245 @@
> +static int load_one_loose_object_map(struct repository *repo, struct object_directory *dir)
> +{
> +       struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
> +       FILE *fp;
> +
> +       if (!dir->loose_map)
> +               loose_object_map_init(&dir->loose_map);
> +
> +       insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
> +       insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_tree, repo->hash_algo->empty_tree);
> +
> +       insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
> +       insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->empty_blob, repo->hash_algo->empty_blob);
> +
> +       insert_oid_pair(dir->loose_map->to_compat, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
> +       insert_oid_pair(dir->loose_map->to_storage, repo->compat_hash_algo->null_oid, repo->hash_algo->null_oid);
> +
> +       strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
> +       fp = fopen(path.buf, "rb");
> +       if (!fp)
> +               return 0;

This early return leaks `path`. At minimum, call
`strbuf_release(&path)` before returning.

> +       errno = 0;
> +       if (strbuf_getwholeline(&buf, fp, '\n') || strcmp(buf.buf, loose_object_header))
> +               goto err;
> +       while (!strbuf_getline_lf(&buf, fp)) {
> +               const char *p;
> +               struct object_id oid, compat_oid;
> +               if (parse_oid_hex_algop(buf.buf, &oid, &p, repo->hash_algo) ||
> +                   *p++ != ' ' ||
> +                   parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
> +                   p != buf.buf + buf.len)
> +                       goto err;
> +               insert_oid_pair(dir->loose_map->to_compat, &oid, &compat_oid);
> +               insert_oid_pair(dir->loose_map->to_storage, &compat_oid, &oid);
> +       }
> +
> +       strbuf_release(&buf);
> +       strbuf_release(&path);
> +       return errno ? -1 : 0;
> +err:
> +       strbuf_release(&buf);
> +       strbuf_release(&path);
> +       return -1;
> +}
> +
> +int repo_write_loose_object_map(struct repository *repo)
> +{
> +       kh_oid_map_t *map = repo->objects->odb->loose_map->to_compat;
> +       struct lock_file lock;
> +       int fd;
> +       khiter_t iter;
> +       struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
> +
> +       if (!should_use_loose_object_map(repo))
> +               return 0;
> +
> +       strbuf_git_common_path(&path, repo, "objects/loose-object-idx");
> +       fd = hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
> +       iter = kh_begin(map);
> +       if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
> +               goto errout;
> +
> +       for (; iter != kh_end(map); iter++) {
> +               if (kh_exist(map, iter)) {
> +                       if (oideq(&kh_key(map, iter), the_hash_algo->empty_tree) ||
> +                           oideq(&kh_key(map, iter), the_hash_algo->empty_blob))
> +                               continue;
> +                       strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
> +                       if (write_in_full(fd, buf.buf, buf.len) < 0)
> +                               goto errout;
> +                       strbuf_reset(&buf);
> +               }
> +       }

Nit: If you call strbuf_reset() immediately before strbuf_addf(), then
you save the reader of the code the effort of having to scan backward
through the function to verify that `buf` is empty the first time
through the loop.

> +       strbuf_release(&buf);
> +       if (commit_lock_file(&lock) < 0) {
> +               error_errno(_("could not write loose object index %s"), path.buf);
> +               strbuf_release(&path);
> +               return -1;
> +       }
> +       strbuf_release(&path);
> +       return 0;
> +errout:
> +       rollback_lock_file(&lock);
> +       strbuf_release(&buf);
> +       error_errno(_("failed to write loose object index %s\n"), path.buf);
> +       strbuf_release(&path);
> +       return -1;
> +}
> +
> +int repo_loose_object_map_oid(struct repository *repo,
> +                             const struct object_id *src,
> +                             const struct git_hash_algo *to,
> +                             struct object_id *dest)
> +
> +{

Style: unnecessary blank line before opening `{`

> +       struct object_directory *dir;
> +       kh_oid_map_t *map;
> +       khiter_t pos;
> +
> +       for (dir = repo->objects->odb; dir; dir = dir->next) {
> +               struct loose_object_map *loose_map = dir->loose_map;
> +               if (!loose_map)
> +                       continue;
> +               map = (to == repo->compat_hash_algo) ?
> +                       loose_map->to_compat :
> +                       loose_map->to_storage;
> +               pos = kh_get_oid_map(map, *src);
> +               if (pos < kh_end(map)) {
> +                       oidcpy(dest, kh_value(map, pos));
> +                       return 0;
> +               }
> +       }
> +       return -1;
> +}
