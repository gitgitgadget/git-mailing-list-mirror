From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Teach git-update-index about gitlinks
Date: Thu, 12 Apr 2007 15:59:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121550540.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704121218130.4061@woody.linux-foundation.org>
 <7vtzvli53u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc8Gh-0005K4-3H
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 00:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXDLW7r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 18:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbXDLW7r
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 18:59:47 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35927 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbXDLW7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 18:59:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CMxgIs027460
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 15:59:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CMxfGQ018957;
	Thu, 12 Apr 2007 15:59:41 -0700
In-Reply-To: <7vtzvli53u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44363>



On Thu, 12 Apr 2007, Junio C Hamano wrote:
> 
> I find the result of applying this patch much easier to read
> than the original.

Hey, that makes two of us then ;)

> > +/*
> > + * Process a regular file
> > + */
> > +static int process_file(const char *path, int len, struct stat *st)
> > +{
> > +	int pos = cache_name_pos(path, len);
> > +	struct cache_entry *ce = pos < 0 ? NULL : active_cache[pos];
> > +
> > +	if (ce && S_ISDIRLNK(ntohl(ce->ce_mode)))
> > +		return error("%s is already a gitlink, not replacing", path);
> > +
> > +	return add_one_path(ce, path, len, st);	
> > +}
> 
> I may be missing the obvious but if I have a subproject at
> "path/S" and I say "update-index path/S/Makefile", what should
> happen?  There is ISDIRLNK entry at path/S and add_one_path()
> would allow removal of "path/S" to make room for
> path/S/Makefile, when --replace is given.

Good catch. I think we should quite possibly make that be a check in 
"add_cache_entry()", along with the check_file_directory_conflict() stuff.

I don't think anything protects against it as-is.

Of course, we could do it inside builtin-update-index, but we've generally 
had the rule that "add_cache_entry()" is the thing that *enforces* any 
index consistency rules, and the callers are just doing their own sanity 
checks.

			Linus
