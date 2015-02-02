From: Jonathon Mah <me@jonathonmah.com>
Subject: Re: [PATCH 2/2] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 10:37:57 -0800
Message-ID: <9215E7CF-4A6C-48ED-8A63-76085D5B151A@jonathonmah.com>
References: <BF4AA771-DEB5-4DED-9C74-768036C1E2DD@jonathonmah.com> <50251CB8-0885-40FF-A7C9-9C9460266E14@jonathonmah.com> <20150202175259.GA24025@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 19:38:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YILtH-0005Q9-1B
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 19:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbbBBSi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 13:38:27 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57114 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754292AbbBBSi0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 2 Feb 2015 13:38:26 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 9EBB020939
	for <git@vger.kernel.org>; Mon,  2 Feb 2015 13:38:03 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 02 Feb 2015 13:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=jonathonmah.com;
	 h=x-sasl-enc:content-type:mime-version:subject:from:in-reply-to
	:date:cc:content-transfer-encoding:message-id:references:to; s=
	mesmtp; bh=JbWYTzPn0/TmBjuHgekqtBKbcvo=; b=FwFIOiOIciBHBgHh+Jlot
	yyTrjcsHQbW5wWs4ojEHo2Pw66KbQlLHS3lzDwLD9+p3tRHuW/eAuMvmJxltCjkT
	rUazIyc/8cMDXd3p1/bVias8ZvZeJD3lruiQ4PWVOMI4ue1EebUgc3+E4AWinh/W
	uthY26YBfd5jS+Q34to5Bk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:content-type:mime-version
	:subject:from:in-reply-to:date:cc:content-transfer-encoding
	:message-id:references:to; s=smtpout; bh=JbWYTzPn0/TmBjuHgekqtBK
	bcvo=; b=iFLy5zzkSh0jP8zYEvNbjORZUoEqucVSeDlS0D8K8kFZpck1RJeBlK8
	LTuelydaCy7tMgZd7fVzQ2FJoOXMkNugEWeH+f3l7ihIPQ25HtyTlvSNCwXw282l
	ZiLySnf9y0aRj+rSh5gNCOjnYitAgJzUcRKmB+wrsNMHtUdWSta4=
X-Sasl-enc: yArQWHqhBt9IJNNs+0umzEmaVXC7OeU7GVgY9gAci8OP 1422902277
Received: from [172.16.3.162] (unknown [206.169.144.70])
	by mail.messagingengine.com (Postfix) with ESMTPA id 34CEBC002A9;
	Mon,  2 Feb 2015 13:37:57 -0500 (EST)
In-Reply-To: <20150202175259.GA24025@peff.net>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263270>

> On 2015-02-02, at 09:53, Jeff King <peff@peff.net> wrote:
> 
> I think this is probably the best fix, and is the pattern we use
> elsewhere when touching alt->base.
> 
> We _could_ further change this to have for_each_loose_file_in_objdir
> actually use alt->base as its scratch buffer, writing the object
> filenames into the end of it (i.e., what it was designed for). But:
> 
>  1. We still need a strbuf scratch-buffer for the non-alternate object
>     directory. So we'd have to push more code there to over-allocate
>     the buffer, and then for_each_loose_file_in_objdir would assume
>     we always feed it a buffer with the extra slop. That would work,
>     but I find the strbuf approach a little safer; there's not an
>     implicit over-allocation far away in the code preventing us from
>     overflowing a buffer.
> 
>  2. The reason for the existing alt->base behavior is that the
>     sha1_file code gets fed objects one at a time, and don't want to
>     pay strbuf overhead for each. With the iterator, we know we are
>     going to hit a bunch of objects, so we only have to pay the strbuf
>     overhead once for the iteration. So there's not the same
>     performance penalty, and we can stick with the strbuf if we prefer
>     it.

Thanks for your feedback. I considered the same, and came to a similar conclusion. The strbuf cost is only once per alternate, so I feel on balance it's more robust to use alt->base consistently inside each function, rather than have this a more fragile special case to save allocation of only one path.

Updated the test patch.


Jonathon Mah
me@JonathonMah.com
