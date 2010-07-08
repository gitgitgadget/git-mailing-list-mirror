From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 08 Jul 2010 14:21:35 +0100
Message-ID: <1278595295.2668.10.camel@wpalmer.simply-domain>
References: <20100701150331.GA12851@sigill.intra.peff.net>
	 <20100701153842.GA15466@sigill.intra.peff.net>
	 <20100702192612.GM1333@thunk.org>
	 <20100703080618.GA10483@sigill.intra.peff.net>
	 <20100704005543.GB6384@thunk.org>
	 <20100705122723.GB21146@sigill.intra.peff.net>
	 <20100705141012.GA25518@thunk.org>
	 <20100706115826.GA15413@sigill.intra.peff.net>
	 <1278430303.32094.15.camel@wpalmer.simply-domain>
	 <20100706165336.GJ25518@thunk.org>
	 <20100708112802.GA2294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 15:29:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWr9x-0007d6-Ey
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 15:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711Ab0GHN2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 09:28:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59047 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab0GHN2x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 09:28:53 -0400
Received: by wwb24 with SMTP id 24so3813360wwb.1
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 06:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=qO5D1yg8H0uAZSDyd2j36ZaMp42pH0c5/hJWR/TocpU=;
        b=LMY7aZYurnDEgZh8DLZPcpemvCfmYIlk9mXScKb1XG2Z0xB+RfowLRxb37dR1QZGpz
         9YDL7s5h+PaMK+V3q9Jf72MOQH91IDmRzbNljUo8hS3uUFi8Kkzz7KZf8btHkf569C98
         tWi5KoyjqQ7cEGYxvNjPSAgTrm70GwCX06ADM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ANnQ0l+/H7jzgab3TaKnOaZ2jgzXrDGoFVn/i58YhH6xwlEho7loxQxkP5o6Yayv78
         KylBE6BaCeSZGOk0MWuTuvwrfAf7s5OKF5rc2oAVC6sMESOXqCsZzG3gOA2HFs3Y0hpX
         MWrjFcQWTGPMhNhgYHGMMz40SQEB5zJUE+A/o=
Received: by 10.227.135.65 with SMTP id m1mr6650832wbt.212.1278595299233;
        Thu, 08 Jul 2010 06:21:39 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id p29sm51187024wbc.7.2010.07.08.06.21.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 06:21:38 -0700 (PDT)
In-Reply-To: <20100708112802.GA2294@sigill.intra.peff.net>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150572>

On Thu, 2010-07-08 at 07:28 -0400, Jeff King wrote:
> On Tue, Jul 06, 2010 at 12:53:36PM -0400, tytso@mit.edu wrote:
> Whatever we do with the optimization, I do agree with your suggestion at
> least for "git commit" to avoid making such commits.  Rejecting them
> during fetchs and pushes would be a nice, too, but should probably just
> be a warning at first, in case you have to pull from somebody with an
> older git...[snip]
> Yeah. I think the real question is what the default for that parameter
> should be: pessimistic but always correct, optimistic but possibly
> incorrect in the face of skew, or auto-tuned per-repository.
> -Peff

I think these two go hand-in-hand, and would resolve most of my issues
with it. Auto-tune, starting pessimistically, but then using something
more-optimized after something like gc has detected that it's okay. On
pull from an older repository (which I see as happening very frequently,
I add remotes much more often than I do a straight "clone"), a warning
and an auto-tune to something which would account for the newly-fetched
bad data.

My only other objection is more wishy-washy and/or lazy: currently a
"commit" doesn't need to know anything at all about what it references
in order to be considered a valid object, but saying "the time of commit
needs to be equal to or greater than the parent commit" means that a
tool.. and by "tool" I mean "wretched abuse of cat-file and sed", which
is sometimes just faster to throw-together than filter-branch ..needs to
be more aware of what it's doing. Yes, it's a horrible abuse, but I was
always under the impression that low-level abuse of the system is
something which git supports, by virtue of having such a simple model.
