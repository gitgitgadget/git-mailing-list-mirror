From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 6 Sep 2006 16:56:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609061651500.27779@g5.osdl.org>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
 <44FF5C27.2040300@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 01:56:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7Ff-00010z-P8
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 01:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWIFX4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 19:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWIFX4M
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 19:56:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030262AbWIFX4K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Sep 2006 19:56:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k86Nu6nW002485
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 6 Sep 2006 16:56:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k86Nu5mW032397;
	Wed, 6 Sep 2006 16:56:06 -0700
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <44FF5C27.2040300@gmail.com>
X-Spam-Status: No, hits=-0.508 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.146 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26572>



On Wed, 6 Sep 2006, A Large Angry SCM wrote:

> Jon Smirl wrote:
> > On 9/6/06, A Large Angry SCM <gitzilla@gmail.com> wrote:
> >> TREE objects do not delta or deflate well.
> > 
> > I can understand why they don't deflate, the path names are pretty
> > much unique and the sha1s are incompressible. By why don't they delta
> > well? Does sorting them by size mess up the delta process?
> 
> My guess would be the TREEs would only delta well against other TREE
> versions for the same path.

That's what you'd normally have in a real project, though. I wonder if 
your "pack mashup" lost the normal behaviour: we very much sort trees 
together normally, thanks to the "sort-by-filename, then by size" 
behaviour that git-pack-objects should have (for trees, the size normally 
shouldn't change, so the sorting should basically boil down to "sort the 
same directory together, keeping the ordering it had from git-rev-list").

Btw, that "keeping the ordering it had" part I'm not convinced we actually 
enforce. That would depend on the sort algorithm used by "qsort()", I 
think. So there might be room for improvement there in order to keep 
things in recency order.

> Just looking at the structures in non-BLOBS, I see a lot of potential
> for the use of a set dictionaries when deflating TREEs and another set
> of dictionaries when deflating COMMITs and TAGs. The low hanging fruit
> is to create dictionaries of the most referenced IDs across all TREE or
> COMMIT/TAG objects.

Is there any way to get zlib to just generate a suggested dictionary from 
a given set of input?

		Linus
