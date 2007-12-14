From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [Funky] "git -p cmd" inside a bare repository
Date: Fri, 14 Dec 2007 20:58:52 +0700
Message-ID: <fcaeb9bf0712140558p37eb3387h7c4d3177473e6fcd@mail.gmail.com>
References: <20071129122139.GA11176@laptop>
	 <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 14:59:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3B4S-0007j2-Ow
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 14:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbXLNN66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 08:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXLNN65
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 08:58:57 -0500
Received: from mu-out-0910.google.com ([209.85.134.184]:61181 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXLNN65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 08:58:57 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1627555mue.5
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4S51tl7eD3LnMrdGheNtPMY++viSddwMFSsZI/4N+Io=;
        b=I2+b8k9rwPzpU1PpPu/bFt6M5s54JSvk+xCjcTi77chjGVGZWSUH8LbEuiGIELpFaSIkPJtkzEK6KA6C6FTvgLnigPg7iyCbyt81xhjbGeEI1fJDaKJGP/YYwR+9cju6ARReyos+2XtweZFix7a0Nx64S0yIOjvKwKHoiMCOObs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qIt3EFK5jnPGCThpAoGbBBmJ0sjGfegqIAbeQCLwbPebo1T1leyMNDuJ7tdeO7dQ6pjeZE+kMBWhdjfe/xjZa/MDn3/bZPtHMvaj818an7PLHQ7/6xxI/jL/jgNgSpnMlD/hheLcJW0HsiFQQBGRLqG0eDG5lVVxs/2IyxeM9Tc=
Received: by 10.82.186.5 with SMTP id j5mr8889992buf.16.1197640732959;
        Fri, 14 Dec 2007 05:58:52 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Fri, 14 Dec 2007 05:58:52 -0800 (PST)
In-Reply-To: <7vmysexdvw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68305>

On Dec 14, 2007 8:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If you have a bare repository and try this there:
>
>         $ PAGER=head git show HEAD:gcc/ChangeLog
>
> it works as expected, but if you explicitly ask for pagination, like
> this:
>
>         $ PAGER=head git -p show HEAD:gcc/ChangeLog
>
> you would get a very funky error message:
>
>         fatal: ambiguous argument 'HEAD:gcc/ChangeLog': unknown revision or path not in the working tree.
>         Use '--' to separate paths from revisions
>
> as if we are working with a repository with working tree.
>
> I originally noticed this with ls-tree.  The symptom is a bit different:
>
>         $ git -p ls-tree HEAD
>         fatal: Not a valid object name HEAD
>
>
>
> I _think_ what is happening is that setup_pager() tries to run
> git_config(), which runs setup(), and then RUN_SETUP set for "ls-tree"
> (or "show") internal command runs setup again.  HEAD is given to
> resolve_ref() and git_path("%s", ref) makes it to ".git/HEAD", even
> though in a bare repository git_dir should be set to ".", and of course
> we cannot find such a path in the git directory.

You meant setup_git_directory() or setup_git_env()? If find that
setup_git_env() is called too soon so it caches wrong git_dir and
friends if you setup_pager().

Another option (BTW I think your patch is fine) is to call
setup_git_env one more time to refresh its cache.
-- 
Duy
