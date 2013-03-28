From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 12:03:44 -0700
Message-ID: <20130328190344.GA5361@jtriplet-mobl1>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org>
 <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
 <7vfvzfwn55.fsf@alter.siamese.dyndns.org>
 <20130328160937.GD16034@leaf>
 <7vr4iztl3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:04:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULI7Y-0005WR-W9
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab3C1TDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 15:03:53 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54969 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab3C1TDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 15:03:52 -0400
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id E610BA80BE;
	Thu, 28 Mar 2013 20:03:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter22-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id oCrnCJi61OL4; Thu, 28 Mar 2013 20:03:49 +0100 (CET)
X-Originating-IP: 173.246.103.110
Received: from jtriplet-mobl1 (joshtriplett.org [173.246.103.110])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D9DD7A80C2;
	Thu, 28 Mar 2013 20:03:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr4iztl3z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219448>

On Thu, Mar 28, 2013 at 11:50:08AM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> (on url.$base.pushInsteadOf)
> >> If a remote has an explicit pushurl, git will ignore this setting for
> >> that remote.
> > That really meant what I just said above: git will prefer an explicit
> > pushurl over the pushInsteadOf rewrite of url.
> 
> Very correct.
> 
> > It says nothing about
> > applying pushInsteadOf to rewrite pushurl.
> 
> Incorrect, I think.  If you have pushURL, pushInsteadOf is *ignored*.
> Of course, if you have both URL and pushURL, the ignored pushInsteadOf
> will not apply to _anything_.  It will not apply to URL, and it will
> certainly not apply to pushURL.

Debatable whether the documentation sentence above really says that; it
certainly doesn't say it very clearly if so.  But that does match the
actual behavior, making the proposed change a regression from the actual
behavior, whether the documentation clearly guarantees that behavior or
not.

> You are correct to point out that with the test we would want to
> make sure that for a remote with pushURL and URL, a push goes
> 
>  - to pushURL;
>  - not to URL;
>  - not to insteadOf(URL);
>  - not to pushInsteadOf(URL);
>  - not to insteadOf(pushURL); and
>  - not to pushInsteadOf(pushURL).
> 
> I do not think it is worth checking all of them, but I agree we
> should make sure it does not go to pushInsteadOf(URL) which you
> originally meant to check, and we should also make sure it does not
> go to pushInsteadOf(pushURL).

Agreed.

Related to this, as a path forward, I do think it makes sense to have a
setting usable as an insteadOf that only applies to pushurl, even though
pushInsteadOf won't end up serving that purpose.  That way,
pushInsteadOf covers the "map read-only repo url to pushable repo url"
case, and insteadOfPushOnly covers the "construct a magic prefix that
maps to different urls when used in url or pushurl" case.

> >>  test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
> >>  	mk_empty &&
> >> -	TRASH="$(pwd)/" &&
> >> -	git config "url.trash2/.pushInsteadOf" trash/ &&
> >> +	git config "url.trash2/.pushInsteadOf" testrepo/ &&
> 
> Adding
> 
> 	git config "url.trash3/.pusnInsteadOf" trash/wrong &&
> 
> here should be sufficient for that, no?  If we mistakenly used URL
> (i.e. trash/wrong) the push would fail.  If we mistakenly used
> pushInsteadOf(URL), that is rewritten to trash3/ and again the push
> would fail.  pushInsteadOf(pushURL) would go to trash2/ and that
> would also fail.
> 
> We aren't checking insteadOf(URL) and insteadOf(pushURL) but
> everything else is checked, I think, so we can do without replacing
> anything.  We can just extend it, no?

That sounds sensible.

- Josh Triplett
