From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Enable core.fsyncObjectFiles by default
Date: Tue, 23 Jun 2015 19:29:21 -0400
Message-ID: <20150623232921.GB14324@thunk.org>
References: <1435096643-18159-1-git-send-email-sbeller@google.com>
 <xmqqpp4maww7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	peff@peff.net, torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 01:29:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7XdD-0006SL-JX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 01:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbbFWX31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 19:29:27 -0400
Received: from imap.thunk.org ([74.207.234.97]:51430 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932359AbbFWX3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 19:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=eMxL8GinIuEPCSgbjjz1xIi4GC0d1pMfM1ar6oJSPdY=;
	b=ntf4syAmZDD7y5DKI3Gn5cBOlcAITD+TpUG6qnEJ/8Z/w62xsk4a0jDQGhKt5hQ7lXgLOtj8eb2FR5KFq7RDWiCO46k3F/ozf0vZehGVSjCvmcHdgn4QyTDW0w24NlLCB10jJL2xYIDeSnqUK0VrNoSesTsWH3crDER6TeZNOxI=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1Z7Xd4-0006NG-Rm; Tue, 23 Jun 2015 23:29:22 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id AADA95809A2; Tue, 23 Jun 2015 19:29:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqpp4maww7.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272525>

The main issue is that non-expert users might not realize that they
really need to run "git fsck" after a crash; otherwise, what might
happen is that although git is only appending, that you might have
some zero-length (or partially written) git object or pack files, and
while you might not notice at that moment, it might come and bite you
later.  If you do try to recover immediately after a crash, in the
worst case you might have to do that "git am -s /tmp/mbox-filled-with
patches" command, but otherwise you won't lose much data.

So perhaps one alternative strategy to calling fsync(2) after every
single git object file write might be to have git create a zero-length
".git/in-progress-<pid>" file, which gets fsync'ed, and then it can do
the "git am -s /tmp/akpm-big-bag-o-patches" processing nice and fast,
and once git is done, then we call call sync(2) and then delete the
in-progress file.

If there is an in-progress file in the .git directory, git would then
automatically run git fsck to make sure the repository is consistent.

For people who care, maybe that's a good compromise.  (Me, the way
things are right now is just fine since I have a nice fast SSD, and so
setting fsyncObjectfiles is a perfectly fine thing as far as I am
concerned. :-)

		      		     	   - Ted
