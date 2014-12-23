From: Craig Silverstein <csilvers@khanacademy.org>
Subject: Re: Saving space/network on common repos
Date: Mon, 22 Dec 2014 17:00:29 -0800
Message-ID: <CAGXKyzGnnt6bBEPoy4nvNn=zX0hdRHpgvsAe263apaDsVxv0dA@mail.gmail.com>
References: <CAGXKyzEYhR69w1=4q-xtBagVBwOPqNA9C=AD0bAorB+5eRtVRg@mail.gmail.com>
	<20141217223215.GO29365@google.com>
	<CAGXKyzEqTik3p=A8NZJ6kUscFjw_Dh1mBPT-ciwq9L8kNKDDig@mail.gmail.com>
	<20141218000723.GP29365@google.com>
Reply-To: csilvers@khanacademy.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 02:01:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3DqV-000665-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 02:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbaLWBAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 20:00:35 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43327 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaLWBAf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 20:00:35 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so3500689iec.12
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 17:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=jzI7cAAmPChYkfomczXY3natO3hK+BVuc/UBRkFryH4=;
        b=q+KDTGBD3a7KcncxLXV7Ayqsw/cfGOIoCOwu88sJnYoTem/bas+xh+JFFnuHtqH0rp
         +gZiZESSP/q5ctSGpU8NdREe/1AumzkZeelNZ27r/S1xqrrosAGOm43FUxEXIm/Kd3di
         iQdSE41mZpyGEweE4S/6h5E1dKv/Ext5LbCbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jzI7cAAmPChYkfomczXY3natO3hK+BVuc/UBRkFryH4=;
        b=j9RZRW6ZLIZzKlHGVE8xGxfXaOBAiPpNyhFh+F2DlnMM/bPiDLVzb/dD66pl3JUQHc
         lz75J52AwrwwIuY/kZmzwhH/lUtnVGvEfQo9aplS0dSv7Fbq1++IMKccw+Yx7E+czAUy
         kdyNk8tdzYXtoH9vlqcgqmLpfnVz6tEOOFyL/TguBMif9BULjJP+SI64OFkd2il+vRCJ
         ddli6BaNLyfLnXIFaqh3ken/Ui4+Fkk88AH1l5UyDvuVb9acJve5RNKr5S3j6ONes4jG
         rAjz8FWEjPVtHnPXFiwRHqx4u5uxMQVe3v4w7mRFJJR6D07ulgEJ1fqg+R2MkNSLJzuC
         EyDA==
X-Gm-Message-State: ALoCoQlPb9I0iY9pXoHFORATDFahxH5T1FirA4C1Lz871LLzptlo3etb7S1gef5dlH/CZSSIH+wn
X-Received: by 10.43.154.138 with SMTP id le10mr19434711icc.50.1419296429641;
 Mon, 22 Dec 2014 17:00:29 -0800 (PST)
Received: by 10.107.7.159 with HTTP; Mon, 22 Dec 2014 17:00:29 -0800 (PST)
In-Reply-To: <20141218000723.GP29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261705>

btw, just FYI, the scheme you lay out here doesn't actually work
as-is.  The problem is the config file, which has an entry like:
           worktree = ../../../mysubmodule
This depends on the config file living in
./git/modules/mysubmodule/config.  But the proposed scheme moves the
config file to mysubmodule/.git/config, and the relative path is
broken.

I'm not sure what the best solution is; the cleanest one requires a
pretty substantial rewrite of git-new-workdir (not that it's such a
giant piece of code), and separating out new_workdir from new_gitdir.
The smallest one involves having some way to suppress the final 'git
checkout -f' (which is the only thing in this script that needs the
worktree entry to resolve somewhere) to allow for post-script cleanup.

craig

On Wed, Dec 17, 2014 at 4:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Craig Silverstein wrote:
>> On Wed, Dec 17, 2014 at 2:32 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Craig Silverstein wrote:
>
>>>> Question 4) Is there a practical way to set up submodules so they can
>>>> use the same object-sharing framework that the main repo does?
>>>
>>> It's possible to do, but we haven't written a nice UI for it yet.
>>> (In other words, you can do this by cloning with --no-recurse-submodules
>>> and manually creating the submodule workdir in the appropriate place.
>>
>> Hmm, let me see if I understand you right -- you're suggesting that
>> when cloning my reference repo, I do
>>     git clone --no-recurse-submodules <my repo>
>>     for (path, url) in `parse-.gitmodules`: git clone url path
>> # this is psuedocode, obviously :-)
>>
>> and then when I want to create a new workdir, I do something like:
>>     cd reference_repo
>>     git new-workdir /var/workspace1
>>     for (path, url) in `parse-.gitmodules`: cd path && git new-workdir /var/workspace1/path
>>
>> ?  Basically, I'm going back to the old git way of having each
>> submodule have its own .git directory, rather than having it have a
>> .git file with a 'gitdir' entry.  Am I understanding this right?
>
> Basically.  The initial clone can still use --recurse-submodules.
> When you create a new workdir you'd create new workdirs for the
> submodules by hand.
>
> A 'git submodule foreach' command in the initial repo can take
> care of the `parse-.gitmodules` part.
>
> [...]
>> Also, it seems to me there's the possibility, with git-newdir, that if
>> several of the workspaces try to fetch at the same time they could
>> step on each others' toes.  Is that a problem?  I know there's a push
>> lock but I don't believe there's a fetch lock, and I could imagine git
>> getting unhappy if two fetches happened in the same repo at the same
>> time.
>
> That's a good question.  If concurrent fetches cause trouble then I'd
> consider it a bug (it's not too different from multiple concurrent
> pushes to the same repository, which is a very common thing to do),
> but I haven't looked carefully into whether such bugs exist.
>
> Hopefully someone else can chime in.
>
> Thanks,
> Jonathan
