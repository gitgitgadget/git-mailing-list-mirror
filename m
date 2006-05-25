From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-format-patch possible regressions
Date: Thu, 25 May 2006 12:43:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605251233300.5623@g5.osdl.org>
References: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 21:43:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjLkK-00083b-KX
	for gcvg-git@gmane.org; Thu, 25 May 2006 21:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWEYTnf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 15:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWEYTne
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 15:43:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20164 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030374AbWEYTnd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 15:43:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4PJhU2g001656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 May 2006 12:43:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4PJhTu0004979;
	Thu, 25 May 2006 12:43:29 -0700
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550605251223g2cf8cfb9vfa18d016b369188d@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20756>



On Thu, 25 May 2006, Marco Costalba wrote:
> 
> 2) Unhandled ranges list
> 
> $ git-format-patch -s HEAD^..HEAD HEAD^^..HEAD^

You _really_ shouldn't use this "mix two ranges" format.

It may have "worked" before, but it
 - worked differently from all other git ranges
 - it was really an implementation detail (handling each argument 
   separately)

The "x..y" format is defined to mean the same thing "y ^x", and that means 
that "HEAD^..HEAD HEAD^^..HEAD^" really does mean the same thing as 
"^HEAD^ ^HEAD^^ HEAD HEAD^", which in turn means the same thing as "^HEAD^ 
HEAD" from a reachability standpoint (since HEAD^ is by definition 
reachable from HEAD, adding it won't change the revision list, and the 
same goes for ^HEAD^^ vs ^HEAD^).

So thus "HEAD^..HEAD HEAD^^..HEAD^" really _is_ the same thing as 
"HEAD^..HEAD", and any tool that thought otherwise was just being 
very confused.

Now, we could choose to try to make "a..b" mean something else (ie make 
the "^a" part only meaningful for that particular "sub-query"), and yes, 
in many ways that would be a more intuitive thing, but it's not how git 
revision descriptions work currently, and if we make that change we should 
do it across the board.

(It's not an easy change to make, but it should be possible by having 
multiple separate NECESSARY/UNNECESSARY bits, and make the revision 
walking logic a whole lot more complicated than it already is).

So I'd argue that you should really do something like

	( git-rev-list a..b ; git-rev-list c..d ) |
		git-format-patch --stdin

in qgit if you want the ranges to be truly independent.

(And no, I don't think git-format-patch takes a "--stdin" argument, but it 
might not be unreasonable to add it as a generic revision walking 
argument for scripting like this).

			Linus
