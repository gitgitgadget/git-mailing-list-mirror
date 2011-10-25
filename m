From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 15:50:21 +0200
Message-ID: <201110251550.22248.trast@student.ethz.ch>
References: <20111024201153.GA1647@x4.trippels.de> <20111024214949.GA5237@amd.home.annexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Markus Trippelsdorf <markus@trippelsdorf.de>,
	<meyering@redhat.com>, <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>
To: "Richard W.M. Jones" <rjones@redhat.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 15:50:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIhOg-00089y-MG
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 15:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933412Ab1JYNu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 09:50:26 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54208 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933347Ab1JYNuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 09:50:25 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 25 Oct
 2011 15:50:19 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.339.1; Tue, 25 Oct
 2011 15:50:23 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.6-44-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20111024214949.GA5237@amd.home.annexia.org>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184205>

[Shawn, Peff, Nicolas: maybe you can say something on the
(non)raciness of xmalloc() in parallel with read_sha1_file().  See the
last paragraph below.]

Richard W.M. Jones wrote:
> On Mon, Oct 24, 2011 at 10:11:53PM +0200, Markus Trippelsdorf wrote:
> > Suddenly I'm getting strange protection faults when I run "git grep" on
> > the gcc tree:
> 
> Jim Meyering and I are trying to chase what looks like a similar or
> identical bug in git-grep.  We've not got much further than gdb and
> valgrind so far, but see:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=747377
> 
> It's slightly suspicious that this bug only started to happen with the
> latest glibc, but that could be coincidence, or could be just that
> glibc exposes a latent bug in git-grep.

I'm tempted to write this off as a GCC bug.  If that's ok for you,
I'll leave further investigation and communication with the GCC folks
to you.

My findings are as follows:

It's easy to reproduce the behavior described in the above bug report,
using an F16 beta install in a VM.  I gave the VM two cores, but
didn't test what happens with only one.  By "easy" I mean I didn't
have to do any fiddling and it crashes at least one out of two times.

I looked at how git builds grep.o by saying

  rm builtin/grep.o; make V=1

I then modified this to give me the assembly output from the compiler

  gcc -S -s builtin/grep.o -c -MF builtin/.depend/grep.o.d -MMD -MP  -g -O2 -Wall -I.  -DHAVE_PATHS_H -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS  builtin/grep.c

and looked at the result.  To interpret the output, I would like to
remind you of the following snippets:

  #define grep_lock() pthread_mutex_lock(&grep_mutex)
  #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
...
  static struct work_item *get_work(void)
  {
          struct work_item *ret;

          grep_lock();
          while (todo_start == todo_end && !all_work_added) {
                  pthread_cond_wait(&cond_add, &grep_mutex);
          }

...
  }
...
  static void *run(void *arg)
  {
          int hit = 0;
          struct grep_opt *opt = arg;

          while (1) {
                  struct work_item *w = get_work();
...
          }
...
  }

Getting back to assembly, near the beginning of run() I see (labels
and .p2align snipped):

	.loc 1 162 0
	movl	todo_end(%rip), %ebx
	.loc 1 125 0
	movl	$grep_mutex, %edi
	call	pthread_mutex_lock
	.loc 1 126 0
	movl	todo_start(%rip), %eax
	cmpl	%ebx, %eax

I should say that I don't really know much about assembly, in
particular not enough to write two correct lines of it.  But I can't
help noticing that it moved the load of todo_end *out of* the section
where grep_mutex is locked.  And the comment near the top of the file
does say that the whole todo_* family is supposed to be protected by
that mutex.  What's extra odd is that the .loc seems to indicate that
the moved load comes from work_done() instead of get_work(), which is
an entirely separate locked section!

Un-inlining the get_work helper using __attribute__((noinline)) makes
the assembly

	movl	$grep_mutex, %edi
	call	pthread_mutex_lock
	.loc 1 127 0
	movl	todo_start(%rip), %eax
	cmpl	todo_end(%rip), %eax
	je	.L15

instead; i.e., the load is now after the lock.  (Note that line
numbers were wiggled by inserting an __attribute__ line.)  The
beginning of run() turns into exactly the same code if I instead
prohibit inlining of work_done().

So AFAICS, we're just unlucky to hit a GCC optimizer bug that voids
all guarantees given on locks.


That being said, I'm not entirely convinced that the code in
builtin/grep.c works in the face of memory pressure.  It guards
against concurrent access to read_sha1_file() with the
read_sha1_mutex, but any call to xmalloc() outside of that mutex can
still potentially invoke the try_to_free_routine.  Maybe one of the
pack experts can say whether this is safe.  (However, I implemented
locking around try_to_free_routine as a quick hack and it did not fix
the issue discussed in the bug report.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
