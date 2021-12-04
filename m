Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E62C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 02:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhLDCRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 21:17:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:43390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231452AbhLDCRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 21:17:15 -0500
Received: (qmail 25663 invoked by uid 109); 4 Dec 2021 02:13:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Dec 2021 02:13:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7990 invoked by uid 111); 4 Dec 2021 02:13:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 21:13:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 21:13:50 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: coverity problems in reftable code
Message-ID: <YarO3nkrutmWF7nb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

We're not doing project-wide analysis with Coverity right now, but I've
been doing builds of my personal repo, which I usually build off of
next. And since hn/reftable just hit next, it got included in my latest
build.

It came up with several complaints. Some of them are dumb and can be
ignored (e.g., using rand() in a test harness, oh no!) but I poked at a
few and they look like real issues:

  - the stack overflow in reftable_log_record_print() is real; I think you
    want HEXSZ instead of RAWSZ for your buffer (also, should it be
    GIT_MAX_HEXSZ?)

  - various fd/memory leaks on error returns

  - A lot of your structs have vtables. Initializing them to NULL, as in
    reftable_reader_refs_for_indexed(), leaves the risk that we'll try
    to call a NULL function pointer, even if it's for something simple
    like cleaning up. That's the case here (if loading want_rec fails,
    we'll jump to "done" and try to clean up got_rec, even though it's
    still got a NULL vtable). One solution is for reftable_record_release()
    to check for NULL (and other destructors; there's a similar case in
    the last snippet below for reftable_reader_free()).

    But I also wasn't sure how extensive the use of polymorphism was,
    and if it might be possible for us to do more at initialization
    time. Something like:

diff --git a/reftable/reader.c b/reftable/reader.c
index 2db0019111..8ac248b070 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -653,21 +653,19 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 		.hash_prefix = oid,
 		.hash_prefix_len = r->object_id_len,
 	};
-	struct reftable_record want_rec = { NULL };
+	struct reftable_record want_rec = REFTABLE_RECORD_OBJ(&want);
 	struct reftable_iterator oit = { NULL };
 	struct reftable_obj_record got = { NULL };
-	struct reftable_record got_rec = { NULL };
+	struct reftable_record got_rec = REFTABLE_RECORD_OBJ(&got);
 	int err = 0;
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	reftable_record_from_obj(&want_rec, &want);
 	err = reader_seek(r, &oit, &want_rec);
 	if (err != 0)
 		goto done;
 
 	/* read out the reftable_obj_record */
-	reftable_record_from_obj(&got_rec, &got);
 	err = iterator_next(&oit, &got_rec);
 	if (err < 0)
 		goto done;
diff --git a/reftable/record.c b/reftable/record.c
index 5a4bbed6c8..4c34752d18 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -572,7 +572,7 @@ static int not_a_deletion(const void *UNUSED(p))
 	return 0;
 }
 
-static struct reftable_record_vtable reftable_obj_record_vtable = {
+struct reftable_record_vtable reftable_obj_record_vtable = {
 	.key = &reftable_obj_record_key,
 	.type = BLOCK_TYPE_OBJ,
 	.copy_from = &reftable_obj_record_copy_from,
@@ -1106,14 +1106,6 @@ void reftable_record_from_ref(struct reftable_record *rec,
 	rec->ops = &reftable_ref_record_vtable;
 }
 
-void reftable_record_from_obj(struct reftable_record *rec,
-			      struct reftable_obj_record *obj_rec)
-{
-	assert(!rec->ops);
-	rec->data = obj_rec;
-	rec->ops = &reftable_obj_record_vtable;
-}
-
 void reftable_record_from_index(struct reftable_record *rec,
 				struct reftable_index_record *index_rec)
 {
diff --git a/reftable/record.h b/reftable/record.h
index 498e8c50bf..316cde9182 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -66,6 +66,12 @@ struct reftable_record {
 	struct reftable_record_vtable *ops;
 };
 
+extern struct reftable_record_vtable reftable_obj_record_vtable;
+#define REFTABLE_RECORD_OBJ(obj_record) { \
+	.data = obj_record, \
+	.ops = &reftable_obj_record_vtable \
+}
+
 /* returns true for recognized block types. Block start with the block type. */
 int reftable_is_block_type(uint8_t typ);
 
@@ -119,8 +125,6 @@ void reftable_record_destroy(struct reftable_record *rec);
 
 /* initialize generic records from concrete records. The generic record should
  * be zeroed out. */
-void reftable_record_from_obj(struct reftable_record *rec,
-			      struct reftable_obj_record *objrec);
 void reftable_record_from_index(struct reftable_record *rec,
 				struct reftable_index_record *idxrec);
 void reftable_record_from_ref(struct reftable_record *rec,

but there may be other cases which really want the more dynamic
initialization. And also, the virtual release function would need to
handle the NULL data as well.

I similarly wondered if these polymorphic types could be using a union
within reftable_record, rather than pointing to a separate stack
variable. Then you could initialize the whole thing without worrying
about intermediate NULLs (and also there's less pointer chasing and it's
a little bit more type safe than a void pointer). But again, I don't
know the code well enough to know if that would cover all of your cases.

The summary of issues is below. You can get more details on their site.
I _think_ I've configured it so that anybody can look at:

  https://scan.coverity.com/projects/peff-git/view_defects

but you'll probably need to make a log in (or connect with a GitHub
account). I usually find the summary enough to find issues, but
sometimes it's useful to look at the site because it outlines the full
path of assumptions (not just "here we dereference NULL", but the
sequence of code that goes from knowing that a variable is NULL to the
point of dereferencing it).

I'm happy to help dig into any of them more, or even work on patches.
But per the above diff, I wasn't sure how far to go. :)

-Peff

-- >8 --
** CID 1467043:  Resource leaks  (RESOURCE_LEAK)
/reftable/block.c: 220 in block_reader_init()


________________________________________________________________________________________________________
*** CID 1467043:  Resource leaks  (RESOURCE_LEAK)
/reftable/block.c: 220 in block_reader_init()
214     				block->data + block_header_skip, &src_len)) {
215     			reftable_free(uncompressed);
216     			return REFTABLE_ZLIB_ERROR;
217     		}
218     
219     		if (dst_len + block_header_skip != sz)
>>>     CID 1467043:  Resource leaks  (RESOURCE_LEAK)
>>>     Variable "uncompressed" going out of scope leaks the storage it points to.
220     			return REFTABLE_FORMAT_ERROR;
221     
222     		/* We're done with the input data. */
223     		reftable_block_done(block);
224     		block->data = uncompressed;
225     		block->len = sz;

** CID 1467042:  Null pointer dereferences  (FORWARD_NULL)


________________________________________________________________________________________________________
*** CID 1467042:  Null pointer dereferences  (FORWARD_NULL)
/reftable/reader.c: 692 in reftable_reader_refs_for_indexed()
686     		goto done;
687     	got.offsets = NULL;
688     	iterator_from_indexed_table_ref_iter(it, itr);
689     
690     done:
691     	reftable_iterator_destroy(&oit);
>>>     CID 1467042:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "&got_rec" to "reftable_record_release", which dereferences null "got_rec.ops".
692     	reftable_record_release(&got_rec);
693     	return err;
694     }
695     
696     static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
697     					      struct reftable_iterator *it,

** CID 1467041:  Resource leaks  (RESOURCE_LEAK)
/reftable/blocksource.c: 138 in reftable_block_source_from_file()


________________________________________________________________________________________________________
*** CID 1467041:  Resource leaks  (RESOURCE_LEAK)
/reftable/blocksource.c: 138 in reftable_block_source_from_file()
132     		}
133     		return -1;
134     	}
135     
136     	err = fstat(fd, &st);
137     	if (err < 0)
>>>     CID 1467041:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "fd" going out of scope leaks the handle.
138     		return -1;
139     
140     	p = reftable_calloc(sizeof(struct file_block_source));
141     	p->size = st.st_size;
142     	p->fd = fd;
143     

** CID 1467040:  Null pointer dereferences  (FORWARD_NULL)


________________________________________________________________________________________________________
*** CID 1467040:  Null pointer dereferences  (FORWARD_NULL)
/reftable/record_test.c: 159 in test_reftable_ref_record_roundtrip()
153     
154     		reftable_record_from_ref(&rec_out, &out);
155     		m = reftable_record_decode(&rec_out, key, i, dest,
156     					   GIT_SHA1_RAWSZ);
157     		EXPECT(n == m);
158     
>>>     CID 1467040:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "&out" to "reftable_ref_record_equal", which dereferences null "out.refname".
159     		EXPECT(reftable_ref_record_equal(&in, &out, GIT_SHA1_RAWSZ));
160     		reftable_record_release(&rec_out);
161     
162     		strbuf_release(&key);
163     		reftable_ref_record_release(&in);
164     	}

** CID 1467039:    (TAINTED_SCALAR)
/reftable/block.c: 212 in block_reader_init()


________________________________________________________________________________________________________
*** CID 1467039:    (TAINTED_SCALAR)
/reftable/block.c: 212 in block_reader_init()
206     		uint8_t *uncompressed = reftable_malloc(sz);
207     
208     		/* Copy over the block header verbatim. It's not compressed. */
209     		memcpy(uncompressed, block->data, block_header_skip);
210     
211     		/* Uncompress */
>>>     CID 1467039:    (TAINTED_SCALAR)
>>>     Passing tainted expression "dst_len" to "uncompress2", which uses it as an offset.
212     		if (Z_OK !=
213     		    uncompress2(uncompressed + block_header_skip, &dst_len,
214     				block->data + block_header_skip, &src_len)) {
215     			reftable_free(uncompressed);
216     			return REFTABLE_ZLIB_ERROR;
217     		}
/reftable/block.c: 206 in block_reader_init()
200     		int block_header_skip = 4 + header_off;
201     		uLongf dst_len = sz - block_header_skip; /* total size of dest
202     							    buffer. */
203     		uLongf src_len = block->len - block_header_skip;
204     		/* Log blocks specify the *uncompressed* size in their header.
205     		 */
>>>     CID 1467039:    (TAINTED_SCALAR)
>>>     Passing tainted expression "sz" to "reftable_malloc", which uses it as an allocation size.
206     		uint8_t *uncompressed = reftable_malloc(sz);
207     
208     		/* Copy over the block header verbatim. It's not compressed. */
209     		memcpy(uncompressed, block->data, block_header_skip);
210     
211     		/* Uncompress */

** CID 1467038:    (DC.WEAK_CRYPTO)
/reftable/readwrite_test.c: 145 in test_log_buffer_size()
/reftable/readwrite_test.c: 144 in test_log_buffer_size()


________________________________________________________________________________________________________
*** CID 1467038:    (DC.WEAK_CRYPTO)
/reftable/readwrite_test.c: 145 in test_log_buffer_size()
139     	/* This tests buffer extension for log compression. Must use a random
140     	   hash, to ensure that the compressed part is larger than the original.
141     	*/
142     	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
143     	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
144     		hash1[i] = (uint8_t)(rand() % 256);
>>>     CID 1467038:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, because linear congruential algorithms are too easy to break.
145     		hash2[i] = (uint8_t)(rand() % 256);
146     	}
147     	log.value.update.old_hash = hash1;
148     	log.value.update.new_hash = hash2;
149     	reftable_writer_set_limits(w, update_index, update_index);
150     	err = reftable_writer_add_log(w, &log);
/reftable/readwrite_test.c: 144 in test_log_buffer_size()
138     
139     	/* This tests buffer extension for log compression. Must use a random
140     	   hash, to ensure that the compressed part is larger than the original.
141     	*/
142     	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
143     	for (i = 0; i < GIT_SHA1_RAWSZ; i++) {
>>>     CID 1467038:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, because linear congruential algorithms are too easy to break.
144     		hash1[i] = (uint8_t)(rand() % 256);
145     		hash2[i] = (uint8_t)(rand() % 256);
146     	}
147     	log.value.update.old_hash = hash1;
148     	log.value.update.new_hash = hash2;
149     	reftable_writer_set_limits(w, update_index, update_index);

** CID 1467037:  Security best practices violations  (DC.WEAK_CRYPTO)
/reftable/stack.c: 439 in format_name()


________________________________________________________________________________________________________
*** CID 1467037:  Security best practices violations  (DC.WEAK_CRYPTO)
/reftable/stack.c: 439 in format_name()
433     	return 0;
434     }
435     
436     static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
437     {
438     	char buf[100];
>>>     CID 1467037:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, because linear congruential algorithms are too easy to break.
439     	uint32_t rnd = (uint32_t)rand();
440     	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
441     		 min, max, rnd);
442     	strbuf_reset(dest);
443     	strbuf_addstr(dest, buf);
444     }

** CID 1467036:  Code maintainability issues  (UNUSED_VALUE)
/reftable/stack_test.c: 816 in test_reftable_stack_auto_compaction()


________________________________________________________________________________________________________
*** CID 1467036:  Code maintainability issues  (UNUSED_VALUE)
/reftable/stack_test.c: 816 in test_reftable_stack_auto_compaction()
810     		};
811     		snprintf(name, sizeof(name), "branch%04d", i);
812     
813     		err = reftable_stack_add(st, &write_test_ref, &ref);
814     		EXPECT_ERR(err);
815     
>>>     CID 1467036:  Code maintainability issues  (UNUSED_VALUE)
>>>     Assigning value from "reftable_stack_auto_compact(st)" to "err" here, but that stored value is overwritten before it can be used.
816     		err = reftable_stack_auto_compact(st);
817     		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
818     	}
819     
820     	EXPECT(reftable_stack_compaction_stats(st)->entries_written <
821     	       (uint64_t)(N * fastlog2(N)));

** CID 1467035:    (OVERRUN)


________________________________________________________________________________________________________
*** CID 1467035:    (OVERRUN)
/reftable/record.c: 603 in reftable_log_record_print()
597     		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
598     		       log->refname, log->update_index, log->value.update.name,
599     		       log->value.update.email, log->value.update.time,
600     		       log->value.update.tz_offset);
601     		hex_format(hex, log->value.update.old_hash, hash_size(hash_id));
602     		printf("%s => ", hex);
>>>     CID 1467035:    (OVERRUN)
>>>     Overrunning array "hex" of 33 bytes by passing it to a function which accesses it at byte offset 63 using argument "hash_size(hash_id)" (which evaluates to 32).
603     		hex_format(hex, log->value.update.new_hash, hash_size(hash_id));
604     		printf("%s\n\n%s\n}\n", hex, log->value.update.message);
605     		break;
606     	}
607     }
608     
/reftable/record.c: 601 in reftable_log_record_print()
595     		break;
596     	case REFTABLE_LOG_UPDATE:
597     		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
598     		       log->refname, log->update_index, log->value.update.name,
599     		       log->value.update.email, log->value.update.time,
600     		       log->value.update.tz_offset);
>>>     CID 1467035:    (OVERRUN)
>>>     Overrunning array "hex" of 33 bytes by passing it to a function which accesses it at byte offset 63 using argument "hash_size(hash_id)" (which evaluates to 32).
601     		hex_format(hex, log->value.update.old_hash, hash_size(hash_id));
602     		printf("%s => ", hex);
603     		hex_format(hex, log->value.update.new_hash, hash_size(hash_id));
604     		printf("%s\n\n%s\n}\n", hex, log->value.update.message);
605     		break;
606     	}

** CID 1467034:  Error handling issues  (CHECKED_RETURN)
/reftable/stack_test.c: 92 in test_read_file()


________________________________________________________________________________________________________
*** CID 1467034:  Error handling issues  (CHECKED_RETURN)
/reftable/stack_test.c: 92 in test_read_file()
86     	EXPECT_ERR(err);
87     
88     	for (i = 0; names[i]; i++) {
89     		EXPECT(0 == strcmp(want[i], names[i]));
90     	}
91     	free_names(names);
>>>     CID 1467034:  Error handling issues  (CHECKED_RETURN)
>>>     Calling "remove(fn)" without checking return value. This library function may fail and return an error code.
92     	remove(fn);
93     }
94     
95     static void test_parse_names(void)
96     {
97     	char buf[] = "line\n";

** CID 1467033:  Resource leaks  (RESOURCE_LEAK)
/reftable/stack.c: 951 in stack_compact_range()


________________________________________________________________________________________________________
*** CID 1467033:  Resource leaks  (RESOURCE_LEAK)
/reftable/stack.c: 951 in stack_compact_range()
945     		subtable_locks[j] = subtab_lock.buf;
946     		delete_on_success[j] = subtab_file_name.buf;
947     		j++;
948     
949     		if (err != 0)
950     			goto done;
>>>     CID 1467033:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "sublock_file_fd" going out of scope leaks the handle.
951     	}
952     
953     	err = unlink(lock_file_name.buf);
954     	if (err < 0)
955     		goto done;
956     	have_lock = 0;

** CID 1467032:  Null pointer dereferences  (FORWARD_NULL)


________________________________________________________________________________________________________
*** CID 1467032:  Null pointer dereferences  (FORWARD_NULL)
/reftable/reader.c: 504 in reader_seek_indexed()
498     	reftable_record_from_index(&index_result_rec, &index_result);
499     
500     	err = reader_start(r, &index_iter, reftable_record_type(rec), 1);
501     	if (err < 0)
502     		goto done;
503     
>>>     CID 1467032:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "&index_iter" to "reader_seek_linear", which dereferences null "index_iter.r".
504     	err = reader_seek_linear(&index_iter, &want_index_rec);
505     	while (1) {
506     		err = table_iter_next(&index_iter, &index_result_rec);
507     		table_iter_block_done(&index_iter);
508     		if (err != 0)
509     			goto done;

** CID 1467031:  Null pointer dereferences  (FORWARD_NULL)


________________________________________________________________________________________________________
*** CID 1467031:  Null pointer dereferences  (FORWARD_NULL)
/reftable/stack.c: 710 in reftable_addition_add()
704     		unlink(temp_tab_file_name.buf);
705     	}
706     
707     	strbuf_release(&temp_tab_file_name);
708     	strbuf_release(&tab_file_name);
709     	strbuf_release(&next_name);
>>>     CID 1467031:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "wr" to "reftable_writer_free", which dereferences it.
710     	reftable_writer_free(wr);
711     	return err;
712     }
713     
714     uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
715     {

** CID 1467030:  Security best practices violations  (DC.WEAK_CRYPTO)
/reftable/stack.c: 367 in reftable_stack_reload_maybe_reuse()


________________________________________________________________________________________________________
*** CID 1467030:  Security best practices violations  (DC.WEAK_CRYPTO)
/reftable/stack.c: 367 in reftable_stack_reload_maybe_reuse()
361     			free_names(names_after);
362     			return err;
363     		}
364     		free_names(names);
365     		free_names(names_after);
366     
>>>     CID 1467030:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security-related applications, because linear congruential algorithms are too easy to break.
367     		delay = delay + (delay * rand()) / RAND_MAX + 1;
368     		sleep_millisec(delay);
369     	}
370     
371     	return 0;
372     }

** CID 1467029:  Resource leaks  (RESOURCE_LEAK)
/reftable/stack.c: 1065 in stack_compact_range()


________________________________________________________________________________________________________
*** CID 1467029:  Resource leaks  (RESOURCE_LEAK)
/reftable/stack.c: 1065 in stack_compact_range()
1059     	}
1060     	strbuf_release(&new_table_name);
1061     	strbuf_release(&new_table_path);
1062     	strbuf_release(&ref_list_contents);
1063     	strbuf_release(&temp_tab_file_name);
1064     	strbuf_release(&lock_file_name);
>>>     CID 1467029:  Resource leaks  (RESOURCE_LEAK)
>>>     Handle variable "lock_file_fd" going out of scope leaks the handle.
1065     	return err;
1066     }
1067     
1068     int reftable_stack_compact_all(struct reftable_stack *st,
1069     			       struct reftable_log_expiry_config *config)
1070     {

** CID 1467028:  Null pointer dereferences  (FORWARD_NULL)
/reftable/reader.c: 675 in reftable_reader_refs_for_indexed()


________________________________________________________________________________________________________
*** CID 1467028:  Null pointer dereferences  (FORWARD_NULL)
/reftable/reader.c: 675 in reftable_reader_refs_for_indexed()
669     	/* read out the reftable_obj_record */
670     	reftable_record_from_obj(&got_rec, &got);
671     	err = iterator_next(&oit, &got_rec);
672     	if (err < 0)
673     		goto done;
674     
>>>     CID 1467028:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "got.hash_prefix" to "memcmp", which dereferences it.
675     	if (err > 0 ||
676     	    memcmp(want.hash_prefix, got.hash_prefix, r->object_id_len)) {
677     		/* didn't find it; return empty iterator */
678     		iterator_set_empty(it);
679     		err = 0;
680     		goto done;

** CID 1467027:  Security best practices violations  (SECURE_TEMP)
/reftable/stack_test.c: 72 in test_read_file()


________________________________________________________________________________________________________
*** CID 1467027:  Security best practices violations  (SECURE_TEMP)
/reftable/stack_test.c: 72 in test_read_file()
66     	return dir;
67     }
68     
69     static void test_read_file(void)
70     {
71     	char *fn = get_tmp_template(__LINE__);
>>>     CID 1467027:  Security best practices violations  (SECURE_TEMP)
>>>     Calling "mkstemp" without securely setting umask first.
72     	int fd = mkstemp(fn);
73     	char out[1024] = "line1\n\nline2\nline3";
74     	int n, err;
75     	char **names = NULL;
76     	char *want[] = { "line1", "line2", "line3" };
77     	int i = 0;

** CID 1467026:  Null pointer dereferences  (FORWARD_NULL)


________________________________________________________________________________________________________
*** CID 1467026:  Null pointer dereferences  (FORWARD_NULL)
/reftable/reader.c: 683 in reftable_reader_refs_for_indexed()
677     		/* didn't find it; return empty iterator */
678     		iterator_set_empty(it);
679     		err = 0;
680     		goto done;
681     	}
682     
>>>     CID 1467026:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "got.offsets" to "new_indexed_table_ref_iter", which dereferences it.
683     	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
684     					 got.offsets, got.offset_len);
685     	if (err < 0)
686     		goto done;
687     	got.offsets = NULL;
688     	iterator_from_indexed_table_ref_iter(it, itr);

** CID 1467025:  Security best practices violations  (SECURE_TEMP)
/reftable/stack.c: 642 in reftable_addition_add()


________________________________________________________________________________________________________
*** CID 1467025:  Security best practices violations  (SECURE_TEMP)
/reftable/stack.c: 642 in reftable_addition_add()
636     	strbuf_reset(&next_name);
637     	format_name(&next_name, add->next_update_index, add->next_update_index);
638     
639     	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
640     	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
641     
>>>     CID 1467025:  Security best practices violations  (SECURE_TEMP)
>>>     Calling "mkstemp" without securely setting umask first.
642     	tab_fd = mkstemp(temp_tab_file_name.buf);
643     	if (tab_fd < 0) {
644     		err = REFTABLE_IO_ERROR;
645     		goto done;
646     	}
647     

** CID 1467024:  Null pointer dereferences  (FORWARD_NULL)


________________________________________________________________________________________________________
*** CID 1467024:  Null pointer dereferences  (FORWARD_NULL)
/reftable/reader.c: 799 in reftable_reader_print_file()
793     	if (err < 0)
794     		goto done;
795     
796     	reftable_table_from_reader(&tab, r);
797     	err = reftable_table_print(&tab);
798     done:
>>>     CID 1467024:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "r" to "reftable_reader_free", which dereferences it.
799     	reftable_reader_free(r);
800     	return err;

