From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 18:05:11 -0800 (PST)
Message-ID: <405044.6078.qm@web31809.mail.mud.yahoo.com>
References: <7vd55y46ta.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 02 03:05:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Z1m-0003PV-6p
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 03:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbXABCFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 21:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754372AbXABCFO
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 21:05:14 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:48817 "HELO
	web31809.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753623AbXABCFM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jan 2007 21:05:12 -0500
Received: (qmail 8699 invoked by uid 60001); 2 Jan 2007 02:05:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=anGpaIUSWIhrLYstJtLEXzxRdJo6M+L5cBGHdtikMkAaQrDWAWt7q/7srGvoPFQRKypM81VLIfpAow0tg6ZWdsWCotc4nriBh6seM6lJCN0RqJOpyqNALUoks/QOQwWqW8+OP3SOj9tOhL9hGvkftG2ufloS6TSNavn7Yv2EuJ0=;
X-YMail-OSG: CVbJwkcVM1nykemaGn2UK6T__rKHqZ6xTW7Lwj69ErrmJPQ1lOZ2t6m25v_rGI6HDDh1YT5tEZLh1pQUzojZqxLM.wh_6W7idcqNWWjKQbcv_fopN7xye5ZKFimKXHsrBbldMWaTJ0673SMBW50gK5ozVeJ0R9jYQ5zJUV3gKcUhuFByIctTh5QO
Received: from [71.84.31.238] by web31809.mail.mud.yahoo.com via HTTP; Mon, 01 Jan 2007 18:05:11 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd55y46ta.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35761>

--- Junio C Hamano <junkio@cox.net> wrote:
> What's going on is clean-up towards v1.5.0-rc1 ;-).
> 
>  - 'git clone' does not create a file that has a line that looks
>    like "Pull: master:origin" anywhere anymore.
> 
>  - 'git clone' also does not create the traditional "'master' is
>    special and we map that to origin, others are mapped as is
>    under refs/heads/, and we have to drop 'origin' from the
>    remote side because that name we want to use to store their
>    'master'" layout.
> 
> So after a clone, you would get:
> 
> 	[remote "origin"]
>         	url = ....
>                 fetch = refs/heads/*:refs/remotes/origin/*
>         [branch "master"]
>         	remote = origin
>                 merge = refs/heads/master
> 
> This configuration still causes "git pull" or "git pull origin"
> while on "master" to fetch and store the remote side's master as
> what you can refer to as 'origin' (because it expands to
> 'remotes/origin/HEAD' thanks to sha1_name.c::get_sha1_basic()),
> and then merges that to your current branch, so there is no
> change in the user experience in the big picture, but what is
> created to achieve that effect is different from what was
> described.

Ah, I see.  Thanks Junio.

... And this is why I see some objections as to what I'm proposing
because it extends too far the extension itself of the old
behavior. (See below.)

Questions:

What is the reasonining of defining branch.<name>.merge to point
to the "remote's setup"?  I would much, much rather stop the leak
of the remote's setup right at [remote] and contain it there,
while everything in [branch] would refer to local stuff.

So the above configuration would become:

 	[remote "origin"]
         	url = ....
                fetch = refs/heads/*:refs/remotes/origin/*
        [branch "master"]
         	remote = origin
# merge gives the place and name of the remote branch locally mapped
                merge = refs/heads/origin/master
# OR, better yet
# merge gives the name only of the remote branch to be merged
# the local mapping can be found from "remote = " above
                merge = master

The reasoning is that the remote's setup should only leak into
[remote] and no further.  I.e. [remote] is the only one concerned
with the mapping between the remote repo and the local repo.

Then, [branch] only talks about local relationships.  Now
since [branch] does refer to _where_ the local mapping resolves
to, i.e. the right hand part of `:', then there is a redundancy
in branch.<name>.merge, since branch.<name>.remote _does refer_
to [remote] where we can find where it is locally mapped.

Thus, by reducibility, branch.name.merge should only contain
a name.  Here is the dependency graph:

branch.name.merge <- (gives a local name)
      branch.name.remote <- (gives the remote)
            remote.rname.fetch <- (gives the remote:local name mapping)
                   remote.rname.url (gives the URL).

Now as to what I'm talking about, should be able to be had with:

     [remote "parent"]
           url = .
           fetch = :
     [branch "A"]
           remote = parent
           merge = master
     [branch "B"]
           remote = parent
           merge = A
     [branch "C"]
           remote = parent
           merge = B

   Luben
