Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E855C32
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075250; cv=none; b=bj7LV45N3EBHz6QstslJg9i8KTADo5gxLBcAqYGJ8wzEtVqjDSMzn7pOu9YMs1X4hN3sXppI24n1WXwC3b+GZ020n4uqxGJvIBqqm7/EwEas1Cbnnbs3de7PlCkMyHsE4+v1G6pinGWKxwx25H1GUVWXAjdP9DfisxRm/vrXYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075250; c=relaxed/simple;
	bh=qpGg9BNkm6fqQzYf6b42I+1HLVPdN8GgSm98iKsGgM8=;
	h=From:To:Subject:cc:Date:Message-ID:MIME-Version:Content-Type; b=EZXZ/JUvc2/tJ7Xz+SQf6i+2+TprO1l78xVPgnhPDavoWtjAnJtS6QRwZu/3gWdHkhyPb4GCfuye6y3Gv6C3HoElGorjNY+fwUqGkAv9exyCB/QXoxnc2Nqqz2tfCGVRYuUCfWv6aNeJ0/OY6zZEwVOe0vERSM4yg7LGaZecha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LpPNRa74; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LpPNRa74"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CFC1E266AE;
	Tue, 27 Feb 2024 18:07:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=qpGg9BNkm6fqQzYf6b42I+1HLVPdN8GgSm98iKsGgM8=; b=LpPNRa746lVI
	z5dnJYWVZDMT4qNYqlveO50T3XKiOE8mURWMFUnPk/QECM/Gf28ch/0RywNPgUj4
	VSoVqeAtgd/J0hjLyqzw4XVyXYeb4nZ8C8NKFrqMxB1h2Bw0zpWW7PkDvjdeyg8n
	rCTj0UtaixCKcCNVjz+JnHn2N2Gt26o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C699E266AD;
	Tue, 27 Feb 2024 18:07:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EA016266A9;
	Tue, 27 Feb 2024 18:07:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Uses of xwrite() in the codebase
cc: "Randall S. Becker" <randall.becker@nexbridge.ca>
Date: Tue, 27 Feb 2024 15:07:19 -0800
Message-ID: <xmqqil29o6ag.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5D4FBB8-D5C4-11EE-9A29-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

There aren't too many places that we make calls to xwrite(), so
let's audit all.

I'll show something that looks like patch, but I won't be applying
any of them myself, at least not as a part of this message.

First, some ground rules:

 * Calling xwrite() relieves us from worrying about interrupted
   system call returning with EINTR or EAGAIN without writing
   anything.  If we were using write(2), we need to be calling it
   again with the same arguments, but xwrite() retries that call for
   us.  That is the _only_ thing it does.

 * Specifically, when write(2) returns after writing less than what
   it was asked to (called "short write"), xwrite() returns the
   number of bytes written, just like the underlying write(2) does,
   and it is not an error.

 * Errors xwrite() internally handles are only the ones that are
   related to an interrupted system call that needs retrying.  Other
   errors are responsibility of the caller to handle.  If a platform
   raises an error when passed a very large buffer to write out,
   instead of just making a short write and returning the number of
   writes written, the platform port should protect itself from such
   an error by limiting MAX_IO_SIZE, so that xwrite() does not even
   attempt to make such a large write(2) call.

Now, I'll go through "git grep -W -e 'xwrite('" output and annotate
it.

--------------------
builtin/index-pack.c:final() is prepared to see and handle a short
write(2) itself.  It is a correct implementation that does not need
to be touched, but we could replace the loop with a single call to
write_in_full().

diff --git c/builtin/index-pack.c w/builtin/index-pack.c
index a3a37bd215..a54cb07a35 100644
--- c/builtin/index-pack.c
+++ w/builtin/index-pack.c
@@ -1570,13 +1570,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		 * Let's just mimic git-unpack-objects here and write
 		 * the last part of the input buffer to stdout.
 		 */
-		while (input_len) {
-			err = xwrite(1, input_buffer + input_offset, input_len);
-			if (err <= 0)
-				break;
-			input_len -= err;
-			input_offset += err;
-		}
+		write_in_full(1, input_buffer + input_offset, input_len);
 	}
 
 	strbuf_release(&rev_index_name);


--------------------
builtin/receive-pack.c:report_message() has a call to xwrite() that
will lead to message truncation if the underlying write(2) returns
early.

diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index 56d8a77ed7..4d8ed3f7a3 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -456,7 +456,7 @@ static void report_message(const char *prefix, const char *err, va_list params)
 	if (use_sideband)
 		send_sideband(1, 2, msg, sz, use_sideband);
 	else
-		xwrite(2, msg, sz);
+		write_in_full(2, msg, sz);
 }
 
 __attribute__((format (printf, 1, 2)))



--------------------
builtin/repack.c:write_oid() feeds a line with an object name on it
to a subprocess, but it can suffer from a short write(2).

diff --git c/builtin/repack.c w/builtin/repack.c
index ede36328a3..1a516a6bed 100644
--- c/builtin/repack.c
+++ w/builtin/repack.c
@@ -314,8 +314,10 @@ static int write_oid(const struct object_id *oid,
 			die(_("could not start pack-objects to repack promisor objects"));
 	}
 
-	xwrite(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz);
-	xwrite(cmd->in, "\n", 1);
+	if (write_in_full(cmd->in, oid_to_hex(oid), the_hash_algo->hexsz) ||
+	    write_in_full(cmd->in, "\n", 1))
+		die(_("failed to feed promisor objects to pack-objects"));
+
 	return 0;
 }
 

--------------------
builtin/unpack-objects.c:cmd_unpack_objects() has the same xwrite()
loop as we saw in builtin/index-pack.c:final().  It is a correct
implementation that does not need to be touched, but we could
replace the loop with a single call to write_in_full().

diff --git i/builtin/unpack-objects.c w/builtin/unpack-objects.c
index e0a701f2b3..f1c85a00ae 100644
--- i/builtin/unpack-objects.c
+++ w/builtin/unpack-objects.c
@@ -679,13 +679,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 	use(the_hash_algo->rawsz);
 
 	/* Write the last part of the buffer to stdout */
-	while (len) {
-		int ret = xwrite(1, buffer + offset, len);
-		if (ret <= 0)
-			break;
-		len -= ret;
-		offset += ret;
-	}
+	write_in_full(1, buffer + offset, len);
 
 	/* All done */
 	return has_errors;


--------------------
http.c:fwrite_sha1_file() has xwrite() loop that is prepared to see
a short write(2).  The loop could be replaced with write_in_full() but
the semantics of the value returned upon failure could become different,
so I'd rather not to touch it.

http.c-	do {
http.c:		ssize_t retval = xwrite(freq->localfile,
http.c-					(char *) ptr + posn, size - posn);
http.c-		if (retval < 0)
http.c-			return posn / eltsize;
http.c-		posn += retval;
http.c-	} while (posn < size);

--------------------
sideband.c:demultiplex_sideband() uses xwrite() that does not retry
for its progress eye-candy.  write_in_full() may be overkill for
them, I suspect.

sideband.c-			strbuf_addch(scratch, *brk);
sideband.c:			xwrite(2, scratch->buf, scratch->len);
sideband.c-			strbuf_reset(scratch);
sideband.c ...
sideband.c-	if (scratch->len) {
sideband.c-		strbuf_addch(scratch, '\n');
sideband.c:		xwrite(2, scratch->buf, scratch->len);
sideband.c-	}


--------------------
streaming.c:stream_blob_to_fd() keeps track of the "hole" at the end
of the output file by refraining from writing series of NULs, and
instead uses lseek() to move the write pointer to 1-byte before the
desired end of file, and then uses xwrite() to write a single NUL at
the end.  This should not result in a short write(2), and it handles
write error correctly already, but it would be OK to update it to
write_in_full() for consistency.

diff --git c/streaming.c w/streaming.c
index 10adf625b2..38925ea9fd 100644
--- c/streaming.c
+++ w/streaming.c
@@ -538,7 +538,7 @@ int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter
 			goto close_and_exit;
 	}
 	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
-		     xwrite(fd, "", 1) != 1))
+		     write_in_full(fd, "", 1) != 1))
 		goto close_and_exit;
 	result = 0;
 
--------------------
t/helper/test-genzeros.c:cmd__genzeros() runs xwrite() and dies if
it got an error.  It does handle short write(2) correctly.

(1) If asked to write an infinite stream of NUL, it just feeds
zeros[] array without caring how many NUL bytes have actually been
written by a single xwrite() call.  It just stops when it sees an
error.

t/helper/test-genzeros.c-	/* Writing out individual NUL bytes is slow... */
t/helper/test-genzeros.c-	while (count < 0)
t/helper/test-genzeros.c:		if (xwrite(1, zeros, ARRAY_SIZE(zeros)) < 0)
t/helper/test-genzeros.c-			die_errno("write error");

(2) If asked to write a specific number of NUL bytes, it does a loop
that handles short write(2) correctly.

t/helper/test-genzeros.c-	while (count > 0) {
t/helper/test-genzeros.c:		n = xwrite(1, zeros,
t/helper/test-genzeros.c-			   count < ARRAY_SIZE(zeros)
t/helper/test-genzeros.c-			   ? count : ARRAY_SIZE(zeros));
t/helper/test-genzeros.c-
t/helper/test-genzeros.c-		if (n < 0)
t/helper/test-genzeros.c-			die_errno("write error");
t/helper/test-genzeros.c-
t/helper/test-genzeros.c-		count -= n;
t/helper/test-genzeros.c-	}

--------------------
transport-helper.c:disconnect_helper() has a call to xwrite() of a
single byte that does not care about errors, whose rationale is
given in a well written comment.

--------------------
transport-helper.c:udt_do_write() has a call to xwrite() that makes
a non-zero progress per a call to it, and its caller is prepared to
call it until the buffer is drained fully, prepared to handle a
short write(2) correctly.  There is nothing to fix there.

--------------------
upload-pack.c:send_client_data() calls unchecked xwrite() on fd #2
to show an error message, but this happens only when the sideband is
not in use, so I do not know offhand how much this matters these
days.  When the sideband is in use, the data is passed to
send_sideband() that does write_or_die(), so I guess for consistency
it might want to become write_in_full().  

HOWEVER, there is a comment that reads "are we happy to lose stuff
here?" left by 93822c22 (short i/o: fix calls to write to use xwrite
or write_in_full, 2007-01-08), which was an earlier audit of this
exact issue that turned many unchecked xwrite() into write_in_full(),
so, I dunno.

upload-pack.c-	if (use_sideband) {
upload-pack.c-		send_sideband(1, fd, data, sz, use_sideband);
upload-pack.c-		return;
upload-pack.c-	}
upload-pack.c-	if (fd == 3)
upload-pack.c-		/* emergency quit */
upload-pack.c-		fd = 2;
upload-pack.c-	if (fd == 2) {
upload-pack.c-		/* XXX: are we happy to lose stuff here? */
upload-pack.c:		xwrite(fd, data, sz);
upload-pack.c-		return;
upload-pack.c-	}
upload-pack.c-	write_or_die(fd, data, sz);
upload-pack.c-}
