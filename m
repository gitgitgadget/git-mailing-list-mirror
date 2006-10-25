X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] gitweb: Filter out commit ID from @difftree in git_commit and git_commitdiff
Date: Wed, 25 Oct 2006 10:03:22 +0200
Message-ID: <200610251003.22526.jnareb@gmail.com>
References: <200610241349.54685.jnareb@gmail.com> <200610241354.49396.jnareb@gmail.com> <7v1woxf1v9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 08:03:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GVvIrGtpLcw5BuMoy4mnSwOAvv2RdzDtDJnm/7l1FNF41RozTRKc6/dKRXBRkoP1TMltkIskOex7XIapnoOQp2TiuWHO5R6Jn7OK1iF1KNa4yBFmKKsuFBCDDaK1IlMU+1PXK2EQ7HEAyb8TcyIPwdiNkAt9tFCHplW3kwl92I8=
User-Agent: KMail/1.9.3
In-Reply-To: <7v1woxf1v9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30037>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcdjZ-0006NB-4E for gcvg-git@gmane.org; Wed, 25 Oct
 2006 10:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423105AbWJYIDG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 04:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423104AbWJYIDF
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 04:03:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:17427 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423102AbWJYIDC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 04:03:02 -0400
Received: by ug-out-1314.google.com with SMTP id 32so34878ugm for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 01:03:01 -0700 (PDT)
Received: by 10.67.101.8 with SMTP id d8mr394441ugm; Wed, 25 Oct 2006
 01:03:01 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110]) by
 mx.google.com with ESMTP id 32sm1857810ugf.2006.10.25.01.03.00; Wed, 25 Oct
 2006 01:03:01 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Filter out commit ID output that git-diff-tree adds when called with
>> only one <tree-ish> (not only for --stdin) in git_commit and
>> git_commitdiff.
> 
> I initially wondered why this, or other existing such sripping,
> is necessary in the first place.
> 
> The collected result is given to git_difftree_body() and it
> feeds parse_difftree_raw_line() with it.  Interestingly enough,
> it _is_ prepared to handle the line with the commit object
> name.

Perhaps I was overeager in adding that. The only place it was used
was git_tree_blame in the proof-of-concept/RFC patch which added
"tree_blame" view, and even there it was discarded solution: using
git-diff-tree can give only commit which changed the file to current
version; it cannot find commit which changed tree/directory (latest
commit which changed any of its files).

This can be useful if at any time we need to parse git-diff-tree --stdin
output.
 
> However, the very initial part of git_difftree_body assumes that
> the array it gets does not have the commit object name (i.e. it
> counts the array members and says "N files changed").

The same is true for git_patchset_body. Moreover if I remember correctly
they count elements of @difftree array (or do equivalent of counting)
_before_ parsing.

> So I think your change is probably a good one, but I suspect you
> probably are better off to make parse_difftree_raw_line() to
> barf when it gets the commit object name to make sure that all
> callers strip it at the same time; 

I'd rather not do that, and leave parse_difftree_raw_line generic.

>                                    better yet, perhaps you can 
> have a single function that invokes git-diff-tree -r (with
> different parameters) and returns the result that is already
> only the difftree body lines?

That would be good idea... if not for the fact that git_commitdiff
uses --patch-with-raw format... but that would make it only slightly
more complicated (strip commit-id, or rather tree-ish from output,
and stop on end of raw part i.e. on first empty line).

I'll do that (unless someone else would do this first).
-- 
Jakub Narebski
