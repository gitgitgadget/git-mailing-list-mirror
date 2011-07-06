From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: generation numbers (was: [PATCH 0/4] Speed up git tag --contains)
Date: Wed, 6 Jul 2011 20:46:42 +0200
Message-ID: <201107062046.43820.jnareb@gmail.com>
References: <1307819051-25748-1-git-send-email-avarab@gmail.com> <20110706150103.GA2693@thunk.org> <20110706181200.GD17978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 06 20:46:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeX7c-0008Qp-Lf
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 20:46:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab1GFSqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 14:46:47 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:32991 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab1GFSqr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 14:46:47 -0400
Received: by fxd18 with SMTP id 18so346652fxd.11
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=wA/KYy9t22q87S7kqBPZUzmfL0ctIbgdyOmqt65xaLI=;
        b=dcTr3/gttufHQ0NC6Ne4vqUZpy2udM3P8U/L9YMrzSmws8j7YNmimyMuH+i6H58xp8
         BEt2ZDGLRwGgW+YIO9t1YYGzsKcNHfrVkCetB2ajEVgRXzK/UkPIHKXRiuDgNg29M1bF
         6JygTZ5xpEazPvwWqVuLfdeJe+4nAmaBABSUg=
Received: by 10.223.156.9 with SMTP id u9mr3909509faw.70.1309978005937;
        Wed, 06 Jul 2011 11:46:45 -0700 (PDT)
Received: from [192.168.1.15] (abvw74.neoplus.adsl.tpnet.pl [83.8.220.74])
        by mx.google.com with ESMTPS id u20sm4061883fac.18.2011.07.06.11.46.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 11:46:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110706181200.GD17978@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176723>

On Wed, 6 Jul 2011, Jeff King wrote:
> On Wed, Jul 06, 2011 at 11:01:03AM -0400, Ted Ts'o wrote:
> 
> > Is it worth it to try to replicate this information across repositories?
> 
> Probably not. I suggested notes-cache just because the amount of code is
> very trivial.

Well, generation numbers are universal and would help everybody.  For
new commits with 'generation' header those would be always replicated,
for old commits with 'generation' notes / notes-cache the can be
replicated.
 
> One problem with notes storage is that it's not well optimized for tiny
> pieces of data like this (e.g., the generation number should fit in a
> 32-bit unsigned int, as its max is the size of the longest single path
> in the history graph). But notes are much more general; we will actually
> map each commit to a blob object containing the generation number, which
> is pretty wasteful.

Wasn't textconv-cache using commit-less notes?  The same can be done
for generation notes-cache.  Though it is still wasteful...  By the
way, would we be using text representation (like in 'generation'
commit header) or 32-bit integer binary representation in some
ordering, or variable-length integer (I think git uses them somewhere)?

Nb. I wonder if 32-bit unsigned int would always be enough, for example
Linux kernel + history.

> > Why not just simply have a cache file in the git directory which is
> > managed somewhat like gitk.cache; call it generation.cache?
> 
> Yeah, that would be fine. With a sorted list of binary sha1s and 32-bit
> generation numbers, you're talking about 24 bytes per commit. Or a 6
> megabyte cache for linux-2.6.
> 
> You'd probably want to be a little clever with updates. If I have
> calculated the generation number of every commit, and then do "git
> commit; git tag --contains HEAD", you probably don't want to rewrite the
> entire cache. You could probably journal a fixed number of entries in an
> unsorted file (or even in a parallel directory structure to loose
> objects), and then periodically write out the whole sorted list when the
> journal gets too big. Or choose a more clever data structure that can do
> in-place updates.

And that is the difference between gitk.cache (generated _once_ when starting
gitk, and regenerated on request), and idea of generation.cache

I think it would be simpler to use generation header + generation notes.
Or start with generation notes only.

-- 
Jakub Narebski
Poland
