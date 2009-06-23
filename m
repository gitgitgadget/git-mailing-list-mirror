From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 1/6 v2] Create input and output streams that have
	timeouts
Date: Tue, 23 Jun 2009 09:41:57 -0700
Message-ID: <20090623164157.GB11191@spearce.org>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org> <1245446875-31102-2-git-send-email-spearce@spearce.org> <200906222309.07435.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 18:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ94S-0008UK-Sd
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 18:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756426AbZFWQl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 12:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZFWQl4
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 12:41:56 -0400
Received: from george.spearce.org ([209.20.77.23]:48977 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZFWQlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 12:41:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DD0DA381FD; Tue, 23 Jun 2009 16:41:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906222309.07435.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122100>

We can use these streams to wrap around a PipedInputStream, such
as the one given to us by JSch, to implement a timeout so we can
abort a transport operation if the remote peer doesn't communicate
with us in a timely fashion.

Only the input and output streams and tests are defined, later
I will make use of them in the transport layer where we can't
rely upon raw socket timeouts to abort a long running IO call.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This version addresses all of your comments in the unit tests.

 .../jgit/util/io/TimeoutInputStreamTest.java       |  183 +++++++++++++
 .../jgit/util/io/TimeoutOutputStreamTest.java      |  279 ++++++++++++++++++++
 .../org/spearce/jgit/util/io/InterruptTimer.java   |  216 +++++++++++++++
 .../spearce/jgit/util/io/TimeoutInputStream.java   |  133 ++++++++++
 .../spearce/jgit/util/io/TimeoutOutputStream.java  |  146 ++++++++++
 5 files changed, 957 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutOutputStreamTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/InterruptTimer.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutInputStream.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutOutputStream.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java
new file mode 100644
index 0000000..272838c
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java
@@ -0,0 +1,183 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.util.io;
+
+import java.io.IOException;
+import java.io.InterruptedIOException;
+import java.io.PipedInputStream;
+import java.io.PipedOutputStream;
+import java.util.Arrays;
+import java.util.List;
+
+import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.io.InterruptTimer;
+import org.spearce.jgit.util.io.TimeoutInputStream;
+
+import junit.framework.TestCase;
+
+public class TimeoutInputStreamTest extends TestCase {
+	private static final int timeout = 250;
+
+	private PipedOutputStream out;
+
+	private PipedInputStream in;
+
+	private InterruptTimer timer;
+
+	private TimeoutInputStream is;
+
+	private long start;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		out = new PipedOutputStream();
+		in = new PipedInputStream(out);
+		timer = new InterruptTimer();
+		is = new TimeoutInputStream(in, timer);
+		is.setTimeout(timeout);
+	}
+
+	protected void tearDown() throws Exception {
+		timer.terminate();
+		for (Thread t : active())
+			assertFalse(t instanceof InterruptTimer.AlarmThread);
+		super.tearDown();
+	}
+
+	public void testTimeout_readByte_Success1() throws IOException {
+		out.write('a');
+		assertEquals('a', is.read());
+	}
+
+	public void testTimeout_readByte_Success2() throws IOException {
+		final byte[] exp = new byte[] { 'a', 'b', 'c' };
+		out.write(exp);
+		assertEquals(exp[0], is.read());
+		assertEquals(exp[1], is.read());
+		assertEquals(exp[2], is.read());
+		out.close();
+		assertEquals(-1, is.read());
+	}
+
+	public void testTimeout_readByte_Timeout() throws IOException {
+		beginRead();
+		try {
+			is.read();
+			fail("incorrectly read a byte");
+		} catch (InterruptedIOException e) {
+			// expected
+		}
+		assertTimeout();
+	}
+
+	public void testTimeout_readBuffer_Success1() throws IOException {
+		final byte[] exp = new byte[] { 'a', 'b', 'c' };
+		final byte[] act = new byte[exp.length];
+		out.write(exp);
+		NB.readFully(is, act, 0, act.length);
+		assertTrue(Arrays.equals(exp, act));
+	}
+
+	public void testTimeout_readBuffer_Success2() throws IOException {
+		final byte[] exp = new byte[] { 'a', 'b', 'c' };
+		final byte[] act = new byte[exp.length];
+		out.write(exp);
+		NB.readFully(is, act, 0, 1);
+		NB.readFully(is, act, 1, 1);
+		NB.readFully(is, act, 2, 1);
+		assertTrue(Arrays.equals(exp, act));
+	}
+
+	public void testTimeout_readBuffer_Timeout() throws IOException {
+		beginRead();
+		try {
+			NB.readFully(is, new byte[512], 0, 512);
+			fail("incorrectly read bytes");
+		} catch (InterruptedIOException e) {
+			// expected
+		}
+		assertTimeout();
+	}
+
+	public void testTimeout_skip_Success() throws IOException {
+		final byte[] exp = new byte[] { 'a', 'b', 'c' };
+		out.write(exp);
+		assertEquals(2, is.skip(2));
+		assertEquals('c', is.read());
+	}
+
+	public void testTimeout_skip_Timeout() throws IOException {
+		beginRead();
+		try {
+			is.skip(1024);
+			fail("incorrectly skipped bytes");
+		} catch (InterruptedIOException e) {
+			// expected
+		}
+		assertTimeout();
+	}
+
+	private void beginRead() {
+		start = now();
+	}
+
+	private void assertTimeout() {
+		// Our timeout was supposed to be ~250 ms. Since this is a timing
+		// test we can't assume we spent *exactly* the timeout period, as
+		// there may be other activity going on in the system. Instead we
+		// look for the delta between the start and end times to be within
+		// 50 ms of the expected timeout.
+		//
+		final long wait = now() - start;
+		assertTrue(Math.abs(wait - timeout) < 50);
+	}
+
+	private static List<Thread> active() {
+		Thread[] all = new Thread[16];
+		int n = Thread.currentThread().getThreadGroup().enumerate(all);
+		while (n == all.length) {
+			all = new Thread[all.length * 2];
+			n = Thread.currentThread().getThreadGroup().enumerate(all);
+		}
+		return Arrays.asList(all).subList(0, n);
+	}
+
+	private static long now() {
+		return System.currentTimeMillis();
+	}
+}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutOutputStreamTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutOutputStreamTest.java
new file mode 100644
index 0000000..07e5c38
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutOutputStreamTest.java
@@ -0,0 +1,279 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.util.io;
+
+import java.io.IOException;
+import java.io.InterruptedIOException;
+import java.io.OutputStream;
+import java.io.PipedInputStream;
+import java.io.PipedOutputStream;
+import java.util.Arrays;
+import java.util.List;
+
+import org.spearce.jgit.util.NB;
+import org.spearce.jgit.util.io.InterruptTimer;
+import org.spearce.jgit.util.io.TimeoutOutputStream;
+
+import junit.framework.TestCase;
+
+public class TimeoutOutputStreamTest extends TestCase {
+	private static final int timeout = 250;
+
+	private PipedOutputStream out;
+
+	private FullPipeInputStream in;
+
+	private InterruptTimer timer;
+
+	private TimeoutOutputStream os;
+
+	private long start;
+
+	protected void setUp() throws Exception {
+		super.setUp();
+		out = new PipedOutputStream();
+		in = new FullPipeInputStream(out);
+		timer = new InterruptTimer();
+		os = new TimeoutOutputStream(out, timer);
+		os.setTimeout(timeout);
+	}
+
+	protected void tearDown() throws Exception {
+		timer.terminate();
+		for (Thread t : active())
+			assertFalse(t instanceof InterruptTimer.AlarmThread);
+		super.tearDown();
+	}
+
+	public void testTimeout_writeByte_Success1() throws IOException {
+		in.free(1);
+		os.write('a');
+		in.want(1);
+		assertEquals('a', in.read());
+	}
+
+	public void testTimeout_writeByte_Success2() throws IOException {
+		final byte[] exp = new byte[] { 'a', 'b', 'c' };
+		final byte[] act = new byte[exp.length];
+		in.free(exp.length);
+		os.write(exp[0]);
+		os.write(exp[1]);
+		os.write(exp[2]);
+		in.want(exp.length);
+		in.read(act);
+		assertTrue(Arrays.equals(exp, act));
+	}
+
+	public void testTimeout_writeByte_Timeout() throws IOException {
+		beginWrite();
+		try {
+			os.write('\n');
+			fail("incorrectly write a byte");
+		} catch (InterruptedIOException e) {
+			// expected
+		}
+		assertTimeout();
+	}
+
+	public void testTimeout_writeBuffer_Success1() throws IOException {
+		final byte[] exp = new byte[] { 'a', 'b', 'c' };
+		final byte[] act = new byte[exp.length];
+		in.free(exp.length);
+		os.write(exp);
+		in.want(exp.length);
+		in.read(act);
+		assertTrue(Arrays.equals(exp, act));
+	}
+
+	public void testTimeout_writeBuffer_Timeout() throws IOException {
+		beginWrite();
+		try {
+			os.write(new byte[512]);
+			fail("incorrectly wrote bytes");
+		} catch (InterruptedIOException e) {
+			// expected
+		}
+		assertTimeout();
+	}
+
+	public void testTimeout_flush_Success() throws IOException {
+		final boolean[] called = new boolean[1];
+		os = new TimeoutOutputStream(new OutputStream() {
+			@Override
+			public void write(int b) throws IOException {
+				fail("should not have written");
+			}
+
+			@Override
+			public void flush() throws IOException {
+				called[0] = true;
+			}
+		}, timer);
+		os.setTimeout(timeout);
+		os.flush();
+		assertTrue(called[0]);
+	}
+
+	public void testTimeout_flush_Timeout() throws IOException {
+		final boolean[] called = new boolean[1];
+		os = new TimeoutOutputStream(new OutputStream() {
+			@Override
+			public void write(int b) throws IOException {
+				fail("should not have written");
+			}
+
+			@Override
+			public void flush() throws IOException {
+				called[0] = true;
+				for (;;) {
+					try {
+						Thread.sleep(1000);
+					} catch (InterruptedException e) {
+						throw new InterruptedIOException();
+					}
+				}
+			}
+		}, timer);
+		os.setTimeout(timeout);
+
+		beginWrite();
+		try {
+			os.flush();
+			fail("incorrectly flushed");
+		} catch (InterruptedIOException e) {
+			// expected
+		}
+		assertTimeout();
+		assertTrue(called[0]);
+	}
+
+	public void testTimeout_close_Success() throws IOException {
+		final boolean[] called = new boolean[1];
+		os = new TimeoutOutputStream(new OutputStream() {
+			@Override
+			public void write(int b) throws IOException {
+				fail("should not have written");
+			}
+
+			@Override
+			public void close() throws IOException {
+				called[0] = true;
+			}
+		}, timer);
+		os.setTimeout(timeout);
+		os.close();
+		assertTrue(called[0]);
+	}
+
+	public void testTimeout_close_Timeout() throws IOException {
+		final boolean[] called = new boolean[1];
+		os = new TimeoutOutputStream(new OutputStream() {
+			@Override
+			public void write(int b) throws IOException {
+				fail("should not have written");
+			}
+
+			@Override
+			public void close() throws IOException {
+				called[0] = true;
+				for (;;) {
+					try {
+						Thread.sleep(1000);
+					} catch (InterruptedException e) {
+						throw new InterruptedIOException();
+					}
+				}
+			}
+		}, timer);
+		os.setTimeout(timeout);
+
+		beginWrite();
+		try {
+			os.close();
+			fail("incorrectly closed");
+		} catch (InterruptedIOException e) {
+			// expected
+		}
+		assertTimeout();
+		assertTrue(called[0]);
+	}
+
+	private void beginWrite() {
+		start = now();
+	}
+
+	private void assertTimeout() {
+		// Our timeout was supposed to be ~250 ms. Since this is a timing
+		// test we can't assume we spent *exactly* the timeout period, as
+		// there may be other activity going on in the system. Instead we
+		// look for the delta between the start and end times to be within
+		// 50 ms of the expected timeout.
+		//
+		final long wait = now() - start;
+		assertTrue(Math.abs(wait - timeout) < 50);
+	}
+
+	private static List<Thread> active() {
+		Thread[] all = new Thread[16];
+		int n = Thread.currentThread().getThreadGroup().enumerate(all);
+		while (n == all.length) {
+			all = new Thread[all.length * 2];
+			n = Thread.currentThread().getThreadGroup().enumerate(all);
+		}
+		return Arrays.asList(all).subList(0, n);
+	}
+
+	private static long now() {
+		return System.currentTimeMillis();
+	}
+
+	private final class FullPipeInputStream extends PipedInputStream {
+		FullPipeInputStream(PipedOutputStream src) throws IOException {
+			super(src);
+			src.write(new byte[PIPE_SIZE]);
+		}
+
+		void want(int cnt) throws IOException {
+			NB.skipFully(this, PIPE_SIZE - cnt);
+		}
+
+		void free(int cnt) throws IOException {
+			NB.skipFully(this, cnt);
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/io/InterruptTimer.java b/org.spearce.jgit/src/org/spearce/jgit/util/io/InterruptTimer.java
new file mode 100644
index 0000000..8f625e0
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/io/InterruptTimer.java
@@ -0,0 +1,216 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.util.io;
+
+/**
+ * Triggers an interrupt on the calling thread if it doesn't complete a block.
+ * <p>
+ * Classes can use this to trip an alarm interrupting the calling thread if it
+ * doesn't complete a block within the specified timeout. Typical calling
+ * pattern is:
+ *
+ * <pre>
+ * private InterruptTimer myTimer = ...;
+ * void foo() {
+ *   try {
+ *     myTimer.begin(timeout);
+ *     // work
+ *   } finally {
+ *     myTimer.end();
+ *   }
+ * }
+ * </pre>
+ * <p>
+ * An InterruptTimer is not recursive. To implement recursive timers,
+ * independent InterruptTimer instances are required. A single InterruptTimer
+ * may be shared between objects which won't recursively call each other.
+ * <p>
+ * Each InterruptTimer spawns one background thread to sleep the specified time
+ * and interrupt the thread which called {@link #begin(int)}. It is up to the
+ * caller to ensure that the operations within the work block between the
+ * matched begin and end calls tests the interrupt flag (most IO operations do).
+ * <p>
+ * To terminate the background thread, use {@link #terminate()}. If the
+ * application fails to terminate the thread, it will (eventually) terminate
+ * itself when the InterruptTimer instance is garbage collected.
+ *
+ * @see TimeoutInputStream
+ */
+public final class InterruptTimer {
+	private final AlarmState state;
+
+	private final AlarmThread thread;
+
+	final AutoKiller autoKiller;
+
+	/** Create a new timer with a default thread name. */
+	public InterruptTimer() {
+		this("JGit-InterruptTimer");
+	}
+
+	/**
+	 * Create a new timer to signal on interrupt on the caller.
+	 * <p>
+	 * The timer thread is created in the calling thread's ThreadGroup.
+	 *
+	 * @param threadName
+	 *            name of the timer thread.
+	 */
+	public InterruptTimer(final String threadName) {
+		state = new AlarmState();
+		autoKiller = new AutoKiller(state);
+		thread = new AlarmThread(threadName, state);
+		thread.start();
+	}
+
+	/**
+	 * Arm the interrupt timer before entering a blocking operation.
+	 *
+	 * @param timeout
+	 *            number of milliseconds before the interrupt should trigger.
+	 *            Must be > 0.
+	 */
+	public void begin(final int timeout) {
+		if (timeout <= 0)
+			throw new IllegalArgumentException("Invalid timeout: " + timeout);
+		Thread.interrupted();
+		state.begin(timeout);
+	}
+
+	/** Disable the interrupt timer, as the operation is complete. */
+	public void end() {
+		state.end();
+	}
+
+	/** Shutdown the timer thread, and wait for it to terminate. */
+	public void terminate() {
+		state.terminate();
+		try {
+			thread.join();
+		} catch (InterruptedException e) {
+			//
+		}
+	}
+
+	static final class AlarmThread extends Thread {
+		AlarmThread(final String name, final AlarmState q) {
+			super(q);
+			setName(name);
+			setDaemon(true);
+		}
+	}
+
+	// The trick here is, the AlarmThread does not have a reference to the
+	// AutoKiller instance, only the InterruptTimer itself does. Thus when
+	// the InterruptTimer is GC'd, the AutoKiller is also unreachable and
+	// can be GC'd. When it gets finalized, it tells the AlarmThread to
+	// terminate, triggering the thread to exit gracefully.
+	//
+	private static final class AutoKiller {
+		private final AlarmState state;
+
+		AutoKiller(final AlarmState s) {
+			state = s;
+		}
+
+		@Override
+		protected void finalize() throws Throwable {
+			state.terminate();
+		}
+	}
+
+	static final class AlarmState implements Runnable {
+		private Thread callingThread;
+
+		private long deadline;
+
+		private boolean terminated;
+
+		AlarmState() {
+			callingThread = Thread.currentThread();
+		}
+
+		public synchronized void run() {
+			while (!terminated && callingThread.isAlive()) {
+				try {
+					if (0 < deadline) {
+						final long delay = deadline - now();
+						if (delay <= 0) {
+							deadline = 0;
+							callingThread.interrupt();
+						} else {
+							wait(delay);
+						}
+					} else {
+						wait(1000);
+					}
+				} catch (InterruptedException e) {
+					// Treat an interrupt as notice to examine state.
+				}
+			}
+		}
+
+		synchronized void begin(final int timeout) {
+			if (terminated)
+				throw new IllegalStateException("Timer already terminated");
+			callingThread = Thread.currentThread();
+			deadline = now() + timeout;
+			notifyAll();
+		}
+
+		synchronized void end() {
+			if (0 == deadline)
+				Thread.interrupted();
+			else
+				deadline = 0;
+			notifyAll();
+		}
+
+		synchronized void terminate() {
+			if (!terminated) {
+				deadline = 0;
+				terminated = true;
+				notifyAll();
+			}
+		}
+
+		private static long now() {
+			return System.currentTimeMillis();
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutInputStream.java b/org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutInputStream.java
new file mode 100644
index 0000000..3a321aa
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutInputStream.java
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.util.io;
+
+import java.io.FilterInputStream;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.InterruptedIOException;
+
+/** InputStream with a configurable timeout. */
+public class TimeoutInputStream extends FilterInputStream {
+	private final InterruptTimer myTimer;
+
+	private int timeout;
+
+	/**
+	 * Wrap an input stream with a timeout on all read operations.
+	 *
+	 * @param src
+	 *            base input stream (to read from). The stream must be
+	 *            interruptible (most socket streams are).
+	 * @param timer
+	 *            timer to manage the timeouts during reads.
+	 */
+	public TimeoutInputStream(final InputStream src,
+			final InterruptTimer timer) {
+		super(src);
+		myTimer = timer;
+	}
+
+	/** @return number of milliseconds before aborting a read. */
+	public int getTimeout() {
+		return timeout;
+	}
+
+	/**
+	 * @param millis
+	 *            number of milliseconds before aborting a read. Must be > 0.
+	 */
+	public void setTimeout(final int millis) {
+		if (millis < 0)
+			throw new IllegalArgumentException("Invalid timeout: " + millis);
+		timeout = millis;
+	}
+
+	@Override
+	public int read() throws IOException {
+		try {
+			beginRead();
+			return super.read();
+		} catch (InterruptedIOException e) {
+			throw readTimedOut();
+		} finally {
+			endRead();
+		}
+	}
+
+	@Override
+	public int read(byte[] buf) throws IOException {
+		return read(buf, 0, buf.length);
+	}
+
+	@Override
+	public int read(byte[] buf, int off, int cnt) throws IOException {
+		try {
+			beginRead();
+			return super.read(buf, off, cnt);
+		} catch (InterruptedIOException e) {
+			throw readTimedOut();
+		} finally {
+			endRead();
+		}
+	}
+
+	@Override
+	public long skip(long cnt) throws IOException {
+		try {
+			beginRead();
+			return super.skip(cnt);
+		} catch (InterruptedIOException e) {
+			throw readTimedOut();
+		} finally {
+			endRead();
+		}
+	}
+
+	private void beginRead() {
+		myTimer.begin(timeout);
+	}
+
+	private void endRead() {
+		myTimer.end();
+	}
+
+	private static InterruptedIOException readTimedOut() {
+		return new InterruptedIOException("Read timed out");
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutOutputStream.java
new file mode 100644
index 0000000..014cd92
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutOutputStream.java
@@ -0,0 +1,146 @@
+/*
+ * Copyright (C) 2009, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.util.io;
+
+import java.io.IOException;
+import java.io.InterruptedIOException;
+import java.io.OutputStream;
+
+/** OutputStream with a configurable timeout. */
+public class TimeoutOutputStream extends OutputStream {
+	private final OutputStream dst;
+
+	private final InterruptTimer myTimer;
+
+	private int timeout;
+
+	/**
+	 * Wrap an output stream with a timeout on all write operations.
+	 *
+	 * @param destination
+	 *            base input stream (to write to). The stream must be
+	 *            interruptible (most socket streams are).
+	 * @param timer
+	 *            timer to manage the timeouts during writes.
+	 */
+	public TimeoutOutputStream(final OutputStream destination,
+			final InterruptTimer timer) {
+		dst = destination;
+		myTimer = timer;
+	}
+
+	/** @return number of milliseconds before aborting a write. */
+	public int getTimeout() {
+		return timeout;
+	}
+
+	/**
+	 * @param millis
+	 *            number of milliseconds before aborting a write. Must be > 0.
+	 */
+	public void setTimeout(final int millis) {
+		if (millis < 0)
+			throw new IllegalArgumentException("Invalid timeout: " + millis);
+		timeout = millis;
+	}
+
+	@Override
+	public void write(int b) throws IOException {
+		try {
+			beginWrite();
+			dst.write(b);
+		} catch (InterruptedIOException e) {
+			throw writeTimedOut();
+		} finally {
+			endWrite();
+		}
+	}
+
+	@Override
+	public void write(byte[] buf) throws IOException {
+		write(buf, 0, buf.length);
+	}
+
+	@Override
+	public void write(byte[] buf, int off, int len) throws IOException {
+		try {
+			beginWrite();
+			dst.write(buf, off, len);
+		} catch (InterruptedIOException e) {
+			throw writeTimedOut();
+		} finally {
+			endWrite();
+		}
+	}
+
+	@Override
+	public void flush() throws IOException {
+		try {
+			beginWrite();
+			dst.flush();
+		} catch (InterruptedIOException e) {
+			throw writeTimedOut();
+		} finally {
+			endWrite();
+		}
+	}
+
+	@Override
+	public void close() throws IOException {
+		try {
+			beginWrite();
+			dst.close();
+		} catch (InterruptedIOException e) {
+			throw writeTimedOut();
+		} finally {
+			endWrite();
+		}
+	}
+
+	private void beginWrite() {
+		myTimer.begin(timeout);
+	}
+
+	private void endWrite() {
+		myTimer.end();
+	}
+
+	private static InterruptedIOException writeTimedOut() {
+		return new InterruptedIOException("Write timed out");
+	}
+}
-- 
1.6.3.2.416.g04d0
