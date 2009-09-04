From: David Aguilar <davvid@gmail.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
	merge)
Date: Fri, 4 Sep 2009 16:45:53 -0700
Message-ID: <20090904234552.GA43797@gmail.com>
References: <4AA17874.7090905@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Haas <haas@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 01:55:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjid3-0004Wf-CM
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 01:55:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933967AbZIDXyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 19:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933961AbZIDXyL
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 19:54:11 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:2591 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933927AbZIDXyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 19:54:11 -0400
Received: by an-out-0708.google.com with SMTP id d40so2468614and.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rk6CSBS8iXPEKPrnOMXsg1WjAqqTlqX9ZSo3IRMD48s=;
        b=D+UjsCOUFbHx3La1Odk4MIW1g93vVFPKnn885QdhjLuAxHmu5z1KADyAIfvuOlc5nH
         tZeUoQMJsbOj5sdMMUE5Mb/wyiqJMt1UQ/BUeBodY8xGRlZrwOV20SKkRNPP+Kpv3nMY
         Dz/OWGjBZqtpSYeDcQPELqlq5sexyjbwTcrX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fALqn38RRoOIVjwpxN3zQ5ShtFqgaXvlDSwG/yB1FOnfofajSBTsQujfAoRM7fQK4G
         boRLJ279uA/fCQGmEkG3fHQmgHpyIq4uVcEYcKdkWdfxiTiW2XuTOXjrg9S17XwbLBc4
         EfL2sp/T8LwSiUXADLbGtzH/64ZEo7LjYqCGI=
Received: by 10.101.59.5 with SMTP id m5mr13209918ank.67.1252107959614;
        Fri, 04 Sep 2009 16:45:59 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d22sm397453and.7.2009.09.04.16.45.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Sep 2009 16:45:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AA17874.7090905@debian.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127773>

On Fri, Sep 04, 2009 at 10:28:36PM +0200, Christoph Haas wrote:
> 
> Now I imported a new upstream version into the upstream branch. And then
> tried to merge the 'upstream' branch into the 'master' branch to work on
> it. And suddenly I get this error:
> 
>    error: Entry 'cream-abbr-eng.vim' would be overwritten by merge.
>    Cannot merge.
> 
> To reproduce my problem:
> 
>   $> git clone git://git.workaround.org/cream
>   $> cd cream
>   $> git merge origin/upstream
>   error: Entry 'cream-abbr-eng.vim' would be overwritten by merge.
>   Cannot merge.
>   fatal: merging of trees 70008c82f82a7985531aa2d039c03fdf944ea267 and
>   78d3a35e300434d6369424dd873bb587beacfaa4 failed

Very odd indeed!

$ git version
git version 1.6.4.2.264.g79b4f

I was able to workaround it:

$ rm *
$ git add -u
$ git merge origin/upstream

I've never run into this before.
I think it has to do with all the renamed files.
It looks like you're running into ain unfortunate edge case.

The merge-base of both branches (the initial commit) has all
files underneath a cream/ directory.

Both descendants (upstream and master) moved files up to the
root.  So when you go to merge those histories the merge driver
gets confused.

What happened in master?    cream/A -> A
What happened in upstream?  cream/A -> A

That seems like an edge case that might need some attention.

Anyways, once you do the workaround merge it'll settle
itself out and won't happen to you again since the merge will
resolve it for all your future commits (future merges will
have a new, rename-safe merge base).

Does anyone else on the list have any insights?

-- 
		David
