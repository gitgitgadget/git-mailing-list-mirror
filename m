From: =?UTF-8?Q?Stefan_Fr=c3=bchwirth?= <stefan.fruehwirth@uni-graz.at>
Subject: Re: [PATCH] merge_blobs: use strbuf instead of manually-sized
 mmfile_t
Date: Fri, 19 Feb 2016 13:43:49 +0100
Message-ID: <56C70E05.8020508@uni-graz.at>
References: <56C2459B.5060805@uni-graz.at>
 <20160216011258.GA11961@sigill.intra.peff.net>
 <20160216050915.GA5765@flurp.local>
 <20160216055043.GB28237@sigill.intra.peff.net> <56C31291.1010308@uni-graz.at>
 <20160216203526.GA27484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 13:44:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWkQ1-0006A8-Bl
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 13:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757634AbcBSMnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 07:43:55 -0500
Received: from EX07HTCA01.UNI-GRAZ.AT ([143.50.13.79]:25124 "EHLO
	ex07htca01.uni-graz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757126AbcBSMny (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 07:43:54 -0500
Received: from EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) by
 ex07htca01.pers.ad.uni-graz.at (2002:8f32:d4f::8f32:d4f) with Microsoft SMTP
 Server (TLS) id 8.3.406.0; Fri, 19 Feb 2016 13:43:51 +0100
Received: from [143.50.233.116] (143.50.233.116) by
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Fri, 19 Feb 2016 13:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160216203526.GA27484@sigill.intra.peff.net>
X-ClientProxiedBy: EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) To
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286711>

On 2016-02-16 at 21:35 Jeff King wrote:

> Yeah, I agree there isn't a great solution in git here. Using "git
> merge" is definitely wrong if you don't want to touch HEAD or have a
> working directory.  If you _just_ care about doing the tree-level merge
> without content-level merging inside blobs, you can do it in the index
> like:
>
>    export GIT_INDEX_FILE=temp.index
>    base=$(git merge-base $ours $theirs)
>    git read-tree -i -m --aggressive $base $ours $theirs
>
> If you want to do content-level resolving on top of that, you can do it
> with:
>
>    git merge-index git-merge-one-file -a
>
> though it will need a temp directory to write out conflicts and
> resolved content.

That's an interesting alternative, I'll give it a try!

> I don't think merge-tree is at all the wrong tool, in the sense that it
> is being used as designed. But it is using merge code that is different
> from literally the rest of git. That means you're going to run into
> weird bugs (like this one), and places where it does not behave the
> same.  This add/add case, for instance, is usually a conflict in a
> normal git merge (try your test case with "git merge"), but merge-tree
> tries to do a partial content merge with a base that never actually
> existed[1].

Thank you for clarifying, I understand.

> So I worry that merge-tree's existence is a disservice to people like
> Chris, because there is no disclaimer that it is effectively
> unmaintained.

I agree, I don't want to advocate continuing development under these 
conditions.

> So merge-blobs.c:generate_common_file() is definitely buggy, but I think
> the bug gets unintentionally canceled out by the follow-on three-way
> merge. Which is...good, I guess?

Well I don't know how to handle all this with respect to my original 
problem, but that's completely off topic. Anyway: Thanks!

Stefan
