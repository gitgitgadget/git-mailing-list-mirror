Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C37C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJTSVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJTSVH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:21:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E7A1A045E
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:21:01 -0700 (PDT)
Received: (qmail 7343 invoked by uid 109); 20 Oct 2022 18:21:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Oct 2022 18:21:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22865 invoked by uid 111); 20 Oct 2022 18:21:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Oct 2022 14:21:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Oct 2022 14:21:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Another possible instance of async-signal-safe opendir path
 callstack? (Was: [PATCH] tmp-objdir: do not opendir() when handling a
 signal)
Message-ID: <Y1GRjH9d9FR5zbrv@coredump.intra.peff.net>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
 <00af268377fb7c3b8efd059482ee7449b71f48b1.camel@fnusa.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00af268377fb7c3b8efd059482ee7449b71f48b1.camel@fnusa.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 01:58:58PM +0200, Jan Pokorný wrote:

> Just noticed this unattended git crash in the logs and I think it might
> actually be another occurrence of the same problem in principle, so
> shamelessly piggy-backing the stack trace here (no coredump preserved
> at this point, sorry):
> 
>     #0  0x00007f08df0ea06c __pthread_kill_implementation (libc.so.6 + 0x8b06c)
>     #1  0x00007f08df098046 raise (libc.so.6 + 0x39046)
>     #2  0x00007f08df0817fc abort (libc.so.6 + 0x227fc)
>     #3  0x00007f08df082533 __libc_message.cold (libc.so.6 + 0x23533)
>     #4  0x00007f08df090a67 __libc_assert_fail (libc.so.6 + 0x31a67)
>     #5  0x00007f08df0f68f2 sysmalloc (libc.so.6 + 0x978f2)
>     #6  0x00007f08df0f7789 _int_malloc (libc.so.6 + 0x98789)
>     #7  0x00007f08df0f80d2 __libc_malloc (libc.so.6 + 0x990d2)
>     #8  0x00007f08df12fa55 __alloc_dir (libc.so.6 + 0xd0a55)
>   ->#9  0x00007f08df12fac2 opendir_tail (libc.so.6 + 0xd0ac2)
>     #10 0x00005632ea10c823 remove_temporary_files.lto_priv.0 (git + 0xdc823)
>   ->#11 0x00005632ea10c97c remove_pack_on_signal.lto_priv.0 (git + 0xdc97c)
>     #12 0x00007f08df0980f0 __restore_rt (libc.so.6 + 0x390f0)
>     #13 0x00007f08df0f7775 _int_malloc (libc.so.6 + 0x98775)
>     #14 0x00007f08df0f80d2 __libc_malloc (libc.so.6 + 0x990d2)
>     #15 0x00007f08df0d2b44 _IO_file_doallocate (libc.so.6 + 0x73b44)
>     #16 0x00007f08df0e1d20 _IO_doallocbuf (libc.so.6 + 0x82d20)
>     #17 0x00007f08df0e0a8c _IO_file_underflow@@GLIBC_2.2.5 (libc.so.6 + 0x81a8c)
>     #18 0x00007f08df0d4598 __getdelim (libc.so.6 + 0x75598)
>     #19 0x00005632ea29f372 strbuf_getwholeline (git + 0x26f372)
>     #20 0x00005632ea117915 cmd_repack (git + 0xe7915)
>     #21 0x00005632ea0556fa handle_builtin.lto_priv.0 (git + 0x256fa)
>     #22 0x00005632ea050551 main (git + 0x20551)
>     #23 0x00007f08df082a50 __libc_start_call_main (libc.so.6 + 0x23a50)
>     #24 0x00007f08df082b09 __libc_start_main@@GLIBC_2.34 (libc.so.6 + 0x23b09)
>     #25 0x00005632ea051555 _start (git + 0x21555)

Good find. This is definitely the same issue.

Unfortunately it's another hard one to fix.

git-repack asks git-pack-objects to use .tmp-pack-$$ as a prefix. So I
thought we might be able to get away with using register_tempfile() to
just record the names of potential files it creates by appending .pack,
.idx, and so forth. That code is well-tested and is careful to be
signal-safe.

But the actual name will include the checksum of the packfile, so
.tmp-pack-$$-1234abcd.pack, etc. And repack doesn't know those until
pack-objects reports the hash to us. OTOH, I think pack-objects doesn't
create the files with that name until the very last minute (it has its
own tempfiles[1]). So we could probably get away with expanding the
filenames once it tells us the hash.

Something like the patch below.

diff --git a/builtin/repack.c b/builtin/repack.c
index a5bacc7797..8d6121b438 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -122,13 +122,6 @@ static void remove_temporary_files(void)
 	strbuf_release(&buf);
 }
 
-static void remove_pack_on_signal(int signo)
-{
-	remove_temporary_files();
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 /*
  * Adds all packs hex strings to either fname_nonkept_list or
  * fname_kept_list based on whether each pack has a corresponding
@@ -268,6 +261,17 @@ static unsigned populate_pack_exts(char *name)
 	return ret;
 }
 
+static void register_tmp_pack_for_cleanup(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		char *path = xstrfmt("%s-%s%s", packtmp, name, exts[i].name);
+		register_tempfile(path);
+		free(path);
+	}
+}
+
 static void repack_promisor_objects(const struct pack_objects_args *args,
 				    struct string_list *names)
 {
@@ -714,6 +718,7 @@ static int write_cruft_pack(const struct pack_objects_args *args,
 			die(_("repack: Expecting full hex object ID lines only "
 			      "from pack-objects."));
 		string_list_append(names, line.buf);
+		register_tmp_pack_for_cleanup(line.buf);
 	}
 	fclose(out);
 
@@ -859,8 +864,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		split_pack_geometry(geometry, geometric_factor);
 	}
 
-	sigchain_push_common(remove_pack_on_signal);
-
 	prepare_pack_objects(&cmd, &po_args);
 
 	show_progress = !po_args.quiet && isatty(2);
@@ -955,6 +958,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		if (line.len != the_hash_algo->hexsz)
 			die(_("repack: Expecting full hex object ID lines only from pack-objects."));
 		string_list_append(&names, line.buf);
+		register_tmp_pack_for_cleanup(line.buf);
 	}
 	fclose(out);
 	ret = finish_command(&cmd);
@@ -1025,6 +1029,16 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			else if (unlink(fname) < 0 && errno != ENOENT)
 				die_errno(_("could not unlink: %s"), fname);
 
+			/*
+			 * We should deregister pack tempfiles here; leaving
+			 * them kind of works in that we'll try to unlink
+			 * something that is already gone, but it would be
+			 * cleaner to note that we expect them to be gone here.
+			 * We could perhaps even just use rename_tempfile() and
+			 * delete_tempfile() here, if we modified item->util to
+			 * keep track of the tempfile objects (rather than
+			 * single bits).
+			 */
 			free(fname);
 			free(fname_old);
 		}

-Peff

[1] Note that to some degree, this cleanup is already a bit of a fool's
    errand. It is only catching the "finished" packfiles before we move
    them to their final names. Whereas pack-objects is perfectly happy
    to write bytes into tmp_pack_XXXXXX, and does not bother to clean it
    if it runs into an error or signal. And that is where most of the
    time will be spent.

    So one option would be to just drop this signal handling entirely.
    But IMHO we should go the other way, and teach pack-objects to also
    clean up after itself. I know GitHub has been running with patches
    to call register_tempfile() like this for years (but it is hacky the
    way the above patch is; it never unregisters, which is why we never
    sent them upstream).

    Another problem is that repack.c only catches signals, not die(),
    which is the more likely culprit (e.g., you generate the "main"
    pack, and then something goes wrong while renaming or generating
    an ancillary cruft-packs). Switching to register_tempfile() does fix
    that, though.
