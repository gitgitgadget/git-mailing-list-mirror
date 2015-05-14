From: Jeff King <peff@peff.net>
Subject: Re: Clone hangs when done over http with --reference
Date: Wed, 13 May 2015 20:47:25 -0400
Message-ID: <20150514004724.GA3059@peff.net>
References: <20150513210436.GA7407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Thu May 14 02:47:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YshJJ-00080y-PW
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 02:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbbENAr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 20:47:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:58354 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754564AbbENAr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 20:47:28 -0400
Received: (qmail 28837 invoked by uid 102); 14 May 2015 00:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 19:47:28 -0500
Received: (qmail 18779 invoked by uid 107); 14 May 2015 00:47:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 20:47:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 20:47:25 -0400
Content-Disposition: inline
In-Reply-To: <20150513210436.GA7407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269020>

On Wed, May 13, 2015 at 05:04:36PM -0400, Konstantin Ryabitsev wrote:

> I have a reproducible case where git clone --reference hangs when
> performed over http://, but not when performed over git://

Thanks for giving us a reproduction recipe. I was able to recreate the
problem on my machine.

There's a minor bug in git's error reporting that makes this a little
harder to examine, but isn't the root cause. I'll send a patch for that
momentarily.  But here's what I've found.

During the ref negotiation between the client and the server, there's so
much data that we end up making several POSTs to the server. In one of
them, we end up in a deadlock situation between the CGI and Apache. You
can get a full strace of the Apache side by cloning this:

  git://github.com/gist/9daf49aaaff16b4436f2

The interesting part is at 19:23:48.182380. Process 19891 is Apache,
reading from the client (on fd 8) and relaying the data to http-backend
over fd 10:

  19891 19:23:48.182331 read(8,  <unfinished ...>
  19891 19:23:48.182358 <... read resumed> "\320#\200*:x\26\355;t\205\36\v\361'}\304\24x\2502\327\247O\203\255\211\21e\324[_"..., 8000) = 5020
  19891 19:23:48.182365 write(10, "dy\206\327\256\311\230D\236\256\366\3639;\10\356\343%9R\3420\203~\200\256\276\250\332g7\331"..., 236 <unfinished ...>
  19891 19:23:48.182373 <... write resumed> ) = -1 EAGAIN (Resource temporarily unavailable)
  19891 19:23:48.182380 poll([{fd=10, events=POLLOUT}], 1, 60000 <unfinished ...>
  19891 19:24:48.242493 <... poll resumed> ) = 0 (Timeout)
  19891 19:24:48.242609 close(10)         = 0

During one of the writes we get EAGAIN; the buffer to http-backend is
full. So Apache calls poll() to give it 60 seconds. The http-backend
process never starts reading, so Apache gives up and closes the
descriptor, truncating the input to http-backend.

So what's http-backend doing? It's pid 2361 in this output (which you
can verify looking further back in the strace dump and finding the
clone/exec). It's busily relaying all the data to its child,
upload-pack:

  2361  19:23:48.182232 read(0,  <unfinished ...>
  2361  19:23:48.182246 <... read resumed> "\371r\324\366\3600\247\236\227\216i\376P\204R\32Op;\362\247\3573\227\2174\213\361k\5\300\\"..., 8192) = 8192
  2361  19:23:48.182324 write(4, "3435b8c152bec0c78998ff0445bd2c0f"..., 8192 <unfinished ...>
  2361  19:24:48.247291 <... write resumed> ) = 8192

but notice the minute-long jump in that write. It's not reading from
stdin because it's _also_ blocked on writing. So why isn't upload-pack
reading?

  2363  19:23:48.184370 read(0, "have 4ed051beb0ff979344c541ec659"..., 46) = 46
  2363  19:23:48.184381 alarm(0)          = 0
  2363  19:23:48.184398 write(1, "0038ACK 4ed051beb0ff979344c541ec"..., 56 <unfinished ...>
  2363  19:24:48.243565 <... write resumed> ) = 56

It's writing responses to its own stdout, of course! Which also blocks,
preventing us from reading during the crucial minute.  Now who's
supposed to be reading our stdout here?

It's rather difficult to tell from the strace output, as you have to
walk through the parents to see if anybody re-opened stdout over a pipe.
But the last one is in process 2361, just before we exec
git-http-backend. Apache has opened a pipe for the CGI stdout, and is
holding the other end of the pipe. But it's not reading, because it's
blocked trying to write the request body to us.

At 19:24:48, Apache gives up on writing and truncates the input to the
CGI. It starts reading the output, which lets Git start moving again.
But we hit this code:

  ssize_t n = xread(0, in_buf, sizeof(in_buf));
  if (n <= 0)
	die("request ended in the middle of the gzip stream");

because of the truncated input. At this point, everything is done on the
server. Presumably Apache sends us a reasonable content-length, so even
though our output isn't complete, we at least know when it ends. You can
see that in the client git-remote-http here (note this is from a
different run than above, so the timestamps are not the same; this is
a bit after the minute-long hang has completed):

  4453  20:19:32.557686 recvfrom(5,  <unfinished ...>
  4453  20:19:32.557695 <... recvfrom resumed> "4cea692129be9c003c33 common\n\r\n38"..., 16384, 0, NULL, NULL) = 9025
  4453  20:19:32.557703 write(6, "4cea692129be9c003c33 common\n", 28 <unfinished ...>
  4453  20:19:32.557714 <... write resumed> ) = 28 

This is the last bit of data we read from the server, so presumably we
believe we got it all. We relay it all to fd 6, which goes to our
git-fetch-pack sub-process. It in turn reads everything we give it, and
then waits for more. But we don't have any more. The two client
processes are deadlocked, each waiting for more data from the other. The
remote-http process has no way to tell fetch-pack "the server didn't
send any more data". It can't just close() the descriptor, because it's
expecting fetch-pack to tell it to make another POST request to the
server. And fetch-pack is waiting for more input, because what came from
the server was not enough to proceed.

This is a non-ideal way to handle the error, of course. But it's not the
fundamental problem; the best we could do is notice and say "hey, the
server didn't send us enough data".

The fundamental problem is the deadlock on the server side, which is
producing bogus protocol output. And that's a mismatch between what
Apache expects (that the CGI will read all of the input request and then
generate an output request) and what the CGI wants to do (stream output
as it reads the input).

I don't know if there's a way to convince Apache to be more interactive.
As a hacky workaround, we could basically spool all of the input into
memory (or a tempfile) and work from that. Or the output. Either way
would break the pipe deadlock. But we'd have to be sensitive to the type
of request (it's probably OK to spool ref negotiation, but not OK to
spool packfiles, which can be arbitrarily big).

The (horrible, should-not-be-applied) patch below makes your case work
for me:

diff --git a/http-backend.c b/http-backend.c
index 0670719..25471f6 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -269,21 +269,20 @@ static struct rpc_service *select_service(const char *name)
 static void inflate_request(const char *prog_name, int out)
 {
 	git_zstream stream;
-	unsigned char in_buf[8192];
+	struct strbuf in = STRBUF_INIT;
 	unsigned char out_buf[8192];
 	unsigned long cnt = 0;
 
 	memset(&stream, 0, sizeof(stream));
 	git_inflate_init_gzip_only(&stream);
 
-	while (1) {
-		ssize_t n = xread(0, in_buf, sizeof(in_buf));
-		if (n <= 0)
-			die("request ended in the middle of the gzip stream");
-
-		stream.next_in = in_buf;
-		stream.avail_in = n;
+	if (strbuf_read(&in, 0, 8192) < 0)
+		die("unable to read request");
+	stream.next_in = (unsigned char *)in.buf;
+	stream.avail_in = in.len;
 
+	{
+		unsigned long n;
 		while (0 < stream.avail_in) {
 			int ret;
 
@@ -304,6 +303,8 @@ static void inflate_request(const char *prog_name, int out)
 		}
 	}
 
+	die("request ended in the middle of the gzip stream");
+
 done:
 	git_inflate_end(&stream);
 	close(out);
