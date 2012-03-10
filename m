From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Stop a git commit by a specific author using pre-commit hook
Date: Sat, 10 Mar 2012 17:03:08 -0600
Message-ID: <4F5BDDAC.4050700@gmail.com>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com> <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Adrian Cornish <git@bluedreamer.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 00:03:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6VKC-0001TN-GR
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 00:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab2CJXDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 18:03:12 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55214 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261Ab2CJXDL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 18:03:11 -0500
Received: by iagz16 with SMTP id z16so4437762iag.19
        for <git@vger.kernel.org>; Sat, 10 Mar 2012 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=RFEEKCQoN8Hhf4EPhEuvvj0PzHooqEuOpHpK4J0mLn8=;
        b=f014rUmO1hgs1JqCYBKKasW4lIoWGqlX9H+dcMNAqWV2MGUOg1zKoN3REJegaMuuD1
         d8LqBB4I9t+jptoBcz/H/3IPbTrZATKevL3l3JGUvWgLn2E7/0ZisYdzuVXSnJaefGfu
         PTnpBTyczBtTrcNuB3+aCUbPbjnWy6R6lCnJWXkvN+WW/T/Y8TCcWF+bwS2clLo4WOfl
         8yKIzHdf5PR7M0kXaqNK9uIjhuK0X5nFl7qvejpXfLWK7Pnr45dr+6cbqPMPWg+Hzozn
         a+ZibAKFX9DnBUyXcs9/63DeSv5XSJIj2Tjc0uTBpd/UYBCZFqR6wciJFC2tDAakUtQI
         uM7w==
Received: by 10.182.2.135 with SMTP id 7mr2967111obu.78.1331420590741;
        Sat, 10 Mar 2012 15:03:10 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id v10sm10751210obb.4.2012.03.10.15.03.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Mar 2012 15:03:10 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vboo415rn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192794>

On 3/10/2012 3:54 PM, Junio C Hamano wrote:
> Neal Kreitzinger<nkreitzinger@gmail.com>  writes:
>
>> On 3/8/2012 7:15 PM, Adrian Cornish wrote:
>>> My plan is to use git to keep track of changes in /etc but when
>>> committing I want to have the person making the change specify
>>> themselves as author by adding the --author option on the commandline.
>>> So I would like to stop accidental commits as root.
>> ...
>> We use whoami in our pre-commit hook to see who the user is that is
>> doing the commit.  I think you could also use GIT_COMMITTER_NAME or
>> linux $USER environment variables.  Either way, the --author seems
>> like an unnecessary and unreliable way to get the username.
>> ...  If people can su to root
>> then $USER will not work because it will still be set to their
>> original user name (before they did su to root).  Therefore, "whoami"
>> seems like your best solution.
> When people want to raise a red flag against a commit made by root,
> they are coming from two different schools.
>
> One is "do not run 'git' or any development tool for that matter
> while being root". It is a good discipline to follow in general to
> limit what you do with escalated privilege to the minimum.
>
> The other is "record who actually did the work, not 'root' that
> people cannot later track down who it actually was".  People from
> this school do not mind running development tools as root.
>
> And your advice is a good one for the former, but not very relevant
> for the latter.
>
> And I think Adrian is asking for the latter.
>
Now I see.  In that case, at the point pre-commit is run git has not 
overriden GIT_AUTHOR_IDENT with your --author value, yet.  I don't know 
if that is a bug or not.  The prepare-commit-msg hook is the same way.  
However, by the time the commit-msg hook runs git has placed your 
--author override into GIT_AUTHOR_IDENT so if you check it there it will 
work and you can abort the commit.  Of course, at that point the user 
has already typed their commit message and may lose it.  You could 
create a git alias like "git root-commit" that prompts them to enter 
their authorname and then runs git-commit --author with that user 
provided value.  Pre-commit hook could detect root user and error out 
telling them to run git-root-commit instead.

v/r,
neal
