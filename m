From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/3] Avoid using 'lstat()' to figure out directories
Date: Thu, 9 Jul 2009 16:26:19 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907091626080.3352@localhost.localdomain>
References: <20090707000500.GA5594@dpotapov.dyndns.org> <alpine.LFD.2.01.0907081902371.3352@localhost.localdomain> <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907091011280.3352@localhost.localdomain> <alpine.LFD.2.01.0907091013540.3352@localhost.localdomain> <7vab3d3dpc.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907091153130.3352@localhost.localdomain> <alpine.LFD.2.01.0907091344340.3352@localhost.localdomain>
 <4A5670F3.9020309@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 01:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP325-0005XO-JY
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 01:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbZGIX1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 19:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZGIX1I
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 19:27:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39582 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751616AbZGIX1H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 19:27:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69NQKdB029739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 9 Jul 2009 16:26:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n69NQJCP028251;
	Thu, 9 Jul 2009 16:26:19 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A5670F3.9020309@gnu.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.966 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123019>


On Fri, 10 Jul 2009, Paolo Bonzini wrote:
> 
> I'm not much worried about accessing foo-0001, foo-0002, foo-0003 while 
> looking for foo/a (that would be O(number of files in a directory), 
> which is bearable), but risking to go down a huge subtree is not very 
> nice.

That sounds rather unlikely, and the thing is, even if it were to happen, 
it really wouldn't be that slow. Our data structures are pretty efficient, 
and it wouldn't be _that_ slow to traverse them.

That said, I don't love that loop. It would be better to do that whole 
cache_name_pos() call with the '/' simply appended to the path, and then 
we'd do the binary search directly to the first entry.

Of course, since 'path' is a 'const char *', we'd need to either do a 
silly copy, or we'd need to change a whole lot of the code to make it 
clear that we can actually add a slash to the end (which we can: I think 
it's already always going to be an array that we _will_ add a slash to in 
case it turns out to be a directory).

So there's definitely room for improvement there. I just think that the 
improvement isn't the patch you suggest.

			Linus
