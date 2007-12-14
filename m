From: David Miller <davem@davemloft.net>
Subject: Re: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 14:24:48 -0800 (PST)
Message-ID: <20071214.142448.52660507.davem@davemloft.net>
References: <7vfxy5rsui.fsf@gitster.siamese.dyndns.org>
	<20071214.111736.258936000.davem@davemloft.net>
	<20071214214533.GA4943@steel.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: raa.lkml@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 14 23:25:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Iy0-0000xV-NE
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 23:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbXLNWYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 17:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbXLNWYu
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 17:24:50 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39674
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752407AbXLNWYt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 17:24:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 11D64C8C182;
	Fri, 14 Dec 2007 14:24:49 -0800 (PST)
In-Reply-To: <20071214214533.GA4943@steel.home>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68355>

From: Alex Riesen <raa.lkml@gmail.com>
Date: Fri, 14 Dec 2007 22:45:33 +0100

> David Miller, Fri, Dec 14, 2007 20:17:36 +0100:
> > ++ git show-ref -q refs/remotes/local/master
> > ++ git branch my3 local/master
> > fatal: Out of memory, malloc failed
> 
> Something unusual about the system? Like a malloc debugger in
> LD_PRELOAD configuration?

No, I'm not doing anything fancy like that.

> Maybe you could retry with a little bit instrumentation?
> (The program last failed (git-branch) is normally very benign...)
> 
> Something like this:

Here is the output from the debugging patch:

++ git branch my3 local/master
fatal: Out of memory, malloc(4293963242) at git-compat-util.h:256 failed

This bogus size value in hex is 0xfff0adea, FWIW.

I added similar diags to xmemdupz() and xstrndup() and that gives us:

fatal: Out of memory, xstrndup(0x103ebf:4293902657:4293902657) at remote.c:112 failed

(the first three values are xstrndup() vars 'str', 'len', and
 the computed second argument to xmemdupz).

That bogus length is being generated via the length argument
passed to make_branch() by handle_config() in remote.c:

	if (!prefixcmp(key, "branch.")) {
		name = key + 7;
		subkey = strrchr(name, '.');
		branch = make_branch(name, subkey - name);

What if 'subkey' is NULL?  I bet that's what happening here.

I added a debugging check for this and indeed, subkey is NULL
in handle_condig() and that's why 'subkey - name' generates that
bogus negative length.

The string 'key' is "branch.autosetupmerge" in this case.
