From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Wed, 17 Apr 2013 11:47:16 +0200
Message-ID: <87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 11:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USOxX-0002kY-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 11:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966016Ab3DQJrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 05:47:20 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:38746 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965843Ab3DQJrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 05:47:19 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 17 Apr
 2013 11:47:13 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 17 Apr 2013 11:47:16 +0200
In-Reply-To: <7vhaj7r116.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 15 Apr 2013 13:28:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221527>

Junio C Hamano <gitster@pobox.com> writes:

> * jc/add-2.0-delete-default (2013-03-08) 3 commits
>  - git add <pathspec>... defaults to "-A"
>   (merged to 'next' on 2013-04-05 at 199442e)
>  + git add: start preparing for "git add <pathspec>..." to default to "-A"
>  + builtin/add.c: simplify boolean variables
>
>  In Git 2.0, "git add pathspec" will mean "git add -A pathspec".  If
>  you did this in a working tree that tracks dir/lost and dir/another:
>
>  $ rm dir/lost
>  $ edit dir/another
>  $ git add dir
>
>  The last step will not only notices and records updated
>  dir/another, but also notices and records the removal of dir/lost
>  in the index.
>
>  Start training the users for this change to say --no-all when they
>  want to ignore the removal to smooth the transition hump.
>
>  Will merge to 'master' the early bits and cook the rest in 'next' until Git 2.0.

The warning triggers in some cases where it shouldn't, relating to
submodules:

  $ git submodule add gitosis@git.csa.inf.ethz.ch:domjudge.git domjudge
  Adding existing repo at 'domjudge' to the index                                                        
  warning: In Git 2.0, 'git add <pathspec>...' will also update the                                      
  index for paths removed from the working tree that match                                               
  the given pathspec. If you want to 'add' only changed                                                  
  or newly created paths, say 'git add --no-all <pathspec>...' instead.

It also seems to hint that the problem is with giving a 'pathspec', but
in fact in the case of a "proper" pathspec (that isn't an existing path)
it does *not* trigger, even though it probably should:

  $ git ls-files
  foo
  $ rm foo
  $ git add 'f*'
  $ git status
  # On branch master
  # Changes not staged for commit:
  #   (use "git add/rm <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #       deleted:    foo
  #
  no changes added to commit (use "git add" and/or "git commit -a")
  $ git add -A 'f*'
  $ git status
  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #       deleted:    foo
  #
  # Untracked files not listed (use -u option to show untracked files)

That's of course assuming that you want to unconditionally make -A the
default.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
