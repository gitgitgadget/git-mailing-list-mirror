From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bisect needing to be at repo top-level?
Date: Wed, 09 Oct 2013 20:27:58 +0200
Message-ID: <5255A02E.3050405@googlemail.com>
References: <CAJTo0LZ=bNNUc8O=bDDOp2vudsc_wL+-nqsXW5r1rq3H7M0e7Q@mail.gmail.com>	<xmqqbo3rz7ca.fsf@gitster.dls.corp.google.com>	<20130917175813.GA14173@blizzard> <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Burton\, Ross" <ross.burton@intel.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Wed Oct 09 20:28:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTyUS-00060k-BM
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 20:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab3JIS1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 14:27:50 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:41489 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab3JIS1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 14:27:49 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so616521eak.32
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=d5M9e6ooU7whN7gycToDUpJ3sw7XLkXehkqWOHeA7XU=;
        b=gieKaZwJlz6C69ZBPQKUKqW/kdz554J+N1yc1vi1Ej874edY0VEZdVQFg5hvZrCTB9
         DtYH1h0eXuB4KX2yx7mRWDlTnHS3he69eLJa89gkWKLJRehVl/RFOWwpslD+o6L9ltju
         0rxQqfdjUogmxSb+AG+dMOYjFHYAAySniKnT0fJxlULr96d+MogOhtA2dLzd6tIDnFN3
         Vllg+1bNGeC7MjoljFBwvdPgT2w6pY2eoMgpRp9xJ15hjqyBj1/zBk4wFtl02t0qlj6r
         7k1YjlN/xYUl1Y8iZxSQAeKIFE3KtGk6CjJPrV2BDP61RYw7Nu/rTALkq5DL/t44O8ix
         1M+A==
X-Received: by 10.14.113.137 with SMTP id a9mr13382105eeh.3.1381343268344;
        Wed, 09 Oct 2013 11:27:48 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id h45sm91706999eeg.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 11:27:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <xmqqioxzxnjh.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235831>

Reigniting the discussion from three weeks ago:
I found it at http://git-blame.blogspot.de/search?q=leftover

On 09/17/2013 09:20 PM, Junio C Hamano wrote:
> 
> At least on Linux, if you checkout a revision with "foo/" directory,
> chdir to it and then checkout a revision with "foo" file to nuke
> your current place, I know "git checkout" will happily do so and you
> will still be in a directory that is connected nowhere.  Your ".."
> is probably pointing at the top-level, but there is no reverse, so
> "cd ../foo" may or may not work from that state, and it would lead
> to an interesting confusion.
> 
> We may want to check the condition and forbid such a checkout.

I think forbidding such a checkout is a bit hard:
	$ git checkout <branch>
	fatal: checkout not possible, because of said reason (dangling pwd)
	$ cd ../.. # go to top level or somewhere else unaffected
	$ git checkout <branch> # this will work

Wouldn't it be better to navigate to the 'nearest' possible working dir on checkout?
Such a workflow would emerge:
	$ git checkout <branch> # this includes the "cd .." of the previous step, it just went the dir structure up, until a valid dir was found.
	warning: the current working directory is not part of the tree, navigating to $(PWD)

Personally I feel this is more what you'd actually want.
This discussion will become interesting once we have a commit (mostly?) renaming a folder:
	dir1/* => dir2/*
	
If you're checking out accross such a change, we'd end up in the top level
directory, which is safe, but maybe not fully optimal. But still better than forbidding
it in the first run.

Stefan
