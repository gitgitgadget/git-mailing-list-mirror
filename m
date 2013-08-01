From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Difficulty adding a symbolic link, part 3
Date: Thu, 1 Aug 2013 11:00:03 -0400
Message-ID: <201308011500.r71F03HJ008579@freeze.ariadne.com>
References: <201307312029.r6VKT4vC023100@hobgoblin.ariadne.com> <CACsJy8DZ11zFEgL_vZ-kG2tuwodU=vBJZqZxUPWtYh9u8o-_Tg@mail.gmail.com>
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 01 17:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4uMQ-0003l6-MC
	for gcvg-git-2@plane.gmane.org; Thu, 01 Aug 2013 17:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811Ab3HAPAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Aug 2013 11:00:07 -0400
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:46150
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755727Ab3HAPAF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Aug 2013 11:00:05 -0400
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id 7Sa01m00617dt5G51T0490; Thu, 01 Aug 2013 15:00:04 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id 7T041m0021KKtkw3ZT04us; Thu, 01 Aug 2013 15:00:04 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r71F03Bt008580;
	Thu, 1 Aug 2013 11:00:03 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r71F03HJ008579;
	Thu, 1 Aug 2013 11:00:03 -0400
In-reply-to: <CACsJy8DZ11zFEgL_vZ-kG2tuwodU=vBJZqZxUPWtYh9u8o-_Tg@mail.gmail.com>
	(pclouds@gmail.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375369204;
	bh=6bKY/RyczIV+FSjasfIk8tvLKHEJpQmJNDXRKJgQtag=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=lNI/0UMXFNeryRSaieutpi4U2Z29b+T2nVM2ABfFz2zAgyGIDZCZCC8Cr9+6z44FB
	 NqJvDzNlQrWBxdSlS0mf7JXKxJq84KdC6l1TxznbDZQb5bO/3qPxr8K+pIyf7HCM0O
	 L+HTyRcfC8njAUDJIRtSEmn/FVWTIuGJXrUjEIb94HPLW602LGZzrV9ODh4CPHZlNp
	 PKFf1psseyOQL32TBVI1NSMlmnh+DwbFSjZRqfdYYDHU3fOKYRnY7npRN6WSHWriz+
	 sZum1Njipt7krFLn57jG2/kcQRbLiuVT1ucJdmx42emV7vuT05/VydgYKXY1YJR7a6
	 pgKBiM+Ip0OqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231487>

> From: Duy Nguyen <pclouds@gmail.com>

> > Can someone give me advice on what this code *should* do?
> 
> It does as the function name says: given cwd, a prefix (i.e. a
> relative path with no ".." components) and a path relative to
> cwd+prefix, convert 'path' to something relative to cwd. In the
> simplest case, prepending the prefix to 'path' is enough. cwd is also
> get_git_work_tree().
> 
> I agree with you that this code should not resolve anything in the
> components after 'cwd', after rebasing the path to 'cwd' (not just the
> final component). Not sure how to do it correctly though because we do
> need to resolve symlinks before cwd. Maybe a new variant of real_path
> that stops at 'cwd'?
> 
> We may also have problems with resolve symlinks before cwd when 'path'
> is relative, as normalize_path_copy() does not resolve symlinks. We
> just found out emacs has this bug [1] but did not realize we also have
> one :-P.

Thanks for the detailed information.  It seems to me that the minimum
needed change is that the handling of relative and absolute paths
should be made consistent.

> [1] http://thread.gmane.org/gmane.comp.version-control.git/231268

That problem isn't so much a matter of not resolving symlinks but
rather the question of what ".." means.  In the case shown in that
message, the current directory *is* {topdir}/z/b, but it was entered
with "cd {topdir}/b" -- and the shell records the latter as the value
of $PWD.  (Actually, the bash shell can handle symbolic-linked
directories *either* way, depending on whether it is given the "-P"
option.)

When Emacs is given the file name "../a/file", does the ".." mean to
go up one directory *textually* in the pathspec based on $PWD

"{topdir}/b/../a/file" -> "{topdir}/a/file" (which does not exist)

or according to the directory linkage on the disk (where the ".."
entry in the current directory goes to the directory named {topdir}/z,
which does contain a file a/file.  It looks like Emacs uses the first
method.

The decision of which implementation to use depends on the semantics
you *want*.  As I noted, bash allows the user to choose *either*
interpretation, which shows that both semantics are considered valid
(by some people).

Dale
