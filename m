From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] setup: do not change to work tree prematurely
Date: Sat, 22 May 2010 20:35:39 -0500
Message-ID: <20100523013539.GA14403@progeny.tock>
References: <20100523000719.GA32380@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun May 23 03:36:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG06k-0008Qd-8u
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 03:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718Ab0EWBfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 21:35:36 -0400
Received: from mail-yw0-f180.google.com ([209.85.211.180]:49480 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669Ab0EWBff (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 21:35:35 -0400
Received: by ywh10 with SMTP id 10so1294123ywh.1
        for <git@vger.kernel.org>; Sat, 22 May 2010 18:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=E1DNio3dgFtJXDMuZcX1TXJ5otQXxwYsIShzi3NaE2E=;
        b=oA1RdPD+7a2G8R0SUNzaeS6Ghdv73EqaEZHvJuIcswguCvx2E6pjduqGJBJX6jCJYA
         Vjg0WsR5/7YcsB5unAFM7Wuk1/SXMnnqUlpLQ9Zucvlkt4an4uYzadeHLQoAkfo6d1dz
         PcS06X6TMIvi3gY+YJkgVLWSfqTnUE5z6GBRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iStne2IIpbKYJlBu+9F+RhEJ21oeDD4f25ug+Ec+Sy5ljPC4lTPrTIlcO4DkY8TGKy
         XKkNmVrLPntu8icRYovOW2DsWvg1gg8Sd6Hwdk8Qu4DxzLnOTl14QFtRZHpOMSfkYc1+
         fep1SiZDkXjFSY97qlsWtLD40VZWHMVdGy1dg=
Received: by 10.90.147.14 with SMTP id u14mr1739461agd.207.1274578534949;
        Sat, 22 May 2010 18:35:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm1918247ywh.8.2010.05.22.18.35.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 18:35:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100523000719.GA32380@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147553>

Hi Clemens,

Clemens Buchacher wrote:

> $ cd .git
> $ git --work-tree=/tmp/git symbolic-ref HEAD
> fatal: ref HEAD is not a symbolic ref

Without your patch applied, I get

 $ cd .git
 $ git --work-tree=/tmp/git symbolic-ref HEAD
 refs/heads/hello

I should have done the following instead:

 $ worktree=$(pwd)
 $ cd .git
 $ git --work-tree="$worktree" symbolic-ref HEAD
 fatal: ref HEAD is not a symbolic ref

> +char *get_relative_path(char *cwd, const char *dir)

Looks reasonable.  Should be const char *cwd.

> diff --git a/setup.c b/setup.c
> index 5716d90..67b5122 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -524,14 +524,18 @@ const char *setup_git_directory(void)
> 	const char *retval = setup_git_directory_gently(NULL);
>  
>  	/* If the work tree is not the default one, recompute prefix */
>  	if (inside_work_tree < 0) {

If I understand correctly, you made two changes here:

 - interpret GIT_WORK_TREE and friends relative to .git instead of
   the original cwd (by not calling chdir(retval) before
   get_git_work_tree())

 - make setup_git_directory stay in the last directory searched for a
   .git directory instead of chdir-ing into the toplevel of the work tree.

Are these safe changes to make?

Jonathan

diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 9df3012..93bf92c 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -106,6 +106,15 @@ test_expect_success 'repo finds its work tree from work tree, too' '
 	 test sub/dir/tracked = "$(git ls-files)")
 '
 
+test -d work || cp -R repo.git/work .
+test_expect_success 'repo finds its .git dir with separate worktree' '
+	(unset GIT_DIR GIT_WORK_TREE GIT_CONFIG &&
+	 worktree=$(pwd) &&
+	 cd repo.git &&
+	 git symbolic-ref HEAD &&
+	 git --work-tree="$worktree" symbolic-ref HEAD)
+'
+
 test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE' '
 	(cd repo.git/work/sub/dir &&
 	GIT_DIR=../../.. GIT_WORK_TREE=../.. GIT_PAGER= \
-- 
