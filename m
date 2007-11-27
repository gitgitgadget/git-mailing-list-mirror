From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 09:16:41 -0800
Message-ID: <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
	<474C0105.3010908@viscovery.net>
	<81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:17:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix43c-0007CQ-T9
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 18:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667AbXK0RQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757656AbXK0RQw
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 12:16:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55136 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757608AbXK0RQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 12:16:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4553B2F2;
	Tue, 27 Nov 2007 12:17:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A7899A4DC;
	Tue, 27 Nov 2007 12:17:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66243>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>> Doesn't git-commit operate only on the index, unless you pass it extra
>> arguments?
>
> It doesn't
>
>> What am I missing?
>
> run_status and check for changed files

I am sympathetic to the _cause_, but I do not think the option --cached
is a good match for this change.  As Hannes points out, as-is commit is
the default, and --cached to other commands mean "work only with index
not work tree", not "short-circuit for systems with slow lstat(3)".

Obviously we cannot short-circuit checking for modified or removed paths
when "git-commit -a" is run, but it is plausible that people may still
want to trade run_status output with interactive speed even when doing
"git-commit -a".

On the other hand, when we know we do not have to _show_ the list of
staged/modified/untracked files (i.e. we already have the commit log
message via -m, -F, or -C and we were told not to invoke editor), we do
not have to call run_status(), only to discard its output.  In such a
case, we are calling it only to see if we have something committable,
and we should be able to optimize THAT without being told by the user
with this new option.  Incidentally I just checked the scripted version;
it does not do this optimization (git-commit.sh, ll. 514-517).  The C
rewrite in 'next' does not have it in either (builtin-commit.c,
ll. 387-390).  When no_edit is in effect, I think these two places can
be replaced with an equivalent of "diff-index --cached HEAD --" (which
should not hit the work tree at all) to see if there is anything to be
committed.  For initial commit the check would obviously be "is the
index empty?" instead.

So in short:

 * The option "--cached" is a wrong thing to have the user say and is
   not what you want anyway. You want "no status list in the commit log
   template";

 * Skip run_status() and replace with "diff-index --cached HEAD" (or "is
   the index empty?") when the user instructs so;

 * In addition, the same optimization should apply when we know we do
   not use the exact run_status() output.
