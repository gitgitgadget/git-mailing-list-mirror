From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 0/2] git diff -q option removal
Date: Tue, 16 Jul 2013 12:28:05 +0200
Message-ID: <1373970487-32595-1-git-send-email-stefanbeller@googlemail.com>
References: <20130714220739.GC13444@google.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, jrnieder@gmail.com, trast@student.ethz.ch,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 16 12:28:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz2UU-0005ZC-KF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 12:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab3GPK2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 06:28:14 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:45816 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab3GPK2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 06:28:13 -0400
Received: by mail-wg0-f43.google.com with SMTP id z11so427738wgg.34
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fLBw5kRi7WJQo1m6A2UT4vw8sI28+RCtZVZ1bSvI/2g=;
        b=Bk66Y1l43kQxOwpz0HNk7X3P0mbdzh+et1njE4qGXGTuAFyfyTcbZEwpHqMUTn2cYm
         iFrgoX5/4mGQP9hLz4OK4w4E1YOma7sgGTDot+fjhBo5k6N7KPKBTHvg66mJZr9l5PS/
         QudRPfGts8wZxNOZDq6svyO3cYmXqTxpeqU6IzcYBAIzvW5hj9nTzcP6dEwD2PnAdxmo
         pbJLtu7Pb/hYHNi3PjZfeq2YX354VWV9HHSRA7JdpgSfzCbK/n5YJwOZ1rBeh8bLIY0F
         3GZ1tYX5v4J2FOF3i+N1S6/z3jzTBg/tzFY6Ku5DWntpe5G7BStfRGzmSOJf6SfYBfcY
         8tEw==
X-Received: by 10.194.9.101 with SMTP id y5mr596265wja.86.1373970492721;
        Tue, 16 Jul 2013 03:28:12 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id fd3sm26748467wic.10.2013.07.16.03.28.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 03:28:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3.10.g2733812
In-Reply-To: <20130714220739.GC13444@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230560>

On 07/15/2013 12:07 AM, Jonathan Nieder wrote:
> This feature was obviously never tested with --no-index, so I agree it
> makes sense to remove it.  Probably the commit message and a comment
> should say so, though.  E.g.:
>
>       diff --no-index: remove nonfunctional "-q" handling
>
>       Before v1.5.6-rc1~41^2~2, the option parsing for diff --no-index
>       and "git diff-files" shared code.  In "git diff-files", "-q" means
>       to be silent about removed files.  In "git diff --no-index", in
>       various versions it has been an error, an infinite loop, or a no-op.
> 
>       Simplify the code to clarify that it is now a no-op, continuing to
>       accept and ignore the -q option in "git diff --no-index" to avoid
>       breaking scripts.
>
> I wouldn't mind removing support for "-q" altogether, by the way (as a
> separate change).
>
> Hope that helps,
> Jonathan
>

I am resending the commit with a different wording, thanks to Jonathan.   

However I tried to remove support for -q in a separate commit, and
I have some questions about the structure of the files.
(I am sure it's documented, but I cannot find it, so please hint me 
where to read.)

The changes in the following patch are in diff_no_index.c, but the
diff_no_index(...) is called from cmd_diff, which is in builtin/diff.c
That cmd_diff is actually called from git.c having the
{ "diff", cmd_diff }, entry in handle_internal_command.

My question now is this: Why is the builtin/diff.c relying on stuff
outside of builtin/ ? Wouldn't it be better to move all these files
(such as diff_no_index.c) into the builtin folder as well?

Regarding the removal of the -q option, I tried it in the second patch.
Is it as easy as that, or am I missing the point?

The first patch doesn't change the behavior, so I'd assume it's safe to 
apply it to origin/sb/misc-fixes, whereas the second patch will make 
git diff complain about the -q option, so I'd assume it would wait for the
next major release?

Before:
	touch actual_file
	git diff -q  actual_file no_file
	error: Could not access 'no_file'
	echo $?
	1

After:
	touch actual_file
	git diff -q  actual_file no_file
	fatal: invalid diff option/value: -q
	echo $?
	128

Thanks,
Stefan

Stefan Beller (2):
  diff --no-index: remove nonfunctional "-q" handling
  git diff: Remove -q option to stay silent on missing files.

 Documentation/git-diff-files.txt | 6 +-----
 diff-no-index.c                  | 5 -----
 2 files changed, 1 insertion(+), 10 deletions(-)

-- 
1.8.2.3.10.g2733812
