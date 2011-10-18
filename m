From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep patterns
Date: Tue, 18 Oct 2011 02:55:21 -0500
Message-ID: <20111018075521.GB20976@elie.hsd1.il.comcast.net>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
 <7vd3duixdg.fsf@alter.siamese.dyndns.org>
 <20111018072655.GA22309@elie.hsd1.il.comcast.net>
 <7v8voiiwfo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 09:55:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG4WT-0001eH-Mf
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 09:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab1JRHzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 03:55:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33869 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab1JRHzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 03:55:36 -0400
Received: by iaek3 with SMTP id k3so418789iae.19
        for <git@vger.kernel.org>; Tue, 18 Oct 2011 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kqTE/7CEfB2Ge7MmUv15ZXsRcKne8oKKNfik+8wWHQY=;
        b=IoNnQ4EXGK9dUyMRczR2dvJXB2Qxnc4GS+bm6qZzhjJjbYHPkQdrJ1xt5cYmkkaqKJ
         1MyrKf2HYumAqhKzupvjsllGkGq5P0nz8pXcpriGZPn8NQz6PJNvyL5aUXvHoErONfoO
         3cd2Ij+/gPtzn+yxZg4KokEL4g8U15Rc0CCsc=
Received: by 10.42.157.135 with SMTP id d7mr2553353icx.19.1318924536185;
        Tue, 18 Oct 2011 00:55:36 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p16sm3522339ibk.6.2011.10.18.00.55.34
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Oct 2011 00:55:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8voiiwfo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183871>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Junio C Hamano wrote:

>>> +git_check = $(shell git ls-files >/dev/null 2>&1; echo $$?)
[...]
>> Neat.  I'd prefer something like
[...]
>> that avoid punishing people who were using the makefile for some
>> purpose unrelated to tags and cscope, though. ;)
>
> Hmm, how would this punish anybody exactly (I just took the structure
> from the way how the auto-depend is done)?

As Matthieu mentioned, the code in $(shell ...) gets run once each
time the makefile is loaded, adding to the runtime and possible
failure modes of

	make clean

that does not care about the result.  The dep_check test has that same
problem, and I was a little nervous about that when we added it.  But:

 i.   it seemed to be worth the convenience

 ii.  computing whether the compiler supports -MMD once each time $(CC)
      is launched would slow enough not to be an option

 iii. in the end, most uses of the makefile are to compile something,
      anyway, so it is not _that_ much of a waste.

 iv.  if someone finds the per-make-invocation to be too high, we
      could introduce a DONT_COMPUTE_HEADER_DEPENDENCIES variable that
      causes the check to be skipped by forcing that particular result.

Great.

In this new tags/cscope example, one could make an argument that
running exactly once is similarly better than running as needed (as in
(ii) above), by pointing out that

	make tags TAGS cscope

would have to check for a working "git ls-files" once instead of three
times.  But I don't buy it. :)

> Besides, you would need to have the whole thing in a subshell or
> something, as this is used as the upstream to "| xargs".

Good catch, thanks.
