From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: [BUG] 'stg add FILE' when FILE is a symlink to dir adds dir contents
Date: Wed, 11 Apr 2007 19:54:52 +0400
Message-ID: <20070411155452.GL5329@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 18:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbfEw-0002Pj-Qp
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 18:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbXDKQAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 12:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753188AbXDKQAG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 12:00:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:49736 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbXDKQAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 12:00:03 -0400
Received: by ug-out-1314.google.com with SMTP id 44so149724uga
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 09:00:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=e0O3W+pMdAXFwAnR2O6lbSe3ujyd2x/amsDrRAzhcSzll7hZCK2j99RRZCmONDk1LHT3xUbn7K52cYFjOIpXgLDSiMmESyb9UwFhpuK4GyscgsFEe2xlRNBPc7TyTu9MfRyWLwpdlksdv0wwXfcarcIjU5FlVcedIZkL7v1u1pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=JSVAIkWga4FJmPw9tZfstI9/bNsSyQS9jx3nZXsfBiEX1XSONNrt1DZwGhZDVmnndyuypI/WD95zbE7AjNxHrsqAqL2VQSCJWhjoBetPjH9OQcywKeQw4V+IuJkltKjO3nMnAAiwKJSUsE7t1z+iIzUyTExi4nod7tn4wgWoHpI=
Received: by 10.67.100.10 with SMTP id c10mr529789ugm.1176307201702;
        Wed, 11 Apr 2007 09:00:01 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTP id s1sm1773464uge.2007.04.11.09.00.00;
        Wed, 11 Apr 2007 09:00:01 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 933873A7C2;
	Wed, 11 Apr 2007 19:54:53 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l3BFsqin025781;
	Wed, 11 Apr 2007 19:54:52 +0400
Mail-Followup-To: git@vger.kernel.org,
	Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44242>

Hello,

I have noticed that 'stg add FILE' works differently from 'git add
FILE' when file is a symlink to the directory: StGIT adds the contents
of dir, while GIT adds the symlink itself.

In stgit/git.py we see:

> def add(names):
>     """Add the files or recursively add the directory contents
>     """
>     # generate the file list
>     files = []
>     for i in names:
>         if not os.path.exists(i):
>             raise GitException, 'Unknown file or directory: %s' % i
> 
>         if os.path.isdir(i):
>             # recursive search. We only add files
>             for root, dirs, local_files in os.walk(i):
>                 for name in [os.path.join(root, f) for f in local_files]:
>                     if os.path.isfile(name):
>                         files.append(os.path.normpath(name))
>         elif os.path.isfile(i):
>             files.append(os.path.normpath(i))
>         else:
>             raise GitException, '%s is not a file or directory' % i
> 
>     if files:
>         if __run('git-update-index --add --', files):
>             raise GitException, 'Unable to add file'


I have no knowledge of Python, so I can't fix it myself, but perhaps
one should check for symlink before 'if os.path.isdir(i):'.  This also
will fix 'elif os.path.isfile(i):' branch if 'os.path.normpath(i)'
call dereferences symlinks (I'm not sure if that is the case).

But curious, why does the code traverse the tree itself?  Why not to
give the file list directly to git-update-index, and let it decide
what files to add, and how?  I also guess the code doesn't honor
.gitignore.

Could 'names' list be passed to git-update-index directly?


-- 
   Tomash Brechko
