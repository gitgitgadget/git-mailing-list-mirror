From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 03:58:46 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>  <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>  <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net> <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 10:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHaSX-0004lO-Oc
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 10:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYL3I64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 03:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbYL3I6z
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 03:58:55 -0500
Received: from rose.makesad.us ([219.105.37.19]:48528 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbYL3I6z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 03:58:55 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id 6FB09A010F
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 03:58:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id E06C13A62BD
	for <git@vger.kernel.org>; Tue, 30 Dec 2008 00:58:46 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104170>

On Tue, 30 Dec 2008, demerphq wrote:

> 2008/12/30 Asheesh Laroia <asheesh@asheesh.org>:

>> I ask about this because I'm using git to track email in Maildir 
>> repositories, and in that vein I'm getting bitten by git's removal of 
>> empty directories.
>
> Add a .exists to each directory.  There is precedent for such an 
> approach in other systems.

Delivering mail into a Maildir is a three-step process.  Let's say 
we are delivering to a Maildir spool stored in ~/Maildir.

(1)

The message is written out to ~/Maildir/tmp/some_filename.

(2)

When the message is complete, it is rename()d to 
~/Maildir/new/some_name.

(3)

When a mail user agent reads the Maildir spool, it checks new/ for new 
mail. If there is a message there, it renames it to 
~/Maildir/cur/some_other_filename and announces to the user, "You've got 
mail!"

So, let's say I take your suggestion.

$ touch ~/Maildir/new/.exists
$ git add ~/Maildir/new/.exists && git commit -m "La di da"

Now a spec-compliant Maildir user agent will attempt to deliver this new 
"email message" of zero bytes into the mail spool and assign it a message 
UID.  Doing so will remove it from Maildir/new.

Then I do "git pull" to get the new messages from my mail server's Maildir 
repository for my email.  This causes git read-tree to eventually be run. 
If the new tree has no unprocessed email, git runs rmdir() on 
~/Maildir/new/.

Now if I want to write a new email to ~/Maildir/ (such as due to copying 
an email from another folder), the Maildir user agent suddenly finds 
itself in a strange place: new/ does not exist, violating the definition 
of a Maildir. This breaks mail processing for that ~/Maildir/ folder.

This is because git is removing these directories. There is a strict 
incompatibility between git rmdir()ing empty directories behind my back 
and Maildir systems.

I hope that explains the issue I face, both to Junio and to Yves.

Note that for me, there is no issue with how to handle merging of empty 
directories, or what happens if these empty directories become files, or 
which empty directories to keep around; if git just never rmdir()s any 
directories for me, and otherwise acts identically to now, that would 
solve my problem. I can look into preparing an RFC patch that creates a 
mode like that.

-- Asheesh.

-- 
You will be the last person to buy a Chrysler.
