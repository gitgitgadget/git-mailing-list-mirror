From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 12:13:50 +0000
Message-ID: <200703051213.52513.andyparkins@gmail.com>
References: <17895.18265.710811.536526@lisa.zopyra.com> <Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070302162136.GA9593@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 13:14:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOC56-0004iq-Dd
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 13:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbXCEMOC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 07:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933266AbXCEMOC
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 07:14:02 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:25713 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933193AbXCEMOA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 07:14:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1215604uga
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 04:13:59 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pl8++hoQxSSkXRJPe3dBiDK87kqPjSpxYDV1/LsQyntZ5PWSHCI/XV8aFrFrACC53nnTRreLN2uPn51X4Shit0wAsHa4r8qdJL4MeRufnxUfZWt89el/P8senwRH6GIIWO75v6e+ShtrZl/20jNC6e/LrBZvjx44/d9ZzAKMw3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WYTqAVgTVwDDsAYXtdk++roEEUMUDBb/q1RSMYDYeyAtJ507Yc3gai20Ghd1Yd4MT2ajMpqDve45CyJCGwwY3Q2fjD+Xt2ghgXylgV/+bXa5Vv1NIomaoa5R+uemd6XbqCZ/9z4aUIecUq8gdTf1vnKfuwSTLMsFXW6fLYjVj88=
Received: by 10.78.178.5 with SMTP id a5mr608126huf.1173096838614;
        Mon, 05 Mar 2007 04:13:58 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id v20sm22717902nfc.2007.03.05.04.13.55;
        Mon, 05 Mar 2007 04:13:56 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070302162136.GA9593@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41438>

On Friday 2007 March 02 16:21, Karl Hasselstr=F6m wrote:

> However, given that your file timestamps have been bumped (without
> file content changes), it's a performance bug in your make tool if

Actually, git is as good as it could reasonably get in this regard.

Let's say you did this:

 git checkout branch1
 git checkout branch2
 git checkout branch1

Git will only touch the timestamps of files that are different between =
the=20
branches.  If the same file is in both branches, then that one remains=20
untouched in your working tree (it's tricks like this that make git so=20
blindingly fast).

The fact that you've changed back from branch2 to branch1 is the bone o=
f=20
contention - how is git meant to know that you haven't done a compilati=
on=20
while you were on branch2 and hence changed the files that untracked fi=
les=20
depend on?  The /only/ sane thing it can do is, in both cases, update c=
hanged=20
files to have the current time.

Perhaps an example would make it clearer:

 git checkout branch1
 # sourcefile.c changes, so git touches the timestamp
 # make would rebuild sourcefile.o
 git checkout branch2
 # sourcefile.c changes, so git touches the timestamp
 # make would rebuild sourcefile.o
 git checkout branch1
 # sourcefile.c changes, so git touches the timestamp
 # make would rebuild sourcefile.o

That's all exactly right, make knows in each case the the ".o" file is =
out of=20
date because it has a timestamp earlier than sourcefile.c

Now take the suggestion that timestamps from the repository version sho=
uld be=20
restored and do the same thing:

 git checkout branch1
 # sourcefile.c changes, git sets the timestamp to $timestamp1
 # make would rebuild sourcefile.o (setting its timestamp to $now)
 git checkout branch2
 # sourcefile.c changes, so sets the timestamp to $timestamp2
 # make wouldn't rebuild sourcefile.o because $timestamp2 < $now
 git checkout branch1
 # sourcefile.c changes, so git sets the timestamp to $timestamp1
 # make wouldn't rebuild sourcefile.o because $timestamp1 < $now

All very wrong; in two out of the three builds, the wrong sourcefile.o =
ends up=20
in the final object.

What git does now is absolutely the right thing.  It keeps unnecessary=20
rebuilds to the safest minimum.



Andy
--=20
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
