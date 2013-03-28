From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 09:09:37 -0700
Message-ID: <20130328160937.GD16034@leaf>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
 <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
 <7vfvzfwn55.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFP4-0005UT-AS
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336Ab3C1QJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:09:46 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:59547 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3C1QJq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:09:46 -0400
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id F074D172089;
	Thu, 28 Mar 2013 17:09:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter22-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id p-Jv-CvvJRTO; Thu, 28 Mar 2013 17:09:42 +0100 (CET)
X-Originating-IP: 50.43.39.152
Received: from leaf (static-50-43-39-152.bvtn.or.frontiernet.net [50.43.39.152])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6C25A1720A9;
	Thu, 28 Mar 2013 17:09:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfvzfwn55.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219419>

On Thu, Mar 28, 2013 at 08:37:58AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > On Wed, Mar 27, 2013 at 05:48:45PM -0500, Rob Hoelz wrote:
> > ...
> >> The test that checked that pushInsteadOf + pushurl shouldn't work as I
> >> expect was actually broken; I have removed it, updated the
> >> documentation, and sent a new patch to the list.
> >
> > There's an argument for either behavior as valid.  My original patch
> > specifically documented and tested for the opposite behavior, namely
> > that pushurl overrides any pushInsteadOf, because I intended
> > pushInsteadOf as a fallback if you don't have an explicit pushurl set.
> 
> For only this bit.
> 
> I think the test in question is this one from t5516:
> 
> test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
> 	mk_empty &&
> 	TRASH="$(pwd)/" &&
> 	git config "url.trash2/.pushInsteadOf" trash/ &&
> 	git config remote.r.url trash/wrong &&
> 	git config remote.r.pushurl "$TRASH/testrepo" &&
> 	git push r refs/heads/master:refs/remotes/origin/master &&
> 	(
> 		cd testrepo &&
> 		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
> 		test "z$r" = "z$the_commit" &&
> 
> 		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
> 	)
> '
> 
> It defines a remote "r", with URL "trash/wrong" (used for fetch) and
> pushURL "$(pwd)/testrepo" (used for push).  There is a pushInsteadOf
> rule to rewrite anything that goes to "trash/*" to be pushed to
> "trash2/*" instead but that shouldn't be used to rewrite an explicit
> pushURL.
> 
> And then the test pushes to "r" and checks if testrepo gets updated;
> in other words, it wants to make sure remote.r.pushURL defines the
> final destination, without pushInsteadOf getting in the way.
> 
> But $(pwd)/testrepo does not match trash/* in the first place, so
> there is no chance for a pushInsteadOf to interfere; it looks to me
> that it is not testing what it wants to test.

That test does actually test something important: it tests that the
result of applying pushInsteadOf to url does *not* override pushurl.
Not the same thing as testing that pushInsteadOf does or does not apply
to pushurl.

The relevant sentence of the git-config manpage (in the documentation
for pushInsteadOf) says:
> If a remote has an explicit pushurl, git will ignore this setting for
> that remote.
That really meant what I just said above: git will prefer an explicit
pushurl over the pushInsteadOf rewrite of url.  It says nothing about
applying pushInsteadOf to rewrite pushurl.

> Perhaps we should do something like this?  We tell it to push to
> "testrepo/" with pushURL, and set up a pushInsteadOf to rewrite
> "testrepo/" to "trash2/", but because for this push it comes from an
> explicit pushURL, it still goes to "testrepo/".
> 
> As we do not have "trash2/" repository, the test not just tests the
> push goes to "testrepo/", but it also tests that it does not attempt
> to push to "trash2/", checking both sides of the coin.

Sensible test, assuming you want to enforce that behavior.  I don't
strongly care either way about that one, since it only applies if your
pushInsteadOf rewrites could apply to your pushurl, and I only ever use
pushInsteadOf to rewrite unpushable repos to pushable ones.  However...

>  t/t5516-fetch-push.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index d3dc5df..b5ea32c 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -230,10 +230,9 @@ test_expect_success 'push with pushInsteadOf' '
>  
>  test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
>  	mk_empty &&
> -	TRASH="$(pwd)/" &&
> -	git config "url.trash2/.pushInsteadOf" trash/ &&
> +	git config "url.trash2/.pushInsteadOf" testrepo/ &&
>  	git config remote.r.url trash/wrong &&
> -	git config remote.r.pushurl "$TRASH/testrepo" &&
> +	git config remote.r.pushurl "testrepo/" &&
>  	git push r refs/heads/master:refs/remotes/origin/master &&
>  	(
>  		cd testrepo &&

...the test you describe should appear in *addition* to this test, not
replacing it, because as described above this test does test one
critical bit of behavior, namely prefering pushurl over the
pushInsteadOf rewrite of url.

- Josh Triplett
