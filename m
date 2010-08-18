From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Ignoring commits when merging
Date: Wed, 18 Aug 2010 18:38:09 -0500
Message-ID: <20100818233809.GF2346@burratino>
References: <AANLkTi=B9gsroJS_6SRqa2CLQOed2UguxN7KiFtFWL8t@mail.gmail.com>
 <20100818015947.GA19632@burratino>
 <AANLkTi=MLE6WEmmDb6964-wX4f79ucpGU6SPieQK66ry@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Strauch <mike.strauch@hannonhill.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 01:39:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlsEg-0003yo-L6
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 01:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab0HRXjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 19:39:53 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35520 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab0HRXjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 19:39:51 -0400
Received: by gxk23 with SMTP id 23so436176gxk.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 16:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0bQFiY/3bkfZzxGLE8/DtZ7tpcEsHxLSFKrdPGaxFgE=;
        b=hQJh1a4rPgGQ0p/tivH3n/LHQMbFyYmmQBdBGQZLFqsYqOPtYSUFggXZHGPBuUzQ5a
         iJfZPTgnqZHVLDFcbqmm5uN3E1bp/t3Kgd+aMqka3PmhWm6wmBRChGiT+AAWpq5HtLyD
         wgZ2unasapagLXn6cxJUUCMeC2xt29iWq3aXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dJ2vW0LXOFXz4UMT0AFZJ6q6gxXiw5imNPQosrpwaSKsphe4qmjLpQkmHEg9V/xFVV
         7D8UBKKcvUBCOJXwzuNJ2wPZTPGFdmPWLb51nb1HoDEmwedBbpTCIFu3Wvx0aW50RdTx
         ePUFl/U9B6iQEGWnw9zeDtUxnR/5gBuB4G3ZU=
Received: by 10.100.243.24 with SMTP id q24mr10261610anh.183.1282174789769;
        Wed, 18 Aug 2010 16:39:49 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id w6sm1213189anb.3.2010.08.18.16.39.48
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 16:39:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=MLE6WEmmDb6964-wX4f79ucpGU6SPieQK66ry@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153898>

Mike Strauch wrote:

> We have a
> maintenance branch in which the majority of commits are bug fixes.  We
> would then like to merge those bug fixes into our master branch.  The
> difference being that there will occasionally be a commit in our
> maintenance branch that we do not want to merge into our master branch
> because it contains application version information

I see.  Yes, this is interesting (and not covered by gitworkflows though
it should be).

> 1. We fix some bugs in the maint branch (previous bug fixes)
> 2. We test those fixes
> 3. Merge the fixes back into master (M1)
> 4. Commit version information to maint branch (version info commit)
> 5. Release from maint branch (v1.0)
> 6. Start the process over from step 1 but with the version information
> commit in the maint branch commit history.
> 
> So, in this scenario there is really only ever 1 commit that we don't
> want to be merged into master from the maint branch.

Now your "merge -s ours" solution is looking like a good one.  So the
workflow on the release day might look like this:

 1. Fix some bugs on maint
 2. Test them
 3. Merge fixes back into master
 4. Version info commit on the maint branch
 5. Test a little more, tag the release.
 6. "merge -s ours" from maint to master
 7. Do some other work on topic branches and master.
 8. Push.

Ideally, in the published history, maint would _always_ be an ancestor
of master.  Life is simpler that way.

> This is not
> always the case of course.  There could be some other commits in maint
> branch that we don't want to merge back into master.

Sure.  Another possibility is to explicitly revert patches from maint,
either as a separate commit or as part of a merge.  The latter would
generally not make sense unless it is a very small patch.

For example:

 1. Fix some bugs on maint.
 2. Notice a test on maint is passing now.  Mark it as such.
 3. ... more work on maint ...
 4. Switch to master.  Merge from maint.  Since the test is
    failing:
    i.   "git reset --keep HEAD^" (undo the merge)
    ii.  "git merge --no-commit maint"
    iii. Mark the test as expected to fail.
    iv.  "git commit", mentioning the test failure in the log message.

This is called an "evil merge" because it introduces changes that
are not from either side.  Used judiciously it can be useful for
ensuring that every commit passes some basic tests (which might be
wanted if you use "git bisect" heavily).

"git revert" is simpler, of course.

Hope that helps.
Jonathan
