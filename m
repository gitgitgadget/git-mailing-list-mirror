From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:08:22 -0700
Message-ID: <20130325220822.GG1414@google.com>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vfvzjw334.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Weinberger <richard@nod.at>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFZX-0002QA-G2
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933428Ab3CYWI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:08:28 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:57460 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758981Ab3CYWI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:08:27 -0400
Received: by mail-pd0-f170.google.com with SMTP id 4so2719756pdd.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=qP9uQEURYNOLal8cQa0IYyb0sIR6mrsCaibL8rLwicg=;
        b=N7KtxZYbLSPFsaRgo1orjJjkfo6OIhYL0pwO/UO/UKZSAS7b6hENaFo1YvBwQ1P+AO
         TKiRloRYT8FKlt2D1ullvo0THJkaK+/RYs4CRRBfAWDq6C9Z2oTgvUGeQK05Y+Lqi+nd
         1fQ2vpfp36FEi/d5qZ1d1lj6Wi1D43TvY3Oz4fcN5Z7pIpcsMfi8r+12+PcK4tzfJ5PU
         xPf8Je1bjHo5MH9xu/fOH1vNHIKHmgWvwkKq0BlFKr8whzawwyfrTdMv5+cSfqUStGHq
         8lGdCAAYXLuWeRpt/RaZgUxUClW9Yl6cH/CJTNszrfutKwbuKtdpLVzL2BsZPipUPibC
         Ju6A==
X-Received: by 10.68.201.135 with SMTP id ka7mr20078153pbc.119.1364249307082;
        Mon, 25 Mar 2013 15:08:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id bs1sm4007168pbc.8.2013.03.25.15.08.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 15:08:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfvzjw334.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219106>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> In git versions including the patch 2cd83d10bb6b (setup: suppress
>> implicit "." work-tree for bare repos, 2013-03-08, currently in "next"
>> but not "master"), you can set GIT_IMPLICIT_WORK_TREE=0 to avoid this
>> behavior.
>
> WAT?

Is that false?

If I understand the history correctly, the ability to set the GIT_DIR
envvar was meant to allow a person to keep their .git directory outside
the worktree.  So you can do:

	git init my-favorite-repo
	cd my-favorite-repo
	...work as usual...

	# cleaning time!
	mv .git ~/my-favorite-repo-metadata.git
	GIT_DIR=$HOME/my-favorite-repo-metadata.git; export GIT_DIR
	... work as usual...

If you want to set GIT_DIR and treat it as a bare repository, the
sane way to do that is simply

	cd ~/my-favorite-bare-repository.git
	... use git as usual ...

But if something (for example relative paths used by your script)
ties your cwd somewhere else, you might really want to do

	GIT_DIR=~/my-favorite-bare-repository.git; export GIT_DIR
	... work as usual ...

and as a side effect of Jeff's patch there is now a mechanism to do
that:

	GIT_IMPLICIT_WORK_TREE=0; export GIT_IMPLICIT_WORK_TREE
	GIT_DIR=~/my-favorite-bare-repository.git; export GIT_DIR
	... work as usual ...

This is of course unsafe because it ties your usage to a specific
version of git.  And the variable is not advertised in the
documentation.
