From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] fix clone guess_dir_name regression in v2.4.8
Date: Wed, 05 Aug 2015 10:19:56 -0700
Message-ID: <xmqq8u9p4pqb.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
	<0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
	<20150804043401.4494.43725@typhoon>
	<CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
	<20150804224246.GA29051@sigill.intra.peff.net>
	<20150805083526.GA22325@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:20:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN2MG-0005Sr-5t
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbbHERT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:19:59 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35468 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbHERT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:19:58 -0400
Received: by pabxd6 with SMTP id xd6so23153617pab.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IeepgkGg98++EG9O4gScvlS9QKMtp/99+TnghZdAMyI=;
        b=p/M8l2zbdrK0E8te81tHIQQ725zZ+rwkfPtW0FsaBjV41YPNw3U5FVD6/Hf0QtK2sA
         WHGy7HSAwI5M2GejusFxay4l9wSft4SmfjSmmpqvlJhzhFSjauIJ4+mwUKC/bvyBzEEs
         mHd8IuVSi0eH0a9GJDfI2zu55odSxwxH+1lG/2T1h2mjGsJiGaS2Uli7hNLRSYKxxDfE
         qiy6rJhO+n4+5WShri3256LZ9pA93RF4+6d44KHc1R5h3y7x/SXDPxa677XXGLDlTMy7
         6CSd0PvRKEYXr4jOWtwKNeLh8FhYfSChrNFiJai14/FS04wr22r23hCX+g3X3N6iWTGU
         lyNg==
X-Received: by 10.68.241.166 with SMTP id wj6mr21490783pbc.114.1438795198024;
        Wed, 05 Aug 2015 10:19:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id ow5sm3558163pdb.30.2015.08.05.10.19.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 10:19:57 -0700 (PDT)
In-Reply-To: <20150805083526.GA22325@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Aug 2015 04:35:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275378>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2015 at 06:42:46PM -0400, Jeff King wrote:
>
>> > I did not intend this change in behavior, and I can confirm that
>> > reverting my patch restores the original behavior. Thanks for bringing
>> > this to my attention, I'll work on a patch.
>> 
>> I think this regression is in v2.4.8, as well. We should be able to use
>> a running "len" instead of the "end" pointer in the earlier part, and
>> then use strip_suffix_mem later (to strip from our already-reduced
>> length, rather than the full NUL-terminated string). Like this:
>
> Looks like "git clone --bare host:foo/.git" is broken, too. I've added
> some tests to cover the recently broken cases, as well as some obvious
> normal cases (which the patch I sent earlier break!). And as a bonus, we
> can easily cover Patrick's root-repo problems (so people will actually
> run the tests, unlike the stuff in t1509. :) ).

Sorry, my fault; I should have been much less trusting while queuing
a patch like that offending one that was meant to be a no-op.

> Here are the patches.
>
>   [1/2]: clone: add tests for output directory
>   [2/2]: clone: use computed length in guess_dir_name
>
Thanks.
