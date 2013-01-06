From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v4] git-completion.bash: add support for path completion
Date: Sun, 06 Jan 2013 19:39:13 +0100
Message-ID: <50E9C4D1.4020608@gmail.com>
References: <1356108872-5881-1-git-send-email-manlio.perillo@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC0672D1@eusaamb103.ericsson.se> <7vobh4sffw.fsf@alter.siamese.dyndns.org>,<7vehi0qh4x.fsf@alter.siamese.dyndns.org> <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"szeder@ira.uka.de" <szeder@ira.uka.de>,
	"felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 19:40:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trv8T-0004Vu-RO
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 19:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab3AFSjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 13:39:32 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:38193 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756047Ab3AFSjb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 13:39:31 -0500
Received: by mail-wg0-f47.google.com with SMTP id dq11so8720751wgb.2
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 10:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=0A3Ijs5On1tBShDypetguVt7j7gPSZ+hJOu699d5EXg=;
        b=duHwse6siUtCrMU5W9LF5h2SUl3BIWas6nTQrpobRDFOHSfULHLDChSjfXWy7ESUTS
         J4MvwAZAMWqQl4NiAF5W19T1fRsJZs8VpRFeMi4wq+xeXsrwQsxgUMAyiXZb6EP54ASA
         YmDEZTu1ZygEktniUpPuHxXZwLKB41XEulZhX9d+UBde/TiSowvFkWUe0TtOmr2v83O7
         qlrmmUIOXCZCK8T7HzCKKyiNSVEntJ6f/+SIbzzlcXxf4vCD9R1o3Hq5y7tAREcWd3dc
         0F0rQ0xCfg/r6cn4HwYxMKzb0AGhw54cpTKkMLahTBLLpO1tgOLM8k4Dm/Rd3yw7WFnN
         I6kA==
X-Received: by 10.194.122.98 with SMTP id lr2mr92239393wjb.55.1357497569682;
        Sun, 06 Jan 2013 10:39:29 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id g2sm9646252wiy.0.2013.01.06.10.39.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 10:39:29 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC0681FA@eusaamb103.ericsson.se>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212833>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 05/01/2013 21:23, Marc Khouzam ha scritto:
> [...]
> Thanks for this, it improves the situation dramatically.
> I did further testing with your patch and found some less obvious
> issues.  I didn't debug the script myself as I'm not that familiar with
> it either, but I think the testcases below should help Manlio or
> someone else look into some regressions.
> 
> 1- Using .. or . breaks completion when after the '/':
> [...]
> 2- Maybe related to problem 1.  Using .. breaks completion in other ways:
> [...]
> 3- Also probably related to problems 1 and 2.  Using absolute paths behaves wierdly and 
> worse than before:

> In my opinion, the above three cases are regressions.
>

Yes.
I did not considered this use case, thanks!
I have never done something like this when working with Mercurial.

The problem is caused by the __git_index_file_list_filter function.

The job of this function is to stop path completion at directory
boundary (in order to avoid to suggest files in child
directories [1]), and to make paths relative to current directory.

Unfortunately, what it does is to simply remove the prefix string from
the path name; of course this will not work when the prefix is a non
canonical path name.

The solution is quite simple: canonicalize both the prefix path and each
of the path name returned by git.

This can be done using `readlink -f "$path"` or `realpath $path`, but
the problem is that it is inefficient to execute an external command for
each of the path returned by git; moreover readlink and realpath are not
POSIX and may not be supported on all platforms where git works (but I
found a portable implementation using pushd, popd, `pwd`,  `dirname`,
`basename` -- not very efficient).

IMHO, the best solution is to recode __git_index_file_list_filter in Perl.

Another possible solution (as suggested by Junio) is to use the
- --relative option; unfortunately this is only supported by
`git diff-index` and not by `git ls-files`.
And it will not solve the problem when using absolute path names (but
this case can be handled by leaving path completion to bash).

> 4- Completion choices include their entire path, which is not what bash does by default.  For example:
>> cd git/contrib
>> ls completion/git-<tab>
> git-completion.bash  git-completion.tcsh  git-completion.zsh   git-prompt.sh
> but
>> git rm completion/git-<tab>
> completion/git-completion.bash  completion/git-completion.tcsh  completion/git-completion.zsh   completion/git-prompt.sh
> notice the extra 'completion/' before each completion.

This is another thing I missed.
The problem is that only the current directory is removed from the path
names returned by git.

>  This can get pretty large when completing with 
> many directory prefixes.  The current tcsh completion has the same problem which I couldn't fix.  However, I am 
> not sure if it can be fixed for bash.
> 

The fix was very easy, and it seems to work.
The problem is in the __git_complete_index_files and
__git_complete_diff_index_files function.

When calling the __git_index_files and git_index_files, the "$cur"
variable should be used, instead of the computed "$pfx".

Not sure if this is correct.
I will post the patch, so you can test it.

> I personally don't think this is regression, just an slight annoyance.
> 
> 5- With this feature git-completion.bash will return directories as completions.  This is something
> git-completion.tcsh is not handling very well.  I will post a patch to fix that.
> 

I'll pass on this, thanks.

> Below are two suggestions that are in line with this effort but that are not regressions.
> 
> A) It would be nice if 
> git commit -a <TAB>
> also completed with untracked files
> 

I agree.
And there are other places when it may be useful to check the passed
options (see the comments).

But I think it is better to leave these issues for the future.
I will just add a comment to take note of this use case.

> B) Now that, for example, 'git rm' completion is smart about path completion 
> it would be nice to somehow not trigger bash default file completion
> when 'git rm' does not report any completions.  
> 

Not sure how this can be done, but it is possible and should be easy.

> For example, if I have a file called zz.tar.gz (which is an ignored file) 
> and I do 'git rm <tab>', I will get the proper list of files that can be
> removed by git, excluding zz.tar.gz.  But if I complete
> 'git rm zz.tar.<tab>' then the completion script will return nothing,
> since git cannot remove that ignored file, but we will then fall-back
> to the bash default completion, which will complete the file to zz.tar.gz.
> 
> Although there are some issues, I think this feature will greatly benefit the user
> and is worth the time needed to fix.
> 
> Thanks!
> 
> Marc


Thanks to you for the review!

Regards   Manlio


[1] this is what the Mercurial bash completion script does
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDpxNEACgkQscQJ24LbaURZEgCcD2Uc+7/W+RCrMk3j+vrd5w36
6ogAn1ou4pOarBSMywaQ3zQKdZmofyKA
=iU13
-----END PGP SIGNATURE-----
