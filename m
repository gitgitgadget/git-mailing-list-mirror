From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git-fetch fetches blobs that are already in the local repository
 if no history is shared?
Date: Wed, 25 Apr 2012 06:56:38 +0530
Message-ID: <CAMK1S_jxC=7TK=2ODtJ6+5CqhUnLpiD_HC-hW1voQvTO1213LA@mail.gmail.com>
References: <D7CFF7BD2A9545148AC2553870AA3A15@gmail.com>
	<CAJo=hJsgk-5ByMoOJ-RSce+TUFLm43_SYHf1eHWsqE+xs6QNEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Adam Roben <adam@roben.org>, git@vger.kernel.org,
	=?UTF-8?Q?Tor_Arne_Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 03:27:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMr0i-0005UK-3S
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 03:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857Ab2DYB0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 21:26:44 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64039 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825Ab2DYB0n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 21:26:43 -0400
Received: by wgbdr13 with SMTP id dr13so1243511wgb.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 18:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nXT48tR2kDmDXBkMp+18nyvgMI1cx60EmNSiqhEg1GA=;
        b=jqmbhVeAQvdrhiOqG0sbtNH4rHu00v4LlB2RxTFBj7olDq328V2ZQnKntbZT6Pm1L1
         8O7p+AWJSvbIqGYRWdRnCN/1n5zoghQULjp84l+pzV7nzwYTmSNC+5FrHKmVpb3zEj2H
         KTK+R0xc8IZLWtKMEwmMD1B3NC5vKpKF/wSJDPAeNhQ0toSLs8bEOwcVHVYgBwySEkXF
         PEFCQ/DIzN9fUBb1B4YNUtCvfZsi1NApc0zcDaUM8QTB2u7dleDjto7F03IocWgVyLtS
         61P3J3Tucuw2OwvlwF/1rUPEzneYRKYLps9d1BBcbzpH5Oo2QD7c4QLcQvpCxAJJa3+S
         GjOQ==
Received: by 10.180.102.3 with SMTP id fk3mr1741776wib.9.1335317198406; Tue,
 24 Apr 2012 18:26:38 -0700 (PDT)
Received: by 10.180.82.200 with HTTP; Tue, 24 Apr 2012 18:26:38 -0700 (PDT)
In-Reply-To: <CAJo=hJsgk-5ByMoOJ-RSce+TUFLm43_SYHf1eHWsqE+xs6QNEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196294>

On Tue, Apr 24, 2012 at 7:53 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Tue, Apr 24, 2012 at 07:19, Adam Roben <adam@roben.org> wrote:
>> There are two main git mirrors of the WebKit Subversion repository: <git://git.webkit.org/WebKit.git> and <https://github.com/WebKit/webkit>. These repositories have the exact same trees/blobs, but have entirely different commits due to the GitHub mirror using a custom --authors-prog with git-svn.
>>
>> Tor Arne (CCed) noticed something interesting today:
>>
>> If you clone one of these repositories, then add the other as a remote and fetch it, all the trees/blobs seem to get pulled down again, even though they're already in the local repository. It seems like only the commit objects should be fetched, since they're the only difference between the two remotes.
>>
>> Is this a bug in git?
>
> No. Its the way the Git protocol was designed to function. Git only
> negotiates over the commit history, as trying to include the blob and
> tree information into the negotiation protocol would make the payloads
> unreasonable in size. Granted in this case sending the 100M or
> whatever it takes to enumerate all SHA-1s is smaller than the 4G or
> whatever that WebKit actually is, but the protocol assumes nobody
> would be this crazy to establish a huge project with two different
> competing commit histories and then think they could fetch them
> together into one repository with a small network delta.
>
> Basically... Don't do this, and don't expect Git to save you.

That said, if you have shell access to the remote server you *can* do
this.  We needed to do something like this as a one-time thing once,
and I think I just made a note of the SHA for the new branch, then ran
'git rev-list new-branch | git pack-objects pack'.  Copy the two files
created to the other machine's ".git/objects/pack" directory, then
give the SHA a name.

It's a hack but if you need it, you need it... :)

> There should be only one version of the WebKit history imported into
> Git that everyone agrees on as being the canonical version of that
> import. And everyone else who mirrors or works with WebKit in Git
> should base off that version.
>
> WebKit is a big enough project with enough users that you would think
> you could trust the git.webkit.org conversion. Which suggests the
> github.com one should be done over.


-- 
Sitaram
