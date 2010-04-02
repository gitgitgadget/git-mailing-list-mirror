From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: are hashes calculated from data
Date: Fri, 2 Apr 2010 00:48:44 -0400
Message-ID: <y2j32541b131004012148w283911f8pf04a21fc307f68ed@mail.gmail.com>
References: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com> 
	<o2q32541b131004011950u6023ef29ocac1d80f2847ef6f@mail.gmail.com> 
	<buozl1mbi0o.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Raymond Auge <raymond.auge@liferay.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Apr 02 06:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxYoj-00015I-QO
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 06:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab0DBEtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 00:49:08 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:35626 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab0DBEtG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 00:49:06 -0400
Received: by ywh2 with SMTP id 2so1223991ywh.33
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 21:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NeHHdXGj2dbzXKxLcNTkYeYOIJltE97LW7eo2RWlo84=;
        b=voZU1pWilcWilJJ3xqS9aKjveqQnrTK7rNqxRbxsy0tZcD1Y6zRG2SvVtxUXcHBmtK
         AtRgUQyC8XcMtpD3YuGzOofv5FcoFFWBoJ2vVcvKYKtEamNytT+zpm6TrTtILavMHkrj
         A/iaaphdQIs4uHa2Q8x+wx/RR1VPrEbXF6esw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AiQTkDYZFjCJUEHN1saLESdfikKk92CvXXI8kMOL68EEn06UqQBfRffZ/kNhdQbKjF
         SVVZFhw2topycUxeLXbGAYjJwZsvGgI5jxm2MwJ6hKZiSbSnQWOGbCPiCeEjvqL6w2fQ
         hfEQ1+rwac/LRBGMxJ4L17rr1MWrPYe9QVymo=
Received: by 10.150.152.4 with HTTP; Thu, 1 Apr 2010 21:48:44 -0700 (PDT)
In-Reply-To: <buozl1mbi0o.fsf@dhlpc061.dev.necel.com>
Received: by 10.150.128.39 with SMTP id a39mr2123281ybd.257.1270183744306; 
	Thu, 01 Apr 2010 21:49:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143776>

On Fri, Apr 2, 2010 at 12:22 AM, Miles Bader <miles@gnu.org> wrote:
> Avery Pennarun <apenwarr@gmail.com> writes:
>> At work, we have a cronjob that basically does most of these steps f=
or
>> us. =A0Then there's a central git repo that corresponds to the svn r=
epo;
>> people who want to use git can use that repo and not worry about
>> git-svn.
>
> Do you happen to have the cron script available for perusal anywhere?
>
> I imagine many of the details would need to be changed for other
> installations, but just looking at a working concrete example could b=
e
> very helpful...

Unfortunately the particular script we're using is about 99% local
stuff and 1% useful stuff, so posting it won't really help.  The
pseudocode is something like this:

       # configure your git-svn so that all its branches are under remo=
tes/svn/*
       git fetch origin
       git svn fetch --fetch-all
       for each branch in remotes/svn/*
           git checkout remotes/svn/$branch   # detaches HEAD
           git merge --no-ff origin/$branch
           git svn dcommit   # replaces merge commit
           git checkout origin/$branch
           git merge remotes/svn/$branch
           git push origin HEAD:$branch
       git push origin refs/remotes/svn/*:refs/heads/svn/*

And then people who want to push into svn can push into the 'origin'
repository, wherever that may be.  With some tweaking, you could make
the git-svn repo and the origin repo the same.  It's a little annoying
because git-svn absolutely insists on its branches being in
refs/remotes/ somewhere, which means they don't normally get fetched
when other people grab from your repo.

Also consider setting [merge]summary=3Dtrue in your .gitconfig, so that
the svn commit will have *some* useful information about what got
committed.

Hope this helps.

Avery
