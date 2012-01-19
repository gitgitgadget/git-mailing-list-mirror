From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: post-update to stash after push to non-bare current branch
Date: Thu, 19 Jan 2012 15:48:18 -0600
Message-ID: <4F188FA2.1000209@gmail.com>
References: <jf70vc$kol$1@dough.gmane.org> <4F171088.4080006@gmail.com> <4F1714AD.4090706@gmail.com> <7vwr8oljq7.fsf@alter.siamese.dyndns.org> <4F1764B9.90907@gmail.com> <7vboq0ld5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 22:48:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnzqO-00036m-5Z
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 22:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909Ab2ASVsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 16:48:24 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55216 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab2ASVsX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 16:48:23 -0500
Received: by yhoo21 with SMTP id o21so280115yho.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 13:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2QsU9hhb01X+3t0B0/VL2tJPWY8yFm/Iy33P2UjkhHg=;
        b=K///ipyqp7XzEV7uaQnLmhflNqycpUWawontYN4RmCvlUkl7oISNc05IBYuqhyetH8
         +LsfifS3wK0SMrSdRKTPCOVc2yKdVRIJWbi+4Fk2oNRUydjf0iNfQdyX7kRufrKxqG5g
         9ukPfZSk8HBMSsHOp58tIpcg9ca5o+dG/bNgI=
Received: by 10.236.181.198 with SMTP id l46mr42551871yhm.40.1327009702707;
        Thu, 19 Jan 2012 13:48:22 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id u47sm1295089yhl.0.2012.01.19.13.48.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 13:48:21 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vboq0ld5e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188840>

On 1/18/2012 7:00 PM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>>> Have you checked where in the filesystem hierarchy that script is run
>>> (hint: pwd)?
>>>
>> echo pwd in post-update echoes /path/WORKTREE/.git in git-push stdout.
>> ...
>> 'git-checkout -f' works manually, but in post-update hook...
>
> Stronger hint. Did you run "git checkout -f" in /path/WORKTREE/.git to
> back that "works manually" claim?

(Manual behavior):
If pwd is WORKTREE/ then git-checkout has correct effect, ie. worktree, 
index, and HEAD match.
If pwd is WORKTREE/.git/ then git-checkout complains 'must be run in a 
worktree' and has no effect.

(post-update hook behavior):
If pwd is WORKTREE/.git/ then git-push verbage does not complain, and 
git-checkout exits zero status but has incorrect effect, ie. index and 
HEAD match, but worktree matches HEAD@{1}.
If pwd is WORKTREE/ then git-push complains 'not a git repository', and 
git-checkout exits non-zero status and has no effect, ie. worktree and 
index match HEAD@{1}.

Evidence:

(post-update hook script):
MYPWD=`pwd`
echo $MYPWD
pushd /home/neal/FSNMSTHTML
MYPWD=`pwd`
echo $MYPWD
git checkout -f HEAD
if [ $? -ne 0 ]; then
   echo "error on checkout!"
else
   echo "checkout HEAD to non-bare remote current branch after push"
fi
echo $MYPWD
popd
MYPWD=`pwd`
echo $MYPWD

(git-push verbage):
$ git push origin HEAD
Counting objects: 9, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 462 bytes, done.
Total 5 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
remote: warning: updating the current branch
remote: /home/neal/FSNMSTHTML/.git
remote: ~/FSNMSTHTML ~/FSNMSTHTML/.git
remote: /home/neal/FSNMSTHTML
remote: fatal: Not a git repository: '.'
remote: error on checkout!
remote: /home/neal/FSNMSTHTML
remote: ~/FSNMSTHTML/.git
remote: /home/neal/FSNMSTHTML/.git
To file:///home/neal/FSNMSTHTML
    cee9269..34dc5a9  HEAD -> master

v/r,
neal
