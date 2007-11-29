From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git guidance
Date: Thu, 29 Nov 2007 08:19:58 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711290810170.8458@woody.linux-foundation.org>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 17:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixm8p-0004RF-1a
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 17:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050AbXK2QUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 11:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbXK2QUc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 11:20:32 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57709 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758976AbXK2QUa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 11:20:30 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATGJwh8032212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 08:19:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATGJwuv028307;
	Thu, 29 Nov 2007 08:19:58 -0800
In-Reply-To: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com>
X-Spam-Status: No, hits=-2.688 required=5 tests=AWL,BAYES_00,TW_VC
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66545>



On Thu, 29 Nov 2007, Jing Xue wrote:
> 
> By the way, the only SCM I have worked with that tries to mount its
> repository (or a view on top of it) as a file system is ClearCase with
> its dynamic views. And, between the buggy file system implementation,
> the intrusion on workflow, and the lack of scalability, at least in
> the organization I worked for, it turned out to be a horrible,
> horrible, horrible idea.

Doing a read-only mount setup tends to be pretty easy, but it's largely 
pointless except for specialty uses. Ie it's obviously not useful for 
actual *development*, but it can be useful for some other cases.

For example, a read-only revctrl filesystem can be a _very_ useful thing 
for test-farms, where you may have hundreds of clients that run tests on 
possibly different versions at the same time. In situations like that, the 
read-only mount can actually often be done as a user-space NFS server on 
some machine.

The advantage is that you don't need to export close to infinite amounts 
of versions from a "real" filesystem, or make the clients have their own 
copies. And if you do it as a user-space NFS server (or samba, for that 
matter), it's even portable, unlike many other approaches. The read-only 
part also makes 99% of all the complexity go away, and it turns out to be 
a fairly easy exercise to do.

So I don't think the filesystem approach is _wrong_ per se. But yes, doing 
it read-write is almost invariably a big mistake. On operatign systems 
that support a "union mount" approach, it's likely much better to have a 
read-only revctl thing, and then over-mount a regular filesystem on top of 
it.

Trying to make it read-write from the revctl engine standpoint is almost 
certainly totally insane.

				Linus
