From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Wed, 4 Jun 2008 14:31:06 +0200
Message-ID: <200806041431.07494.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806040211.29430.jnareb@gmail.com> <4845E45E.9030504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 14:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3s9z-0000iA-TS
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 14:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbYFDMbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 08:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754918AbYFDMbT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 08:31:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:49452 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbYFDMbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 08:31:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so26932nfc.21
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Majvhy0+5eK7U1JReTRz1zw5Ao/o9ppkNPmW+eGqCSM=;
        b=xnUfwff6jqdGBZWtKkxU/AT6FmVzvAkH5aS/2M8EZFWFVod3uf0YdLFanNFuHiasLE
         XQQDImsnPv1KkvXwpPiAk/ANKWSjrvcCZKShQaFfCCEExwNyhA19euHCfhPD4ostdcjj
         +PFktuMGCC1RksW3qoXszeVQYj7kw7ZSiSzFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pONX51ACIRrX9kZg+Z0W9510KMFu2JnFkkAvXCnZBQYSVFJV84kgHPbk33Sd+7VAKu
         hWX1DrcNAyAgB4uwHoiJcxc7OvHOJKsXFhg1Zm8BP3sBd5tztbhWR0FDDngde0+MROdl
         ZeEQem/phR5uIrwuGEEUwEfhXItY2zOKhv6RE=
Received: by 10.210.75.6 with SMTP id x6mr1297381eba.136.1212582676352;
        Wed, 04 Jun 2008 05:31:16 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.210.131])
        by mx.google.com with ESMTPS id f3sm1875866nfh.21.2008.06.04.05.31.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 05:31:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4845E45E.9030504@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83779>

Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > And snapshots [and blob_plain].  We certainly want to stream snapshots, as
> > they can be quite large.
> 
> Yup.  I suppose that those need to be cached on disk rather than in 
> memory, so they need a separate cache.

Or at least (in the first implementation) to avoid caching them in
memory-based cache (and serve them uncached).

Although I wonder how memory-based caches such as memcached or swifty,
and perhaps also mmap based cache (BerkeleyDB based cache is supposedly
fast because it fits into memory/caches in memory) deals with overly
large cache entries...

> > [Parents in blame output:]
> > It perhaps makes no difference performance wise (solution with
> > "git rev-list --parents --no-walk" has one fork more), but it might
> > make code unnecessarily more complicated.
> 
> A few lines.  *shrugs*  Probably actually easier than adding stuff to 
> git-blame's output, but I won't argue against the latter if you want it.

With modified (enhanced) git-blame output code would look like this
(rough pseudocode):

  while (<$fd>) {
    ...
    <parse 'parent' header>
    ...
  }

while using no-walk rev-list requires list of blamed parents upfront,
so the code would have to look like this

  @blame_data = <$fd>;
  @commitlist = map { <get sha1> } grep { <header line> } @blame_list;
  %commit_parents = get_parents(\@commitlist); # calls git-rev-list
  foreach (@commitlist) {
    ...
    ...
  }

Note that you read whole data into gitweb, inclreasing memory usage...
which we want to avoid, especially when using memcached or similar
caching backend (git-blame itself has to keep data in memory, but no
need to duplicate the amount).


Besides git-blame output needs to be extended/enhanced anyway for the
data mining / annotated file history navigation Luben wanted to be
really robust.  See my response to Linus email in this thread (to be
written).

> > use AJAX together with "git blame --incremental" to reduce latency.
> > It was done by having JavaScript check if browser is AJAX-capable,
> 
> Unfortunately there is no such check (and I doubt it's doable without 
> cookie or redirect trickery) -- you'll find that the blames on 
> repo.or.cz don't work without JavaScript.

I have in my git repository original version (well, one of original
versions) adding incremental blame output

  Message-ID: <20070825222404.16967.9402.stgit@rover>
  http://permalink.gmane.org/gmane.comp.version-control.git/56657

by Petr Baudis, tweaked version of Fredrik Kuivinen patch, and in the
commit message there is the floowing info:

    Compared to the original patch, this one works with pathinfo-ish URLs as
    well, and should play well with non-javascript browsers as well (the HTML
    points to the blame action, while javascript code rewrites the links to use
    the blame_incremental action; it is somewhat hackish but I couldn't think
    of a better solution).

Instead of rewriting links gitweb's JavaScript could use JavaScript
redirect trickery, using JavaScript (by setting location.href for
example) to redirect to blame_incremental action from blame action.


As to checking if browser is AJAX capable: you can at least check
if all methods needed are available.


P.S. You would probably want to remove old git-annotate based git_blame
(dead code, currently not used by any action), and rename git_blame2 to
git_blame.  A bit less code to check for caching problems etc,...
-- 
Jakub Narebski
Poland
