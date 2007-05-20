From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: Using git to store /etc, redux
Date: Sun, 20 May 2007 11:48:35 +0200
Message-ID: <20070520094835.GA6971@hardeman.nu>
References: <20070519174815.GA5124@hardeman.nu>
 <Pine.LNX.4.64.0705191611150.6938@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun May 20 11:47:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpi0y-0000Y9-UD
	for gcvg-git@gmane.org; Sun, 20 May 2007 11:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbXETJrn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 20 May 2007 05:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755327AbXETJrn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 05:47:43 -0400
Received: from smtp18.wxs.nl ([195.121.247.9]:47676 "EHLO smtp18.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755016AbXETJrm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 05:47:42 -0400
Received: from austin (ip54532fb6.speed.planet.nl [84.83.47.182])
 by smtp18.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with ESMTP id
 <0JIC002EO37H7Q@smtp18.wxs.nl> for git@vger.kernel.org; Sun,
 20 May 2007 11:47:41 +0200 (CEST)
Received: by austin (Postfix, from userid 1000)	id 65FDB290D5F; Sun,
 20 May 2007 11:48:35 +0200 (CEST)
In-reply-to: <Pine.LNX.4.64.0705191611150.6938@asgard.lang.hm>
Content-disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47805>

On Sat, May 19, 2007 at 04:37:54PM -0700, david@lang.hm wrote:
>On Sat, 19 May 2007, David H=E4rdeman wrote:
>
>>I recently had the idea to store and track /etc using git. When googl=
ing=20
>>the topic I came across the "Using git to store /etc" thread from the=
 end=20
>>of last year which provided some interesting details on what would be=
=20
>>necessary.
>>
>>It seems the file metadata (owner, group, mode, xattrs, etc) was the =
big=20
>>stumbling point, so I wrote up a tool over the last few days which al=
lows=20
>>the metadata to be stored in a separate file which can be stored alon=
g=20
>>with the rest of the data in the repo (or separately).
>>
>>This is also useful for tripwire type checks and for other types of=20
>>storage which drops some of the metadata (tar comes to mind)...
>>
>>The tool (metastore) is available from: git://git.hardeman.nu/metasto=
re.git
>>
>>Not completely cleaned up yet (it lacks a real README and some Makefi=
le=20
>>targets) but I hope it might be useful to others (it sure is to me).
>>
>>Please CC me on any replies.
>
>as I understand the issue, the problem isn't creating a tool to store =
the=20
>metadata, but in integrating things with git.

That is also important of course, the problem is that there are many=20
different scenarios for how people might want to work with the metadata=
=20
(e.g. whether changed metadata should be stored automatically or only=20
with user interaction, etc).

=46or the "store /etc in git" solution which is what got me into this, =
it=20
might be enough to have a pre-commit hook if all changes are made in=20
/etc and committed to /etc/.git periodically (meaning there are no real=
=20
checkouts to speak of).

>when checking something in a pre-commit hook needs to run the tool to=20
>store the data.
>
>git supports this and it's pretty simple to do this.

Yes, I already have hook scripts in my local setup which does this,=20
it was not clear whether pre-commit hooks could change the commit by=20
adding more files to be committed but it seems to work, essentially=20
the pre-commit hook is just:

metastore -s
git-add .metadata

>however when checking things out there are approaches
>
>1. modify git to have a post-checkout hook to set the metadata to matc=
h
>    what was stored at checkin and accept the fact that this leaves a
>    window where the file has the wrong metadata on it (between when t=
he
>    file is written and when the hook runs), or use a staging area to =
have
>    copies of the files during check-in and check-out

Right, I use a non-hook script for this right now which changes umask t=
o=20
0077, pulls the changes, shows the difference in metadata and asks for=20
confirmation and then applies the metadata (which undoes the effects of=
=20
the umask setting).

I think I'll add both scripts to my git repo as examples soon.

--=20
David H=E4rdeman
