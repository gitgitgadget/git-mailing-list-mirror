From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 10:47:04 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
 <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
 <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org> <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 19:48:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1h8-0003QW-JV
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 19:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbYAUSsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 13:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYAUSsA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 13:48:00 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51945 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920AbYAUSr7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 13:47:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LIl5if017700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 10:47:06 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LIl4h6014447;
	Mon, 21 Jan 2008 10:47:05 -0800
In-Reply-To: <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.224 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71307>



On Mon, 21 Jan 2008, Junio C Hamano wrote:
>
> The mtime recorded in the cache entry is not time_t anymore but
> of type (unsigned int).  This casts the comparison and also adds
> fuzz factor of 1 second.

I really don't think this is the right fix.

The real problem seems to be that the whole "racy_timestamp()" thing 
*hides* the bug, and your change actually makes racy_timestamp() just hide 
things even more (by making it trigger all the time).

Adding a "sleep 1" to your test-case (appended) actually makes it fail 
reliably (without your hack - with your "+1" hack I assume you'd need to 
make the sleep longer).

So the problem is that the test-suite actually *hid* the bug by doing 
thigns so fast that the racy code triggered, and that in turn somehow 
fixed things up. 

Will experiment more now that I have a case that reliably fails. The 
commit that causes this literally shouldn't have caused any semantic 
changes at all, so this is rather interesting.

		Linus

---
#!/bin/sh

test_description='reduced 7501'

. ./test-lib.sh

test_expect_success setup '

        >file &&
        git add file &&
        test_tick &&
        git commit -m initial

'

if test -f ../trace.log
then
        mv ../trace.log ../trace.log.old
fi

test_expect_success 'partial commit that involves removal (1)' '

        test_tick &&
        git rm --cached file &&
        mv file elif &&
	sleep 1 &&
        git add elif &&
	sleep 1 &&

        strace -v -o ../trace.log git commit -m "Partial: add elif" elif &&

        git diff-tree --name-status HEAD^ HEAD >current &&
        echo "A	elif" >expected &&
        diff expected current

'

test_done
