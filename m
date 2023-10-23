Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54928224FA
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD15D78
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:51:04 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 746AB23FE5;
	Mon, 23 Oct 2023 15:50:54 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qv0ww-iun-00; Mon, 23 Oct 2023 21:50:54 +0200
Date: Mon, 23 Oct 2023 21:50:54 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Jeff King <peff@peff.net>
Cc: Michael Strawbridge <michael.strawbridge@amd.com>,
	Junio C Hamano <gitster@pobox.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] Revert "send-email: extract email-parsing code into
 a subroutine"
Message-ID: <ZTbOnsxBFERPLN3F@ugly>
References: <20231020100343.GA2194322@coredump.intra.peff.net>
 <20231020101310.GB2673716@coredump.intra.peff.net>
 <ZTJaVzt75r0iHPzR@ugly>
 <20231023184010.GA1537181@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231023184010.GA1537181@coredump.intra.peff.net>

On Mon, Oct 23, 2023 at 02:40:10PM -0400, Jeff King wrote:
>On Fri, Oct 20, 2023 at 12:45:43PM +0200, Oswald Buddenhagen wrote:
>> that seems like a rather significant point, doesn't it?
>
>Maybe. It depends on whether anybody is interested in adding
>continuation support. Nobody has in the previous 18 years, and nobody
>has asked for it.
>
dunno, it seems like a bug to me. so if i cared at all about this 
functionality, i'd fix it just because. so at least it doesn't seem nice 
to make it harder for a potential volunteer.

>> > So another option is to just fix the individual bugs separately.
>> > 
>> ... so that seems preferable to me, given that the necessary fixes 
>> seem
>> rather trivial.
>
>They're not too bad. Probably:
>
>  1. lc() the keys we put into the hash
>
>  2. match to/cc/bcc and dereference their arrays
>
>  3. maybe handle 'body' separately from headers to avoid confusion
>
with the header keys lowercased, one could simply use BODY as the key 
and be done with it.

>But there may be other similar bugs lurking.

>One I didn't mention: the
>hash-based version randomly reorders headers!
>
hmm, yeah, that would mean using Tie::IxHash if one wanted to do it 
elegantly, at the cost of depending on another non-core module.

also, it means that another hash with non-lowercased versions of the 
keys would have to be kept.

ok, that's stupid. it would be easier to just keep an additional array 
of the original keys for iteration, and check the hash before emitting 
them.

>> > I guess "readable" is up for debate here, but I find the inline handling
>> > a lot easier to follow
>> > 
>> any particular reason for that?
>
>For the reasons I gave in the commit message: namely that the matching
>and logic is in one place and doesn't need to be duplicated (e.g., the
>special handling of to/cc/bcc, which caused a bug here).
>
from what i can see, there isn't really anything to "match", apart from 
agreeing on the data structure (which the code partially failed to do, 
but that's trivial enough). and layering/abstracting things is usually 
considered a good thing, unless the cost/benefit ratio is completely 
backwards.

>The "//" one would
>work, but we support perl versions old enough that they don't have it.
>
according to my grepping, that ship has sailed.
also, why _would_ you support such ancient perl versions? that makes 
even less sense to me than supporting ancient c compilers.

regards
