From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v3 13/22] resolve_ref(): turn buffer into a proper string as soon as possible
Date: Fri, 23 Sep 2011 10:17:55 +0200
Message-ID: <201109231017.55996.trast@student.ethz.ch>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu> <1316121043-29367-14-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	<cmn@elego.de>, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 23 10:18:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R70xR-0003Kw-TN
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 10:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab1IWISA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 04:18:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:19789 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab1IWIR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 04:17:57 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 23 Sep
 2011 10:17:55 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 23 Sep
 2011 10:17:55 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1316121043-29367-14-git-send-email-mhagger@alum.mit.edu>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181949>

Hi Michael

Michael Haggerty wrote:
> Immediately strip off trailing spaces and null-terminate the string
> holding the contents of the reference file; this allows the use of
> string functions and avoids the need to keep separate track of the
> string's length.  (get_sha1_hex() fails automatically if the string is
> too short.)
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

I'm getting valgrind failures in t1450-fsck and t3800-mktag which
blame to this commit.  For t1450 it looks as follows:

    ok 5 - object with bad sha1

    expecting success: 
            git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
            test_when_finished "git update-ref -d refs/heads/invalid" &&
            git fsck 2>out &&
            cat out &&
            grep "not a commit" out

    ==19623== Use of uninitialised value of size 8
    ==19623==    at 0x4B6747: hexval (cache.h:798)
    ==19623==    by 0x4B6797: get_sha1_hex (hex.c:42)
    ==19623==    by 0x4DD12A: resolve_ref (refs.c:588)
    ==19623==    by 0x4DC777: get_ref_dir (refs.c:313)
    ==19623==    by 0x4DC6FA: get_ref_dir (refs.c:302)
    ==19623==    by 0x4DC963: get_loose_refs (refs.c:368)
    ==19623==    by 0x4DD556: do_for_each_ref (refs.c:687)
    ==19623==    by 0x4DDA05: for_each_replace_ref (refs.c:806)
    ==19623==    by 0x4E5CE9: prepare_replace_object (replace_object.c:86)
    ==19623==    by 0x4E5D3C: do_lookup_replace_object (replace_object.c:103)
    ==19623==    by 0x4C99BB: lookup_replace_object (cache.h:764)
    ==19623==    by 0x4C9FA6: parse_object (object.c:191)
    ==19623==  Uninitialised value was created by a stack allocation
    ==19623==    at 0x4DCE34: resolve_ref (refs.c:498)

or when I run it at the tip of pu instead of at the commit itself,
line numbers are like so:

    ==2308== Use of uninitialised value of size 8
    ==2308==    at 0x4ADB8B: get_sha1_hex (cache.h:800)
    ==2308==    by 0x4D4283: resolve_ref (refs.c:629)
    ==2308==    by 0x4D4851: get_ref_dir (refs.c:361)
    ==2308==    by 0x4D48C6: get_ref_dir (refs.c:350)
    ==2308==    by 0x4D4D29: do_for_each_ref (refs.c:412)
    ==2308==    by 0x4DCD93: do_lookup_replace_object (replace_object.c:86)
    ==2308==    by 0x4C31F4: parse_object (cache.h:764)
    ==2308==    by 0x4F2A1D: get_sha1_1 (sha1_name.c:567)
    ==2308==    by 0x4F2D5F: get_sha1_with_context_1 (sha1_name.c:1117)
    ==2308==    by 0x4F3543: get_sha1 (cache.h:822)
    ==2308==    by 0x461B50: cmd_rev_parse (rev-parse.c:723)
    ==2308==    by 0x404B71: run_builtin (git.c:308)
    ==2308==  Uninitialised value was created by a stack allocation
    ==2308==    at 0x4D4006: resolve_ref (refs.c:530)

Can you look into this?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
