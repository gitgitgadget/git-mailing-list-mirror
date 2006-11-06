X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: git PATH reordering
Date: Mon, 06 Nov 2006 13:58:39 +0000
Message-ID: <454F3F8F.2080808@shadowen.org>
References: <priv$efbe06146839$619d340665@200611.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 6 Nov 2006 13:59:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <priv$efbe06146839$619d340665@200611.gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31014>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh50A-0000CU-D3 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 14:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753140AbWKFN6p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 08:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbWKFN6p
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 08:58:45 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:61962 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1753140AbWKFN6n
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 08:58:43 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gh4zD-00063X-V0; Mon, 06 Nov 2006 13:58:04 +0000
To: Janos Farkas <chexum+dev@gmail.com>
Sender: git-owner@vger.kernel.org

Janos Farkas wrote:
> Hi!
> 
> I'm facing an issue which seems to originate about a year ago, so I'm a
> bit late :)
> 
> Apparently, most git commands seem to tweak their PATH to make sure the
> corresponding version of a subcommand gets ran in the case there are
> multiple ones in there.
> 
> The thing is, since this "ensuring" is done by prepend_to_path(), which
> can then change all exec() afterwards.   Usually, that's not a problem,
> but that made git run an unexpectedly different ssh command for remote
> access.  When I discovered what the problem is, I easily fixed it by
> setting GIT_SSH to the explicit path, and I can live with that, but it's
> a bit confusing.
> 
> I don't want to start a neverending thread, so if my bikeshed doesn't
> interest you, I'll give up :)  But the way it's done now seems to be for
> the case which should be very rare.
> 
> As I see, all this PATH manipulation logic was meant to solve the case
> when the desired "git" version is not in the path or some mismatching
> components of it is.  Including the case when you want to point some
> higher level tool to one specific version of "git" to be used,
> irrespective of PATH.  Is this the right way to do it?  Is it
> really required at all?

Well its pretty important if you run /usr/local/foo/git clone its
running git-clone from the version you think it is going to.
> 
> Apart from getting rid of this (possibly useful?) munging, I could see
> about two ways to change the behavior to less surprising:
> 
> - Don't make PATH munging if "our" path is in the PATH already.
> - Save the PATH before munging, and restore before any non-git command
>   is run.  This is a bit complex, as multiple languages are used,
>   including sh..
> 
> Both could make sense, but I don't think either is the correct way.

It sounds a lot like we want to be running the equivalent of `dirname
$0`/git-cmd over git-cmd in all cases to ensure we get the right ones.
Perhaps we could export that as GIT_BIN inside the tools.

Something like this might work for shell:

	export GIT_BIN=${GIT_BIN:-`dirname $0`}

	$GIT_BIN/git-rev-list ...

Thoughts?

> 
> What bit me, if someone cares about the details, is that on my system,
> everything is in the correct path, even git*.  There is however a private
> ~/bin at the front of the PATH containing some preferred/fixed versions
> of some system tools.  When git (living as a normal citizen in /usr/bin)
> does its PATH munging, it puts /usr/bin in the front of the path,
> skipping this well built house of cards.  As I said, I can live with
> that, since only ssh is one that I can designate as "important", and
> that one can be set separately with GIT_SSH, but still..

