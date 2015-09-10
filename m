From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1 2/2] git-p4: work with a detached head
Date: Thu, 10 Sep 2015 09:20:08 -0700
Message-ID: <xmqq7fny5jrb.fsf@gitster.mtv.corp.google.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
	<1441461738-25066-3-git-send-email-luke@diamand.org>
	<xmqqfv2n5khe.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-_zhxf_daVxNB-hxFfbakMbJp9rk0vP+k46ErrJ6Qxiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:20:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za4aA-0001x8-HU
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 18:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbIJQUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 12:20:14 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36098 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbIJQUM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 12:20:12 -0400
Received: by padhk3 with SMTP id hk3so46989929pad.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ifxob83/OGzE1j9hHvYof8rgWFkaAT9rMKmcimYp8es=;
        b=vTDYp6ckasF8yEgbz8p/sWhMOzzKWzdjpuxsxD+C0mceFWgRS8ccxqlXqRUWPT1txs
         1kLaHyD+eYdKxIv4F9FCPTqEbO8yN+MoCnAJtHQTAStNxlotScJ5I+dbS/V6nImNTI9T
         GBHQo8rXEW1Pv+G6shgBuUQABFTRi9wmnMdII93+F0opOpV+LA94eepUXCoZq8ZUWvD7
         L7MNgoAeAGzcnXRE4AEU+A6jUqUQFe6qqX3r6iKFptV+H1bm+N0qfhFY/ecF+9KKbLS9
         noUYaMjDD6FYc9PBU+Fi9x3IC5uauu4piQ0FM9hQ2WoLqhJEP2rjdtedjbzOp1kb3Lj/
         kiHQ==
X-Received: by 10.67.8.40 with SMTP id dh8mr73946853pad.129.1441902011603;
        Thu, 10 Sep 2015 09:20:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id qp5sm12901501pbc.0.2015.09.10.09.20.09
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 10 Sep 2015 09:20:09 -0700 (PDT)
In-Reply-To: <CAE5ih7-_zhxf_daVxNB-hxFfbakMbJp9rk0vP+k46ErrJ6Qxiw@mail.gmail.com>
	(Luke Diamand's message of "Thu, 10 Sep 2015 08:29:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277596>

Luke Diamand <luke@diamand.org> writes:

> On 9 September 2015 at 22:52, Junio C Hamano <gitster@pobox.com> wrote:
>> Luke Diamand <luke@diamand.org> writes:
>>
>>>      def run(self, args):
>>>          if len(args) == 0:
>>>              self.master = currentGitBranch()
>>> -            if len(self.master) == 0 or not gitBranchExists("refs/heads/%s" % self.master):
>>> -                die("Detecting current git branch failed!")
>>> +            if self.master == "undefined":
>>> +                self.master = None
>>
>> The comparison with textual "undefined" smelled fishy and I ended up
>> looking at the implementation of currentGitBranch().
>>
>>     def currentGitBranch():
>>         return read_pipe("git name-rev HEAD").split(" ")[1].strip()
>>
>> Yuck.  I know it is not entirely the fault of this patch, but
>> shouldn't it be reading from
>>
>>     $ git symbolic-ref HEAD
>>
>> and catch the error "fatal: ref HEAD is not a symbolic ref" and use
>> it as a signal to tell that the HEAD is detached?
>
> That sounds much nicer. I'll redo the patch accordingly.

While "symbolic-ref" _is_ the right way to learn what the currently
checked out branch is, I think you'd need to be a bit careful while
analysing the ramifications of that fix.

Notice:

    $ git checkout ld/p4-detached-head
    $ git symbolic-ref -q HEAD; echo $?
    refs/heads/ld/p4-detached-head
    0
    $ git checkout HEAD^0
    $ git symbolic-ref -q HEAD; echo $?
    1
    $ git name-rev HEAD
    HEAD ld/p4-detached-head

A few implications of the above observation:

 * The fact that the code used to use 'name-rev HEAD' means that it
   behaved as if you are on some branch when you are in a detached
   HEAD state, if your current commit happened to be at the tip of
   some branch.  Users could be relying on this behaviour, i.e. 
   you can detach (perhaps because you do not want to accidentally
   advance the history of the real branch) at the tip of a branch,
   and have "git p4" still apply the configuration based on the name
   of the original branch.

 * If there were multiple branches that point at your current
   commit, then what is returned by currentGitBranch based on
   name-rev is unpredictable.  So in that sense, the workflow that
   relies on the existing "use the configuration based on the branch
   name returned by name-rev" behaviour is already broken, but not
   many people have two or more branches pointing at the same commit
   very often, so they may perceive existing breakage of their
   workflow a non-issue.  To them, fixing the implementation of
   currentGitBranch may appear to be a regression.

 * Of course, if the user happens to have a branch whose name is
   "undefined", you may have detached the HEAD at a totally
   unrelated commit, and the existing code in run() would first set
   self.master to "undefined", notices "refs/heads/undefined"
   exists, and without even noticing that these two are not related
   to each other at all, happily goes ahead and uses "undefined"
   branch.  I don't know what happens in that case---perhaps it is
   the same as the second case where configuration for an unrelated
   branch is applied and no other damage is done.  Perhaps the code
   gets confused and sometimes updates HEAD and sometimes updates
   the tip of self.master branch.  In either case, the existing
   behaviour cannot be something the users have sensibly relied on.

A good write-up of the bug in the externally visible behaviour that
is corrected by fixing currentGitBranch implementation in the
Release Notes (when this fix hits a release) should be sufficient, I
think.

Thanks.

   
