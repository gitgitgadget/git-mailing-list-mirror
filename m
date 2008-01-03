From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: Stitching together private svn repo and public git repo
Date: Thu, 03 Jan 2008 14:43:09 +0000
Message-ID: <C3A2A4FD.1089D%jefferis@gmail.com>
References: <20080102224611.GA14984@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>,
	Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 15:43:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JARIQ-0002bo-T5
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 15:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYACOnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 09:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYACOnU
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 09:43:20 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:6138 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbYACOnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 09:43:19 -0500
Received: by nf-out-0910.google.com with SMTP id g13so390215nfb.21
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 06:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=DZf3h0WWd3L23KxHBSOB6gSHHDRdGS6kiEmgf0r2vH8=;
        b=aK0FaX0SPxoAwQM+eLSxS83zUJmIQpdrOAbVpTRObb2TNCB4uCMuoQzHmmyRzl/2PcfLTAepp9z8z7YCLYqYuEdJb0xOEPPT4mPfqFAVBSWunqOsFts9bElcCpHQD0wcZotf+OjpB+h2f3RaSQqzPHGTSZOz9HsdJzqUY0NeO8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=MFefOxI6SnPqhSGb6FBLUf8sQe6kFHfOBLc+tWzGG64fr+WxROPqjmoB2+XfMhW5TBhPrbCz0va9lKoxa4ivGDVjEEphZ6TJkB+PvbI+zesKR2o69YXXoUaU9H4E4N2KdjI4BsljoOBt0abD2V3vhbNIoh24jkk9dGqjUq31RKo=
Received: by 10.78.186.9 with SMTP id j9mr18138999huf.49.1199371396294;
        Thu, 03 Jan 2008 06:43:16 -0800 (PST)
Received: from ?81.98.250.69? ( [81.98.250.69])
        by mx.google.com with ESMTPS id d27sm23198492nfh.34.2008.01.03.06.43.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Jan 2008 06:43:14 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: Stitching together private svn repo and public git repo
Thread-Index: AchOFvUxM7AtGroKEdyDSgAUURoPUg==
In-Reply-To: <20080102224611.GA14984@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69527>

Many thanks to both for your replies.  Starting from your comments and
consulting:

http://www.kernel.org/pub/software/scm/git/docs/repository-layout.html

for (fairly scant) details of .git/info/grafts and
 
http://www.kernel.org/pub/software/scm/git/docs/git-filter-branch.html

I think I have now been able to do the necessary.  Since I found this a
trivial operation (in the true mathematical sense of quasi-impossible until
someone helps you to figure it out and simple once you have) and I tripped
over a couple of times, I thought I would share my final shell script below.

One point that I missed initially.  The graft file format is unforgiving.
You are allowed comments but each regular line is:

Commit-SHA-1 Parent1-SHA-1 Parent2-SHA-1\n
      
If you put e.g. more than a single space between your SHA-1s you will get
"bad graft data:" - I missed one in the fake merge line and ran round in
circles for a bit thinking it was something to do with the state of my
trees.

Anyway, boy did it feel great when I was able to git-pull the latest public
release into my private repository:

    34 files changed, 11563 insertions, 8399 deletions

and only 2 simple conflicts to fix with git-mergetool.  That was not a merge
I wanted to do by hand!

Best wishes and thanks again,

Greg.
-- 

#!/usr/bin/env bash
# makemygitbygraft.sh
# merge my private repo (converted from svn) with a public git repo
# retains history of both and will allow 3 way merges etc in future

# work on a copy of my svn imported repo just in case
cd ~/dev/Physiology
rm -rf ~/dev/Physiology/nm-graft
cp -R nm-git-svn2 nm-graft
cd nm-graft

# Now get to work, bring in public repo as a remote
git remote add nm-ucl ../nm-ucl
git fetch nm-ucl

# set up the grafts
cat > .git/info/grafts <<EOF
# connect r2 of git-svn to v1.86 of nm-ucl
# r1 (which was an identical initial import) will now be detached (and
forgotten)
52b1933421ef524811407fa4c240da58ceec5749
eca3db14fcf25744fdf585456f03599a9db2af96
#
# Make fake merge with Neuromatic v1.91b
# svn-manualmerge1 svn-manualmerge1~1 public-v1.91b
120282ee5275027312dde386c8995218f361cf35
0962cb27f7ad92f44def04630e8e6a22b86e0699
6735057f53dd57248c7ec23f6ae9f22085d98fba
EOF

# running git-status seems to stop git thinking that the working dir is
dirty
git-status
# run git-filter-branch to instantiate the new parents
# just use cat so that parent names are untouched by the process
# but will be fed by .git/grafts/info as appropriate
git-filter-branch --parent-filter cat HEAD

Nicely formatted snippet also at
http://pastie.textmate.org/private/pv1n1nbmcmtxnxbq4zd7w

On 2/1/08 22:46, "Charles Bailey" <charles@hashpling.org> wrote:

> On Thu, Jan 03, 2008 at 01:13:54AM +0300, Dmitry Potapov wrote:
>> I believe there is a much easier way to do that using .git/info/grafts
>> The first step is to create .git/info/grafts, which specifies commit-id
>> and its parents for each commit that you want to change. Then you
>> can check the result using gitk, and if you are satisfied with what
>> you see then you run git filter-branch on it to convert 'fake' parents
>> into real ones.
>> 
>> Dmitry
>> 
> 
> Oh yes, this is much easier.  Unless I'm missing something, the
> documentation on grafts is fairly sparse, though.  They are mentioned
> (almost in passing) in git help filter-branch but the file format is
> only documented in repository-layout.txt which seems more developer
> than user oriented.
> 
> Charles.

-- 
Gregory Jefferis, PhD
Division of Neurobiology
MRC Laboratory of Molecular Biology,
Hills Road,
Cambridge, CB2 0QH, UK.

http://www2.mrc-lmb.cam.ac.uk/NB/jefferis_g
http://www.neuroscience.cam.ac.uk/directory/profile.php?gsxej2
http://flybrain.stanford.edu
