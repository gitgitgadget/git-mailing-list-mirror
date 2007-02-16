From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: suggested feature: someone mails me a blob, git please tell me
 what it is
Date: Fri, 16 Feb 2007 09:37:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702160930130.20368@woody.linux-foundation.org>
References: <3c6c07c20702160823j316c52f4pe4cf5ca8a882e194@mail.gmail.com>
 <vpqr6sq58j8.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 16 18:38:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI72S-0003q5-Ug
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 18:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946021AbXBPRiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 12:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946023AbXBPRiL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 12:38:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55239 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946021AbXBPRiK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 12:38:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1GHbthB032735
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Feb 2007 09:37:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1GHbt8t004935;
	Fri, 16 Feb 2007 09:37:55 -0800
In-Reply-To: <vpqr6sq58j8.fsf@olympe.imag.fr>
X-Spam-Status: No, hits=-0.442 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39933>



On Fri, 16 Feb 2007, Matthieu Moy wrote:
> 
> But it should be possible to recompute the git sha1sum by recomputing
> the magic formula sha1sum(<ascii type without space> + <space> +
> <ascii decimal size> + <byte\0> + <binary object data>).

Yes. Try this:

	[torvalds@woody git]$ ls -l Makefile
	-rw-rw-rw- 1 torvalds torvalds 27586 Feb 14 13:35 Makefile
	[torvalds@woody git]$ ( echo -en "blob 27586\0" ; cat Makefile ) | sha1sum
	ebecbbd9c28390654ed9fea2ff4ebf6a5a317c70  -

	[torvalds@woody git]$ git ls-tree HEAD Makefile
	100644 blob ebecbbd9c28390654ed9fea2ff4ebf6a5a317c70    Makefile

and notice how the SHA1's match (ebecbb..).

Now, finding all of the copies of that particular object in history is 
pretty expensive. You'll basically have to do something like

	git rev-list --all |
		while read i
		do
			files=$(git ls-tree -r $i | grep $SHA1)
			if [ -n "$files" ]
			then
				git cat-file -p $i
				echo $files
				echo
			fi
		done

which is quite expensive. You can probably start from "git fsck" and ask 
it to print out where it found something (but then it will print out only 
the first time it found it - because it avoids walking trees more than 
once it won't report on it unless if finds it in two trees that are 
different).

			Linus
