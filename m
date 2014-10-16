From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is
 only temporary
Date: Thu, 16 Oct 2014 11:26:54 -0400
Message-ID: <543FE3BE.9010307@xiplink.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>	<543E85FA.6050404@xiplink.com>	<xmqqwq81w8az.fsf@gitster.dls.corp.google.com>	<543EDE6A.7040500@xiplink.com>	<xmqqsiipuifi.fsf@gitster.dls.corp.google.com>	<543EEAC4.8070204@xiplink.com> <xmqqfvepuhmy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 17:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xemx4-0001gh-E0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 17:26:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbaJPP0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 11:26:50 -0400
Received: from smtp106.ord1c.emailsrvr.com ([108.166.43.106]:36493 "EHLO
	smtp106.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750947AbaJPP0u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Oct 2014 11:26:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp22.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 6399E180BDA;
	Thu, 16 Oct 2014 11:26:49 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp22.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 05007180BD0;
	Thu, 16 Oct 2014 11:26:48 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.13);
	Thu, 16 Oct 2014 15:26:49 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqfvepuhmy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-10-15 05:50 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> Yes, but we're cloning gko, not the neighbour.  Doesn't that mean that the
>> clone operation won't know about any of the neighbour's refs?
> 
> No.  --reference (and a natural implementation of --borrow, I would imagine)
> peeks the refs of the repository we borrow from and that is how
> clone can say "I already have objects reachable from these refs, so
> please send me the remainder" to the repository it is cloning from.

By "know about" I meant "want to use".  Sorry for being a bit dense about
this; let me try again.

(BTW, it occurs to me that your patch -- if I read it right -- doesn't
fulfill your scenario since it disassociates the clone from all repos,
regardless of whether they are specified with --reference or --borrow.  In
the following I assume a --borrow that only disassociates from the specified
repo and leaves the --reference repo(s) alone.)

Since we're cloning gko's refs, all of the neighbour's unique refs and
objects can be ignored.  Even though paths to the neighbour and the local
pool will be in the clone's alternates file, any refs the clone operation
creates won't need to use any objects from the neighbour.  The clone
operation gives us no way to refer to the neighbour's unique objects.

I just don't see what difference the --borrow option makes.  Consider the two
cases:

With just --reference=/local/pool/linux.git:
	1. Set up the alternates file with that path.
	2. Copy gko's refs into refs/remotes/origin/.
	3. Set up refs/heads/master to refer to gko's HEAD.
	4. Checkout refs/heads/master (uses objects from local pool).

With both that --reference and --borrow=../my/neighbour/linux-hack.git:
	1. Set up the alternates file with both paths.
	2. Copy gko's refs into refs/remotes/origin/.
	3. Set up refs/heads/master to refer to gko's HEAD.
	4. Checkout refs/heads/master (uses objects from local pool).
	5. Disassociate ourselves from the neighbour repo.

In both cases the first four actions have no need of the neighbour repo.  The
second case's fifth action surgically removes the neighbour as an alternate
object store, and we're left with the same clone we got in the first case.
What was the point?

It seems that in order to make something like --borrow useful, "git clone"
would somehow need to know which of the neighbour's refs you want to *also*
clone, then copy any unique objects from the neighbour before disassociating
from it.

		M.
