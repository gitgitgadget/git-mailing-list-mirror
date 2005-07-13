From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 11:17:44 +0100
Message-ID: <tnxll4bdn7b.fsf@arm.com>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bryan.larsen@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 12:19:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DseJs-0000FF-IY
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 12:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVGMKSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 06:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262545AbVGMKSQ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 06:18:16 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:38876 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262527AbVGMKSO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 06:18:14 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6DAHas4002808;
	Wed, 13 Jul 2005 11:17:36 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA01816;
	Wed, 13 Jul 2005 11:18:11 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 13 Jul 2005 11:18:10 +0100
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local> (Bryan
 Larsen's message of "Wed, 13 Jul 2005 04:38:11 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 13 Jul 2005 10:18:10.0163 (UTC) FILETIME=[2B51FC30:01C58794]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryanlarsen@yahoo.com> wrote:
> The current version of stgit does not allow whitespace in filenames.
> This patch fixes that.  It also speeds up operations on large
> filesets considerably.

Thanks, I will apply it but I have a few comments below:

> +# __run: runs cmd using spawnvp.
> +#
> +#  The shell is avoided so it won't mess up our arguments.
> +# If args is very large, the command is run multiple times;
> +# args is split xargs style:  cmd is passed on each invocation.
> +# Unlike xargs, returns immediately if any non-zero return code 
> +# is received.
> +#
> +def __run(cmd, args=None):

I would prefer to add this as Python function documentation, i.e. with
"""...""" in the function body.

An additional thing, can you please convert all the tabs to spaces?
That's a better convention for a language like Python where you
delimit blocks by indentation.

> @@ -114,14 +132,16 @@ def __tree_status(files = [], tree_id = 
>      # unknown files
>      if unknown:
>          exclude_file = os.path.join(base_dir, 'exclude')
> -        extra_exclude = ''
> +        extra_exclude = []
>          if os.path.exists(exclude_file):
> -            extra_exclude += ' --exclude-from=%s' % exclude_file
> -        fout = os.popen('git-ls-files --others'
> -                        ' --exclude="*.[ao]" --exclude=".*"'
> -                        ' --exclude=TAGS --exclude=tags --exclude="*~"'
> -                        ' --exclude="#*"' + extra_exclude, 'r')
> +            extra_exclude.append('--exclude-from=%s' % exclude_file)
> +        fin, fout = os.popen2(['git-ls-files', '--others',
> +                        '--exclude=*.[ao]', '--exclude=.*'
> +                        '--exclude=TAGS', '--exclude=tags', '--exclude=*~',
> +                        '--exclude=#*'] + extra_exclude)
>          cache_files += [('?', line.strip()) for line in fout]
> +	fin.close()
> +	fout.close()

What's the reason for having 'fin' as well? It doesn't seem to be used
(this is found in other parts of the patch as well).

Something wrong happened to my git-ftp-push script. It looks like it
copied 'master' to stgit.git/ and not to stgit.git/refs/heads/. I
can't fix it until tonight. Before then, you could actually use wget
to pull the whole repository and just copy 'master' to
'refs/heads/master'. In the latest tree I created separate files for
each command.

I'm not sure whether the GIT guys are happy for us to use this mailing
list for StGIT. If the StGIT traffic increases, I will try to create a
separate mailing list (maybe using a site like sf.net).

-- 
Catalin
