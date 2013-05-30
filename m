From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Thu, 30 May 2013 11:47:14 +0200
Message-ID: <87bo7slrz1.fsf@linux-k42r.v.cablecom.net>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 11:47:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhzS6-0004Tv-Tl
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 11:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307Ab3E3JrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 05:47:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:27015 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968065Ab3E3JrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 05:47:17 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 30 May
 2013 11:47:13 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 30 May 2013 11:47:14 +0200
In-Reply-To: <7va9ndqqyf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 29 May 2013 16:58:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225950>

Junio C Hamano <gitster@pobox.com> writes:

> * rr/die-on-missing-upstream (2013-05-22) 2 commits
>  - sha1_name: fix error message for @{<N>}, @{<date>}
>  - sha1_name: fix error message for @{u}
>
>  When a reflog notation is used for implicit "current branch", we
>  did not say which branch and worse said "branch ''".
>
>  Will merge to 'next'.

This interacts with the tests from

> * fc/at-head (2013-05-08) 13 commits

to fail valgrind in t1508 like so:

  ==22927== Invalid read of size 1
  ==22927==    at 0x4C2C71B: __GI_strnlen (mc_replace_strmem.c:377)
  ==22927==    by 0x567FF6B: vfprintf (in /lib64/libc-2.17.so)
  ==22927==    by 0x56AC194: vsnprintf (in /lib64/libc-2.17.so)
  ==22927==    by 0x4EAC39: vreportf (usage.c:12)
  ==22927==    by 0x4EACA4: die_builtin (usage.c:36)
  ==22927==    by 0x4EAEE0: die (usage.c:103)
  ==22927==    by 0x4D8C51: get_sha1_1 (sha1_name.c:542)
  ==22927==    by 0x4D8E5D: get_sha1_with_context_1 (sha1_name.c:1299)
  ==22927==    by 0x4D992A: get_sha1_with_context (sha1_name.c:1417)
  ==22927==    by 0x4D99E1: get_sha1 (sha1_name.c:1124)
  ==22927==    by 0x45E1AC: cmd_rev_parse (rev-parse.c:761)
  ==22927==    by 0x4051B3: handle_internal_command (git.c:284)
  ==22927==  Address 0x5bebccb is 11 bytes inside a block of size 22 free'd
  ==22927==    at 0x4C2ACDA: free (vg_replace_malloc.c:468)
  ==22927==    by 0x4D8C37: get_sha1_1 (sha1_name.c:541)
  ==22927==    by 0x4D8E5D: get_sha1_with_context_1 (sha1_name.c:1299)
  ==22927==    by 0x4D992A: get_sha1_with_context (sha1_name.c:1417)
  ==22927==    by 0x4D99E1: get_sha1 (sha1_name.c:1124)
  ==22927==    by 0x45E1AC: cmd_rev_parse (rev-parse.c:761)
  ==22927==    by 0x4051B3: handle_internal_command (git.c:284)
  ==22927==    by 0x4053E7: main (git.c:492)

I think it's enough to squash this little change; leaking some memory
immediately before die() is not too bad, especially if we're going to
pass real_ref+11 into die()...

diff --git i/sha1_name.c w/sha1_name.c
index 5ea16ff..a07558d 100644
--- i/sha1_name.c
+++ w/sha1_name.c
@@ -538,7 +538,6 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 					"back to %s.", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
 			else {
-				free(real_ref);
 				die("Log for '%.*s' only has %d entries.",
 				    len, str, co_cnt);
 			}


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
