From: colin@horizon.com
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Tue, 11 Mar 2008 05:35:53 -0400
Message-ID: <20080311093553.23191.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: hvammen@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 10:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ10x-000094-Cu
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYCKJmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbYCKJmf
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:42:35 -0400
Received: from science.horizon.com ([192.35.100.1]:13647 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750929AbYCKJme (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:42:34 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Mar 2008 05:42:33 EDT
Received: (qmail 23192 invoked by uid 1000); 11 Mar 2008 05:35:53 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76821>

> What's lacking is "why this is a good idea".

Seconded.  A long time ago (and I'm too lazy to find a link), Linus
explained why disabling fast-forward merges was almost always a Bad Idea,
and nobody has come up with a good reason why you'd want one since.

But from memory, suppose that you have two developers, each working on
their own branch:

     a--a--a <-- A's head
    /
o--o
    \
     b--b--b <-- B's head

Then suppose that they merge back and forth to get to the same state.
With fast-forward merges, it will go like this:

A merges from B:
     a--a--a
    /       \
o--o         o <-- A's head
    \       /
     b--b--b <-- B's head

Then B merges from A:
     a--a--a
    /       \
o--o         o <-- Both heads
    \       /
     b--b--b


And look, they are in sync and can go on to develop from a common base
version.  Future merges will do nothing.


If, instead, you have every merge generate a commit, then you get:
     a--a--a
    /       \
o--o         o <-- A's head
    \       / \
     b--b--b---o <-- B's head

     a--a--a
    /       \
o--o         o---o <-- A's head
    \       / \ /
     b--b--b---o <-- B's head

     a--a--a
    /       \
o--o         o---o <-- A's head
    \       / \ / \
     b--b--b---o---o <-- B's head

.. and it never ends.  All of the merged commits are identical trees, but
if you insist on creating a new commit object each time, you can generate
an infinite number of bogus commits, and more to the point, A and B will
never actually agree on the current HEAD commit.

With more developers, you can make even more of a mess.

What use does the "--ff=never" option have except to generate this cruft?
Flexibility is useful only as long as it provides the ability to do
something desirable.  There's no point to having a button that should
never be pushed.
