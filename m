From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to automatically correct an almost correct auto-merge?
Date: Fri, 16 Dec 2011 15:32:01 -0600
Message-ID: <4EEBB8D1.2050509@gmail.com>
References: <20111216203215.GG1868@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Dec 16 22:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbfO2-0006uj-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 22:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760717Ab1LPVcJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 16:32:09 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53195 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760653Ab1LPVcG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 16:32:06 -0500
Received: by yhr47 with SMTP id 47so3218882yhr.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 13:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=C9A++WAsI/fD7KeFzMXa+wfG7RoqILxqwCWKFYAdORU=;
        b=UJ66KP6DaUTp4n7Suhi/bAB8ZrNvbj40xPTv6L6Bs0plXsGaGMShxb5li+kYaEhQRS
         B5oe1x+LJjCLAyevDT/NgNMwKCyxvWznqgGHbV+F2jUbDVhnL9t8xOvnUfUws+ZgHaX+
         0TwG9vRpJ1DwLD8DJ+NDdY1ZHn50PLDxcLQak=
Received: by 10.236.178.33 with SMTP id e21mr15835015yhm.4.1324071125411;
        Fri, 16 Dec 2011 13:32:05 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id r68sm16055904yhm.18.2011.12.16.13.32.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 13:32:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20111216203215.GG1868@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187321>

On 12/16/2011 2:32 PM, SZEDER G=E1bor wrote:
> Hi,
>
>
> Briefly:
>
> Neighboring areas of a file are modified in two branches.  Git
> merges the two branches without conflicts, but the result is not
> semantically correct.  How can I teach git to produce the correct
> merge result when performing the same merge later on?
>
>
> Longer:
>
> The following commands create a file and two branches, both of them
> modifying the file by adding lines in the same area:
>
> git init cat>file<<\EOF 1
>
> 2 EOF git add file git commit -m file git apply<<\EOF diff --git
> a/file b/file index 1c3e7efc..121366a2 100644 --- a/file +++ b/file
> @@ -1,3 +1,5 @@ 1
>
> +a + 2 EOF git commit -a -m a git checkout -b branch HEAD^ git
> apply<<\EOF diff --git a/file b/file index 1c3e7efc..f2e91d4f 100644
> --- a/file +++ b/file @@ -1,3 +1,6 @@ 1 +b + +c
>
> 2 EOF git commit -a -m 'b c' git checkout master
>
>
> At this point I merge 'branch' and git produces the following
> result:
>
> $ git merge branch Auto-merging file Merge made by the 'recursive'
> strategy. file |    3 +++ 1 files changed, 3 insertions(+), 0
> deletions(-) $ cat file 1 b
>
> c
>
> a
>
> 2
>
>
> Now, these changes and the merge above are the minimal receipe which
> corresponds to a real merge I'm having trouble with at dayjob.  Just
> imagine that '1' and '2' are the beginning and end of a function,
> 'b' is the declaration of a new local variable, and 'a' and 'c' are
> new code blocks.  As it happens, the semantically correct result
> would be the following:
>
> 1 b
>
> a
>
> c
>
> 2
>
> i.e. 'a' must be executed before 'c'.
>
> I corrected the merge result manually, but these two branches are
> merged a couple of times a day into an integration branch, and they
> will likely cook for a few weeks, which means a lot of merges, and a
> lot of manual corrections.  So I'm looking for a way to teach git to
> produce the semantically correct merge result.  Something like
> 'rerere' would be great, but of course I can't use 'rerere' in this
> case, because there are no merge conflicts at all...
>
> Any ideas?  Did someone deal with similar issues before?
>
You can produce conflicts by implementing keyword expansion on "line 1"
(or whatever the first commentable line is in your language) of your=20
source changes during your pre-commit hook.  We do a keyword expansion=20
on "user" (whomai) and "date" (date) keywords.  This will cause "line 1=
"=20
to conflict on same file edits in a merge.  As for trusting rerere, we=20
don't.  We do it manually with kdiff3 as the mergetool.  If rerere work=
s=20
for you reliably in this scenario then I'd like to know about it.

v/r,
neal
