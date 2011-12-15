From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Branch names with slashes
Date: Thu, 15 Dec 2011 14:40:53 -0600
Message-ID: <4EEA5B55.1040405@gmail.com>
References: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Leonardo Kim <dalinaum@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 21:41:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbI6y-0007sh-I5
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 21:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756387Ab1LOUk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 15:40:59 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40446 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1LOUk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 15:40:59 -0500
Received: by ghbz12 with SMTP id z12so1844989ghb.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qCRGExej/7M74aHWpfp/OdrPgBPlo1USp7sv9PUAAMA=;
        b=D0WIbck5atG+hQB5jusPkrtFLWn9jcWzA1h+6yc0J3ZbAaCwMSBV7xSXbGAAxTCi2h
         RmYr+HENC8NwsjjrMJQhPZ1TSvjj2ouoMSgCJZ3/D1oesc2xmRmscb0lDZMkH+6qHlzu
         WohCMmuc1NI883oTA5aXVuVoXrshkQIqCo374=
Received: by 10.101.129.39 with SMTP id g39mr1992554ann.25.1323981657997;
        Thu, 15 Dec 2011 12:40:57 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id k1sm7493123anq.8.2011.12.15.12.40.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 12:40:57 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187229>

On 12/14/2011 4:17 AM, Leonardo Kim wrote:
> Branch names can contain slashes, so we can use 'development/foo' as
> a branch name. If I choose 'development' as a branch name, it doesn't
> work. There is a directory named development at '.git/refs/heads'
> directory. So we cannot create a file named development for
> 'refs/heads/development'.
>
> An error message may occurs like below. Unfortunately, It is not of
> help to me. 'error: 'refs/heads/development/foo' exists; cannot
> create 'refs/heads/development'.
>
> I think that dealing with a file system and an error message above is
> not sufficient for a novice like me. I hope that it should be
> improved.
>
FYI, We also use slashes in our branchnames to leverage some of the 
benefits of a path-like namespace like pattern matching and the logical
expression of hierarchies using descriptive compound names. (We use git 
1.7.1 on linux.) Here's something to keep in mind: You have to plan 
(think ahead) for your naming conventions so that the namespaces will 
maintain uniqueness at a peer level over time that cannot be confused as 
subdirs under .git/refs/heads. For example:

branchnames:
/mysystem/generic
/mysystem/generic/project1

will not work because /mysystem/generic appears to be a parent dir to
/mysystem/generic/project1 under .git/refs/heads.  The solution is:

/mysystem/generic/base
/mysystem/generic/project1

these branches can coexist because they are unique without one appearing
to be a parent dir of the other.  IOW, their namespaces are peers in
their entirety. To carry the example a little further,

/mysystem/generic/project1/part2
will not work because once again it appears to be a subdir of an 
existing branchname (ref).  However,
/mysystem/generic/project1-part2
will work.

I think the reason for this is that if you look at .git/refs/heads you
will see that these slash delimited branch names are actually stored as
subdirs in the filesystem sense.  Therefore, git will get confused and
error out as it tries to find branchnames that are not entirely unique
by their full path namespace under .git/refs/heads because a branch
namespace that is a prefix (in the filesystem sense) of another branch 
name would occupy the same path under .git/refs/heads without being 
distinguishable as unique, and vice versa.

Hope this helps. (Maybe someone else will find a clearer way to explain
this.)

v/r,
neal
