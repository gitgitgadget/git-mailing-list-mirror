From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] cache-tree: Teach write_cache_as_tree to
 discard_cache
Date: Fri, 20 May 2011 13:07:45 -0500
Message-ID: <20110520180745.GC17177@elie>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
 <1305880223-7542-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:07:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNU79-0001Pe-Vq
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 20:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757247Ab1ETSHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 14:07:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43847 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241Ab1ETSHu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 14:07:50 -0400
Received: by iyb14 with SMTP id 14so3128958iyb.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=o6lCPdM0iMft38Fxp+Vdll0ZOV8k3Bnicu98kSMFbe4=;
        b=DjcMxsk2WZgHyta+5Qc1teMeq6Zi68lN/g/kT6tlI5l4vEyNiHZe3hHF+/LpS417Gx
         Q/pK3/oA6RFtzQ9HdlMwYPRL7PSd/CeFP7WiMWcGq/EdGOj3OoRmehBgcQjU0OluM/U8
         yHAhD+fI92n6/QAOcs8/YDfDZtc/sBzEjCXgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=la6CuE/XX2K8NGzjyNhcEsC3UjSK7HkC68m1gPwZNgTWWgUwt7qav4E+1u05mTAFEe
         wMTSLmkICOGOICgkTbNXNwJUMRqpEs8aQ7a1RBE2+l5iSV832yHyFEe79aOGsCaN1qr9
         jAYRdMQJdv6XACaDsrKVh314lhwIawLbsH7Ao=
Received: by 10.42.117.5 with SMTP id r5mr5265975icq.377.1305914869625;
        Fri, 20 May 2011 11:07:49 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.ameritech.net [69.209.78.180])
        by mx.google.com with ESMTPS id 4sm1623874ibc.15.2011.05.20.11.07.47
        (version=SSLv3 cipher=OTHER);
        Fri, 20 May 2011 11:07:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305880223-7542-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174072>

Hi,

Ramkumar Ramachandra wrote:

> If the read_cache() call succeeds, the function must call
> discard_cache() before returning to the caller.
>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>

Sorry, I was unclear.  What I meant is this: currently all three
callers to write_cache_as_tree() call die() or exit() if it fails.
When a new caller wants to carry on after failure, that requires some
careful thinking about what the state should be when it resumes.

Toward that end, your patch "[PATCH 1/8] revert: Improve error
handling by..." included

> -		if (write_cache_as_tree(head, 0, NULL))
> -			die (_("Your index file is unmerged."));
> +		if (write_cache_as_tree(head, 0, NULL)) {
> +			discard_cache();

but it doesn't feel right.  Why after trying to write-tree do we undo
the _reading_ of a tree?  It seemed strange.

So let's think carefully about what the state should be after
write-tree fails.  Does it discard_cache() to make valgrind happier?
Or do we keep the in-core index cached for use in later operations?
Whichever is the right choice would be likely to apply equally well to
"git cherry-pick" and other write_cache_as_tree callers.

I foolishly did not ask "do you really want to discard_cache() here?"
and instead said something to the effect of "if you are going to
discard_cache(), won't that apply equally to all callers?", while the
former is a better question.  Of course this would all be easier if we
had an example to think about that cared about the index state on
error one way or another.

If I understand correctly, the sequencer does not care about the state
at all, and just wants to write a few files under .git and print a
message.  It could do that just as well by keeping the die() and
setting up a die handler.
