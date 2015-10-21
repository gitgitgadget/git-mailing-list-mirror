From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow "clone --dissociate" to dissociate from alternates
Date: Wed, 21 Oct 2015 10:52:26 -0700
Message-ID: <xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
References: <561F8DE9.4040703@cetitec.com>
	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:52:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoxZ3-00061o-P8
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 19:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbbJURwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 13:52:37 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35879 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbJURwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 13:52:36 -0400
Received: by pacfv9 with SMTP id fv9so63455567pac.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RE6Bjl5VeHswxlk9Y/ATQxgkBfyZKEBKIFeuWWzx2cY=;
        b=caol1BS02gzSJc3hzh+M/v2kkPQ1OG5M4qixUgGjT6UHdunWEPujEdw2KYmbvbH8bt
         zpcctev7qhJh1GQUblr5ccisIqmElQGW7JMvzJGEnoGoxVE5T0QsRs9dlhg0rLv/ttVE
         h2tYciFpWeqvGXT5XsLMe45unQIetZ7YkPbT5193OILPP55xJiegc6NQvAwEsG+EC3YW
         vwUxVl/D+vqk95HslChDxroF2DRBFNtbNcqMwlxyCxQrw18E+LwjZKRhrxox5DdCLgFh
         Y4jTwyTLNPmZJ1rG5YUtjrQhqmWVeUzzdIwEzBlqntRvruTDb9DWqSg53qHJQ50hJrjW
         q44A==
X-Received: by 10.66.102.74 with SMTP id fm10mr11666116pab.113.1445449956138;
        Wed, 21 Oct 2015 10:52:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id ro3sm10231359pbc.69.2015.10.21.10.52.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 10:52:35 -0700 (PDT)
In-Reply-To: <56274922.80007@cetitec.com> (Alexander Riesen's message of "Wed,
	21 Oct 2015 10:13:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279994>

Alexander Riesen <alexander.riesen@cetitec.com> writes:

> Reminder. Is this (or rather the one I'm replying to) patch a better option?

I suspect that the reason why you didn't get any quick response was
because it was unclear from either one of these proposed log
messages why any change is needed in the first place.  At least that
is what prevented me from commenting on either.

The "clone --dissociate" was designed to be used with "--reference".
The mindset of those who saw the need for the feature being that
"clone --reference" is the only way to make the resulting
repository's objects incomplete, needing to borrow objects from some
other place, which necessitates the "--dissociate" option.

The readers of this change need to be enlightened with a log message
to remind them that "--reference" is not the only way.  Namely, if
you start from a repository with $GIT_DIR/objects/info/alternates,
i.e. the original already borrows from somewhere, and bypass the
normal "Git aware" transport mechanism, i.e. "git clone --local",
then the resulting repository would also become dependent of the
object store that the original depended on before the clone.  In
order to make it free-standing, you would need "--dissociate", but
there is no "--reference" involved in that use case.

And once that is clarified, it becomes very clear why it is wrong to
blindly require "--reference" to be there on the command line when
"--dissociate" is given.

As to the patch, I think this one is much simpler and preferrable.
It would hurt those who make a clone without bypassing the normal
"Git aware" transport mechanism and pass "--dissociate" without
"--reference".  They will end up making a clone that does not need
repacking to dissociate, but with this patch they would spend extra
cycles to run an unnecessary repack.  To avoid that, I think you can
throw in an check at the beginning of dissociate_from_references()
to see if git_path("objects/info/alternates") is there and make the
function a no-op if there isn't.

Thanks.
