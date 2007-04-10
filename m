From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 07:55:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704100750290.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
 <20070410084022.GB2813@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 01:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbHmY-00024c-Pm
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 16:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbXDJO5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 10:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbXDJO5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 10:57:16 -0400
Received: from smtp.osdl.org ([65.172.181.24]:59784 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753890AbXDJO5P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 10:57:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AEtxPD012448
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 07:56:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AEtwWC009947;
	Tue, 10 Apr 2007 07:55:59 -0700
In-Reply-To: <20070410084022.GB2813@planck.djpig.de>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44146>



On Tue, 10 Apr 2007, Frank Lichtenheld wrote:

> On Mon, Apr 09, 2007 at 09:20:29PM -0700, Linus Torvalds wrote:
> > @@ -2332,6 +2333,8 @@ int index_path(unsigned char *sha1, const char *path, struct stat *st, int write
> >  				     path);
> >  		free(target);
> >  		break;
> > +	case S_IFDIR:
> > +		return resolve_gitlink_ref(path, "HEAD", sha1);
> >  	default:
> >  		return error("%s: unsupported file type", path);
> >  	}
> 
> Not that I have time right now to look up the exact context (only read
> the patch), but I would've expected a "case S_IFDIRLNK:" here?

So we have this strange (and worrying) dualism inside git: we use the same 
macros *both* for "stat data" *and* for "git-internal file modes".

So sometimes a mode is the result of a [l]stat() call like above, and then 
a gitlink is just a directory and we use S_IFDIR. And if it comes from the 
index, then it uses the internal git representation, and is S_IFDIRLNK.

I'm not very happy about it, but I'm actually most unhappy about it since 
I could imagine that the constants themselves are different on different 
OS's (eg VMS - a Unix-related OS will use the same constants for 
historical reasons).

In this particular place (index-path), we obviously not only have a stat() 
result, but more importantly, we never come here for a "normal" directory, 
since a normal directory would have been expanded into its component paths 
by the "read_directory()" logic.

So that interaction with directory expansion is somewhat non-obvious: 
normal directories are expanded recursively into the files they contain, 
while git directories end up being visible to internals as real 
directories, and are turned into gitlinks by code like the above.

		Linus
