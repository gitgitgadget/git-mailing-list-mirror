From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: GSoC proposal for svn remote helper
Date: Sat, 9 Apr 2011 14:21:42 +0600
Message-ID: <BANLkTimp_Bc3bSC5WxHuyFmQdNR23qPRMA@mail.gmail.com>
References: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com>
	<BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com>
	<20110408052126.GA22256@elie>
	<BANLkTinWtqNYvZP2yamx831_U9KHZ4x3qA@mail.gmail.com>
	<20110408223150.GA27284@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, artagnon@gmail.com, david.barr@cordelta.com,
	srabbelier@gmail.com, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 10:22:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8TQe-00083p-Jq
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 10:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab1DIIVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 04:21:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60474 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab1DIIVo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 04:21:44 -0400
Received: by eyx24 with SMTP id 24so1302090eyx.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KbKtRcm6udzoY7SVIzmxeRoAbN/21WosXmef4kM6GBg=;
        b=i+phfx7dukE8RnswZYBUb8guKHCcNTxNIpuWFEqYTIML8I2FzJGnrqM8pqqT5cxy1P
         AxtW5DJTcC640JbeJ59riDMSVwVf53eKRmH2gJtqjY3n3oZLpimQQryy98kuF+HR3FMY
         /SAgCmppM2orHFFlLUngdRgALc2dmb5+BHvTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pd+1ILBkyp2ili2rhX5oAOXodxiILjiEJ+JO6rfN3qZQ3CcFE4iUZKfOCJuXwkJpyz
         u7OjE9pkhY9Eol9L9ghDomnNvpN4AIL+CIK8PD9/mmGfOQN0yVIYMkANzmkcZUWJ/wQK
         2zJyt0Pj1rP/A4eegJTHsDZZxEtR0gSsJ6iBw=
Received: by 10.14.124.68 with SMTP id w44mr1368456eeh.77.1302337302685; Sat,
 09 Apr 2011 01:21:42 -0700 (PDT)
Received: by 10.14.37.10 with HTTP; Sat, 9 Apr 2011 01:21:42 -0700 (PDT)
In-Reply-To: <20110408223150.GA27284@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171186>

Hi

On Sat, Apr 9, 2011 at 4:31 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>
> At the moment I am more concerned with what its guts will look like
> than what features it will support. =A0A feature list is just a way t=
o
> advertise how good the guts are. ;-)
My current view is following:
Use svnrdump stream to track / in say svnroot branch. It'll be linear
(1), commits will include actual diffs, and some revprops translated
to their git counterparts like svn:log,svn:author,svn:date (2). And
it'll be a bridge for svn interaction.
In git-notes tree store sha1 -> svn rev mapping(3), and also for each
svn rev store all it's revprops.
Store and maintain /path branches - there we have some freedom of
choosing git parents.
That's all about fetch. Obviously svnrdump will be used to push
fast-forward linear history back to svnroot, or to a /path branch
which goes the same way in fast-forward case.
And to be somewhat usable we want to be able to rebase-push/dcommit
(if there is a dense stream of svn commits going, we don't want the
user to type git rebase, git push and fail until he gets a lucky
timing).
Merges need more thinking, and may be not that necessary for a start.
Path ignores, or even revision ignores should be possible to implement
in the code, but just an emergency tools for a user (sometimes people
(by mistake) commit something enormous or incompatible with
filesystems names or like, so that user considers it ok to trash this
out of his history), also there could be a need for permanent path
filter (like track /projX, not /bin) - just the same, be ready that
sometime it'll have to be implemented.

[skipped some of svn commit "races" and merge tricks]

>> -- if it was, create a svn branch of our parent, commit there, and
>> then create a merge commit of these two, commit it and get same merg=
e
>> history back
>
> Yikes. =A0I don't think typical projects would like the resulting
> history.
Will make them mad, but in some cases it should be ok, if we are
pushing a lengthy topic branch they'll sometimes prefer to see it as
one commit.

> Yes, this is an interesting question. =A0Given a history like this (t=
ime
> flowing left to right):
>
> =A0 =A0 =A0 =A0 E --- F --- G
> =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0A --- B --- C -- D -- H
>
> where A is the latest rev of trunk/, how do we push this history to
> svn? =A0Where is the name of the side branch recorded in the git
> history?
Could be either autogenerated with some user pattern, like
/branches/user/tmpXX, or specified explicitly in git-notes or
somewhere, or maybe we have already pushed a placeholder branch to svn
and will commit there.
>
> On answer is that it's possible to learn the historical branch name b=
y
> parsing the commit message for "H". =A0Yuck.
>
> I'd put off pushing merges to start.
It's definitely not in the minimal plan.

> I think the cleanest solution is often to reject a push if it is not
> obvious how to represent it remotely, just as though the remote serve=
r
> had a hook that rejected it.
Makes sense, after all plain svn users want to see svn-like history,
because they still use svn.

(1) In theory we could track whole svnroot merges (from svnroot2 on
the same repo for example, or hypothetical merge from another repo)
but that's hardly used by anyone.
(2) The hardest thing is to decide which ones to store in git.
Translating more gives a better look and feel, translating less
reduces the chances to get the same git objects on another clone. And
what should git do if this data changes is not a trivial choice too.
(3) And a funny thing is could happen that there are path1@rev1
path2@rev2 that produce the same sha1. That's perfectly fine because
they are just refs, care should be taken when choosing a path to
commit to though. Also svn will distinguish them, but it's just a
corner case.
