From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Wed, 28 Feb 2007 11:22:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702281104230.12485@woody.linux-foundation.org>
References: <17892.64236.443170.43061@lisa.zopyra.com> <20070228035713.GC5597@spearce.org>
 <20070228044719.GA6068@spearce.org> <17893.40847.313519.283218@lisa.zopyra.com>
 <17893.42063.186763.291346@lisa.zopyra.com> <20070228155412.GC5479@spearce.org>
 <17893.43522.511785.121778@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280830030.12485@woody.linux-foundation.org>
 <17893.44936.525606.74693@lisa.zopyra.com> <Pine.LNX.4.64.0702280843030.12485@woody.linux-foundation.org>
 <17893.45903.748382.298137@lisa.zopyra.com>
 <Pine.LNX.4.64.0702280910330.12485@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702281315480.29426@xanadu.home>
 <Pine.LNX.4.64.0702281031490.12485@woody.linux-foundation.org>
 <17893.53091.452962.414271@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:29:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUUF-00037J-Uf
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbXB1T3K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbXB1T3K
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:29:10 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60915 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932408AbXB1T3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:29:09 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1SJT8L08503;
	Wed, 28 Feb 2007 13:29:08 -0600
In-Reply-To: <17893.53091.452962.414271@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.439 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
X-SpamBouncer: 2.0 (09/30/05)
X-SBScore: 0 (Spam Threshold: 20) (Block Threshold: 5)
X-SBClass: OK
X-Folder: Default
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40994>

[Bill Lear: I'm resending this to the git list --- I did not want to
publicize my trace output, so I have trimmed that.  Below are Linus's
words.]

Ok, thanks. I'm going to be away for the next 24 hours, so won't be able 
to look at it any closer, but hopefully nico or shawn will have found it 
by then, or it will have resolved to a real NFS bug.

I did a very *quick* thing (the pread that fails is in process 28635, so I 
looked at just that one), and the IO patterns are:

	28635 open("/austin/users/blear/repos/git/fusion/objects/pack_pYGHgc", O_RDWR|O_CREAT|O_EXCL, 0600 <unfinished ...>
	28635 <... open resumed> )              = 3
	28635 read(0,  <unfinished ...>
	28635 <... read resumed> "PACK\0\0\0\2\0\0\21\362\236\17x\332\235\313AjC!\20\200"..., 4096) = 4096
	28635 write(3, "PACK\0\0\0\2\0\0\21\362\236\17x\332\235\313AjC!\20\200"..., 4096 <unfinished ...>
	28635 <... write resumed> )             = 4096
	28635 read(0,  <unfinished ...>
	28635 <... read resumed> "\300\355i\31\204\330\343\205\365\365m\177\277\232\1\352"..., 4096) = 4096
	28635 write(3, "\300\355i\31\204\330\343\205\365\365m\177\277\232\1\352"..., 4096 <unfinished ...>
	28635 <... write resumed> )             = 4096
	28635 read(0,  <unfinished ...>
	28635 <... read resumed> "\247h\264\217\23\23\232,\242a\202\1\317\276\354M\335\361"..., 4096) = 4096
	28635 write(3, "\247h\264\217\23\23\232,\242a\202\1\317\276\354M\335\361"..., 4096) = 4096
	...

(so yes, it seems to write the whole pack-file).

The only odd part is at the end of that sequence:

	...
	28635 read(0,  <unfinished ...>
	28635 <... read resumed> "\324/\356{Jc\277\251\20\f\375\210\347\271{m\222D\203S\t"..., 4096) = 3492
	28635 write(3, "\324/\356{Jc\277\251\20\f\375\210\347\271{m\222D\203S\t"..., 3492 <unfinished ...>
	28635 <... write resumed> )             = 3492
	28635 read(0,  <unfinished ...>
	28635 <... read resumed> "\0349[:\')\30\352O\325\244\244[\17\342\251hL\233m", 4096) = 20
	28635 write(3, "\34", 1 <unfinished ...>
	28635 <... write resumed> )             = 1

(I skipped the writes to fd 2, which are just the "99% (4549/4594) done" 
kind of messages). The strange thing here is that I think the last 20 
bytes we read from fd 0 is the SHA1 of the whole pack-file, but then the 
last *write* to the output pack-file is just a single-byte (\34), which is 
just the first byte of the SHA1 we got. Maybe.

Regardless, we did a *lot* of writes to fd 3, yet then we get:

	...
	28635 pread(3,  <unfinished ...>
	28635 <... pread resumed> "", 207, 39395) = 0
	28635 --- SIGALRM (Alarm clock) @ 0 (0) ---
	28635 rt_sigreturn(0xe)                 = 0
	28635 lseek(3, 0, SEEK_END)             = 0
	28635 write(2, "fatal: ", 7)            = 7
	28635 write(2, "cannot pread pack file: Success "..., 59) = 59
	28635 write(2, "\n", 1)                 = 1

which really *does* seem like a NFS bug: the pread() seems to return 0, 
and yes there is a SIGALRM going off that may be the cause of that return. 
HOWEVER, the

	lseek(3, 0, SEEK_END) = 0

also seems to indicate that somehow all the writes to fd 3 were dropped or 
ignored, which makes me wonder whether the SIGALRM was involved after all 
(because it shouldn't have affected the end result of the lseek anyway).

I'm confused. But I need to go now, so I can't look at it any more.

		Linus
