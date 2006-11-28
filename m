X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 10:29:09 +0000
Message-ID: <200611281029.11918.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611260241320.20138@iabervon.org> <456C0313.3020308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 10:29:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=UMvohnL7+Gx9e1uqoH6CAt/9nKeoi5/R+mJ9t2QtfqHHzruOmrVOegQbw2OW+q2SujGUkK45HWjxPcfBJi5fCWonVY5d4TdyzxvItahETkL7R37XcfSPRUWQsb9VJGtCX/ZP1B8EQREPnvtTURe4ltTvfeERyFq2m5VZ+o5dRZ8=
User-Agent: KMail/1.9.5
In-Reply-To: <456C0313.3020308@op5.se>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32504>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0DL-0006gG-68 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 11:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935815AbWK1K3T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 05:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935816AbWK1K3T
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 05:29:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:3681 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935815AbWK1K3S
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 05:29:18 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1432778uga for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 02:29:16 -0800 (PST)
Received: by 10.66.239.18 with SMTP id m18mr1244556ugh.1164709756693; Tue, 28
 Nov 2006 02:29:16 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id m1sm19218565ugc.2006.11.28.02.29.15; Tue, 28 Nov 2006 02:29:16 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Tuesday 2006 November 28 09:36, Andreas Ericsson wrote:

> I'd actually prefer the second solution here and let git print a list of
> submodules with dirty state and ask for some sort of user-response
> before creating the actual commit. As non-interactive commits should
> always be clean, requiring user intervention on non-clean state should
> be a safe thing to do.

I'd agree.  However, is there a need to require user intervention?  Can we not 
make the following analogies to normal git operation:

file in working directory -> submodule working directory
file in index -> submodule repository

It's perfectly possible to make a commit with different contents in the index 
and the working directory - it shows up in the git-status output very nicely.  
Why not deal with submodules in the same way?

Now imagine the following repository:
  file1
  file2
  submodule1/file3
Make changes to file2 and file3, but don't update-index or commit.  git-status 
would show:

# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified:   file2
#       dirty:      submodule1
#
nothing to commit

Now "git-update-index file2" and git-status

# Updated but not checked in:
#   (will commit)
#
#       modified:   file2
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       dirty:      submodule1/
#

Now do a commit in submodule1/ and git-status in the supermodule.

# Updated but not checked in:
#   (will commit)
#
#       modified:   file2
#       submodule:  submodule1/
#

Obviously the detail would be different, but you get the idea.  There is 
almost no difference between git-with-submodules and git-as-normal.

I suppose there would actually need to be an extra step were the submodule is 
added to the supermodule index.  So really there would be three states from 
git-status:

# Updated but not checked in:
#   (will commit)
#
#       modified:   file2
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified:   file1
#       submodule:  submodule1/
#
# Dirty submodules:
#   (commit changes in the submodule to clean)
#
#       dirty:      submodule1/
#

Which means: since the last supermodule commit there has been
 * a change to file2, which is in the index and would be committed.
 * a change to file1, which is not in the index and won't be committed.
 * a commit to submodule1, which won't be committed
 * changes to the submodule working directory

This really reinforces Linus's interpretation that submodules are 
directories - they would presumably just get a new object type and be 
referenced in the tree object.  git-update-index would be blind to dirty 
submodules with no new commit, just as git-update-index on an unchanged file 
has no effect.

Has this question been answered yet?  How does the supermodule know which 
branch to track in the submodule?  Does it simply track HEAD or when the 
submodule is added to the supermodule is it told which branch to track?  I 
suppose it's got to be HEAD really hasn't it?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
