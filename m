From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Tue, 01 May 2012 05:32:09 -0000
Message-ID: <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
References: <4F9F128C.5020304@palm.com>
            <201204302331.q3UNVo7o032303@no.baka.org>
            <4F9F28F5.2020403@palm.com>
            <201205010137.q411bxaU002449@no.baka.org>
            <4F9F52B9.9060508@palm.com>
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Rich Pixley <rich.pixley@palm.com>
X-From: git-owner@vger.kernel.org Tue May 01 07:44:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP5t9-0000ec-L7
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 07:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab2EAFoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 01:44:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40658 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab2EAFoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 01:44:07 -0400
Received: by eaaq12 with SMTP id q12so833974eaa.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 22:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=C4gqwiq2kxjKVQEXuDVQz08AcSe8kZwWd3czmMkaMcY=;
        b=Xot3Cch0iPaBQkUEQdim+7zf4j/I9Kt43EMdYO8SbigswHUP0OTsMUS9AfhmttRjdT
         DPBlBbescOH6BG18hsH26VjJSmj2uwcPWHE8NKcbGjxmDg5USy7KRNoBAdlnypJATdEu
         jCXvVV3yhF0NpFd6d07PXlAL5Yo/0UEEf4T9+3H1hA8dWaNgVhN1L/eT/K4nXr9moEdU
         Wqp28t6zTqQ4IIFBSEvVt8OP7SPmPazi6KXC4Y0UxMmt5rIKU1JHZYRSKNifLdEEJlVa
         Zl7a2tWdMPhLBlsRM8+ah9x5fnCIro8eWdHbuQrgJKk0OWskInfcqkdOgCW8NpgPKUO2
         ucuA==
Received: by 10.213.9.10 with SMTP id j10mr1736288ebj.104.1335851045601;
        Mon, 30 Apr 2012 22:44:05 -0700 (PDT)
Received: from gmail.com (tor21.anonymizer.ccc.de. [31.172.30.4])
        by mx.google.com with ESMTPS id x4sm85680672eef.10.2012.04.30.22.44.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 22:44:03 -0700 (PDT)
In-Reply-To: <4F9F52B9.9060508@palm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196660>

On Mon, 30 Apr 2012 20:04:25 -0700, Rich Pixley wrote:

> I don't need separate branches for each repository.  What I really want 
> is a common branch whose changes I can push back and forth between the 
> various repositories, or coordinate through a central cache, without 
> worrying about the underlying details that git is forcing me to confront.

Here's a start for a more precise discussion.

Sincerely,
Michael Witten


Cache server:

  $ git clone --mirror "$uri_for_central_repo"

Machine A:

  $ git clone "$uri_for_cache_repo"
  $ git checkout -b feature_0 origin/feature_0
  $ # ... do some work ...
  $ git push --set-upstream origin HEAD:shared/feature_0
  $ git config push.default upstream

Machine B:

  $ git clone "$uri_for_cache_repo"
  $ git checkout -b feature_0 origin/feature_0
  $ # ... do some work that conflicts with work done on Machine A...
  $ git push --set-upstream origin HEAD:shared/feature_0
  To $uri_for_cache_repo
   ! [rejected]        HEAD -> shared/feature_0 (non-fast-forward)
   error: failed to push some refs to '$uri_for_cache_repo'
  To prevent you from losing history, non-fast-forward updates were rejected
  Merge the remote changes (e.g. 'git pull') before pushing again.  See the
  'Note about fast-forwards' section of 'git push --help' for details.
  $ git pull origin shared/feature_0
  From $uri_for_cache_repo
   * branch            shared/feature_0 -> FETCH_HEAD
  Auto-merging a
  CONFLICT (add/add): Merge conflict in a
  Recorded preimage for 'a'
  Automatic merge failed; fix conflicts and then commit the result.
  $ # ... resolve conflict and commit results ...
  $ git push --set-upstream origin HEAD:shared/feature_0
  $ git config push.default upstream

Machine A:

  $ git pull # pulls in origin's shared/feature_0
  $ # ... do some work ...
  $ git push # pushes to origin's shared/feature_0

Machine B:

  $ git pull # pulls in origin's shared/feature_0
  $ # ... do some work ...
  $ git push # pushes to origin's shared/feature_0

Machine A:

  $ git pull
  $ git remote add central "$uri_for_central_repo"
  $ git push central HEAD:feature_0 # Assume there is a conflict
  To $uri_for_central_repo
   ! [rejected]        HEAD -> feature_0 (non-fast-forward)
  error: failed to push some refs to '$uri_for_central_repo'
  To prevent you from losing history, non-fast-forward updates were rejected
  Merge the remote changes (e.g. 'git pull') before pushing again.  See the
  'Note about fast-forwards' section of 'git push --help' for details.
  $ git pull central feature_0
  $ # ... resolve conflict and commit results ...
  $ git push central HEAD:feature_0 # Assume it succeeds this time
  $ # Let's update the cache repo from Machine A:
  $ git fetch central
  $ git push origin 'refs/remotes/central/*:refs/heads/*'

Machine B:

  $ git pull
  $ git pull . origin/feature_0 # Get new stuff cached from central server
