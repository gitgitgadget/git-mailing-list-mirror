From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] a tale of Git 2.5, ssh transport and GIT_* environment variables
Date: Fri, 4 Sep 2015 16:02:09 +0200
Message-ID: <CAOxFTcwYJqFHrBkie19Fm3AqeYmSLRNBpBtOAkiYmfO9UgN-0g@mail.gmail.com>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 16:02:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXrZc-0000Jl-6p
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 16:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbbIDOCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 10:02:32 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38791 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbbIDOCb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 10:02:31 -0400
Received: by igbut12 with SMTP id ut12so14117592igb.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oN17HKNkcdCsLav+AOfxd9B+CURQq/LVtlTPNUOlFCI=;
        b=RMY1ldK0nDq2spfAiE5aDDe/YVKbLu3OEz/NWt8ccjhHlfd63R8hcfwhFeXbsaOyKQ
         OvOcHeJZ2W4wiAzEGYVrUjZKcCYuDcrgLlZVk68DJB3HvvWKjj+t2RCob1x6O9IHfAmo
         TrQe3C/p5CQ3G63bXqp4wzZ5ZHjT9+XcDgAirv2LiIoGIJLPPpTodh1IqqaoSSEB7Ann
         3kZsjo/VkJIMwz8iLah52mYf4A4Ovtmwyeh+ujnEc8l+Xd+4u+ggAJlMdgQslIGmXEQp
         vUknHVKfm2SyEgxDpaHveSfiUPmJlDCHWbcbmt0ItJhCeD+Shpd3JdxNr2XCJoNGpGM+
         g5aA==
X-Received: by 10.50.87.98 with SMTP id w2mr7800320igz.60.1441375348772; Fri,
 04 Sep 2015 07:02:28 -0700 (PDT)
Received: by 10.36.22.209 with HTTP; Fri, 4 Sep 2015 07:02:09 -0700 (PDT)
In-Reply-To: <20150904125448.GA25501@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277309>

Hello,

On Fri, Sep 4, 2015 at 2:54 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 04, 2015 at 12:52:45PM +0200, Giuseppe Bilotta wrote:
>
>> Notice two things: the messages refer to the worktree updir of the
>> CLIENT machine, and even though it's _completely not obvious_ due to
>> the missing 'remote:' lines, the messages actually come from the
>> SERVER. The lack of indicator lines _alone_ took me hours of debugging
>> before I finally understood that they were coming from the other side
>
> Older versions of receive-pack would let unpack-objects output go
> straight to stderr, but that changed in a22e6f8 (receive-pack: send
> pack-processing stderr over sideband, 2012-09-21), which is in git
> v1.7.12.3. What version of git is running on the remote server?

Sorry, I forgot to mention this in my origina email, I should have.

The remote is quite ancient: git version 1.7.0.4

>> I still couldn't do much on the SERVER to debug due to a variety of
>> reasons, but I finally had a suspicion: it was almost as if the SERVER
>> was getting the GIT_DIR information from the CLIENT. And why the heck
>> would _that_ be the case?
>>
>> I then remembered that the server was actually configured to AcceptEnv
>> GIT_* in sshd_config, for reasons related to git identity preservation
>> despite single login account (please don't ask). Turning the AcceptEnv
>> to a stricter GIT_AUTHOR* and GIT_COMMITTER* solved the issue.
>
> I couldn't reproduce this problem, either during a local push, or across
> an ssh session (where the client has "SendEnv GIT_*" and the server has
> "AcceptEnv GIT_*").

[snip]

> On the receiving side, git-receive-pack takes an argument for the repo
> path, and calls enter_repo. That should result in calling set_git_dir(),
> which overwrites $GIT_DIR in the environment. AFAICT, it has always done
> so. So I'm not sure how GIT_DIR would leak through, even on an older
> version of git.

Hm, aside from the ancient version of git, the other side also has
gitolite2  running (can you tell it's an ancient installation that
needs upgrading?).  However,I've done a quick test by creating an
empty bare git repository outside of gitolite2, and I'm still getting
the same error, so I would exclude gitolite2 interference. In fact,
your testing approach gave me the idea to test by prepending env 1>&2
to the receive pack and this way I noticed that the variable being set
was GIT_WORK_TREE. In fact, using --receive-pack 'export -n
GIT_WORK_TREE ; git-receive-pack' fixes the problem for me.

So, I've at least been able to circumscribe the problem to: server git
1.7.0.4, client git 2.5, GIT_WORK_TREE being sent over the ssh
connection. I'll see if I can find some time to do some proper
bisecting next week.

-- 
Giuseppe "Oblomov" Bilotta
