From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: A question about git-rev-list
Date: Mon, 16 Jul 2007 13:05:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707161258560.20061@woody.linux-foundation.org>
References: <86wsx0wwvs.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 22:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAWpl-0002ma-3w
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 22:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004AbXGPUGN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758045AbXGPUGN
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 16:06:13 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57425 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756328AbXGPUGM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 16:06:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GK5eGN015191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2007 13:05:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6GK5Yvu030932;
	Mon, 16 Jul 2007 13:05:35 -0700
In-Reply-To: <86wsx0wwvs.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-2.631 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52714>



On Mon, 16 Jul 2007, David Kastrup wrote:
> 
> if I do
> 
> git-rev-list --remove-empty HEAD --not some-commit -- filename | tail -1
> 
> do I have any guarantee that the commit id I get (if any) is a direct
> descendant of some-commit?

No. You get the guarantee that

 - it's some kind of parent of HEAD
 - it's *not* a parent of some-commit

But the trivial case is a simple history like

	 /-B-\
	A     D
         \-C-/

(where "A" is the root commit, and "D" is the current HEAD, and there are 
two development lines from A to  D).

If you now do

	git-rev-list HEAD --not C

you would generally see B on the list of commits, even though it's 
obviously not a direct descendant of C.

No amount of flags will change that. Of course, B might not show up 
for _other_ reasons (ie simply because it doesn't change "filename" at 
all), but generally you must always think of git-rev-list (and git log) as 
a _set_ operation.

There are no git operations that will look for "chain of commits from C to 
D" if that is what you want. No such chain necessarily even exists, and 
quite often it is ambiguous when it *does* exist (ie there is not a single 
chain from A to D, there are two chains).

You could add some kind of function that looks for the "shortest chain of 
commits from X to Y", but that would really be something fundamentally 
different from what git-rev-list gives you.

			Linus
