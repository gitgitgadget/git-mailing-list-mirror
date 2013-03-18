From: Rob Hoelz <rob@hoelz.ro>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Mon, 18 Mar 2013 21:59:53 +0100
Message-ID: <20130318215953.1a7345f0@hoelz.ro>
References: <20130317235040.4cdc9ef2@hoelz.ro>
	<7vd2uxppk0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, josh@joshtriplett.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 22:00:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHhAa-0006rc-CQ
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 22:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab3CRVAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 17:00:00 -0400
Received: from hoelz.ro ([66.228.44.67]:57430 "EHLO mail.hoelz.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754539Ab3CRU76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:59:58 -0400
Received: from localhost.localdomain (g95115.upc-g.chello.nl [80.57.95.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hoelz.ro (Postfix) with ESMTPSA id EB478280EE;
	Mon, 18 Mar 2013 16:59:56 -0400 (EDT)
In-Reply-To: <7vd2uxppk0.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.16; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218450>

On Sun, 17 Mar 2013 16:35:59 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Rob Hoelz <rob@hoelz.ro> writes:
> 
> > git push currently doesn't consider pushInsteadOf when
> > using pushurl; this tests and fixes that.
> >
> > If you use pushurl with an alias that has a pushInsteadOf
> > configuration value, Git does not take advantage of it.  For
> > example:
> >
> > [url "git://github.com/"]
> >     insteadOf = github:
> > [url "git://github.com/myuser/"]
> >     insteadOf = mygithub:
> > [url "git@github.com:myuser/"]
> >     pushInsteadOf = mygithub:
> > [remote "origin"]
> >     url     = github:organization/project
> >     pushurl = mygithub:project
> 
> Incomplete sentence?  For example [this is an example configuration]
> and then what happens?  Something like "with the sample
> configuration, 'git push origin' should follow pushurl and then turn
> it into X, but instead it ends up accessing Y".
> 
> If there is no pushInsteadOf, does it still follow insteadOf?  Is it
> tested already?
> 
> Wouldn't you want to cover all the combinations to negative cases
> (i.e. making sure the codepath to support a new case does not affect
> behaviour of the code outside the new case)?  A remote with and
> without pushurl (two combinations) and a pseudo URL scheme with and
> without pushInsteadOf (again, two combinations) will give you four
> cases.
> 
> 
> Thanks.

I've taken your advice, and an amended patch follows.

> 
> >
> > Signed-off-by: Rob Hoelz <rob@hoelz.ro>
> > ---
> >  remote.c              |  2 +-
> >  t/t5516-fetch-push.sh | 20 ++++++++++++++++++++
> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/remote.c b/remote.c
> > index ca1f8f2..de7a915 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -465,7 +465,7 @@ static void alias_all_urls(void)
> >  		if (!remotes[i])
> >  			continue;
> >  		for (j = 0; j < remotes[i]->pushurl_nr; j++) {
> > -			remotes[i]->pushurl[j] =
> > alias_url(remotes[i]->pushurl[j], &rewrites);
> > +			remotes[i]->pushurl[j] =
> > alias_url(remotes[i]->pushurl[j], &rewrites_push); }
> >  		add_pushurl_aliases = remotes[i]->pushurl_nr == 0;
> >  		for (j = 0; j < remotes[i]->url_nr; j++) {
> > diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> > index b5417cc..272e225 100755
> > --- a/t/t5516-fetch-push.sh
> > +++ b/t/t5516-fetch-push.sh
> > @@ -244,6 +244,26 @@ test_expect_success 'push with pushInsteadOf
> > and explicit pushurl (pushInsteadOf )
> >  '
> >  
> > +test_expect_success 'push with pushInsteadOf and explicit pushurl
> > (pushInsteadOf does rewrite in this case)' '
> > +	mk_empty &&
> > +	TRASH="$(pwd)/" &&
> > +	mkdir ro &&
> > +	mkdir rw &&
> > +	git init --bare rw/testrepo &&
> > +	git config "url.file://$TRASH/ro/.insteadOf" ro: &&
> > +	git config "url.file://$TRASH/rw/.pushInsteadOf" rw: &&
> > +	git config remote.r.url ro:wrong &&
> > +	git config remote.r.pushurl rw:testrepo &&
> > +	git push r refs/heads/master:refs/remotes/origin/master &&
> > +	(
> > +		cd rw/testrepo &&
> > +		r=$(git show-ref -s --verify
> > refs/remotes/origin/master) &&
> > +		test "z$r" = "z$the_commit" &&
> > +
> > +		test 1 = $(git for-each-ref refs/remotes/origin |
> > wc -l)
> > +	)
> > +'
> > +
> >  test_expect_success 'push with matching heads' '
> >  
> >  	mk_test heads/master &&
> 
