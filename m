From: Rich Felker <dalias@aerifal.cx>
Subject: [PATCH] Ensure sufficient stack space for async threads
Date: Mon, 23 Apr 2012 21:55:23 -0400
Message-ID: <20120424015523.GA15287@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 04:07:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMVAJ-0004AX-Eq
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 04:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab2DXCHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 22:07:35 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:48881 "EHLO
	brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab2DXCHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 22:07:34 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2012 22:07:34 EDT
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
	id 1SMUyR-0004BK-00
	for git@vger.kernel.org; Tue, 24 Apr 2012 01:55:23 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196177>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The recv_sideband function, which runs in a non-main thread, makes use
of a 64k buffer on the stack. While Linux/glibc systems default to
huge thread stack size (typically 2-10 MB), it's not portable to
assume that the stack for a newly created thread will be able to
support large automatic buffers unless you specifically request space
when creating the thread. The attached patch ensures that at least
128k of stack space is available; certainly that could be increased if
it's deemed safer.

Does this actually matter? Well, the default build of git crashes on
musl libc (www.etalabs.net/musl), where the default stack size is 16k.
We're presently in the process of evaluating what's a good default
stack size for musl to give applications that don't request one
(aiming for a balance that avoids breaking programs like git but also
avoids excess memory usage on tiny embedded systems, a major target
for us) and we'll almost certainly increase the default enough that
the current version of git works without explicitly requesting a stack
size. Nonetheless, this could be an issue again in the future when
running/using git on mobile/embedded-type targets (anybody know
Bionic's default?), and since the patch is simple and has essentially
no cost, I think it's worthwhile to include.

If you have questions please include me in the Cc as I'm not
subscribed.

Rich

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git_pthread_stacksize.diff"

--- run-command.c.orig
+++ run-command.c
@@ -637,11 +637,19 @@
 	async->proc_in = proc_in;
 	async->proc_out = proc_out;
 	{
-		int err = pthread_create(&async->tid, NULL, run_thread, async);
+		int err;
+		pthread_attr_t attr;
+		size_t stacksize;
+		pthread_attr_init(&attr);
+		pthread_attr_getstacksize(&attr, &stacksize);
+		if (stacksize < 131072) stacksize = 131072;
+		pthread_attr_setstacksize(&attr, stacksize);
+		err = pthread_create(&async->tid, &attr, run_thread, async);
 		if (err) {
 			error("cannot create thread: %s", strerror(err));
 			goto error;
 		}
+		pthread_attr_destroy(&attr);
 	}
 #endif
 	return 0;

--tThc/1wpZn/ma/RB--
