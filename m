From: Phil Hord <hordp@cisco.com>
Subject: Re: How to manage multiple repos using submodules?
Date: Tue, 19 Apr 2011 09:18:11 -0400
Message-ID: <4DAD8B93.1040707@cisco.com>
References: <4DA9C7A7.4010503@sohovfx.com> <20110416182053.GA11017@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.w@sohovfx.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 15:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCAqH-0000iD-OB
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 15:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069Ab1DSNTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 09:19:40 -0400
Received: from sj-iport-3.cisco.com ([171.71.176.72]:47806 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab1DSNTj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 09:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3409; q=dns/txt;
  s=iport; t=1303219179; x=1304428779;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=pfvSrvUZq9SyZrar2/eOt/KbfXUbxY5mVCgHmZ6Xxes=;
  b=E+QxnJZOqsW/FffB0zt8iLHoQBWeWs6OcCxNvxBvlFbN+DNMGFd53bxK
   aB1DEn0hD7sFB5ljoqDWx/r/QeNmER3bVOlh5wSEZOpWzIX+QREi1Z8DN
   jeGYCNQHa+NsUdGKXTiwCwiJw/sm9hiVW7pcWZsdlJV+4+NmkR5XxyvxK
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAJmLrU2rRDoH/2dsb2JhbAAvpHx3iG+fKJx0gwqCZwSOB4N8
X-IronPort-AV: E=Sophos;i="4.64,239,1301875200"; 
   d="scan'208";a="297539416"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by sj-iport-3.cisco.com with ESMTP; 19 Apr 2011 13:19:38 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p3JDJbDG030836;
	Tue, 19 Apr 2011 13:19:37 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <20110416182053.GA11017@elie>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171796>

Thanks, Jonathan.

On 04/16/2011 02:20 PM, Jonathan Nieder wrote:
> Hi Andrew,
>
> Andrew Wong wrote:
>
>> It seems like submodule isn't meant for this, but many people seems
>> to use submodule to link many smaller repos together. With this
>> setup, I imagine whenever someone pushed a small repo, they're
>> /supposed/ to push the big repo as well. This way, if I simply
>> update the big repo and do a "git status", git will tell me that
>> which of the smaller repos are out of date.
> Yep, if you want to keep track of the state of a bunch of repos over
> time, submodules are not so bad[*].  In practice, often one instead
> wants to keep a bunch of repos up-to-date, and all this meta-history
> tracking is overkill.

I had been thinking about this a lot lately.  We are using submodules
somewhat extensively to manage a project with lots of common code
feeding onto 12 different platforms (various OSes, compilers and SOCs). 
It all feels quiet unwieldy but, at the same time, necessary.

I looked briefly at the android repo tool, but it's not just where I
want it to be either. Also, it loses history (by design, though that
seems to be a mistake they intend to correct someday).

But all this thinking got me closer to understanding that there are two
competing needs here, as you both pointed out:
  1. Point-in-time history using SHA-1s (the git model)
  2. Branch following (the 'repo', mr, gitslave or svn model)

When I am looking for a bug introduced in the past, I want to have the
first model.  When I am eager to pull in bug fixes, new features, or a
different meta-branch from other developers (and possibly other
projects), I want the second model.

Submodules make it difficult to manage both at the same time.   It
requires extra steps to do what it should be doing by default (acting
like git, tracking project point-in-time history).  I understand why it
is like this, but empathy doesn't ease the pain.

But I really do want both models.  I want point-in-time history, and I
want semi-automatic branch following.  Maybe something like this:

1. Easily record point-in-time history
   # Create and switch to a branch on superproject and all submodules
   git checkout -b topic-foo --recursive

   submodule A/topic-foo:  hack, hack, hack
   submodule B/topic-foo:  hack, hack, hack

   # Commit and push changes on each submodule
   git commit --recursive
   git push origin HEAD:ph/foo --recursive

2. Ignore the gitlinks and just checkout master everywhere
   git checkout master --recursive
  

I think I can do both with just a few tweaks of the submodule
machinery.  I haven't had time to spelunk there much, but I see others
are working to advance submodules in somewhat similar directions. 
(Thanks for that; it is much appreciated.)

Have these dueling modes been discussed into the dirt somewhere
already?  I find lots of discussions about other tools to perform model
2 instead of model 1, but I don't see much discussion about the
simultaneous need for both.   Maybe I am overthinking it.  Or maybe my
particular code model is unusual.

> I'd suggest using the mr tool.  Some projects (e.g., the
> debian-installer project) are using it to help people keep all their
> repos up to date.
>
> http://kitenet.net/~joey/code/mr/

Thanks.  I hadn't seen that one before.  I'll take a look.

Phil
