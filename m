From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Make git-update-ref invoke the update and post-update hooks
Date: Mon, 15 Jun 2015 13:22:47 -0700
Message-ID: <xmqqpp4w7mco.fsf@gitster.dls.corp.google.com>
References: <CAEJ-0i-BB=5W-Ah3nkeLFCe5-4XW4CvYaDgdqv1mMp4UGF81qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Brian Vandenberg <phantall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:22:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4auE-0002E1-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbbFOUWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 16:22:51 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34640 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbFOUWt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:22:49 -0400
Received: by igboe5 with SMTP id oe5so39425613igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nrsz6xhNd4BC2WKllaj7JTni/ZLeyLOMZqbuMj2MSAY=;
        b=I3c4sGebfDn7Sgnph66OTRQeIN3vuPDtOqu6FWXuJQ+Ti9DkR0sCAan8k6MUnDK70P
         jxvcKcjDYuS7kCRUqIyTvbS5fHeEh7rIoSdtcAvm/HOiHpNywJEi512T2Fl/NIxgcXa1
         xWIXfBRpOS8qVDlUmP2Mne+jDxf8nFhxp+sDhiUj35Juom2pn7RoGiQFRBHgY0U1aJTI
         3LOKnPfTxRD5hEMhZEHEDU81ODKqhupma3ZMlZ3m+c+bjeay5r1g70i6TQWJIQypdjnt
         1bA3KchH4J4a8F/cyeYoYRsmNSuZyvRLtLMPE2rRcLujMRzfAF+K80eJNCADGwLo1iZ2
         fLkQ==
X-Received: by 10.43.102.132 with SMTP id de4mr32348846icc.13.1434399769213;
        Mon, 15 Jun 2015 13:22:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id h10sm5828503iod.44.2015.06.15.13.22.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 13:22:48 -0700 (PDT)
In-Reply-To: <CAEJ-0i-BB=5W-Ah3nkeLFCe5-4XW4CvYaDgdqv1mMp4UGF81qw@mail.gmail.com>
	(Brian Vandenberg's message of "Mon, 15 Jun 2015 13:49:36 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271723>

Brian Vandenberg <phantall@gmail.com> writes:

> From: Junio C Hamano <junkio@cox.net>
> Date: 2006-10-08 15:00:32
> Petr Baudis <pasky@suse.cz> writes:
>
>>> Someone raised a concern that the update and post-update hooks are not
>>> invoked at fetch time in the similar way as they are invoked at push
>>> time, and the idea sort of makes sense. But this patch goes further - it
>>> makes Git invoke those hooks each time a ref is updated in a repository
>>> using the git-update-ref command, which I believe makes a lot of sense as
>>> well - the behaviour is consistent with the current pushing behaviour
>>> and you suddenly finally get a hook where you can properly notify even
>>> about fast-forwards etc.
>
>>In principle I do not have problem with this approach per-se,
>>but I wonder if we were to do this we might want to make
>>receive-pack.c::update() and cmd_update_ref() call the same
>>underlying function, and make that underlying function implement
>>this "ask the hook if updating is ok" dance.  It might even make
>>sense to have update-ref honor deny_non_fast_forwards for that
>>matter (I am mildly doubtful of this last point, though).

I am ultra-doubtful at this point ;-)

For one thing, update-ref is not a tool that is exclusive to
receiving object transfer aka receive-pack, so it makes no sense for
it to pay attention to post-update.

Also it is a low-level plumbing; the policy issues should come at a
level higher than that.  I.e. Porcelain scripts implemented using
them as building blocks should be the ones that you do your policy,
e.g.

	if whatever logic you want to use in your policy says OK
        then
		git update-ref ...args...
	else
        	echo >&2 "My policy does not like your arguments"
                exit 1
	fi
