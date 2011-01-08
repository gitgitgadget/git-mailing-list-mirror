From: Kevin Ballard <kevin@sb.org>
Subject: Re: [BUG] git rev-list --no-walk A B C sorts by commit date incorrectly
Date: Fri, 7 Jan 2011 21:51:54 -0800
Message-ID: <E2E98544-70D0-4549-8395-DBE2397F0FCB@sb.org>
References: <CEF26B82-4281-4B8F-A994-DE32EFB92BA7@sb.org> <7v62u043ba.fsf@alter.siamese.dyndns.org> <BB84A2F6-E6B0-49E4-9DC7-6BA8860623E6@sb.org> <7vk4ig7y0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 06:52:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbRic-0006gC-RY
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 06:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816Ab1AHFv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 00:51:57 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60957 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab1AHFv5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jan 2011 00:51:57 -0500
Received: by iyi12 with SMTP id 12so16364383iyi.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 21:51:56 -0800 (PST)
Received: by 10.42.222.6 with SMTP id ie6mr1727992icb.217.1294465916583;
        Fri, 07 Jan 2011 21:51:56 -0800 (PST)
Received: from [10.0.1.14] (c-69-181-71-253.hsd1.ca.comcast.net [69.181.71.253])
        by mx.google.com with ESMTPS id 8sm23688656iba.22.2011.01.07.21.51.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 21:51:56 -0800 (PST)
In-Reply-To: <7vk4ig7y0t.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164807>

On Jan 7, 2011, at 9:41 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> It almost works, but not quite. My inclination is to say
>> `git rev-list --no-walk A B C` should emit A B C in that order. Implemented
>> this way, `git rev-list --no-walk ^HEAD~3 HEAD` emits commits in the wrong
>> order,
> 
> "git rev-list --no-walk ^HEAD~3 HEAD"?  Isn't it a nonsense?  If it is "no
> walk", then why do you even list a negative one?

That seemed odd to me too, but t3508 tests to make sure git cherry-pick accepts
that syntax. Specifically it tests `git cherry-pick ^first fourth`. It does
make a certain sense, though; it should be (and, I believe, is) equivalent to
saying `git rev-list --no-walk HEAD~3..HEAD`, though I don't know if it's
handled the same internally.

> As to cherry-pick, I wouldn't be surprised if it relies on the current
> internal working of pushing commits in the date order to the queue
> regardless of how they were given from the command line.

My belief is that it doesn't. It sets the reverse flag, so it gets the oldest
commit first. I think it's always just been tested taking commits in the same
order that they were committed, which seems fine except when two commits have
the same date. In that case, if A and B have the same date, then A B C will
get transformed to B A C. It's possible that this one quirk can be fixed by
changing the date test in commit_list_insert_by_date to use <= instead of <,
but that still leaves the issue where `git cherry-pick A B C` will sort those
commits even if the user explicitly wanted to apply them in the given order.

I suspect this just wasn't noticed before because cherry-pick didn't used to
accept multiple commits, and after that support was added, nobody's tried to
cherry-pick commits in a different order than they were committed.

> Indeed, it does exactly that, and then tries to compensate it---notice
> that builtin/revert.c:prepare_revs() gives "revs->reverse" to it.  That
> also needs to be fixed.

I did see that, I just left it out of my explanation.

-Kevin Ballard