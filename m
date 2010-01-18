From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] grep: don't segfault
Date: Mon, 18 Jan 2010 14:40:07 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001181433240.13231@localhost.localdomain>
References: <871vhnhydg.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 23:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX0Gs-0005uU-Du
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 23:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab0ARWkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 17:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229Ab0ARWkN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 17:40:13 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36976 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752805Ab0ARWkM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 17:40:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0IMe7rY020498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Jan 2010 14:40:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0IMe723008721;
	Mon, 18 Jan 2010 14:40:07 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <871vhnhydg.fsf@meyering.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.449 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137409>



On Mon, 18 Jan 2010, Jim Meyering wrote:
> 
> 	sz = xsize_t(st.st_size);
> 	i = open(filename, O_RDONLY);
> 	if (i < 0)
> 		goto err_ret;
> 	data = xmalloc(sz + 1);
> 	if (st.st_size != read_in_full(i, data, sz)) {
> 		error("'%s': short read %s", filename, strerror(errno));
> 		close(i);
> 		free(data);
> 		return 0;
> 	}
> 	close(i);
> >>>     data[sz] = 0;    <======  added line

Heh. Fredrik's threaded grep patch also fixed this, although he did the 
"data[*sz] = 0;" up front.

So an obvious ack on the whole thing (the xmalloc() itself makes it 
obvious that that thing should be NULL-terminated).

That said, I also suspect that we have a _lot_ of these patterns, and I 
wonder if we should just add a 

	void *read_file(int fd, struct stat *st);

helper function, which reads a file and NULL-terminates it. Doing a

	git grep -5 read_in_full

on the git sources, and it looks like there are several cases that 
basically do that xmalloc+read_in_full+error handling pattern.

		Linus
