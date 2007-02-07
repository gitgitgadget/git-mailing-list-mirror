From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 09:12:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqLp-0007Nr-4E
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965688AbXBGRMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965660AbXBGRMp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:12:45 -0500
Received: from smtp.osdl.org ([65.172.181.24]:55720 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965688AbXBGRMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:12:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17HCfmA010207
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 09:12:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17HCdQV020177;
	Wed, 7 Feb 2007 09:12:40 -0800
In-Reply-To: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.112__
X-MIMEDefang-Filter: osdl$Revision: 1.174 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38942>



On Wed, 7 Feb 2007, Don Zickus wrote:
>
> I was curious to know what is the easiest way to filter info inside a
> commit message.
> 
> For example say I wanted to find out what patches Joe User has
> submitted to the git project.
> I know I can do something like ' git log |grep -B2 "^Author: Joe User"
> ' and it will output the matches and the commit id.  However, if I
> wanted to filter on something like "Signed-off-by: Joe User", then it
> is a little harder to dig for the commit id.

There are two ways:

 - "git log" can itself do a lot of filtering. Both on date, on revisions, 
   on "modifies files/directories X, Y and Z" _and_ on strings.

   See "man git-rev-list" for more (it doesn't apply to just "git log", it 
   applies to just about any revision listing, including gitk etc)

   For example,

	git log [--author=pattern] [--committer=pattern] [--grep=pattern]

   will likely do exactly what you want. You can do

	git log --grep="Signed-off-by:.*akpm"

   on the kernel archive to see which ones were signed off by Andrew.

So the above works, and catches *most* uses. But it has problems if you 
want to do something fancier (and I think that includes something as 
simple as doing a case-insensitive grep). So the other approach is:

 - The hacky way: use "git log --pretty -z", and GNU grep -z:

	git log --pretty -z |
		grep -i -z Signed-off-by:.*junkio |
		tr '\0' '\n'

   which allows you to do anything you want with grep (or other unix tools 
   that take zero-terminated output).

> Is there a better way of doing this?  Or should I accept the fact that
> git wasn't designed to filter info like this very quickly?

Git definitely was designed to do it. The "-z" option in particular is 
very much designed for any generic UNIX scripting, but the *easy* cases 
git does internally.

		Linus
