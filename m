From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 0/4] git-merge: ignore space support
Date: Thu, 26 Aug 2010 00:41:58 -0500
Message-ID: <20100826054158.GB9708@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Justin Frankel <justin@cockos.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:43:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVFk-0004XS-Hb
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab0HZFnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:43:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45852 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab0HZFnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:43:45 -0400
Received: by gyd8 with SMTP id 8so516960gyd.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8a5bk485ddenvcGhUIxyHb0yJcmIRDF4OxmLHVAogq8=;
        b=IxpSxkbxHbZaDZBGSNFCuQbLnN/4gDCjfZzyR5IEIZ4wHxzkIXA5pCBLKEj2fHOptz
         rZjyiMfUBipt3UfsnpOuVFQ78YX9DKgz6eL47FdaP1jJYVS2pr4uBHCeFM9VVynIqwRf
         2l+zn8UdEu7QYb30aTn6kXn+d0/AijQBfTy1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fzgPa02K5RNYwcssB6u3Dr1vsSBZUsPo+sAsKEOikJQhVWIgFUfUkdt5VHJ7keSj/L
         Wyw+rOHqdeuSq0sFL3tVzCKBVPd2Bgn2FZfa8ytTjrLsYsno1XZ+irIYVhQm0sYvZkLB
         4dtRzqq77Ek8h3sYSLl8Idu5KSxYzgQEkheVc=
Received: by 10.151.112.13 with SMTP id p13mr9759446ybm.375.1282801424612;
        Wed, 25 Aug 2010 22:43:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm2354105ybk.1.2010.08.25.22.43.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:43:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100823205915.GA4484@ns1.cockos.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154510>

Hi,

Justin Frankel wrote:

> git-merge and git-rebase can now be passed -Xignore-space-at-eol,
> -Xignore-space-change, -Xignore-all-space, -Xpatience options.

I've tried this out a little and it seems to do the right thing.
Here's the series in its current state.

Patch 1 is to avoid the code duplication between builtin/merge and
merge-recursive you noticed, by adding a function that recognizes -X
options to merge-recursive.h.

Unlike the trial balloon patch I sent before, it uses a conventional
return value with 0 meaning "recognized" and -1 meaning "not recognized".

Patch 2 replaces the flag parameter to ll_merge with a struct.
I think the maintenance trouble of keeping track of the flag bits is
not worth it for a marginal speedup.

Patches 3 and 4 provide "merge -Xpatience" and
"merge -Xignore-space-change" et al on top of this foundation.
I split them up and put patience first because it is worth thinking
carefully about which version of a line with only whitespace changes
a merge will take.

No tests yet.  (If someone would like to add them, that would be
great.)  Probably after responding to initial comments I will not have
much time for this series, so please feel free to pick it up and take
it in whatever direction you wish.

Jonathan Nieder (2):
  merge-recursive: expose merge options for builtin merge
  ll-merge: replace flag argument with options struct

Justin Frankel (2):
  merge-recursive --patience
  merge-recursive: options to ignore whitespace changes

 Documentation/merge-strategies.txt    |   22 ++++++++++
 Documentation/technical/api-merge.txt |   73 +++++++++++++++++++++++---------
 builtin/checkout.c                    |    2 +-
 builtin/merge-recursive.c             |   15 +------
 builtin/merge.c                       |   20 +--------
 ll-merge.c                            |   50 +++++++++++++++-------
 ll-merge.h                            |   22 +++-------
 merge-file.c                          |    2 +-
 merge-recursive.c                     |   54 +++++++++++++++++++-----
 merge-recursive.h                     |    3 +
 rerere.c                              |    2 +-
 11 files changed, 168 insertions(+), 97 deletions(-)

-- 
1.7.2.2
