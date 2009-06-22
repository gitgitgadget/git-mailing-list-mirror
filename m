From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 1/6] Create input and output streams that have timeouts
Date: Mon, 22 Jun 2009 23:09:07 +0200
Message-ID: <200906222309.07435.robin.rosenberg@dewire.com>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org> <1245446875-31102-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:10:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIqm0-0004NN-Cy
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 23:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbZFVVJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 17:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755822AbZFVVJL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 17:09:11 -0400
Received: from mail.dewire.com ([83.140.172.130]:1552 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbZFVVJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 17:09:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CABAA147E9B2;
	Mon, 22 Jun 2009 23:09:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQlzEbq2l8R7; Mon, 22 Jun 2009 23:09:09 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 142A3146D000;
	Mon, 22 Jun 2009 23:09:09 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1245446875-31102-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122059>

fredag 19 juni 2009 23:27:50 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> We can use these streams to wrap around a PipedInputStream, such
> as the one given to us by JSch, to implement a timeout so we can
> abort a transport operation if the remote peer doesn't communicate
> with us in a timely fashion.
> 
> Only the input and output streams and tests are defined, later
> I will make use of them in the transport layer where we can't
> rely upon raw socket timeouts to abort a long running IO call.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../jgit/util/io/TimeoutInputStreamTest.java       |  187 +++++++++++++
>  .../jgit/util/io/TimeoutOutputStreamTest.java      |  286 ++++++++++++++++++++
>  .../org/spearce/jgit/util/io/InterruptTimer.java   |  216 +++++++++++++++
>  .../spearce/jgit/util/io/TimeoutInputStream.java   |  133 +++++++++
>  .../spearce/jgit/util/io/TimeoutOutputStream.java  |  146 ++++++++++
>  5 files changed, 968 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java
>  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutOutputStreamTest.java
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/InterruptTimer.java
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutInputStream.java
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutOutputStream.java
> 
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java
> new file mode 100644
> index 0000000..25eff9a
> --- /dev/null
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java
> @@ -0,0 +1,187 @@
> +/*
> + * Copyright (C) 2009, Google Inc.
> + *
> + * All rights reserved.
> + *
> + * Redistribution and use in source and binary forms, with or
> + * without modification, are permitted provided that the following
> + * conditions are met:
> + *
> + * - Redistributions of source code must retain the above copyright
> + *   notice, this list of conditions and the following disclaimer.
> + *
> + * - Redistributions in binary form must reproduce the above
> + *   copyright notice, this list of conditions and the following
> + *   disclaimer in the documentation and/or other materials provided
> + *   with the distribution.
> + *
> + * - Neither the name of the Git Development Community nor the
> + *   names of its contributors may be used to endorse or promote
> + *   products derived from this software without specific prior
> + *   written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> + * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
> + * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
> + * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
> + * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> + * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +package org.spearce.jgit.util.io;
> +
> +import java.io.IOException;
> +import java.io.InterruptedIOException;
> +import java.io.PipedInputStream;
> +import java.io.PipedOutputStream;
> +import java.util.Arrays;
> +import java.util.List;
> +
> +import org.spearce.jgit.util.NB;
> +import org.spearce.jgit.util.io.InterruptTimer;
> +import org.spearce.jgit.util.io.TimeoutInputStream;
> +
> +import junit.framework.TestCase;
> +
> +public class TimeoutInputStreamTest extends TestCase {
> +	private static final int timeout = 250;
> +
> +	private PipedOutputStream out;
> +
> +	private PipedInputStream in;
> +
> +	private InterruptTimer timer;
> +
> +	private TimeoutInputStream is;
> +
> +	private long start;
> +
> +	protected void setUp() throws Exception {
> +		super.setUp();
> +		out = new PipedOutputStream();
> +		in = new PipedInputStream(out);
> +		timer = new InterruptTimer();
> +		is = new TimeoutInputStream(in, timer);
> +		is.setTimeout(timeout);
> +	}
> +
> +	protected void tearDown() throws Exception {
> +		close();
> +		super.tearDown();
> +	}
> +
> +	public void testTimeout_readByte_Success1() throws IOException {
> +		out.write('a');
> +		assertEquals('a', is.read());
> +		close();
Unnecessary close(). It is already in tearDown. Same goes for all other
tests in the suite.

> +	}
> +
> +	public void testTimeout_readByte_Success2() throws IOException {
> +		final byte[] exp = new byte[] { 'a', 'b', 'c' };
> +		out.write(exp);
> +		assertEquals(exp[0], is.read());
> +		assertEquals(exp[1], is.read());
> +		assertEquals(exp[2], is.read());
> +		close();
> +	}

Perhaps a normal end of stream test too, out.close and verify that read
returns -1.

> +	public void testTimeout_readByte_Timeout() throws IOException {
> +		beginRead();
> +		try {
> +			is.read();
> +			fail("incorrectly read a byte");
> +		} catch (InterruptedIOException e) {
> +			// expected
> +		}
> +		assertTimeout();
> +		close();
> +	}
> +
> +	public void testTimeout_readBuffer_Success1() throws IOException {
> +		final byte[] exp = new byte[] { 'a', 'b', 'c' };
> +		final byte[] act = new byte[exp.length];
> +		out.write(exp);
> +		NB.readFully(is, act, 0, act.length);
> +		assertTrue(Arrays.equals(exp, act));
> +		close();
> +	}
> +
> +	public void testTimeout_readBuffer_Success2() throws IOException {
> +		final byte[] exp = new byte[] { 'a', 'b', 'c' };
> +		final byte[] act = new byte[exp.length];
> +		out.write(exp);
> +		NB.readFully(is, act, 0, 1);
> +		NB.readFully(is, act, 1, 1);
> +		NB.readFully(is, act, 2, 1);
> +		assertTrue(Arrays.equals(exp, act));
> +		close();
> +	}
> +
> +	public void testTimeout_readBuffer_Timeout() throws IOException {
> +		beginRead();
> +		try {
> +			is.read(new byte[512]);
> +			fail("incorrectly read bytes");
> +		} catch (InterruptedIOException e) {
> +			// expected
> +		}
> +		assertTimeout();
> +		close();
> +	}

The success read calls NB.readFully, shouldn't the timeout ones use the
same API?

> +	public void testTimeout_skip_Success() throws IOException {
> +		final byte[] exp = new byte[] { 'a', 'b', 'c' };
> +		out.write(exp);
> +		assertEquals(2, is.skip(2));
> +		assertEquals('c', is.read());
> +		close();
> +	}
> +
> +	public void testTimeout_skip_Timeout() throws IOException {
> +		beginRead();
> +		try {
> +			is.skip(1024);
> +			fail("incorrectly skipped bytes");
> +		} catch (InterruptedIOException e) {
> +			// expected
> +		}
> +		assertTimeout();
> +		close();
> +	}
> +
> +	private void beginRead() {
> +		start = now();
> +	}
> +
> +	private void assertTimeout() {
> +		final long wait = now() - start;
> +		assertTrue(Math.abs(wait - timeout) < 50);

Maybe a comment to the uninvited.

> +	}
...
> +public class TimeoutOutputStreamTest extends TestCase {
> +	private static final int timeout = 250;
...
> +	protected void tearDown() throws Exception {
> +		close();
> +		super.tearDown();
> +	}
> +
Same comment as for the input test and close().


And the rest is beautiful code.

-- robin
