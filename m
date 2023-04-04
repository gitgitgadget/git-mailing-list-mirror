Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6719C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 16:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjDDQ0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjDDQ0H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 12:26:07 -0400
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 09:26:05 PDT
Received: from out-13.mta1.migadu.com (out-13.mta1.migadu.com [IPv6:2001:41d0:203:375::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDA740E6
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 09:26:05 -0700 (PDT)
Date:   Tue, 4 Apr 2023 17:16:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mvdan.cc; s=key1;
        t=1680625024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=otZpaowtRsOX87f6gjYYkqy/hgDpy04Ttacaatb/lQA=;
        b=VNUdfJCIzDQ9aWAIgbhymhPVhrsW0Jh7O5Gj4VY9enB05ek9vie84VJIDDZQppmKyyaUjM
        xTQxwilRRNJgvOqBlcIXhtk0lkfzwMd3sbQsBWqpBzBNmu78EgtoptT+FpKoKaNNEBp3nD
        6zE3jKjvrB4rDA1oSYAOyhIZM+KClOs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Daniel =?utf-8?B?TWFydMOt?= <mvdan@mvdan.cc>
To:     git@vger.kernel.org
Subject: mirror clone does not keep HEAD updated
Message-ID: <harpgnimhcdp2m6hww7ht7pgxvchllvrncnwoxkivaorb5xhm7@5rcr2p7hcp4x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I'm testing `git clone --mirror` to properly mirror a repository on
github.com. It appears to be working well, except for keeping HEAD
correctly in place.

For example, here is what I did:

	$ git clone --mirror https://github.com/mvdan/test-repo
	$ cd test-repo
	$ git branch -a
	* main
	$ git log HEAD
	commit d1adda533e90692e02ae837233368fbcca2a0e49 (HEAD -> main)
	[...]

If I then go on the GitHub web UI to rename the default branch from
"main" to "newmain", `git remote update --prune` sees that:

	$ git remote update --prune
	From https://github.com/mvdan/test-repo
	 - [deleted]         (none)     -> main
	 * [new branch]      newmain   -> newmain

However, HEAD stops working:

	$ git log HEAD
	fatal: your current branch 'main' does not have any commits yet

Am I holding the mirror wrong somehow? As far as the manpages say, `git
remote update` should be enough to fully mirror all refs.
And my understanding is that using HEAD is correct, that I do not need
to use origin/HEAD like in a regular git clone.

I also tried what I would usually do to sync origin/HEAD in a regular
git clone, but unsurprisingly, that does not work:

	$ git remote set-head origin -a
	error: Not a valid ref: refs/remotes/origin/newmain

Any pointers appreciated. Assuming I'm not missing anything obvious
here, this might be a bug in `git remote udpate` for mirror clones.
