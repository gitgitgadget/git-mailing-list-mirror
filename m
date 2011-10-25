From: Jim Meyering <jim@meyering.net>
Subject: Re: general protection faults with "git grep" version 1.7.7.1
Date: Tue, 25 Oct 2011 17:17:09 +0200
Message-ID: <87y5w9ayoa.fsf@rho.meyering.net>
References: <20111024201153.GA1647@x4.trippels.de>
	<20111024214949.GA5237@amd.home.annexia.org>
	<201110251550.22248.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Richard W.M. Jones" <rjones@redhat.com>,
	Markus Trippelsdorf <markus@trippelsdorf.de>,
	<git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 25 17:17:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIikm-0000kk-Hu
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 17:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672Ab1JYPRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 11:17:20 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:38342 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab1JYPRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 11:17:19 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 44A6CD4808F
	for <git@vger.kernel.org>; Tue, 25 Oct 2011 17:17:10 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 7615D6008E;
	Tue, 25 Oct 2011 17:17:09 +0200 (CEST)
In-Reply-To: <201110251550.22248.trast@student.ethz.ch> (Thomas Rast's message
	of "Tue, 25 Oct 2011 15:50:21 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184209>

Thomas Rast wrote:
> [Shawn, Peff, Nicolas: maybe you can say something on the
> (non)raciness of xmalloc() in parallel with read_sha1_file().  See the
> last paragraph below.]
>
> Richard W.M. Jones wrote:
>> On Mon, Oct 24, 2011 at 10:11:53PM +0200, Markus Trippelsdorf wrote:
>> > Suddenly I'm getting strange protection faults when I run "git grep" on
>> > the gcc tree:
>>
>> Jim Meyering and I are trying to chase what looks like a similar or
>> identical bug in git-grep.  We've not got much further than gdb and
>> valgrind so far, but see:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=747377
>>
>> It's slightly suspicious that this bug only started to happen with the
>> latest glibc, but that could be coincidence, or could be just that
>> glibc exposes a latent bug in git-grep.
>
> I'm tempted to write this off as a GCC bug.  If that's ok for you,
> I'll leave further investigation and communication with the GCC folks
> to you.
>
> My findings are as follows:
>
> It's easy to reproduce the behavior described in the above bug report,
> using an F16 beta install in a VM.  I gave the VM two cores, but
> didn't test what happens with only one.  By "easy" I mean I didn't
> have to do any fiddling and it crashes at least one out of two times.
>
> I looked at how git builds grep.o by saying
>
>   rm builtin/grep.o; make V=1
>
> I then modified this to give me the assembly output from the compiler
>
>   gcc -S -s builtin/grep.o -c -MF builtin/.depend/grep.o.d -MMD -MP  -g -O2 -Wall -I.  -DHAVE_PATHS_H -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS  builtin/grep.c
...
> So AFAICS, we're just unlucky to hit a GCC optimizer bug that voids
> all guarantees given on locks.

Thanks for the investigation.
Actually, isn't gcc -O2's code-motion justified?
While we *know* that those globals may be modified asynchronously,
builtin/grep.c forgot to tell gcc about that.
Once you do that (via "volatile"), gcc knows not to move things.

This patch solved the problem for me:

>From 8521b8033b8ecbff2e459f9e0070beb712b9b73d Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Tue, 25 Oct 2011 17:07:05 +0200
Subject: [PATCH] declare grep's thread-related global scalars to be
 "volatile"

This avoids heap corruption problems that would otherwise
arise when gcc -O2 moves code out of critical sections.
For details, see http://bugzilla.redhat.com/747377 and
http://thread.gmane.org/gmane.comp.version-control.git/184184/focus=184205

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin/grep.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 7d0779f..38f92de 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -64,14 +64,14 @@ struct work_item {
  */
 #define TODO_SIZE 128
 static struct work_item todo[TODO_SIZE];
-static int todo_start;
-static int todo_end;
-static int todo_done;
+static volatile int todo_start;
+static volatile int todo_end;
+static volatile int todo_done;

-/* Has all work items been added? */
-static int all_work_added;
+/* Have all work items been added? */
+static volatile int all_work_added;

-/* This lock protects all the variables above. */
+/* This lock protects all of the above variables. */
 static pthread_mutex_t grep_mutex;

 /* Used to serialize calls to read_sha1_file. */
--
1.7.7.419.g87009
