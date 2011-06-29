From: Phil Hord <hordp@cisco.com>
Subject: Re: [GSoC 11 submodule] Status update
Date: Wed, 29 Jun 2011 17:27:38 -0400
Message-ID: <4E0B98CA.2050207@cisco.com>
References: <20110627193444.GA26778@paksenarrion.iveqy.com> <4E09205E.2080904@cisco.com> <20110628184358.GA3700@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 29 23:27:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc2IU-0005Ss-Iv
	for gcvg-git-2@lo.gmane.org; Wed, 29 Jun 2011 23:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953Ab1F2V1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 17:27:41 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:49584 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab1F2V1k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 17:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=3683; q=dns/txt;
  s=iport; t=1309382860; x=1310592460;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=3Yv9A6F2F/JyuKidndH8VnDdDnA/VAO7lYWTiO0Ywzo=;
  b=hCI9j4CsKb6huMACruTIiCoaSiXTfQ8tlHrVL9KlPd/nqs7csgG34Swc
   0wO7QTXCY66q7lteNZSsIjeJ80n4cm1X5QaYL3fo/bSRwkrmLv8u3PctG
   Kw4IWw9A+sKEJNCbFBi3qp1voDKLT9wZkqjr80YtU0Zy87RBi1zZW6MXc
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAJyYC06tJV2Z/2dsb2JhbABSp1p3iHijBJ1+hjAEkhaEdYtR
X-IronPort-AV: E=Sophos;i="4.65,445,1304294400"; 
   d="scan'208";a="724390246"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by sj-iport-6.cisco.com with ESMTP; 29 Jun 2011 21:27:39 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p5TLRcSh012301;
	Wed, 29 Jun 2011 21:27:38 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110516 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110628184358.GA3700@book.hvoigt.net>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110629172738516
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176458>

On 06/28/2011 02:43 PM, Heiko Voigt wrote:
> Hi,
>
> On Mon, Jun 27, 2011 at 08:29:18PM -0400, Phil Hord wrote:
>> On 06/27/2011 03:34 PM, Fredrik Gustafsson wrote:
>>> My fourth task (and the main task of this summer) will start on June 27 and
>>> will be to move a submodules .git-dir into the super-projects .git-dir.
>>> Design of this is already done and approved by my mentors.
>> This frightens me a bit, so I read the wiki link about it.  Thanks for
>> explaining where I can find this information.
> I do not know what part of this change frightens you?

It frightens me because it seems like a fundamental break from the
current submodule functionality.  Today a submodule exists as a git
repository with no knowledge that it is a submodule or who its
super-repository is. Maybe this is a design mistake in need of
correction.  But this change seems both huge and subtle to me.  I
suspect it will affect many tools which expect the traditional git
layout, submodules or not.  For example, a third-party tool might seek
out the ".git" directory by walking upwards.  Once it finds it, it will
(safely, today) assume that is the .git directory relating to its
files.  After this change, the tool will be broken.

    # Find my .git directory
    mygit=${PWD}
    while test -d "${mygit}" && ! test -d "${mygit}/.git" ; do
        mygit=$(dirname "$mygit")
    done

    # Now lets do things with "our" repo
    fetched_sha1=$(cat ${mygit}/FETCH_HEAD)
        .
        .
        .

Granted, script-writers should be using the git plumbing as much as
possible to avoid this kind of change.  But not everyone can afford to
be so conscientious.  

>> But I'm still confused.
>>
>> If I understand right, the submodule/.git dirs will be moved into the
>> top-level at .git/submodule/.git.  The benefit is supposed to be that
>> this will free up contention on the non-empty submodule directory when
>> the super-project switches branches.
>>
>> In the simple case, git warns "unable to rmdir sub: Directory not
>> empty".  But I can think of other conflicts as well.
>>
>> My question is, how does this proposed change help the situation?
> The proposed change allows us to implement that a submodules directory
> can be completely removed if it was deleted or moved. If we would do
> that currently you would loose all local history of the submodule. I do
> not know what you mean with "conflicts" but this change will help
> submodule towards behaving like they were ordinary directories in git.

I see.  By moving the local history out of the way, the submodule
directory is free to be changed or removed without harming the local
history.  That's clever.  I think Android's 'repo' tool does something
similar.

I think I can answer my other concerns now.  Do these answers sound right?

What happens if the submodule working directory is dirty?  
    Treat it the same as git does for its own working directory.

But what if the submodule working directory is 'clean' after considering
.gitignore?  Do untracked/ignored files also get deleted?
    Treat this the same as git does for its own working directory.

What if a 'git checkout' results in the submodule being removed?
    Remove the entire submodule directory (or just remove tracked files?)

What if a 'git checkout' or 'git merge' results in submodule 'foo' being
added where there is already a file named 'foo'?
    This is a working-directory merge conflict.

Thanks for explaining.  I feel better about it all now.  I remain
concerned about backwards compatibility, but I'm not so worried about
conflict-resolution anymore.

Phil
