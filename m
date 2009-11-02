From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Mon, 2 Nov 2009 02:33:39 +0100
Message-ID: <fabb9a1e0911011733o7d8d95eem57e02d455e0bd86@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-7-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300221290.14365@iabervon.org> 
	<fabb9a1e0910300557x42d3612pf7e83907e91efdc9@mail.gmail.com> 
	<alpine.LNX.2.00.0910301118070.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 02:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4loJ-0001Gq-84
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 02:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbZKBBdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2009 20:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbZKBBdz
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Nov 2009 20:33:55 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:42164 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZKBBdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2009 20:33:54 -0500
Received: by ey-out-2122.google.com with SMTP id d26so308525eyd.19
        for <git@vger.kernel.org>; Sun, 01 Nov 2009 17:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=n4/ApNnzmAkdlqyte+5s0M8x98OjqJigwEI99DJbKkg=;
        b=c2bcp3iHE1fRh2eu75ENI2FF9drwMZTEc2ReXEIUAcxrngrnTPO1WiIfKJcflk5sZR
         7KADi8us35kH6jzGTyBY9DacrpSo5Y2i/ZW6wtNoMbjhSCryMVr2zaedp833EVT5ybHk
         Zm8huSaeB3gaumXIepodKsL7PFIO022f4lXls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=CICoddrn4hm0SBs+JzuJyLmD9M0USmvoSelp0WzAns16plThMqyDuE7flwvVOJVrwZ
         vqB77Cd8Oioqvu0THi/KZYWTfVg81I2xs0y3uF5NSzMqqHljeZFSuEAKU04bEWg52N4k
         d/5tmrY3E/VOuN6cjbAf3WL6/K/SV6cw4Jazk=
Received: by 10.216.93.71 with SMTP id k49mr3744403wef.172.1257125639146; Sun, 
	01 Nov 2009 17:33:59 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0910301118070.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131890>

Heya,

On Fri, Oct 30, 2009 at 17:04, Daniel Barkalow <barkalow@iabervon.org> wrote:
> I think you have the sides backwards

Yup, sorry, got them the wrong way around for some reason.

> On the other hand, I think it would make sense to use the same style of
> refspec between the helper and transport-helper.c such that the helper
> reports something like:
>
> refs/svn/origin/trunk:refs/heads/trunkr
> refs/svn/origin/branches/*:refs/heads/*
> refs/svn/origin/tags/*:refs/tags/*
>
> "list" gives:
>
> 000000...000 refs/heads/trunkr
>
> "import refs/heads/trunkr" imports the objects, but the refspecs have to
> be consulted by transport-helper.c in order to determine what ref to read
> to get the value of refs/heads/trunkr. Instead of getting the value with
> read_ref("refs/heads/trunkr", ...) like it does now, it would do
> read_ref("refs/svn/origin/trunk", ...). And systems like p4 that don't
> have a useful standard just wouldn't support the "refspec" command and
> people would have to do site-specific configuration to get anything
> useful.

Yes, that sounds very reasonable, and I think that's the right way to
go. This leaves us with only one thing, we need a remote HEAD for 'git
clone hg::/path/to/repo' to work and have it check out a branch, I
think a seperate 'head' command might be appropriate? If supported it
returns the which local symref (e.g. 'refs/heads/trunkr' in the svn
case) should be pointed at by HEAD. If not supported we can just not
set it and clone will give the default 'no remote HEAD, nothing
checked out' message, which would probably be best for p4?

-- 
Cheers,

Sverre Rabbelier
