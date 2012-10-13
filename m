From: "Lauri Alanko" <la@iki.fi>
Subject: Re: A design for subrepositories
Date: Sun, 14 Oct 2012 00:23:04 +0300
Message-ID: <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
	<7vd30m2sbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; DelSp="Yes"; format="flowed"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 13 23:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN9B7-0001MU-LK
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 23:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab2JMVXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 17:23:15 -0400
Received: from smtp-rs1-vallila2.fe.helsinki.fi ([128.214.173.75]:44390 "EHLO
	smtp-rs1-vallila2.fe.helsinki.fi" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754132Ab2JMVXO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 17:23:14 -0400
Received: from webmail.helsinki.fi (webmail1-vallila2.fe.helsinki.fi [128.214.173.135])
	by smtp-rs1.it.helsinki.fi (8.14.4/8.14.4) with ESMTP id q9DLN5hD012929;
	Sun, 14 Oct 2012 00:23:05 +0300
Received: from scan-proxy1-1.it.helsinki.fi (scan-proxy1-1.it.helsinki.fi
	[128.214.2.137]) by webmail.helsinki.fi (Horde Framework) with HTTP; Sun,
	14 Oct 2012 00:23:04 +0300
In-Reply-To: <7vd30m2sbr.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.2.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207578>

Quoting "Junio C Hamano" <gitster@pobox.com>:
> Now
> the subdirectory repositories are bound as submodules of the top
> level directory just fine.

This is indeed possible, but with some serious caveats.

Firstly, if you simply do "git submodule add ./foo" (the obligatory  
"./" being quite an unobvious pitfall), you get something quite  
fragile, since now we have submodule.foo.url = ./foo. If the  
submodules ever get reorganized and foo is moved to ./bar, then it is  
impossible to check out older versions or alternate branches, since  
the submodule is no longer where it is expected to be at the origin.

A more robust solution is to use submodule.foo.url =  
./.git/modules/foo, since logical name of a module doesn't change.  
This seems quite kludgy, though, and this cannot be how git-submodule  
is supposed to be used.

But still, "git submodule update" only looks at the modules in the  
currently checked-out tree. If we have other branches or old tags that  
refer to other submodules, there's no simple way to fetch those, too.  
And there is not even such a concept as a bare repository with modules.

So git-submodule is fundamentally a tool to attach repositories into a  
tree, not to attach repositories into a repository. That's why it's  
not really fit for my purposes.

The core problem is that to clone an entire repository and all its  
submodules, there needs to be a way to list them all remotely. But the  
git protocol doesn't just allow us to list the subdirectories under  
.git/modules. Still, there are several ways to do this:

* Just read .gitmodules in every ref and find by brute force every  
submodule referred to even by a single ref. This doesn't really scale.

* Maintain a list of all the submodules in a repository. This would  
have to be in a separate metadata branch, and would get rather hairy  
when we need to merge from a remote that has added other submodules.

* Represent the submodules as refs instead of independent  
repositories. This is my proposal for subrepositories.

However, I feel that all of these are too drastic changes to make in  
git-submodule, given that it is already well-established.

The minor problems, like lack of active branch tracking and multiple  
mount points of a module, could in principle be fixed in  
git-submodule. But again, I have no fondness for complex shell  
programming. Perhaps it was justified when the only interface to git's  
functionality were the command-line tools, but nowadays there are  
various ways to manipulate git repositories from real programming  
languages through real libraries (libgit2, dulwich, etc), and I prefer  
to use those, so I don't really have any motivation to touch  
git-submodule.


Lauri
