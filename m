From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Cache $parent_commit info in git_blame()
Date: Wed, 10 Dec 2008 22:03:28 +0100
Message-ID: <200812102203.30486.jnareb@gmail.com>
References: <710873.22344.qm@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 22:05:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAWEt-0004BD-Kj
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 22:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbYLJVDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 16:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbYLJVDl
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 16:03:41 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:58954 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbYLJVDk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 16:03:40 -0500
Received: by ti-out-0910.google.com with SMTP id b6so426660tic.23
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rQ4Gpzel4vD0a+d9fGcCnX/IR6Ilc7Luz05U3eo4YtE=;
        b=XyJNe7n4Dc6ULBHct/uzdS7rS9to1NMol5+B5BRlABNcXZNQmxDJTaoEjFhgmn3z68
         CFiLbnu44jn3voAsM5bjVaYRS9pf5XYlc5C+5RUfbHnPuWqa0qK26D7LhEnX99wh5x43
         GXtQdW4nyQ4SUuGGNSs1qupD1BChnsyeSW4GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EhtBdO0T6FaMN5x9H4jdkcTMq/3bgNcTFHByj0Pj9L3FuFgh9YT04q8oHE90vZDY/T
         QTXvSxRXg7vDinGqYHodOxpP/urwUVPL3NNbbilxvnsecgm9rRI35xNxb7tZoucAPnNz
         DsSIiy3QUfAPzepiUZJ3TN3LCVw6MkCbECLdA=
Received: by 10.110.15.9 with SMTP id 9mr2562363tio.48.1228943018752;
        Wed, 10 Dec 2008 13:03:38 -0800 (PST)
Received: from ?192.168.1.11? (abxf60.neoplus.adsl.tpnet.pl [83.8.255.60])
        by mx.google.com with ESMTPS id b7sm1935146tic.23.2008.12.10.13.03.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 13:03:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <710873.22344.qm@web31806.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102720>

On Wed, 10 Dec 2008, Luben Tuikov wrote:
> --- On Wed, 12/10/08, Jakub Narebski <jnareb@gmail.com> wrote:

Side note: is it Yahoo web mail interface that removes attributions?

> > > Have you tested this patch that it gives the same commit chain
> > > as before it?
> > 
> > The only difference between precious version and this patch
> > is that now, if you calculate sha-1 of $long_rev^, it is stored in 
> > $metainfo{$long_rev}{'parent'} and not calculated second time.
> 
> Yes, I agree a patch to this effect would improve performance
> proportionally to the history of the lines of a file.

Or rather proportionally to the ratio of number of lines of a file
to number of unique commits (not groups of lines) which are blamed
for given contents of a file.

> So it's a good thing, as most commits change a contiguous block
> of size more than one line of a file.
> 
> "$parent_commit" depends on "$full_rev^" which depends on "$full_rev".
> So as soon as "$full_rev" != "$old_full_rev", you'd know that you need
> to update "$parent_commit".  "$old_full_rev" needs to exist outside
> the  scope of "while (1)".  I didn't see this in the code or in the
> patch. 

You don't need $old_full_rev. We have to save data about commit in
%metainfo hash because information about commit appears in 
"git blame --porcelain" output _once_ per commit. So we use the same
cache to store $full_rev^ in $meta{'parent'}, which means storing
it in $metainfo{$full_rev}{'parent'}.

Now if the commit we saved this info about appears again in git-blame
output, be it in group of lines for which the same commit is blamed,
or later in unrelated chunk, we use saved info.

Let me try to explain it using the following diagram:

  Commit N Line Original code      This patch
  ------------------------------------------------------
  3a4046 1 xxx  rev-parse 3a4046^  rev-parse 3a4046^
         2 xxx  rev-parse 3a4046^  $mi{3a4046}{'parent'}
         3 xxx  rev-parse 3a4046^  $mi{3a4046}{'parent'}
  f47c19 5 xxx  rev-parse f47c19^  rev-parse f47c19^
         6 xxx  rev-parse f47c19^  $mi{f47c19}{'parent'}
  3a4046 7 xxx  rev-parse 3a4046^  $mi{3a4046}{'parent'}  <--
         8 xxx  rev-parse 3a4046^  $mi{3a4046}{'parent'}

where "rev-parse 3a4046^" means call to git-rev-parse, and $mi{<rev>}
accessing $metainfo{$full_rev} (via $meta).
 
In place marked by arrow '<--' you don't need to calculate 3a4046^
again...

> > But I have checked that (at least for single example file)
> > the blame output is identical for before and after this patch.
> 
> I've always tested it on something like "gitweb.perl", etc.

I've checked it on blob.h.  Other good example is README (with boundary
commits) and GIT-VERSION-GEN (with different output between git-blame
--porcelain and --incremental), both of which take much less time than
gitweb/gitweb.perl (see benchmarks in other post).

-- 
Jakub Narebski
Poland
