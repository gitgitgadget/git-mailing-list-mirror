From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Git for redundant mail servers
Date: Sat, 23 Apr 2005 22:12:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0504232159030.32287@qynat.qvtvafvgr.pbz>
References: <1114238562.3419.29.camel@localhost.localdomain>
 <2cfc403205042301243841fe0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 07:09:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZNI-0008Sh-7F
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 07:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVDXFOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 01:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVDXFOe
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 01:14:34 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:32398 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262262AbVDXFO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 01:14:29 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 23 Apr 2005 22:09:21 -0700
Received: by atlexc02.diginsite.com with Internet Mail Service (5.5.2653.19)
	id <JC0C9SNG>; Sun, 24 Apr 2005 01:12:47 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id J2V6XR31; Sat, 23 Apr 2005 22:12:21 -0700
To: jon@zeta.org.au
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <2cfc403205042301243841fe0c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 23 Apr 2005, Jon Seymour wrote:

> On 4/23/05, David Woodhouse <dwmw2@infradead.org> wrote:
>> Random alternative use for git... we could use it to provide a cluster
>> of redundant mail delivery/storage servers.
>>
>> The principle is simple; you use something like a set of Maildir
>> folders, stored in a git repository. Any action on the mail storage is
>> done as a commit -- that includes delivery of new mail, or user actions
>> from the IMAP server such as changing flags, deleting or moving mail.
>> These actions are actually fairly efficient when Maildir folders are
>> stored in a git repository -- the IMAP model is that mails are
>> immutable, and flag changes are done as renames.
>>
>> In the normal case where all the servers are online, each commit is
>> immediately pushed to each remote server. When a server is offline or
>> separated somehow from the rest of the group, it's going to have to do a
>> merge when it reconnects -- we'd implement a Maildir-specific merge
>> algorithm, which really isn't that hard to do.
>>
>
> This is a cool idea. When the concept is rendered this way, it sounds
> a lot like some of the core principles in the architecture of the
> Lotus Notes replication engine. I've always thought it would be cool
> to have an open engine that provided similar functionality to the
> Lotus Notes replication engine without the naff programming
> environment that sits on top. I can see how the git concepts and code
> could provide the basis of such a solution. Very cool.

Having been in several discussions on the cyrus mailing list about 
replication let me point out a couple basic problems that you have to work 
around.

1. when a new message arrives it gets given a numeric messageid, this 
message id is not supposed to change without fairly drastic things 
happening (the server telling all clients to forget everything they know 
about the status of the mailbox). this requires syncronization between 
servers if both are receiving messages.

2. git effectivly stores snapshots of things and you deduce the changes by 
comparing the snapshots. for things like flags changing this is a 
relativly inefficiant way to replicate changes (although if one server is 
offline for a while it could be a firly efficiant way to do the merge)

and now a couple of starting points

Cyrus already implements single-instance store so the concept of the same 
message living in multiple places doesn't have to be grafted in. it keeps 
the message flags seperate from the messages themselves so the messages 
could be replicated seperatly from the state.

personally I'm not seeing git being a huge advantage for this, but I do 
see some advantages and it's very possible I'm missing some others.

go for it.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
