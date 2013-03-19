From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 09:17:32 +0100
Message-ID: <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
	<20130316114118.GA1940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Zager <szager@google.com>, <git@vger.kernel.org>,
	=?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 09:18:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHrkH-00047w-QJ
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 09:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757744Ab3CSIRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 04:17:40 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:56877 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756292Ab3CSIRg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 04:17:36 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Mar
 2013 09:17:31 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Mar 2013 09:17:32 +0100
In-Reply-To: <20130316114118.GA1940@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 16 Mar 2013 07:41:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218488>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 15, 2013 at 03:42:40PM -0700, Stefan Zager wrote:
>
>> We have uncovered a regression in this commit:
>> 
>> b8a2486f1524947f232f657e9f2ebf44e3e7a243
>> 
>> The symptom is that 'git fetch' dies with:
>> 
>> error: index-pack died of signal 10
>> fatal: index-pack failed
>> 
>> I have only been able to reproduce it on a Mac thus far; will try
>> ubuntu next.  We can make it go away by running:
>> 
>> git config pack.threads 1
>
> I couldn't reproduce the problem on Linux with the instructions you
> gave. I did try running it under valgrind and it produced:
>
>   ==2380== Conditional jump or move depends on uninitialised value(s)
>   ==2380==    at 0x441631: resolve_delta (index-pack.c:837)
>   ==2380==    by 0x4419D6: find_unresolved_deltas_1 (index-pack.c:898)
>   ==2380==    by 0x441A45: find_unresolved_deltas (index-pack.c:914)
>   ==2380==    by 0x4427CA: fix_unresolved_deltas (index-pack.c:1232)
>   ==2380==    by 0x4421F5: conclude_pack (index-pack.c:1111)
>   ==2380==    by 0x443A5C: cmd_index_pack (index-pack.c:1604)
>   ==2380==    by 0x4058A2: run_builtin (git.c:281)
>   ==2380==    by 0x405A35: handle_internal_command (git.c:443)
>   ==2380==    by 0x405C01: main (git.c:532)
>
> but the line in question is:
>
>   if (deepest_delta < delta_obj->delta_depth)
>
> And in the debugger, both of those variables appear to have sane values
> (nor should either impacted by the patch you bisected to). On top of
> that, running with pack.threads=1 produces the same error. So I think it
> may be a false positive from valgrind, and unrelated to your issue.

I find that somewhat unlikely, for two reasons: memcheck is actually
quite good at finding uninitialized memory use, it just isn't that good
at distinguishing if it makes a difference.  Most false positives are of
the "loading an entire word and discarding most of it" kind.

Second, the thread-debugging valgrind tools (drd and helgrind) also
complain about exactly this line:

DRD says:

  ==20987== Thread 4:
  ==20987== Conflicting load by thread 4 at 0x007a70d0 size 4
  ==20987==    at 0x43A783: resolve_delta (index-pack.c:837)
  ==20987==    by 0x43A94F: find_unresolved_deltas (index-pack.c:898)
  ==20987==    by 0x43B0F8: threaded_second_pass (index-pack.c:945)
  ==20987==    by 0x4C2CF60: vgDrd_thread_wrapper (drd_pthread_intercepts.c:341)
  ==20987==    by 0x542FE0D: start_thread (in /lib64/libpthread-2.15.so)
  ==20987== Allocation context: BSS section of /home/thomas/.local/bin/git
  ==20987== Other segment start (thread 2)
  ==20987==    at 0x4C30A1F: pthread_mutex_unlock (drd_pthread_intercepts.c:665)
  ==20987==    by 0x43B06E: threaded_second_pass (index-pack.c:122)
  ==20987==    by 0x4C2CF60: vgDrd_thread_wrapper (drd_pthread_intercepts.c:341)
  ==20987==    by 0x542FE0D: start_thread (in /lib64/libpthread-2.15.so)
  ==20987== Other segment end (thread 2)
  ==20987==    at 0x5436AE3: ??? (in /lib64/libpthread-2.15.so)
  ==20987==    by 0x439C76: unpack_data.constprop.8 (index-pack.c:528)
  ==20987==    by 0x439EA7: get_base_data (index-pack.c:571)
  ==20987==    by 0x43A7B4: resolve_delta (index-pack.c:841)
  ==20987==    by 0x43A94F: find_unresolved_deltas (index-pack.c:898)
  ==20987==    by 0x43B0F8: threaded_second_pass (index-pack.c:945)
  ==20987==    by 0x4C2CF60: vgDrd_thread_wrapper (drd_pthread_intercepts.c:341)
  ==20987==    by 0x542FE0D: start_thread (in /lib64/libpthread-2.15.so)


helgrind says:

  ==21160== Possible data race during read of size 4 at 0x7A70D0 by thread #3
  ==21160== Locks held: none
  ==21160==    at 0x43A783: resolve_delta (index-pack.c:837)
  ==21160==    by 0x43A94F: find_unresolved_deltas (index-pack.c:898)
  ==21160==    by 0x43B0F8: threaded_second_pass (index-pack.c:945)
  ==21160==    by 0x4C2D35D: mythread_wrapper (hg_intercepts.c:219)
  ==21160==    by 0x5424E0D: start_thread (in /lib64/libpthread-2.15.so)
  ==21160== 
  ==21160== This conflicts with a previous write of size 4 by thread #2
  ==21160== Locks held: none
  ==21160==    at 0x43A78E: resolve_delta (index-pack.c:838)
  ==21160==    by 0x43A94F: find_unresolved_deltas (index-pack.c:898)
  ==21160==    by 0x43B0F8: threaded_second_pass (index-pack.c:945)
  ==21160==    by 0x4C2D35D: mythread_wrapper (hg_intercepts.c:219)
  ==21160==    by 0x5424E0D: start_thread (in /lib64/libpthread-2.15.so)


You were apparently just lucky in catching it before it was even
initialized.

I can reproduce the above warnings with

  valgrind --tool=helgrind --trace-children=yes git index-pack <any_pack>

i.e., it does not seem to depend on the pack (sample size 3, packs
looked at were from my git.git).

Duy, what was the reasoning why resolve_delta() does not need to hold
locks when it looks when it looks at deepest_delta?  My coffee levels
aren't up to this task yet.  It certainly seems extremely dubious to me,
as the code uses the global deepest_delta in threaded sections.  You can
probably argue that the load/store is atomic on most(?) platforms, but
you get no guarantees that deepest_delta at any time in fact holds the
maximum value of delta_obj->delta_depth.


Furthermore there's another warning shown by helgrind:

  ==21160== Possible data race during write of size 4 at 0x7A7060 by thread #2
  ==21160== Locks held: 1, at address 0x7A70E0
  ==21160==    at 0x43A840: resolve_delta (index-pack.c:853)
  ==21160==    by 0x43A94F: find_unresolved_deltas (index-pack.c:898)
  ==21160==    by 0x43B0F8: threaded_second_pass (index-pack.c:945)
  ==21160==    by 0x4C2D35D: mythread_wrapper (hg_intercepts.c:219)
  ==21160==    by 0x5424E0D: start_thread (in /lib64/libpthread-2.15.so)
  ==21160== 
  ==21160== This conflicts with a previous read of size 4 by thread #3
  ==21160== Locks held: 1, at address 0x7A7080
  ==21160==    at 0x43AFC8: threaded_second_pass (index-pack.c:955)
  ==21160==    by 0x4C2D35D: mythread_wrapper (hg_intercepts.c:219)
  ==21160==    by 0x5424E0D: start_thread (in /lib64/libpthread-2.15.so)

That one really seems to be a false positive in the sense that
threaded_second_pass() doesn't really care if it gets a bad value for
nr_resolved_deltas.  The only thing that matters is that the counter
increment is done with counter_mutex held.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
