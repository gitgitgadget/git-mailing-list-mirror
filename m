From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 14:01:40 -0500
Message-ID: <qIGyi7O683pM7kzjmlY6QeiakFbPlBEHw9e9bG_SQhtXpvaqdek-Bw@cipher.nrlssc.navy.mil>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <op.utwdsutn1e62zd@merlin.emma.line.org> <7v8wl01iev.fsf@alter.siamese.dyndns.org> <op.utwyczlf1e62zd@merlin.emma.line.org> <81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com> <op.utw7buoi1e62zd@balu> <81b0412b0905140616h69ac2919j26734f02455a5f5c@mail.gmail.com> <op.utw9khqa1e62zd@balu> <fabb9a1e0905140642x26bf5e2ala604a36d0fe520a6@mail.gmail.com> <op.utxlqej91e62zd@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 21:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4gCy-0007yT-1l
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 21:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZENTCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 15:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbZENTCd
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 15:02:33 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44532 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbZENTCc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 15:02:32 -0400
Received: by mail.nrlssc.navy.mil id n4EJ1gXc017570; Thu, 14 May 2009 14:01:42 -0500
In-Reply-To: <op.utxlqej91e62zd@balu>
X-OriginalArrivalTime: 14 May 2009 19:01:41.0064 (UTC) FILETIME=[6A68DC80:01C9D4C6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119214>

Matthias Andree wrote:
> Am 14.05.2009, 15:42 Uhr, schrieb Sverre Rabbelier <srabbelier@gmail.com>:
> 
>> Heya,
>>
>> On Thu, May 14, 2009 at 15:39, Matthias Andree
>> <matthias.andree@gmx.de> wrote:
>>> The bug itself (references to 'deleted' or 'replaced' tag objects remain
>>> reachable rather than becoming dangling) is still there without a
>>> suggestion
>>> to the solution, and you're uselessly the bug.
>>
>> I believe Alex is saying that this is not a bug, but intended
>> behavior, and Matthias is saying that we should change that behavior
>> so that users are at least aware that they are creating such a
>> situation, is that correct?
> 
> I think my statements are:
> 
> 1- git tag -d and git tag -f do not work as advertised for tag objects (as
> opposed to lightweight tags); evidence in the longish mail

Both of these do indeed work.

In your examples 'git tag -d' worked as intended.  The tag was deleted even
though the object still remained in the object database.  The tag subcommand
does not remove objects.  Objects which are not used anymore are removed by
running the 'git gc' command.  This happens automatically periodically.  If
you want to see them disappear now, run 'git gc --prune=now'.

In your examples, 'git tag -f' worked as intended.  The "object" referenced
by the command line arguments was tagged, and the existing tag was replaced
by a new tag with the same name.

So when you do

  $ git tag -f -m 'add tag foo' foo foo

the second foo is dereferenced, and it's object id is what is tagged.  So it
is equivalent to the following:

  $ git tag -f -m 'add tag foo' foo 2e326d8a210536b7cd1f2bc77e3e29d7231f9ec4

This object happens to be a tag object which points to a commit.

Your graph:

  objects:  4481a1 (commit) <- 2e326d (tag "foo") <- 72f346 (tag "foo")

is perfectly correct and valid.  The middle tag object does not exist in
the tag namespace though.  Its name is embedded in the tag object and is
necessary for validating the tag object.

> 2- I presume that the bug cannot be really fixed (signed tags created by
> somebody else), we then have several solutions:
>  2a- warn the user and refuse
>  2b- warn the user and continue nonetheless
>  2c- warn the user and add options to force the user should at least be
> warned that he may be doing something which doesn't work as intended, or
>  2d- give the user a possibility to force git to do stupid things.

There are no 'cycles', there is no inconsistency, there is no bug, except
perhaps in git fast-export.

-brandon
