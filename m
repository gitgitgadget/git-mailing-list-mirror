Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48B1C695
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="gM6kgSUF"
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB059F4
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 03:25:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc4d306fe9so6064655ad.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 03:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1699874718; x=1700479518; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LmI4ckIwkGKBNKvydwK4mSRDZTcp+z6TJyZn/TW7yNM=;
        b=gM6kgSUFXT64nrcKcXPbJ8UsVbnYfgqn0MfiOs3oveJpgOjXAfC/IbC6XhV/dS8tQ+
         JFdmIdbQgcWl8qvCaBShJ9tSXeO+fNtg7x4p12B2ZB5MzMpDhpOFeDbpcWaMj76ZK3N1
         G+QrrmhdnRmTNsgbEGmFk2VRHxzCN3byiSaFj0O8C8t0IZqRkORdnegPi910ywHMY97a
         16bTMZ1YFAaPZ4I7BBMpIXUavTJkts70vIM8+qZLXTVmTqFdyAyI/U7jASPa86xnEnGp
         znqPdNCuVYkgwMPVNTPANojuRFmwmulUtAN2lVu+Ts/Sk145Ac58YMl/BJQoNH2Nbujx
         ag5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699874718; x=1700479518;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LmI4ckIwkGKBNKvydwK4mSRDZTcp+z6TJyZn/TW7yNM=;
        b=hayeAqwJt5KBM8LD31WDyeSwiz8opXAeWcwo2MvmxlV5sFxqUA19Z6w3uOuo9uyTUW
         KuMUxRZ0X9QnvwFxDDlESH6dhgjLGCw6XSFa/03QaaXlp443SqA5mxwO1WsK9aGy8MAX
         j8h8ZdhCHxK+Fs8Q9PtOlripBpl8R2t2CJO4Iy16hctGC5rOe7Dbq7B2lKIy7+0vY7N/
         4cHVOJxKtNB0Nv1R0ROOkFD9cvYk1oV2osWnLzqw2Di0CucMlw25lSRum2nqTgWpxk8C
         mMc3utQ2NCGfBiGVILfFLjWYOfI3cCQbi8DKLxGl/WKdg5bpWMXjWNyWaf5A/5ORdXhF
         wNSQ==
X-Gm-Message-State: AOJu0YzFtrQ46ZUuZeOu/uTeidNX0EUyuDILq3WE9Ofq12GQVcDNKDpF
	TofXonAs7txTcNn8K7MUuTDEgjDPI4lsh8PTqU5doBRV+4Z5dc/IoQM=
X-Google-Smtp-Source: AGHT+IGpsu+cb1Fl8DnSgi2cewRqz5N080iSVgtvLvz9CyvWE9Gapcs7EMySwfJPfOcR4ilJJQHOkxuzB4ARl3GjUSQ=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9d8a:b0:281:291:a6e4 with SMTP id
 k10-20020a17090a9d8a00b002810291a6e4mr6099793pjp.1.1699874718061; Mon, 13 Nov
 2023 03:25:18 -0800 (PST)
Received: from 305313025478 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Nov 2023 03:25:17 -0800
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
Date: Mon, 13 Nov 2023 03:25:17 -0800
Message-ID: <CAGE_+C6DJMAO0bj5QHoKBBV3gMEMtZ-ajJ9ZnDGYq6eorr-oig@mail.gmail.com>
Subject: [PATCH] remote-curl: avoid hang if curl asks for more data after eof
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

It has been observed that under some circumstances, libcurl can call
our `CURLOPT_READFUNCTION` callback `rpc_out()` again even after
already getting a return value of zero (EOF) back once before.

This results in `rpc_read_from_out()` trying to read more from the
child process pipe, because `rpc->flush_read_but_not_sent` is reset to
false already the first time EOF is returned, and then the whole
operation gets stuck - the child process is already trying to read
a response back and will not write anything to the output pipe anymore,
while the parent/remote process is now blocked waiting to read more too
and never even finishes sending the request.

This commit addresses the bug with the following changes:

- Move resetting of the `flush_read_but_not_sent` flag to `post_rpc()`,
  just before the `rpc_out()` function would be potentially used the
  next time. This makes the callback return a zero any number of times
  at the end of a finished upload, thus fixing the bug.

- Rename `flush_read_but_not_sent` to `read_from_out_done`, because the
  flag is not as much about reading and sending the "flush" as about
  the reading/sending phase being done and that `read_from_out()` must
  not be called for this particular RPC exchange anymore.

- Simplify `post_rpc()` a bit by removing nested `if` statements, extra
  logic and comments. This revealed a bug in `stateless_connect()`,
  where `rpc.len` is reset to 0 after each request but not `rpc.pos`,
  relying on it being reset elsewhere. This is being fixed as well.

- Update all related comments and add a few new ones to help the next
  person understand how the chunked large request flow works easier.

- Rename the user data/context argument of libcurl streaming callbacks
  to be consistently `userdata` everywhere, just like the official
  documentation calls it. The current naming is confusing especially
  where it is called `buffer_` now.

- Reset also `CURLOPT_POSTFIELDSIZE_LARGE` to its default value of -1
  before reusing a handle in http.c / `get_active_slot()`. It can stay
  set from a previous request, e.g. to 4 from an earlier probe "0000"
  packet. Seems mostly harmless in practice, but looks confusing when
  looking at libcurl state while debugging problems like this one.

Signed-off-by: Jiri Hruska <jirka@fud.cz>
---
Hi all. I would like to report a bug in Git's integration of libcurl for the
HTTP transport and propose a patch to fix it.


I have seen Git get stuck while fetching a large repo sometimes over the years,
but I have never paid too much attention to it, because just trying again made
it work. But this started to happen much more frequently to me a few months back
and pushed me to investigate better.

I get to work with a large repository with lots of commits, branches and overall
traffic and when I run `git fetch --tags --force` on it, there are a lot of refs
to synchronize even after just a few days. And Git happens to hang for me, like
50% of the time. After a lot of activity and network I/O, it just gets stuck.

I have dumped the relevant processes and found that it all hangs because there
is a deadlock between a parent "git-remote-https" (curl) process and a child
process handling a "fetch-pack" command. Both sides are blocked on reading more
from _their_ side of the IPC pipe, so neither gets to do anything.

The call stacks where both sides get stuck are as follows:

  Parent: git-remote-https origin https://blah@dev.azure.com/blah/_git/meh

       00 ntdll!ZwReadFile
       01 KERNELBASE!ReadFile
       02 msvcrt!_read_nolock
       03 msvcrt!_read    <<<<<<<<<<<<<<<<<<<<<<<< fd = child/client.out
       04 git_remote_https!xread
       05 git_remote_https!read_in_full
       06 git_remote_https!get_packet_data
       07 git_remote_https!packet_read_with_status
       08 git_remote_https!rpc_read_from_out
       09 git_remote_https!rpc_out
       0a libcurl_4!CURLOPT_READFUNCTION callback
       0b libcurl_4!...
       0e git_remote_https!run_active_slot
       0f git_remote_https!run_one_slot
       10 git_remote_https!run_slot
       11 git_remote_https!post_rpc
       12 git_remote_https!rpc_service
       13 git_remote_https!fetch_git
       14 git_remote_https!fetch
       15 git_remote_https!parse_fetch
       16 git_remote_https!cmd_main
          ...

   Child: git fetch-pack --stateless-rpc --stdin --lock-pack --thin
                         --no-progress https://blah@dev.azure.com/blah/_git/meh

       00 ntdll!ZwReadFile
       01 KERNELBASE!ReadFile
       02 msvcrt!_read_nolock
       03 msvcrt!_read    <<<<<<<<<<<<<<<<<<<<<<<< fd = stdin (1)
       04 git!xread
       05 git!read_in_full
       06 git!get_packet_data
       07 git!packet_read_with_status
       08 git!packet_reader_read
       09 git!get_ack
       0a git!find_common
       0b git!do_fetch_patch
       0c git!fetch_pack
       0d git!cmd_fetch_pack
          ...

That is, the child is already trying to read the _response_ of an incremental
common commits negotiation, but the parent, orchestrating the whole RPC
interaction, has not finished sending the _request_ data yet and wants more.

I looked at the packets passed between the two processes, I read through the
whole rpc_service() - post_rpc() - rpc_out() flow many times, but I could not
see how it could all get into this blocked state. It was clear that everything
worked fine as long as the request data fit into one packet, but once the "large
request" code path was taken, things broke and got stuck. But I could not see
any weirdness in the implementation on the Git side that could trigger this.


Which was a correct observation, because the weirdness happens in libcurl!
It turns out that curl's function readwrite_upload() in lib/transfer.c [1] can
call the configured CURLOPT_READFUNCTION callback multiple times even if already
at EOF, even if the user callback has previously returned a zero to signal the
end of the data to upload before. It does not happen every time, only if the
next component in curl (OS socket, http/2 library, ...) is not able to send all
the data right away (and readwrite_upload() then runs again with offset > 0).

[1]: https://github.com/curl/curl/blob/ad051e1cbec68b2456a22661bf0800d49d085294/lib/transfer.c#L810

This is harmless when using the default fread() implementation, which the whole
CURLOPT_READFUNCTION is based on. But Git's rpc_out() function is not safe in
this regard. rpc->flush_read_but_not_sent is reset to false already before
returning a zero (EOF), so the next invocation goes to rpc_read_from_out()
again, reads from the silent pipe and blocks the upload from ever finishing.


A trivial solution would be to just take the line which resets the flag

    /*
     * The line length either does not need to be sent at
     * all or has already been completely sent. Now we can
     * return 0, indicating EOF, meaning that the flush has
     * been fully sent.
     */
-   rpc->flush_read_but_not_sent = 0;
    return 0;

from rpc_out() and reset it only in post_rpc(), before the next time a large
request is being sent out and rpc_out() will go into play again:

    if (large_request) {
        ...
        rpc->initial_buffer = 1;
+       rpc->flush_read_but_not_sent = 0;
        curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);

This way the CURLOPT_READFUNCTION would be returning zeros at the end of the
upload as long as needed, just like fread() at the end of a real file.

Hence, the bug could be fixed with just that two-lines change.


But while trying to figure out the above, I noticed a few things that prolonged
the time I needed to understand what was going on, so I would like to propose
some more changes to make the code perhaps a bit easier to read for the next
person who comes to hack on it after me.

The description of the extra modifications is in the commit message. All of
these changes are obviously optional and naturally subjective. I think that we
can all agree on some points (less indentation = good), but naming is hard,
and so is balance between unclear and too verbose, or when to split all
non-functional changes to a separate commit. So let me know if there are things
to do differently and I will gladly obey, it is your codebase after all.


Which brings me to the next topic, testing.

Validating the fix would be trivial with a mocked libcurl, but turns out to be
much harder with the integration-level test suite of this project.

I have validated this solution against a patched version of libcurl:

    diff --git a/lib/transfer.c b/lib/transfer.c
    index ba0410fc5..82141b648 100644
    --- a/lib/transfer.c
    +++ b/lib/transfer.c
    @@ -915,6 +915,9 @@ static CURLcode readwrite_upload(struct Curl_easy *data,
             k->upload_fromhere += offset;
             result = Curl_fillreadbuffer(data,
data->set.upload_buffer_size-offset,
                                          &fillcount);
    +        if(!result && fillcount == 0)
    +            result = Curl_fillreadbuffer(data,
data->set.upload_buffer_size-offset,
    +                                         &fillcount);
             k->upload_fromhere -= offset;
             if(result)
               return result;

I validated this solution on Windows, in the real-life case of the repo which
triggers these problems, managing to always fetch it smoothly after the fix.

But outside of that, and as far as the bundled test suite goes, I have failed to
write a test that could validate this problem does not ever occur again.

For all I know, the special case when curl calls the callback again happens only
on some operating systems (Windows), only with some versions of libcurl, only
with some dependencies (libnghttp2, OpenSSL) only when talking to some remote
servers (Microsoft Azure DevOps repos) over some protocols (HTTP/2), and only
with some back luck (network speed, TCP/IP window size, moon phase, ...).

Actually, I found at least one report from the past (2017) on Linux [2], which
seems to show exactly the same symptoms. Hard to tell if the root cause was
really the same too, though. The Internet seems full of "git fetch/pull hangs"
stories and there are always helpful people who jump in with their proven
solution of "git config --global http.postBuffer 100000000000000"... If this
bug fix could stop some of that nonsense, that would be awesome.

[2]: https://public-inbox.org/git/xmqqefzoxeki.fsf@gitster.mtv.corp.google.com/T/

Anyway, when I enabled extra GIT_TRACE_PACKET and GIT_CURL_VERBOSE, I could not
reproduce it anymore. When I tried to play with some of the t/*http*.sh
testcases, I did not manage to reproduce it either. And even then, reproducing
it _sometimes_ is not the same as reproducing it _always_. A flaky test is
often worse than no test at all.

So, I do not know how to write a test for this. Any suggestions are welcome.


Based on the guidance from Documentation/SubmittingPatches, as a bug fix, the
patch is based on the current `maint` (2.42.1). But applies cleanly to `master`,
`next` and `seen` as of 2023-11-12 too.

I have added Jeff and Jonathan to CC based on some previous commits to similar
places in remote-curl.c. Sorry if not or no longer relevant.

Thank you for your kind consideration.

Jiri

 http.c        |  1 +
 remote-curl.c | 93 +++++++++++++++++++++++++++++----------------------
 2 files changed, 54 insertions(+), 40 deletions(-)

diff --git a/http.c b/http.c
index 8f71bf00d8..14f2fbb82e 100644
--- a/http.c
+++ b/http.c
@@ -1454,6 +1454,7 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, (curl_off_t)-1);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca5..c043836214 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -606,13 +606,14 @@ struct rpc_state {
 	unsigned write_line_lengths : 1;

 	/*
-	 * Used by rpc_out; initialize to 0. This is true if a flush has been
-	 * read, but the corresponding line length (if write_line_lengths is
-	 * true) and EOF have not been sent to libcurl. Since each flush marks
-	 * the end of a request, each flush must be completely sent before any
-	 * further reading occurs.
+	 * Used by rpc_out; initialize to 0. This is true if a flush packet
+	 * has been read from the child process, signaling the end of the
+	 * current data to send. There might be still some bytes pending in
+	 * 'buf' (e.g. the corresponding line length, if write_line_lengths
+	 * is true), but no more reads can be performed on the 'out' pipe as
+	 * part of the current RPC exchange.
 	 */
-	unsigned flush_read_but_not_sent : 1;
+	unsigned read_from_out_done : 1;
 };

 #define RPC_STATE_INIT { 0 }
@@ -675,48 +676,51 @@ static int rpc_read_from_out(struct rpc_state
*rpc, int options,
 	return 1;
 }

+/*
+ * CURLOPT_READFUNCTION callback, called by libcurl when it wants more data
+ * to send out. Used only if the request did not fit into just one buffer and
+ * data must be streamed as it comes.
+ * Has the same semantics as fread(), but reads packets from the pipe from
+ * the child process instead. A return value of 0 (EOF) finishes the upload.
+ */
 static size_t rpc_out(void *ptr, size_t eltsize,
-		size_t nmemb, void *buffer_)
+		size_t nmemb, void *userdata)
 {
 	size_t max = eltsize * nmemb;
-	struct rpc_state *rpc = buffer_;
+	struct rpc_state *rpc = userdata;
 	size_t avail = rpc->len - rpc->pos;
 	enum packet_read_status status;

-	if (!avail) {
+	/*
+	 * If there is no more data available in our buffer and the child
+	 * process is not done sending yet, read the next packet.
+	 */
+	if (!avail && !rpc->read_from_out_done) {
 		rpc->initial_buffer = 0;
 		rpc->len = 0;
 		rpc->pos = 0;
-		if (!rpc->flush_read_but_not_sent) {
-			if (!rpc_read_from_out(rpc, 0, &avail, &status))
-				BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
-			if (status == PACKET_READ_FLUSH)
-				rpc->flush_read_but_not_sent = 1;
-		}
+		if (!rpc_read_from_out(rpc, 0, &avail, &status))
+			BUG("The entire rpc->buf should be larger than LARGE_PACKET_MAX");
+
 		/*
-		 * If flush_read_but_not_sent is true, we have already read one
-		 * full request but have not fully sent it + EOF, which is why
-		 * we need to refrain from reading.
-		 */
-	}
-	if (rpc->flush_read_but_not_sent) {
-		if (!avail) {
-			/*
-			 * The line length either does not need to be sent at
-			 * all or has already been completely sent. Now we can
-			 * return 0, indicating EOF, meaning that the flush has
-			 * been fully sent.
-			 */
-			rpc->flush_read_but_not_sent = 0;
-			return 0;
-		}
-		/*
-		 * If avail is non-zero, the line length for the flush still
-		 * hasn't been fully sent. Proceed with sending the line
-		 * length.
+		 * If a flush packet was read, it means the child process is
+		 * done sending this request. The buffer might be fully empty
+		 * at this point or contain a flush packet too, depending on
+		 * rpc->write_line_lengths.
+		 * In any case, we must refrain from reading any more, because
+		 * the child process already expects to receive a response back
+		 * instead. If both sides would try to read at once, they would
+		 * just hang waiting for each other.
 		 */
+		rpc->read_from_out_done = (status == PACKET_READ_FLUSH);
 	}

+	/*
+	 * Copy data to the provided buffer. If there is nothing more to send,
+	 * nothing gets written and the return value is 0 (EOF).
+	 * It is important to keep returning 0 as long as needed in that case,
+	 * as libcurl invokes the callback multiple times at EOF sometimes.
+	 */
 	if (max < avail)
 		avail = max;
 	memcpy(ptr, rpc->buf + rpc->pos, avail);
@@ -724,9 +728,16 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 	return avail;
 }

-static int rpc_seek(void *clientp, curl_off_t offset, int origin)
+/*
+ * CURLOPT_SEEKFUNCTION callback, called by libcurl when it wants to seek in
+ * the data being sent out. Used only if the request did not fit into just
+ * one buffer and data must be streamed as it comes.
+ * Has the same semantics as fseek(), but seeks in the buffered packet read
+ * from the pipe from the child process instead.
+ */
+static int rpc_seek(void *userdata, curl_off_t offset, int origin)
 {
-	struct rpc_state *rpc = clientp;
+	struct rpc_state *rpc = userdata;

 	if (origin != SEEK_SET)
 		BUG("rpc_seek only handles SEEK_SET, not %d", origin);
@@ -800,10 +811,10 @@ struct rpc_in_data {
  * from ptr.
  */
 static size_t rpc_in(char *ptr, size_t eltsize,
-		size_t nmemb, void *buffer_)
+		size_t nmemb, void *userdata)
 {
 	size_t size = eltsize * nmemb;
-	struct rpc_in_data *data = buffer_;
+	struct rpc_in_data *data = userdata;
 	long response_code;

 	if (curl_easy_getinfo(data->slot->curl, CURLINFO_RESPONSE_CODE,
@@ -963,6 +974,7 @@ static int post_rpc(struct rpc_state *rpc, int
stateless_connect, int flush_rece
 		 */
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
 		rpc->initial_buffer = 1;
+		rpc->read_from_out_done = 0;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
 		curl_easy_setopt(slot->curl, CURLOPT_SEEKFUNCTION, rpc_seek);
@@ -1482,7 +1494,7 @@ static int stateless_connect(const char *service_name)
 	rpc.gzip_request = 1;
 	rpc.initial_buffer = 0;
 	rpc.write_line_lengths = 1;
-	rpc.flush_read_but_not_sent = 0;
+	rpc.read_from_out_done = 0;

 	/*
 	 * Dump the capability listing that we got from the server earlier
@@ -1505,6 +1517,7 @@ static int stateless_connect(const char *service_name)
 			break;
 		/* Reset the buffer for next request */
 		rpc.len = 0;
+		rpc.pos = 0;
 	}

 	free(rpc.service_url);
-- 
2.42.1.1.g18afbdf3b0
