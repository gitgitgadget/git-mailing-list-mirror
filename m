From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Wed, 18 Jul 2007 16:40:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181628270.27353@woody.linux-foundation.org>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site>
 <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
 <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
 <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 01:46:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBJDz-0003g2-Rd
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937644AbXGRXqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 19:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937733AbXGRXqY
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:46:24 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50959 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937644AbXGRXqV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 19:46:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6INecaQ013908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 16:40:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6INeWRe002854;
	Wed, 18 Jul 2007 16:40:33 -0700
In-Reply-To: <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.173 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52913>



On Wed, 18 Jul 2007, Linus Torvalds wrote:
>
> +		if (!S_ISDIR(st->st_mode))
> +			return -1;
> +		ce->ce_mode = htonl(S_IFDIR);
> +		pretend_sha1_file(NULL, 0, OBJ_TREE, ce->sha1);

Oh, one word of warning: that whole "pretend_sha1_file()" thing won't 
create the object itself, and when I did the limited testing that I did, I 
actually made sure had a magic zero-sized tree object in my object 
directory.

If you don't, some things will complain, because they end up getting a 
SHA1 that they cannot look up, becasue *they* didn't create that pretend 
entry.

I didn't know which way I wanted to go with that thing. I was kind of 
thinking that maybe we would just have the zero-sized OBJ_BLOB and 
OBJ_TREE objects as special magical things, and have all git programs just 
do that "pretend" at the beginning.

But that kind of thing is probably just a totally unnecessary special 
case, and instead, that "pretend_sha1_file()" should have just been a

	write_sha1_file(NULL, 0, "tree", ce->sha1);

instead.

Anyway, if there are issues with not finding an object called 
4b825dc642cb6eb9a060e54bf8d69288fbee4904, then that's the empty tree 
object, and that pretend thing was the cause.

(The git repo itself has the empty tree as an object in it, because one of 
the commits has that - probably as a result of a bug, but there you have 
it)

		Linus
