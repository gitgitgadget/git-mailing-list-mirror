From: Paolo Bonzini <bonzini@gnu.org>
Subject: [RFC] Moving "git remote add --mirror blah" functionality to "git
 clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 10:28:36 +0200
Message-ID: <480EF334.1090907@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 10:29:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoaM3-0008BJ-JW
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 10:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbYDWI2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 04:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbYDWI2j
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 04:28:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:52224 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYDWI2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 04:28:37 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2532255fgb.17
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:sender;
        bh=KWlD897iGLs/rEWu6gqWdooU5NWxQJlU6a5NCwj7opc=;
        b=jzas70NiKUG/M7tE/RF03JXg9h7Jmq7+HwrWx+VrvknmF0RV1l2NkSknwrnOCEIbVRqTge7xbTRa8Qzj9//XB7vnb718KoGcaymOTzhw8oCCsc0MbemNp0rG8lkfDHD2EcbcYsefkAcWzqdiPpDLGQKaL0flpTWgwEXHVByAIjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:sender;
        b=fGKYR1KFETtChK7B+LAU3MQnLYXSLCIP3bvAsyvt9mE8LvoXdXDjGn1qrvL7ZSiv6ssNO0au0lC7oN5MDNFa/dy1dz0kR/nVBmQs/9pJEU5s2QOwpOil4D0kYZVA7irrHcwH4oB4Ek6c3HmAnkpDRACnNdwS6E4tAkpXmzs3gVM=
Received: by 10.86.87.13 with SMTP id k13mr2260889fgb.32.1208939316097;
        Wed, 23 Apr 2008 01:28:36 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id d4sm5795811fga.2.2008.04.23.01.28.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Apr 2008 01:28:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80198>

In the thread "git remote update -> rejected" Junio and Johannes came to 
the conclusion that "--mirror means that you do not have local 
branches", because "you give control away to the other end on the ref 
namespace".  Furthermore, it was agreed that --mirror currently makes 
sense mostly (or only?) on a bare repository.

 From here I gather that if you have "git remote add --mirror", most 
likely the mirrored repository will be the only remote you have.  There 
is in general no point in having other remotes in a bare repository. 
And so there is no loss of generality if this remote is the "origin" remote.

Hence, my proposal is:

1) Add an option to "git clone", to be used with --bare, to create a 
mirror.  --bare already leaves the original refs in place, without 
moving them under refs/remotes/origin, so it makes sense to optionally 
create the remote.

Actually you don't need to add a new option.  Right now, specifying 
-o/--origin together with --bare would give an error; in my proposal, if 
you had "--bare --origin=source" a remote would be created in the config 
file like this:

[remote "source"]
	url = ...
	fetch = +refs/*:refs/*

2) Modify the --mirror option to "git remote add", so that it creates a 
remote *acting as a mirror of this one*.  The config would look like this:

[remote "mirror"]
         url = ...
         fetch = +refs/heads/*:refs/remotes/mirror/*
         push = +refs/heads/*:refs/heads/*
         push = +refs/tags/*:refs/tags/*
         mirror


Now, I know that this is not what was proposed in the original --mirror 
thread, and it is backwards-incompatible.  On the other hand, I think it 
has several advantages:

1) it does not add special cases such as "--mirror is only to be used in 
a --bare repository".  It moves the functionality to a combination of 
options that used to give an error.

2) it provides an easy-to-use UI to create a mirror of this repository 
somewhere.  With a patch I already posted, "git push" would 
automatically update this mirror.

3) overall, I think it makes a lot of sense: "git remote add" is about 
adding one remote of many, and "git clone" is about setting up a single 
special remote.  Now, you can have many remotes that are 
mirrored-from-here, while you can only have one remote that is 
mirrored-to-here.  So, I believe that "git remote add" should add 
mirrored-from-here remotes, while "git clone" should be used to create a 
mirrored-to-here remote.

Opinions?

Paolo
