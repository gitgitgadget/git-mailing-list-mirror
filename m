From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: three-way diff performance problem
Date: Tue, 21 Jul 2009 14:01:03 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907211349570.19335@localhost.localdomain>
References: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain> <7v7hy1g7vg.fsf@alter.siamese.dyndns.org> <7vd47tes2y.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907211324220.19335@localhost.localdomain>
 <7vd47tbw7q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 23:01:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTMSf-00008B-KS
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 23:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbZGUVBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 17:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbZGUVBJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 17:01:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41467 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755655AbZGUVBI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 17:01:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LL13On031945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Jul 2009 14:01:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LL13W0004078;
	Tue, 21 Jul 2009 14:01:03 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vd47tbw7q.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123719>



On Tue, 21 Jul 2009, Junio C Hamano wrote:
> 
> I know why.  The conversion was wrong.  The original found the last_one
> that was from the parent we are looking at, and when there is such, it
> started the scan from the one _after that_.  Otherwise, if lost_head list
> had an entry
> 
> 	@@ -l,k +m,n @@
>         -one
>          two
>          three
> 
> and the diff with the parent we are currently looking at duplicates
> removal:
> 
> 	@@ -l,k +m1,n1 @@
> 	-one
>         -one
>          two
>          three
> 
> we will end up losing the second removal, which would be what is happening
> with the patch you tried.

Ok, that matches what I saw. Doing a 'diff' between the outputs showed 
missing lines from the result with your first patch.

> I actually was scratching my head wondering why it wasn't happening in the
> original code after I sent that faulty patch.
> 
> Here is another attempt.

Yup. This attempt now generates output that matches the original one (in 
44s), while at the same time still handling the previously very expensive 
case quickly (1.4s).

So it looks good now from my testing - I'm not going to say anything else 
about the patch, since I'm not all that familiar with the code itself.

Btw, the 'perf report' on the fixed build now says

    89.67%               git  /home/torvalds/git/git     [.] xdl_prepare_env
     6.42%               git  /home/torvalds/git/git     [.] xdl_recs_cmp
     0.92%               git  [kernel]                   [k] hpet_next_event
     0.52%               git  /home/torvalds/git/git     [.] xdl_prepare_ctx
     0.44%               git  /lib64/libz.so.1.2.3       [.] inflate_fast
     0.29%               git  /home/torvalds/git/git     [.] xdl_hash_record
     0.27%               git  /lib64/libc-2.10.1.so      [.] __GI_memcmp
     0.26%               git  /home/torvalds/git/git     [.] show_patch_diff
     0.14%               git  [kernel]                   [k] _spin_lock
     0.09%               git  [kernel]                   [k] clear_page_c
     0.09%               git  /lib64/libz.so.1.2.3       [.] adler32

so now the expensive part is xdl_prepare_env. And that does actually make 
sense: it's the code that generates all the hash records for the lines to 
be compared, so there doesn't seem to be anything hugely wrong with it. If 
there are a lot of identical lines, I'd expect that to be fairly 
expensive.

			Linus
