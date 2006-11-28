X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: can I remove or move a tag in a remote repository?
Date: Tue, 28 Nov 2006 12:08:01 +0100
Message-ID: <456C1891.80706@op5.se>
References: <87wt5rffbm.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 11:08:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <87wt5rffbm.fsf@rho.meyering.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32510>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0or-0003mB-7q for gcvg-git@gmane.org; Tue, 28 Nov
 2006 12:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935847AbWK1LIF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 06:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935861AbWK1LIF
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 06:08:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:29887 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S935847AbWK1LID (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 06:08:03 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id D9B1B6BCC7; Tue, 28 Nov 2006 12:08:01 +0100 (CET)
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

Jim Meyering wrote:
> 
> Perhaps I shouldn't push the cvs-head tag at all.

Possibly not, although it's nice to let others that use git to know 
where you've cut the release.

> A few questions:
>   - is there a way to say "push all tags matching /COREUTILS-*/"
>       or to say "push all tags, except the ones on this list"?


Here's a snippet from the default update hook we use on all our repos. 
We explicitly deny any non-annotated tags from being pushed to the 
central server and let rogue devs know why the push failed by writing 
the error message to stderr so that it gets sent over the wire. I 
believe this is still the default update-hook shipped with git.
---%<---%<----%<---
ref_type=$(git cat-file -t "$3")

# Only allow annotated tags in a shared repo
# Remove this code to treat dumb tags the same as everything else
case "$1","$ref_type" in
refs/tags/*,commit)
     echo "*** Un-annotated tags are not allowed in this repo" >&2
     echo "*** Use 'git tag [ -a | -s ]' for tags you want to 
propagate." >&2
     exit 1;;
---%<---%<---%<---

>   - is there a way to remove the cvs-head tag from the remote directory?
>       Note: I don't have shell access there.  I can request that someone
>       with shell access do it, but shouldn't have to resort to that.
>   - is there some way to make "git push" do what I want, and update the
>       offending tag in the remote repo?
> 

I'm not sure if execution reaches the update hook when you're uploading 
a tag that already exists. If it is, you could simply remove the 
offending tag in the update-hook and exit 0 to make it work properly. 
You can test this without shell-access on the remote system by setting 
up a repo on your local machine, making some dummy commit, cloning it 
and then hacking away on the hook while pushing to it from your local repo.

Other than that, push your tags manually by naming them explicitly on 
the push-line, like so:
$ git push $remote_repo $tag_name

This is what I do whenever we cut a release. With a one tag per release, 
it's not very troublesome at all, and the update-hook sends a nicely 
formatted message of the changes since the last release (last tag 
really, but it amounts to the same thing for us) to everyone involved.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
