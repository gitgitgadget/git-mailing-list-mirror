Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A31C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 03:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238659AbhKVDiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 22:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbhKVDiU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 22:38:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD103C061574
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:14 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r130so14868666pfc.1
        for <git@vger.kernel.org>; Sun, 21 Nov 2021 19:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ls85hCj+fY4bcXxSDkhL1AxMDQJl+aPlJ2VeZyfEK5k=;
        b=MPTx1MloijL37g70qGswxmTV/IQnUgyIs+nbexLD/J0NTSfijDP1BlFUkyRXaIgVRM
         ns10Lqsbo6ekzQi48OPzDPVnqOFKH94PkZSRtOFSiRhSoZs5q4mEnOgmk8+1oJhMDAGC
         HhxFaKb8dLy6LqEXLMbGV4cDzhzmUdb0hH79co2gh2h+9Z7K9BhaKQbh6dzrMk7/8qit
         QIxuUk4ckABpQJqwnw0NABOryH4bzP0Nrf7xpYFhBOssU7ju3sPk3TGqcLCAWHRjDe51
         X0dFQhrKKtQoOzOzitf7VTUd3LIFyzw2jO+YKOgKjF+b7Fywqjd9Hgw8WEMoivYLSxWz
         Ep/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ls85hCj+fY4bcXxSDkhL1AxMDQJl+aPlJ2VeZyfEK5k=;
        b=ttILtaHj+T7j+/wxhzgf3t+ena8lHCLwb2cm+KEySK5TiCj4AFgTyYmSOdneF8F1rt
         wAoQzDKx/2IFJ/RTaJTP8FzXSPJdUU2T0tTgONbMX/xWfiVGB7XuVKSYSApTFXki1a8+
         hke09FiOE9GgSPUO9L/FOP1Syf9NhiUNEdsN5BorC9NjPBt2WboGuOWmmkTKgXnoz4YE
         Gak4AbtWqwcxmviQOgQ/1FKlZApiDv3qy/yJF8NbQgwW6EoaMyPM8xGlb/EV57XHrJj6
         s8JSbjkxq608icjIR5nCKyBrbVqN8m8NHn6hnnMRXuApxslP9dyvgOoU7XJGkFDg83Os
         vJLA==
X-Gm-Message-State: AOAM530aXJ4hESeKjhdigngEPeE5AZSnD6oYGTC5RoK4ymsEIsG5UuiR
        NKw8LD8v1PNqKq1xdeOXhntxgfsFHMqg5EeP
X-Google-Smtp-Source: ABdhPJyHs1ycIJSWpQ8RMPOw/1vSAKO6qj/JMdgvjyc5hoCqCxroCzNR6Yw0c1WEXXGK7P0sHjYYeA==
X-Received: by 2002:a63:e042:: with SMTP id n2mr31351482pgj.215.1637552114015;
        Sun, 21 Nov 2021 19:35:14 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.99])
        by smtp.gmail.com with ESMTPSA id q11sm1235714pgt.54.2021.11.21.19.35.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Nov 2021 19:35:13 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v3 0/5] unpack large objects in stream
Date:   Mon, 22 Nov 2021 11:32:15 +0800
Message-Id: <20211122033220.32883-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0.6.g676eedc724
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

Although we do not recommend users push large binary files to the git repositories, 
it's difficult to prevent them from doing so. Once, we found a problem with a surge 
in memory usage on the server. The source of the problem is that a user submitted 
a single object with a size of 15GB. Once someone initiates a git push, the git 
process will immediately allocate 15G of memory, resulting in an OOM risk.

Through further analysis, we found that when we execute git unpack-objects, in 
unpack_non_delta_entry(), "void *buf = get_data(size);" will directly allocate 
memory equal to the size of the object. This is quite a scary thing, because the 
pre-receive hook has not been executed at this time, and we cannot avoid this by hooks.

I got inspiration from the deflate process of zlib, maybe it would be a good idea 
to change unpack-objects to stream deflate.

Changes since v2:
* Rewrite commit messages and make changes suggested by Jiang Xin.
* Remove the commit "object-file.c: add dry_run mode for write_loose_object()" and
  use a new commit "unpack-objects.c: add dry_run mode for get_data()" instead.

Han Xin (5):
  object-file: refactor write_loose_object() to read buffer from stream
  object-file.c: handle undetermined oid in write_loose_object()
  object-file.c: read stream in a loop in write_loose_object()
  unpack-objects.c: add dry_run mode for get_data()
  unpack-objects: unpack_non_delta_entry() read data in a stream

 builtin/unpack-objects.c            | 92 +++++++++++++++++++++++++--
 object-file.c                       | 98 +++++++++++++++++++++++++----
 object-store.h                      |  9 +++
 t/t5590-unpack-non-delta-objects.sh | 76 ++++++++++++++++++++++
 4 files changed, 257 insertions(+), 18 deletions(-)
 create mode 100755 t/t5590-unpack-non-delta-objects.sh

Range-diff against v2:
1:  01672f50a0 ! 1:  8640b04f6d object-file: refactor write_loose_object() to support inputstream
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## Commit message ##
    -    object-file: refactor write_loose_object() to support inputstream
    +    object-file: refactor write_loose_object() to read buffer from stream
     
    -    Refactor write_loose_object() to support inputstream, in the same way
    -    that zlib reading is chunked.
    +    We used to call "get_data()" in "unpack_non_delta_entry()" to read the
    +    entire contents of a blob object, no matter how big it is. This
    +    implementation may consume all the memory and cause OOM.
     
    -    Using "in_stream" instead of "void *buf", we needn't to allocate enough
    -    memory in advance, and only part of the contents will be read when
    -    called "in_stream.read()".
    +    This can be improved by feeding data to "write_loose_object()" in a
    +    stream. The input stream is implemented as an interface. In the first
    +    step, we make a simple implementation, feeding the entire buffer in the
    +    "stream" to "write_loose_object()" as a refactor.
     
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filenam
      	return fd;
      }
      
    -+struct input_data_from_buffer {
    -+	const char *buf;
    ++struct simple_input_stream_data {
    ++	const void *buf;
     +	unsigned long len;
     +};
     +
    -+static const char *read_input_stream_from_buffer(void *data, unsigned long *len)
    ++static const void *feed_simple_input_stream(struct input_stream *in_stream, unsigned long *len)
     +{
    -+	struct input_data_from_buffer *input = (struct input_data_from_buffer *)data;
    ++	struct simple_input_stream_data *data = in_stream->data;
     +
    -+	if (input->len == 0) {
    ++	if (data->len == 0) {
     +		*len = 0;
     +		return NULL;
     +	}
    -+	*len = input->len;
    -+	input->len = 0;
    -+	return input->buf;
    ++	*len = data->len;
    ++	data->len = 0;
    ++	return data->buf;
     +}
     +
      static int write_loose_object(const struct object_id *oid, char *hdr,
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      	struct object_id parano_oid;
      	static struct strbuf tmp_file = STRBUF_INIT;
      	static struct strbuf filename = STRBUF_INIT;
    -+	const char *buf;
    ++	const void *buf;
     +	unsigned long len;
      
      	loose_object_path(the_repository, &filename, oid);
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      	the_hash_algo->update_fn(&c, hdr, hdrlen);
      
      	/* Then the data itself.. */
    -+	buf = in_stream->read(in_stream->data, &len);
    ++	buf = in_stream->read(in_stream, &len);
      	stream.next_in = (void *)buf;
      	stream.avail_in = len;
      	do {
    @@ object-file.c: int write_object_file_flags(const void *buf, unsigned long len,
      	char hdr[MAX_HEADER_LEN];
      	int hdrlen = sizeof(hdr);
     +	struct input_stream in_stream = {
    -+		.read = read_input_stream_from_buffer,
    -+		.data = (void *)&(struct input_data_from_buffer) {
    ++		.read = feed_simple_input_stream,
    ++		.data = (void *)&(struct simple_input_stream_data) {
     +			.buf = buf,
     +			.len = len,
     +		},
    @@ object-file.c: int hash_object_file_literally(const void *buf, unsigned long len
      	char *header;
      	int hdrlen, status = 0;
     +	struct input_stream in_stream = {
    -+		.read = read_input_stream_from_buffer,
    -+		.data = (void *)&(struct input_data_from_buffer) {
    ++		.read = feed_simple_input_stream,
    ++		.data = (void *)&(struct simple_input_stream_data) {
     +			.buf = buf,
     +			.len = len,
     +		},
    @@ object-file.c: int force_object_loose(const struct object_id *oid, time_t mtime)
      	char hdr[MAX_HEADER_LEN];
      	int hdrlen;
      	int ret;
    -+	struct input_data_from_buffer data;
    ++	struct simple_input_stream_data data;
     +	struct input_stream in_stream = {
    -+		.read = read_input_stream_from_buffer,
    ++		.read = feed_simple_input_stream,
     +		.data = &data,
     +	};
      
    @@ object-store.h: struct object_directory {
      };
      
     +struct input_stream {
    -+	const char *(*read)(void* data, unsigned long *len);
    ++	const void *(*read)(struct input_stream *, unsigned long *len);
     +	void *data;
     +};
     +
2:  a309b7e391 < -:  ---------- object-file.c: add dry_run mode for write_loose_object()
3:  b0a5b53710 ! 2:  d4a2caf2bd object-file.c: handle nil oid in write_loose_object()
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## Commit message ##
    -    object-file.c: handle nil oid in write_loose_object()
    +    object-file.c: handle undetermined oid in write_loose_object()
     
    -    When read input stream, oid can't get before reading all, and it will be
    -    filled after reading.
    +    When streaming a large blob object to "write_loose_object()", we have no
    +    chance to run "write_object_file_prepare()" to calculate the oid in
    +    advance. So we need to handle undetermined oid in function
    +    "write_loose_object()".
    +
    +    In the original implementation, we know the oid and we can write the
    +    temporary file in the same directory as the final object, but for an
    +    object with an undetermined oid, we don't know the exact directory for
    +    the object, so we have to save the temporary file in ".git/objects/"
    +    directory instead.
     
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## object-file.c ##
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
    - 	const char *buf;
    + 	const void *buf;
      	unsigned long len;
      
     -	loose_object_path(the_repository, &filename, oid);
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     +		strbuf_reset(&filename);
     +		strbuf_addstr(&filename, the_repository->objects->odb->path);
     +		strbuf_addch(&filename, '/');
    -+	} else
    ++	} else {
     +		loose_object_path(the_repository, &filename, oid);
    ++	}
      
    - 	if (!dry_run) {
    - 		fd = create_tmpfile(&tmp_file, filename.buf);
    + 	fd = create_tmpfile(&tmp_file, filename.buf);
    + 	if (fd < 0) {
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
      		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
      		    ret);
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      		die(_("confused by unstable object source data for %s"),
      		    oid_to_hex(oid));
      
    -@@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
    - 
      	close_loose_object(fd);
      
     +	if (is_null_oid(oid)) {
     +		int dirlen;
     +
    -+		/* copy oid */
     +		oidcpy((struct object_id *)oid, &parano_oid);
    -+		/* We get the oid now */
     +		loose_object_path(the_repository, &filename, oid);
     +
    ++		/* We finally know the object path, and create the missing dir. */
     +		dirlen = directory_size(filename.buf);
     +		if (dirlen) {
     +			struct strbuf dir = STRBUF_INIT;
    -+			/*
    -+			 * Make sure the directory exists; note that the
    -+			 * contents of the buffer are undefined after mkstemp
    -+			 * returns an error, so we have to rewrite the whole
    -+			 * buffer from scratch.
    -+			 */
    -+			strbuf_reset(&dir);
     +			strbuf_add(&dir, filename.buf, dirlen - 1);
     +			if (mkdir(dir.buf, 0777) && errno != EEXIST)
     +				return -1;
    ++			if (adjust_shared_perm(dir.buf))
    ++				return -1;
    ++			strbuf_release(&dir);
     +		}
     +	}
     +
4:  09d438b692 ! 3:  2575900449 object-file.c: read input stream repeatedly in write_loose_object()
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## Commit message ##
    -    object-file.c: read input stream repeatedly in write_loose_object()
    +    object-file.c: read stream in a loop in write_loose_object()
     
    -    Read input stream repeatedly in write_loose_object() unless reach the
    -    end, so that we can divide the large blob write into many small blocks.
    +    In order to prepare the stream version of "write_loose_object()", read
    +    the input stream in a loop in "write_loose_object()", so that we can
    +    feed the contents of large blob object to "write_loose_object()" using
    +    a small fixed buffer.
     
    +    Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## object-file.c ##
     @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *hdr,
      	static struct strbuf tmp_file = STRBUF_INIT;
      	static struct strbuf filename = STRBUF_INIT;
    - 	const char *buf;
    + 	const void *buf;
     -	unsigned long len;
     +	int flush = 0;
      
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
      	the_hash_algo->update_fn(&c, hdr, hdrlen);
      
      	/* Then the data itself.. */
    --	buf = in_stream->read(in_stream->data, &len);
    +-	buf = in_stream->read(in_stream, &len);
     -	stream.next_in = (void *)buf;
     -	stream.avail_in = len;
      	do {
      		unsigned char *in0 = stream.next_in;
     -		ret = git_deflate(&stream, Z_FINISH);
     +		if (!stream.avail_in) {
    -+			if ((buf = in_stream->read(in_stream->data, &stream.avail_in))) {
    ++			buf = in_stream->read(in_stream, &stream.avail_in);
    ++			if (buf) {
     +				stream.next_in = (void *)buf;
     +				in0 = (unsigned char *)buf;
    -+			} else
    ++			} else {
     +				flush = Z_FINISH;
    ++			}
     +		}
     +		ret = git_deflate(&stream, flush);
      		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
    - 		if (!dry_run && write_buffer(fd, compressed, stream.next_out - compressed) < 0)
    + 		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
      			die(_("unable to write loose object file"));
5:  9fb188d437 < -:  ---------- object-store.h: add write_loose_object()
-:  ---------- > 4:  ca93ecc780 unpack-objects.c: add dry_run mode for get_data()
6:  80468a6fbc ! 5:  39a072ee2a unpack-objects: unpack large object in stream
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## Commit message ##
    -    unpack-objects: unpack large object in stream
    +    unpack-objects: unpack_non_delta_entry() read data in a stream
     
    -    When calling "unpack_non_delta_entry()", will allocate full memory for
    -    the whole size of the unpacked object and write the buffer to loose file
    -    on disk. This may lead to OOM for the git-unpack-objects process when
    -    unpacking a very large object.
    +    We used to call "get_data()" in "unpack_non_delta_entry()" to read the
    +    entire contents of a blob object, no matter how big it is. This
    +    implementation may consume all the memory and cause OOM.
     
    -    In function "unpack_delta_entry()", will also allocate full memory to
    -    buffer the whole delta, but since there will be no delta for an object
    -    larger than "core.bigFileThreshold", this issue is moderate.
    +    By implementing a zstream version of input_stream interface, we can use
    +    a small fixed buffer for "unpack_non_delta_entry()".
     
    -    To resolve the OOM issue in "git-unpack-objects", we can unpack large
    -    object to file in stream, and use "core.bigFileThreshold" to avoid OOM
    -    limits when called "get_data()".
    +    However, unpack non-delta objects from a stream instead of from an entrie
    +    buffer will have 10% performance penalty. Therefore, only unpack object
    +    larger than the "big_file_threshold" in zstream. See the following
    +    benchmarks:
     
    +        $ hyperfine \
    +        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    +        'git -C dest.git unpack-objects <binary_320M.pack'
    +        Benchmark 1: git -C dest.git unpack-objects <binary_320M.pack
    +          Time (mean ± σ):     10.029 s ±  0.270 s    [User: 8.265 s, System: 1.522 s]
    +          Range (min … max):    9.786 s … 10.603 s    10 runs
    +
    +        $ hyperfine \
    +        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    +        'git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack'
    +        Benchmark 1: git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_320M.pack
    +          Time (mean ± σ):     10.859 s ±  0.774 s    [User: 8.813 s, System: 1.898 s]
    +          Range (min … max):    9.884 s … 12.192 s    10 runs
    +
    +        $ hyperfine \
    +        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    +        'git -C dest.git unpack-objects <binary_96M.pack'
    +        Benchmark 1: git -C dest.git unpack-objects <binary_96M.pack
    +          Time (mean ± σ):      2.678 s ±  0.037 s    [User: 2.205 s, System: 0.450 s]
    +          Range (min … max):    2.639 s …  2.743 s    10 runs
    +
    +        $ hyperfine \
    +        --prepare 'rm -rf dest.git && git init --bare dest.git' \
    +        'git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_96M.pack'
    +        Benchmark 1: git -c core.bigFileThreshold=2m -C dest.git unpack-objects <binary_96M.pack
    +          Time (mean ± σ):      2.819 s ±  0.124 s    [User: 2.216 s, System: 0.564 s]
    +          Range (min … max):    2.679 s …  3.125 s    10 runs
    +
    +    Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## builtin/unpack-objects.c ##
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
      	}
      }
      
    -+struct input_data_from_zstream {
    ++struct input_zstream_data {
     +	git_zstream *zstream;
     +	unsigned char buf[4096];
     +	int status;
     +};
     +
    -+static const char *read_inflate_in_stream(void *data, unsigned long *readlen)
    ++static const void *feed_input_zstream(struct input_stream *in_stream, unsigned long *readlen)
     +{
    -+	struct input_data_from_zstream *input = data;
    -+	git_zstream *zstream = input->zstream;
    ++	struct input_zstream_data *data = in_stream->data;
    ++	git_zstream *zstream = data->zstream;
     +	void *in = fill(1);
     +
    -+	if (!len || input->status == Z_STREAM_END) {
    ++	if (!len || data->status == Z_STREAM_END) {
     +		*readlen = 0;
     +		return NULL;
     +	}
     +
    -+	zstream->next_out = input->buf;
    -+	zstream->avail_out = sizeof(input->buf);
    ++	zstream->next_out = data->buf;
    ++	zstream->avail_out = sizeof(data->buf);
     +	zstream->next_in = in;
     +	zstream->avail_in = len;
     +
    -+	input->status = git_inflate(zstream, 0);
    ++	data->status = git_inflate(zstream, 0);
     +	use(len - zstream->avail_in);
    -+	*readlen = sizeof(input->buf) - zstream->avail_out;
    ++	*readlen = sizeof(data->buf) - zstream->avail_out;
     +
    -+	return (const char *)input->buf;
    ++	return data->buf;
     +}
     +
     +static void write_stream_blob(unsigned nr, unsigned long size)
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	char hdr[32];
     +	int hdrlen;
     +	git_zstream zstream;
    -+	struct input_data_from_zstream data;
    ++	struct input_zstream_data data;
     +	struct input_stream in_stream = {
    -+		.read = read_inflate_in_stream,
    ++		.read = feed_input_zstream,
     +		.data = &data,
     +	};
     +	struct object_id *oid = &obj_list[nr].oid;
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
     +	/* Generate the header */
     +	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), (uintmax_t)size) + 1;
     +
    -+	if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, dry_run, 0, 0)))
    ++	if ((ret = write_loose_object(oid, hdr, hdrlen, &in_stream, 0, 0)))
     +		die(_("failed to write object in stream %d"), ret);
     +
     +	if (zstream.total_out != size || data.status != Z_STREAM_END)
    @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type
      static void unpack_non_delta_entry(enum object_type type, unsigned long size,
      				   unsigned nr)
      {
    --	void *buf = get_data(size);
    +-	void *buf = get_data(size, dry_run);
     +	void *buf;
     +
     +	/* Write large blob in stream without allocating full buffer. */
    -+	if (type == OBJ_BLOB && size > big_file_threshold) {
    ++	if (!dry_run && type == OBJ_BLOB && size > big_file_threshold) {
     +		write_stream_blob(nr, size);
     +		return;
     +	}
      
    -+	buf = get_data(size);
    ++	buf = get_data(size, dry_run);
      	if (!dry_run && buf)
      		write_object(nr, type, buf, size);
      	else
     
    - ## t/t5590-receive-unpack-objects.sh (new) ##
    + ## object-file.c ##
    +@@ object-file.c: static const void *feed_simple_input_stream(struct input_stream *in_stream, unsi
    + 	return data->buf;
    + }
    + 
    +-static int write_loose_object(const struct object_id *oid, char *hdr,
    +-			      int hdrlen, struct input_stream *in_stream,
    +-			      time_t mtime, unsigned flags)
    ++int write_loose_object(const struct object_id *oid, char *hdr,
    ++		       int hdrlen, struct input_stream *in_stream,
    ++		       time_t mtime, unsigned flags)
    + {
    + 	int fd, ret;
    + 	unsigned char compressed[4096];
    +
    + ## object-store.h ##
    +@@ object-store.h: int hash_object_file(const struct git_hash_algo *algo, const void *buf,
    + 		     unsigned long len, const char *type,
    + 		     struct object_id *oid);
    + 
    ++int write_loose_object(const struct object_id *oid, char *hdr,
    ++		       int hdrlen, struct input_stream *in_stream,
    ++		       time_t mtime, unsigned flags);
    ++
    + int write_object_file_flags(const void *buf, unsigned long len,
    + 			    const char *type, struct object_id *oid,
    + 			    unsigned flags);
    +
    + ## t/t5590-unpack-non-delta-objects.sh (new) ##
     @@
     +#!/bin/sh
     +#
    @@ t/t5590-receive-unpack-objects.sh (new)
     +		cd .git &&
     +		find objects/?? -type f | sort
     +	) >expect &&
    -+	git repack -ad
    ++	PACK=$(echo main | git pack-objects --progress --revs test)
     +'
     +
     +test_expect_success 'setup GIT_ALLOC_LIMIT to 1MB' '
    @@ t/t5590-receive-unpack-objects.sh (new)
     +	git -C dest.git config receive.unpacklimit 100
     +'
     +
    -+test_expect_success 'fail to push: cannot allocate' '
    -+	test_must_fail git push dest.git HEAD 2>err &&
    -+	test_i18ngrep "remote: fatal: attempting to allocate" err &&
    ++test_expect_success 'fail to unpack-objects: cannot allocate' '
    ++	test_must_fail git -C dest.git unpack-objects <test-$PACK.pack 2>err &&
    ++	test_i18ngrep "fatal: attempting to allocate" err &&
     +	(
     +		cd dest.git &&
     +		find objects/?? -type f | sort
    @@ t/t5590-receive-unpack-objects.sh (new)
     +'
     +
     +test_expect_success 'unpack big object in stream' '
    -+	git push dest.git HEAD &&
    ++	git -C dest.git unpack-objects <test-$PACK.pack &&
     +	git -C dest.git fsck &&
     +	(
     +		cd dest.git &&
    @@ t/t5590-receive-unpack-objects.sh (new)
     +'
     +
     +test_expect_success 'setup for unpack-objects dry-run test' '
    -+	PACK=$(echo main | git pack-objects --progress --revs test) &&
    -+	unset GIT_ALLOC_LIMIT &&
     +	git init --bare unpack-test.git
     +'
     +
    -+test_expect_success 'unpack-objects dry-run with large threshold' '
    -+	(
    -+		cd unpack-test.git &&
    -+		git config core.bigFileThreshold 2m &&
    -+		git unpack-objects -n <../test-$PACK.pack
    -+	) &&
    -+	(
    -+		cd unpack-test.git &&
    -+		find objects/ -type f
    -+	) >actual &&
    -+	test_must_be_empty actual
    -+'
    -+
    -+test_expect_success 'unpack-objects dry-run with small threshold' '
    ++test_expect_success 'unpack-objects dry-run' '
     +	(
     +		cd unpack-test.git &&
    -+		git config core.bigFileThreshold 1m &&
     +		git unpack-objects -n <../test-$PACK.pack
     +	) &&
     +	(
-- 
2.34.0.6.g676eedc724

