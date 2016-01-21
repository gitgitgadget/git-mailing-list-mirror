From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git status during interactive rebase
Date: Thu, 21 Jan 2016 09:23:59 +0100
Message-ID: <vpqpowvz6g0.fsf@anie.imag.fr>
References: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 09:24:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMAXJ-0004Sn-AP
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 09:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936AbcAUIYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 03:24:05 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48668 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758931AbcAUIYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 03:24:03 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u0L8Nwdg011842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 21 Jan 2016 09:23:58 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u0L8NxVF008073;
	Thu, 21 Jan 2016 09:23:59 +0100
In-Reply-To: <CAGZ79kbUwJ+CN=YoQUP=rm=EhU=fU2ynt_7Q-cd7Dic-bsx+TA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 20 Jan 2016 15:21:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 21 Jan 2016 09:23:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u0L8Nwdg011842
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1453969439.05995@rvkq6iIYk7LmmSpHW3DF2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284505>

Stefan Beller <sbeller@google.com> writes:

> So I ran an interactive rebase, and while editing
> .git/rebase-merge/git-rebase-todo I tried to run
> `git status` in another terminal to inquire about a
> filename of an untracked file.
>
> However, I got:
>
> $ git status
> On branch submodule-groups-v3
> fatal: Could not open file .git/rebase-merge/done for reading: No such
> file or directory
>
> Was this behavior always the case? (IIRC it worked a long time ago?)

>From the list of recipients, I guess you already found that the issue
probably comes from 84e6fb9 (status: give more information during rebase
-i, 2015-07-06), which introduced
read_rebase_todolist("rebase-merge/done", &have_done); in wt-status.c.

> Would it make sense to not abort completely but give a limited status?

Yes.

I guess read_rebase_todolist should be changed:

static void read_rebase_todolist(const char *fname, struct string_list *lines)
{
	struct strbuf line = STRBUF_INIT;
	FILE *f = fopen(git_path("%s", fname), "r");

	if (!f)
		die_errno("Could not open file %s for reading",
			  git_path("%s", fname));

This should return an empty string_list instead of dying when the file
does not exist. The case of an empty list is already dealt with later:

		if (have_done.nr == 0)
			status_printf_ln(s, color, _("No commands done."));

No time to work on a patch for now :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
