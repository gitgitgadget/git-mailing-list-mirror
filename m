From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/14] revert: Introduce --reset to cleanup sequencer data
Date: Wed, 6 Jul 2011 14:21:41 -0500
Message-ID: <20110706192141.GA23516@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-13-git-send-email-artagnon@gmail.com>
 <CALkWK0nhH=_3+Gj=O4Ov2zOGBoVquzD--+RW_QYYnb8YMAHniA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 21:21:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeXfX-0000AI-SO
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 21:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab1GFTVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 15:21:50 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:39507 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab1GFTVu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 15:21:50 -0400
Received: by yia27 with SMTP id 27so118116yia.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ui3O1nf4muQ21OJceui7eCUT+obt7E6rHQwq+/1v/5s=;
        b=uTAQy44r0p21LGucVMOaO6KOXG+VFQtRWnrP4Ku+/Dioq9qDdD49etENOHWRNx9keD
         B81qJFTG8d78tuCb4VV8ZmKKV8cbiYmoEx9CbJnr0s93E/c59tjNAPj1w4E4vg7OEPBY
         QbsPA0FvZTxILPtjdExpW4pWaAg7w7nML0eKY=
Received: by 10.150.113.9 with SMTP id l9mr162071ybc.389.1309980109609;
        Wed, 06 Jul 2011 12:21:49 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id n17sm1053527ybe.5.2011.07.06.12.21.47
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 12:21:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nhH=_3+Gj=O4Ov2zOGBoVquzD--+RW_QYYnb8YMAHniA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176725>

Ramkumar Ramachandra wrote:

>> --- a/t/t3507-cherry-pick-conflict.sh
>> +++ b/t/t3507-cherry-pick-conflict.sh
[...]
> As you can see, there is no "reset --hard" in these

In this one, there's "git checkout -f && git read-tree -u --reset HEAD
&& git clean -fdx", which is almost the same thing.

>> --- a/t/t3505-cherry-pick-empty.sh
>> +++ b/t/t3505-cherry-pick-empty.sh

This one is not a typical script, I think --- if you knew the
cherry-pick was going to be empty, why did you try it in the first
place?  I think it would make sense to make it "git reset --hard" at
the beginning of each test as a separate, preparatory patch with
explanation.

[...]
> There is however, one other thing I can do: if there is
> nothing left to cherry-pick after a successful conflict resolution +
> git commit, I can modify commit.c to blow away the sequencer state
> after checking appropriately.  This will also have a nice end-user
> experience side-effect:
> $ git cherry-pick moo
> fatal: Conflict in foo!
> $ echo "Resolved" > foo
> $ git add moo
> $ git commit
> $ git cherry-pick --continue # This no-op will be unnecessary

Though it's not obvious to me how this would affect the scripts above,
it sounds like a nice enhancement to me independently, fwiw.

> Then again, teaching commit about the sequencer is inelegant,

It's possible to add some hook-like thing to do this, or to structure
the code as if a hook was used.

> and it's
> possible to achieve this effect in another way: when a conflict is
> encountered in the sequencer && length(todo_file) == 1, throw away the
> sequencer state.

Yep, that seems like basically the same effect.  Are there downsides?
(Maybe years from now when a "git cherry-pick --rewind" is introduced
we would regret this?  But that can be figured out years from now.)
