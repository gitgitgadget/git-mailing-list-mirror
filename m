From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG/RFC] Raw diff output format (git-diff-tree) and --relative[=<path>] option
Date: Thu, 8 Jul 2010 13:00:17 +0200
Message-ID: <201007081300.18712.jnareb@gmail.com>
References: <201007051015.26995.jnareb@gmail.com> <201007051744.54266.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 13:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWoqP-0005Lu-H3
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 13:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab0GHLAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 07:00:35 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40802 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0GHLAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 07:00:34 -0400
Received: by bwz1 with SMTP id 1so349763bwz.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kfErAjhxKskA+MjbExJKxNfXiIrLCUrtNbzpLiwDCn4=;
        b=kkkAsasKQAT8Ul5dG/PV9rlTKsP7LW79jeBw//Fhht8TInlHCcjSgn41OvVweULOLZ
         kR7mhA93/8UPg4vcWklswtL0M+nLhaz6Ve+xE6jWOVm4ZvHReTxLc2RcAWE6ZwV2xqm5
         idGHk0xUMzryMnm5JbFqqW0uJgRgRIADDrvyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hO/WjwI0RGHNgod/Rys1zczgVzHDvVyUScErNX5685NSwhUM9PrtRKs0EY8UC5ibMU
         QH3019o1oaiNJsgywMg76YoKN81Ji6Q8cooSGCxIBy5SjhEMg8KAItZe9MOx7qK9XKOE
         Uu42o8jIo4sKhf73JESQK7PAN7sohI0u4lnWQ=
Received: by 10.204.137.193 with SMTP id x1mr1248bkt.165.1278586828563;
        Thu, 08 Jul 2010 04:00:28 -0700 (PDT)
Received: from [192.168.1.15] (abvu212.neoplus.adsl.tpnet.pl [83.8.218.212])
        by mx.google.com with ESMTPS id 24sm32527717bkr.7.2010.07.08.04.00.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 04:00:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201007051744.54266.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150558>

I wanted to get non-recursive raw diff (difftree), but for a given
subdirectory and not starting from root.

In February 2008 Junio C Hamano added support for --relative and 
--relative=<path> options to git-diff:
* cd676a5 (diff --relative: output paths as relative
           to the current subdirectory, 2008-02-12)
* c0cb4a0 (diff --relative: help working in a bare repository,
           2008-02-13)

>From the commit message for cd676a5 (the c0cb4a0 just allows the 
--relative option to say which subdirectory to pretend to be in,
i.e. adds the --relative=<path> version) it looks like this option
was intended for patch (-p) output format.

There was added support also for raw output format, so both 
'git diff-tree' and 'git diff --raw' works with --relative option,
but support for this is buggy, and in my opinion wrong way around.


The '--relative[=<path>]' option works currently like this.  First,
if git command is invoked in subdirectory the diffopts structure
gets set prefix and prefix_length (in init_revisions).  If 
--relative[=<path>] option is passed, git sets RELATIVE_NAME flag,
and if there is argument, prefix is set to it.  Later git removes
prefix (sets it to NULL) if RELATIVE_NAME option is not set.

What's important in this step is that prefix is set without any 
normalization from --relative=<path> argument, while (from what
I understand) if it is set from current directory i.e. with --relative 
option without argument, it is set with trailing slash.  So using
--relative=sub instead of --relative=sub/ might be thought as user
error... but I think here it is lack of robustness in the API.


Then comes the filtering part.  In functions such as diff_change
or stuff_change, if path(s) does not begin with prefix, they are
simply skipped.  This solution limits --relative[=<path>] to work
only with *recursive* (full tree) output, such as patch output format,
or "git diff", or "git diff-tree -r" (and "git diff-tree -t", which
implies "-r").


Last there is filename munging, done using strip_prefix function.
This is done using prefix_length only, and that is the cause of
the bug:
  $ git diff-tree --abbrev -r --raw HEAD --relative=sub
  a3a8425fe5496c61921010cb1e7b455a1f52bb86
  :100644 100644 d90bda0... cefcae0... M	/quux

if one uses '--relative=sub' instead of '--relative=sub/'.


What I'd like to see for the raw output format is to work with 
--relative[=<path>] to work as if <path> was top directory of 
repository.  For example for diff between two trees

  $ git diff-tree A B --relative=sub/

would be equivalent to running

  $ git diff-tree A:sub/ B:sub/

*This* could be done, I think, by modifying diff_tree_sha1 to do a diff 
betweem A:sub/ and B:sub/ (taking 'sub/' from prefix) and unsetting 
prefix (setting prefix to NULL and prefix_length to 0).  But that would 
work only in the case that can be reducted to diff between two tree 
objects.  This wouldn't work for diff in raw output format between tree 
and working area, tree and index, or index and working area.

Is the idea of automagically translating <sha1> into <sha1>:<prefix>
to support --relative / relative=<prefix> well in raw diff output format
a good idea?  Or should I search for another solution.

I also do not know code enough (and it is not simple) to guess how
one would go with the same result for diff between trees, index, and
working area files.

BTW. the approach proposed here has the advantage that for B:<sub>,
if <sub> does not exist in B, we can try to do what 'subtree' merge 
strategy does (and what wholesame directory rename detection did),
namely try to find given directory under different path (like for 
example subtree-merged git-gui and gitk).

-- 
Jakub Narebski
Poland
