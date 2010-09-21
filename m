From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Deleting of the specified ref during the post-receive hook
Date: Tue, 21 Sep 2010 07:50:14 -0700
Message-ID: <20100921145014.GH32601@spearce.org>
References: <4C98C3F2.9050006@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 16:50:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy4As-0005XZ-I5
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 16:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612Ab0IUOuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 10:50:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab0IUOuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 10:50:16 -0400
Received: by pvg2 with SMTP id 2so1444057pvg.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 07:50:16 -0700 (PDT)
Received: by 10.143.17.12 with SMTP id u12mr9186499wfi.55.1285080616424;
        Tue, 21 Sep 2010 07:50:16 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id v6sm2727365wfg.3.2010.09.21.07.50.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 07:50:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C98C3F2.9050006@workspacewhiz.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156727>

Joshua Jensen <jjensen@workspacewhiz.com> wrote:
>  I've recently asked whether there was a public script to act as an  
> automatic 'maintainer', something akin to Gerrit's push always  
> succeeding without having to pull first when using Git as a central  
> repository.  I received a number of suggestions, and I have begun trial  
> implementations.
>
> My current line of thought has an auto-merging script that monitors the  
> refs/for/ namespace (similar to Gerrit) and then applies --no-ff merges  
> to the appropriate branch.  For instance, when the user pushes to  
> refs/for/master, the post-receive hook creates a secondary ref called  
> refs/for/master-SHA1-timestamp and then deletes the refs/for/master ref:
>
> #!bin/sh
> # post-receive hook
> while read oldrev newrev ref
> do
>     case $ref in
>         refs/for/*)
>             timestamp=`date +%s`
>             `git update-ref $ref-$newrev-$timestamp $newrev`
>             `git update-ref -d $ref`

FWIW, you don't need `` around the git update-ref calls, because you
aren't using the output of the command as input to another command.

> If you'll pardon my lacking shell script skills (I'm open to learn!), my  
> primary question concerns safety.  When receiving a ref via an SSH-based  
> server (which happens to be Gitolite, but I don't think that is relevant  
> here), is the post-receive hook guaranteed to be run in a lockstep  
> manner?

No.  If there are two concurrent pushes occurring, the script may
execute in parallel.

But you'll actually get something much worse.  receive-pack will
create refs/for/master for the first user... and then might be put
to sleep while another user's receive-pack starts.  That second
user will see refs/for/master existing, and will fail their push
because their concept of $newrev doesn't match what is currently
at refs/for/master.  Then the first user wakes up, runs your
post-receive, and the ref is cleared.

The better strategy would be to use an update hook that refuses to
permit the creation of refs/for/master:

  #!/bin/sh
  ref=$1
  old=$2
  new=$3

  case $ref in
  refs/for/*)
    timestamp=`date +%s`
    git update-ref $ref-$new-$timestamp $new
    echo "Created $ref-$new-$timestamp"
    exit 1
    ;;
  *)
    exit 0
    ;;
  esac


By exit 1 here we refuse the push attempt, so receive-pack won't
create refs/for/master, and another user pushing won't see that
false failure.  However, unlike with Gerrit, every user is now going
to receive a push failure message because the hook has appeared to
reject the value, even though it accepted it.

> That is, if two people push to 'refs/for/master' at the same  
> time, is there a lock to process one user and then the other user?

There is, but only for the duration of the update hook.  So if you
used an update hook instead, one user would succeed with the push
and the other would get a lock failure, and would need to retry.

> Before I go too much deeper down this path, am I way off base here?

I'd have to ask why you are using gitolite and trying to abuse
git-receive-pack to do something that Gerrit does out of the box...

-- 
Shawn.
