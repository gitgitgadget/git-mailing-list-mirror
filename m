From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] remote-hg: do not fail on invalid bookmarks
Date: Fri, 21 Mar 2014 21:47:19 +0100
Message-ID: <532CA557.20007@web.de>
References: <A4F451CA-D1DE-43A9-A4DA-23594C08C4DD@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Max Horn <max@quendi.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 21:48:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6ME-0000nv-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 21:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbaCUUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 16:47:42 -0400
Received: from mout.web.de ([212.227.17.11]:49217 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbaCUUri (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 16:47:38 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M8Qpi-1XMnZH1Lla-00vxdt; Fri, 21 Mar 2014 21:47:25
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <A4F451CA-D1DE-43A9-A4DA-23594C08C4DD@quendi.de>
X-Provags-ID: V03:K0:eDMDJ2LkWFZx7O5lZ9U8+j0ERsuG7seBd+YQ23A70o7HXR8f2xf
 SK3t2ADe33Gw91p3yhQbZINHEDfxuKXd7UVgUeJsDqlzeIO9nhFV6WKVvga8ueQnGUYrgyS
 0sJycNwnN+c23dwpoyj2y1+MHUZTmF2ieU2mF3CNDIimgVyaKEHEZ07eFWC4zQb768kmcoA
 C7nqal/GyutEpz7YWpEIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244736>

On 2014-03-21 12.36, Max Horn wrote:
All tests passed :-), thanks from my side.
comments inline, some are debatable
> Mercurial can have bookmarks pointing to "nullid" (the empty root
> revision), while Git can not have references to it. When cloning or
> fetching from a Mercurial repository that has such a bookmark, the
> import failed because git-remote-hg was not be able to create the
> corresponding reference.
>
> Warn the user about the invalid reference, and do not advertise these
> bookmarks as head refs, but otherwise continue the import. In
> particular, we still keep track of the fact that the remote repository
> has a bookmark of the given name, in case the user wants to modify that
> bookmark.
>
> Also add some test cases for this issue.
s/some test cases/test cases/
>
> Reported-by: Antoine Pelisse <apelisse@gmail.com>
> Signed-off-by: Max Horn <max@quendi.de>
> ---
> This is a different fix than in my previous attempts. I thought
> a bit more about the issue, and determined that the previous fix,
> while working, was not really correct: It is wrong to
> treat nullid bookmarks as if they are non-existent; if e.g.
> the user wants to modify the bookmark from git, we need to
> into account that the remote already has a bookmark with that name.
> Indeed, I extended the new test cases to cover this aspect.
> With the previous fix, the new tests would fail upon pushing,
> with the new one, they work.
>
>  contrib/remote-helpers/git-remote-hg |  5 ++-
>  contrib/remote-helpers/test-hg.sh    | 67 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
> index eb89ef6..36b5261 100755
> --- a/contrib/remote-helpers/git-remote-hg
> +++ b/contrib/remote-helpers/git-remote-hg
> @@ -643,7 +643,10 @@ def do_list(parser):
>              print "? refs/heads/branches/%s" % gitref(branch)
>  
>      for bmark in bmarks:
> -        print "? refs/heads/%s" % gitref(bmark)
> +        if  bmarks[bmark].hex() == '0000000000000000000000000000000000000000':
> +            warn("Ignoring invalid bookmark '%s'", bmark)
> +        else:
> +            print "? refs/heads/%s" % gitref(bmark)
>  
>      for tag, node in repo.tagslist():
>          if tag == 'tip':
> diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
> index a933b1e..f5d0d97 100755
> --- a/contrib/remote-helpers/test-hg.sh
> +++ b/contrib/remote-helpers/test-hg.sh
> @@ -772,4 +772,71 @@ test_expect_success 'remote double failed push' '
>  	)
>  '
>  
> +test_expect_success 'clone remote with master null bookmark, then push to the bookmark' '
> +	test_when_finished "rm -rf gitrepo* hgrepo*" &&
> +
> +	(
> +	hg init hgrepo &&
> +	cd hgrepo &&
Minor:
We can change the order here, to make the "cd hgrepo" the first line in the subshell:

+	hg init hgrepo &&
+	(
+	cd hgrepo &&


> +	echo a >a &&
> +	hg add a &&
> +	hg commit -m a &&
> +	hg bookmark -r null master
> +	) &&
> +
> +	git clone "hg::hgrepo" gitrepo &&
> +	check gitrepo HEAD a &&
And here we do "cd", and this should be done in a subshell
> +	cd gitrepo &&
> +	git checkout --quiet -b master &&
> +	echo b >b &&
> +	git add b &&
> +	git commit -m b &&
> +	git push origin master
> +'
> +
> +test_expect_success 'clone remote with default null bookmark, then push to the bookmark' '
> +	test_when_finished "rm -rf gitrepo* hgrepo*" &&
> +
> +	(
> +	hg init hgrepo &&
> +	cd hgrepo &&
(Same minor as above)
> +	echo a >a &&
> +	hg add a &&
> +	hg commit -m a &&
> +	hg bookmark -r null -f default
> +	) &&
> +
> +	git clone "hg::hgrepo" gitrepo &&
> +	check gitrepo HEAD a &&
> +	cd gitrepo &&
> +	git checkout --quiet -b default &&
> +	echo b >b &&
> +	git add b &&
> +	git commit -m b &&
> +	git push origin default
> +'
> +
> +test_expect_success 'clone remote with generic null bookmark, then push to the bookmark' '
> +	test_when_finished "rm -rf gitrepo* hgrepo*" &&
> +
> +	(
> +	hg init hgrepo &&
> +	cd hgrepo &&
(Same as above)
> +	echo a >a &&
> +	hg add a &&
> +	hg commit -m a &&
> +	hg bookmark -r null bmark
> +	) &&
> +
> +	git clone "hg::hgrepo" gitrepo &&
> +	check gitrepo HEAD a &&
> +	cd gitrepo &&
Sub-shell missing
> +	git checkout --quiet -b bmark &&
> +	git remote -v &&
> +	echo b >b &&
> +	git add b &&
> +	git commit -m b &&
> +	git push origin bmark
> +'
> +
>  test_done
