From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Btrfs-devel] btrfs and git-reflog
Date: Sat, 26 Jan 2008 23:22:32 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801262314360.3222@www.l.google.com>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org> <200801251050.16697.chris.mason@oracle.com> <alpine.LFD.1.00.0801250905570.14161@hp.linux-foundation.org> <7vmyqt657t.fsf@gitster.siamese.dyndns.org> <7v7ihx2fdb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Mason <chris.mason@oracle.com>, btrfs-devel@oss.oracle.com,
	Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 08:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJ1ra-0008KI-JN
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 08:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbYA0HXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 02:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbYA0HXD
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 02:23:03 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39217 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751128AbYA0HXB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2008 02:23:01 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0R7MZXN002871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 Jan 2008 23:22:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0R7MW8W002823;
	Sat, 26 Jan 2008 23:22:33 -0800
X-X-Sender: torvalds@www.l.google.com
In-Reply-To: <7v7ihx2fdb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.221 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71807>



On Fri, 25 Jan 2008, Junio C Hamano wrote:
> 
> * builtin-prune-packed.c::prune_dir() loops and unlinks (some
>   of) returned paths while in the loop.  This should not
>   interfere with readdir(3).

Correct. The "loop and unlink" behaviour is common and accepted practice, 
and is, for example, what things like "rm -rf" tend to do. 

It's only newly created files that may or may not show up in readdir() 
after they've been created, regardless of whether they were created under 
a name that was previously existed.

>   I am presuming that we can declare
>   readdir(3) implementation buggy if this happens:
> 
> 	* opendir();
> 	* readdir() gives $P;
>         * unlink($P);
>         * readdir() later gives $P again.

Yes, but the potential problem is actually very different:

 - directory contains 'a', 'b' and 'c'

	* opendir()
	* readdir() returns 'a'
	  * unlink('a');
	* readdir() returns 'c', having skipped 'b'.

This is something that could in theory happen if a directory is indexed 
using the *position* of a filename in a directory. 'a' was position 1, 'b' 
was position 2, and 'c' was position 3. After the first readdir(), the 
file position was 2 (pointing at 'b'), but when we removed 'a', the other 
entries positions moved down, and now 'b' is at position 1, and 'c' is at 
position '2'. When we call readdir() the next time, it skips 'b' (because 
it already returned position 1!), and returns 'c'.

See? It's basically the issue of removing an entry in a linked list. And 
yes, we've actually had bugs like that in our in-memory tmpfs. But they 
were bugs, and they got fixed, and that's not how readdir() is supposed to 
work, exactly because it makes doing an "rm -rf" very hard.

So readdir() should basically be safe wrt 'unlink()' happening while the 
readdir() is running, and the only entry that can disappear is the one 
that is unlinekd.

So don't worry about unlink's, it's only new files being created in the 
same directory that can be problematic in that you don't know if 
readdir() will return them or not..

		Linus
