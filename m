From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Sat, 20 Feb 2016 15:59:09 +0700
Message-ID: <CACsJy8BQZCBpfmvXk+o5PqM7=zad7cxgA9B2995Rb0D0YBxEVw@mail.gmail.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com> <1455772670-21142-26-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:59:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX3OE-0008EP-5c
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992773AbcBTI7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:59:42 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34986 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992561AbcBTI7l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:59:41 -0500
Received: by mail-lf0-f46.google.com with SMTP id l143so67690058lfe.2
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 00:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ghXiYoNttObLIMfPlVmJgWuXb+15lntyj4MHVVpKMC8=;
        b=vGiT/yzYNyi73lkGLswGZW7KrHRZY0ZnOYS6XJFEUChFTBuwSEmd1chhzye8G8b361
         D9ZnH+iEvmRP8CHW5hh9EtpblK9tEHChP5c/UzAVnSZ32TyUWTQG9PCeSKrfILHmwFCB
         NHoW6MA9a0pMIiDgV9DCrqZBbmunDpypj7+skyK2cmJNFHmVrZAgGUPi/0/552NGPAoU
         98XvwmHeL81nyO6+60LOJxqcz6xLnAC4P/L1NmwmNp5g3WC3HFUd9f7lIzqX1f3QJWV5
         aNVgqSIF3e2Uo7ifsH24lyqy35byR080MJZjoNF10ZsPRro8Jfj/4bvYN4fSMhQ8uds/
         EGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ghXiYoNttObLIMfPlVmJgWuXb+15lntyj4MHVVpKMC8=;
        b=LNknkWtZ5VOeKO5zbT3xcRTno5lczXxkd4wXlKkrYjh13OJUsdn08lBddy/46VQym1
         +VWQZVWYcADXUpaC6YsxWOExD0N8IbQUPpvrHN8dLyqZkR1uXhHU9L6Flw453bu+Q+nV
         2zcuIiHDgp0zXENA7VEWay/56D5dD4rA93RMIshqz76VMgKA3nd41O99zzbMbYZJ69of
         uT3aVUuPIXacIxl6kseIycpD9/5OGY4Scta/v83rvJTo2ThMvyhTV8/6EtuVwMkHpif3
         0ZI2ZHI6YQrZrctSuoHOgRppwK+tIDmh0OTtS0T2HC9h/HuCEnFpS/GHgTIhuWTP0aCX
         /FjQ==
X-Gm-Message-State: AG10YOQChrKKzEaJ8hzpfCjghn5hNqLzaRuwOrdrXptSxLr5G0VQ0zQ7P7qJ1UdmZ1QNjzz3rvPFg4LpQGBXkg==
X-Received: by 10.25.161.131 with SMTP id k125mr3561021lfe.83.1455958779676;
 Sat, 20 Feb 2016 00:59:39 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sat, 20 Feb 2016 00:59:09 -0800 (PST)
In-Reply-To: <1455772670-21142-26-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286774>

On Thu, Feb 18, 2016 at 12:17 PM, David Turner <dturner@twopensource.com> wrote:
> LMDB has a few features that make it suitable for usage in git:
> ...

I'm reading lmdb documents and hitting  the caveat section [1]. Random thoughts

* "There is normally no pure read-only mode, since readers need write
access to locks and lock file.".

This will be a problem for server side that serves git:// protocol
only. Some of those servers disable write access to the entire
repository and git still works fine (but won't when lmdb is used).
Should we do something in this case? Just tell server admins to relax
file access, or use MDB_NOLOCK (and when? based on config var?)

*  " Use an MDB_env* in the process which opened it, without
fork()ing.". We do use fork on non-Windows in run-command.c, but it
should be followed by exec() with no ref access in between, so we're
almost good.

I notice atexit() is used in this for/exec code, which reminds me we
also use atexit() in many other places. I hope none of them access
refs, or we could be in trouble.

* "Do not have open an LMDB database twice in the same process at the
same time. Not even from a plain open() call - close()ing it breaks
flock() advisory locking"

I wonder what happens if we do open twice, will it error out or
silently ignore and move on? Because if it's the latter case, we need
some protection from the caller and I'm not sure if
lmdb-backend.c:init_env() has it, especially when it open submodule's
lmdb.

* "Avoid long-lived transactions...."

OK we don't have a problem with this. But it makes me realize lmdb
transactions do not map with ref transactions. We don't open lmdb
transaction at ref_transaction_begin(), for example. Is it simply more
convenient to do transactions the current way, or is it impossible or
incorrect to attach lmdb transactions to ref_transaction_*()?

* "Avoid aborting a process with an active transaction. The
transaction becomes "long-lived" as above until a check for stale
readers is performed or the lockfile is reset, since the process may
not remove it from the lockfile."

Does it mean we should at atexit() and signal handler to release
currently active transaction?

* "Do not use LMDB databases on remote filesystems, even between
processes on the same host. This breaks flock() on some OSes, possibly
memory map sync, and certainly sync between programs on different
hosts."

OK can't do anything about it anyway, but maybe it should be mentioned
somewhere in Git documentation.

* "Opening a database can fail if another process is opening or
closing it at exactly the same time."

We have some retry logic in resolve_ref_1(). Do we need the same for
lmdb? Not very important though.

[1] http://symas.com/mdb/doc/
-- 
Duy
