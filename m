From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t9010: svnadmin can fail even if available
Date: Thu, 6 Jan 2011 14:46:05 -0600
Message-ID: <20110106204605.GA15090@burratino>
References: <4D25E818.5050909@gmail.com>
 <20110106165958.GA11190@burratino>
 <4D25F9C5.6030503@gmail.com>
 <20110106180051.GC11346@burratino>
 <7vpqs9aiul.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 21:46:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PawjW-00042J-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab1AFUq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:46:26 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51828 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab1AFUqW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:46:22 -0500
Received: by qyj19 with SMTP id 19so19787555qyj.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QGQN49JdY0SryF2xN/X1up54hJnpr4SFUF2ZSoXwWqQ=;
        b=CZoC3mqhzSHfuOS5Ew+NDSPNIMax7Hehw9QFkOxy5cw4nnXC+kwonQYD8EXSfA3l1J
         mYptpWYaBxpTgBy+EHUa5LVKQ9GrjRB/KymJ35UfbcvauDEZtCQ/IU+vOMjIbphgrgrj
         4I6QvSJF/nT6NiyPRH91Z7kkmgbxcU+AxqWcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BReHqF+XsvlET63Q/CpTYcze2YziEDf4tXPhnJkWvXzQemmixodBu7vfQ/PD10Rk6o
         2tVKu9A+tlAqiNFdR8Eqg01EhzQ3Xcww89XSQ56EW1nreacD6B58Wrv2fIoWlYno1A3O
         U8E8DY+S6ImVkevUSAJj4FeaTHJ4LrdL4rWYo=
Received: by 10.224.37.2 with SMTP id v2mr23771849qad.92.1294346781800;
        Thu, 06 Jan 2011 12:46:21 -0800 (PST)
Received: from burratino ([69.209.72.219])
        by mx.google.com with ESMTPS id nb15sm13707032qcb.14.2011.01.06.12.46.19
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 12:46:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqs9aiul.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164671>

Junio C Hamano wrote:

> But I am somewhat unhappy because I do not think we want to cater to all
> the broken installations of system tools.  When tests fail because
> somebody's "mkdir -p" (just a random example I picked from your patch)
> does not work correctly, we would just say "Your system is broken, and
> here is a nickle; get a better computer".  Why is svnadmin so special?
> 
> Also isn't the breakage not just this test, but also in all the tests that
> try to run "svnadmin load"?  Shouldn't we somehow hoist this logic out of
> t9010 and put it in t/lib-vcs-svn.sh or somewhere?
>
> As far as I understand, svn interoperability bits (git-svn and vcs-svn) do
> not rely on svnadmin at runtime, so a breakage in the system's svnadmin
> would not be a reason to omit building and installing them.

You're right, I did not do a good job of selling the patch.  I should
have said:

	Subject: t9010: svnadmin can fail even if available

	If svn is built against one version of SQLite and run against
	another, libsvn_subr needlessly errors out in operations that
	need to make a commit.

	That is clearly not a bug in git but let us consider the
	ramifications for the test suite.  git-svn uses libsvn directly
	and is probably broken by that bug; it is right for git-svn
	tests to fail.  The vcs-svn lib, on the other hand, does not use
	libsvn and the test t9010 only uses svn to check its work.  This
	points to two possible improvements:

	 - do not disable most vcs-svn tests if svn is missing.
	 - skip validation rather than failing it when svn fails.

	Bring about both by putting the svn invocations into a single
	test that builds a repo to compare the test-svn-fe result
	against.  The test will always pass but only will set the new
	SVNREPO test prereq if svn succeeds; and validation using that
	repo gets an SVNREPO prerequisite so it only runs with working
	svn installations.

	Works-around: http://bugs.debian.org/608925
	Noticed-by: A Large Angry SCM <gitzilla@gmail.com>
	Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
