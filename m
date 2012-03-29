From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: Removing useless merge commit with "filter-branch"
Date: Thu, 29 Mar 2012 11:26:47 -0700
Message-ID: <CAOMFOmWrG9WGZCF6j3P=Somo1DDxoB=ALCiYYbjO__8=uxYokg@mail.gmail.com>
References: <CAOMFOmWMsXgepY0-ZWFymd9uHSUmbOk66r75qa-Kv5TWx_U=EA@mail.gmail.com>
	<7v62eebri3.fsf@alter.siamese.dyndns.org>
	<CAOMFOmUT+2q7jC9Z1=zFJdBi_KAg=A66yHJNF2LRvjfQcgbdFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 20:26:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDK3h-0006ou-K7
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 20:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759623Ab2C2S0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 14:26:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47455 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab2C2S0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 14:26:48 -0400
Received: by ghrr11 with SMTP id r11so1743470ghr.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=BNd0OyBdDi4hFoGAC+0JQ/I6byIX20+WqXMN9fT+RxM=;
        b=x/uJ2HlhnEKXY/Pw1byCgUsAn5JyI+MZDXgRhQS0PBOhzloYY21zFbfEDLruei6yB7
         HhO2mM10lFq2LdIt4KVP6fPcIhipEienQjYEerK2pOD9Tz3RkFPTBP/w42+fwbQKO6j7
         Jbtr2MFG8UAa4x9R6WVk8gOypjT7s4OH2nAsQmiaki2xoJ5fb7ZoYP2TSSgbKwLGlP2b
         YHNauKcGt4DX22eBgEZHaNPb/5Seu5CwO5+mx7TVHHN+eTB+/mhyZwxVlbY/S5dlrQmc
         SXIt/m0jLrBaKFPV+VrXldDAw6CnpXmHcCiaYYcg+2JxhA5ZEZcyRTzYtAviXWf8SPyz
         jjgQ==
Received: by 10.236.201.233 with SMTP id b69mr27395903yho.71.1333045607409;
 Thu, 29 Mar 2012 11:26:47 -0700 (PDT)
Received: by 10.101.57.6 with HTTP; Thu, 29 Mar 2012 11:26:47 -0700 (PDT)
In-Reply-To: <CAOMFOmUT+2q7jC9Z1=zFJdBi_KAg=A66yHJNF2LRvjfQcgbdFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194285>

Hi,

I solved my issue by using "git filter-branch --parent-filter". The
idea is to visit all commits and remove all "dependent" parents. To
find independent parents I used "git show-branch --independent
PARENT_1..PARENT_N" command. In my case (we have a lot of short-term
development branches) this converted ~80% of all merges to "empty
non-merge commits" and later "git filter-branch --prune-empty" removed
them. This made history of my project much more simpler and linear.

I think such functionality should be available in git and enabled when
"--prune-empty" flag is used. So "--prune-empty" removes not only
simple commits but also empty useless merge commits. Or maybe add a
--prune-empty-merges flag?

Anyway here is the script that I use, future readers might find it usef=
ul:

$ git filter-branch -f --prune-empty --parent-filter
PATH_TO/rewrite_parent.rb master
$ cat rewrite_parent.rb
#!/usr/bin/ruby
old_parents =3D gets.chomp.gsub('-p ', ' ')

if old_parents.empty? then
  new_parents =3D []
else
  new_parents =3D `git show-branch --independent #{old_parents}`.split
end

puts new_parents.map{|p| '-p ' + p}.join(' ')

Most likely the script can be rewritten as one-line shell script.

On Tue, Mar 13, 2012 at 3:27 PM, Anatol Pomozov
<anatol.pomozov@gmail.com> wrote:
> Hi
>
> On Thu, Mar 8, 2012 at 3:30 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> Anatol Pomozov <anatol.pomozov@gmail.com> writes:
>>
>>> |
>>> o =C2=A0 =C2=A0 =C2=A0- merge commit that previously merged feature=
 X
>>> |\
>>> | \
>>> | =C2=A0\
>>> o =C2=A0| =C2=A0 - real commit
>>> | =C2=A0 |
>>> | =C2=A0/
>>> |/
>>> |
>>
>> It is unclear how many commits are drawn in the above picture and
>> what "feature X" is about in the above picture. =C2=A0Care to redraw=
 the
>> commit DAG to explain what you are trying to do a bit better?
>>
>> The way I read it is that you start from a history like this (note
>> that when we draw an ascii art history we often write it sideways,
>> time flows from left to right):
>>
>> =C2=A0 =C2=A0---A-----B-----M---
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 C-------D
>>
>> where a side branch to implement "feature X" that has C and D forked
>> at A, and it was merged at M after somebody else committed B on the
>> mainline. =C2=A0When you filtered out some parts of the tree, it tur=
ns
>> out that C and D are totally unintereseting because their changes
>> touch parts outside of your interest, i.e. the history is:
>>
>> =C2=A0 =C2=A0---A-----B-----M---
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 o-------o
>>
>> where 'o' are now no-op.
>>
>> Is that what you are talking about?
>
> Yes, in fact --prune-empty flag removes empty commits so the history =
looks like
>
> -----A-------B-------M--------
> =C2=A0 =C2=A0 =C2=A0 \ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--------------
>
>
> So M is a merge that has 2 parents A and B. I would like to remove
> this merge M and leave the history as
>
> -----A-----B-----
>
> as only these commits have changes in my library that I am trying to =
extract.
>
> I think some trickery with "git filter-branch --parent-filter" should=
 help here.
>
> First one runs filter-branch with --parent-filter and removes useless
> parents from merges (in this example with will be parent A---M), this
> converts such merges to regular empty commits
>
> then run filter-branch one more time with --prune-empty - it removes
> empty commits.
>>
>> I think "log --simplify-merges A..M -- path" may already has logic
>> that deals with this, so it may help if you study what it does and
>> how it does what it does.
