From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/4] Allow custom merge strategies, take 4
Date: Wed, 30 Jul 2008 01:16:57 +0200
Message-ID: <cover.1217372486.git.vmiklos@frugalware.org>
References: <7v4p68eame.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 01:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNyRr-0007ys-9l
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 01:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYG2XQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 19:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYG2XQk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 19:16:40 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55570 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509AbYG2XQf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 19:16:35 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id A4EE81DDC5F;
	Wed, 30 Jul 2008 01:16:33 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 09A4A1AA738; Wed, 30 Jul 2008 01:17:01 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.14.g95f8.dirty
In-Reply-To: <7v4p68eame.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90707>

On Tue, Jul 29, 2008 at 12:47:05PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> This feels overly wasteful.  Granted, this is not a performance critical
> codepath, but you list all commands that begin with "git-merge-" in
> is_git_command(), only to discard it and then iterate over 140+ main_cmds
> list only to cull the ones whose name do not appear in the strategies
> list.
>
> Perhaps this shows that changing the function is_git_command() is a wrong
> approach (for one thing, with the custom prefix, it is not about "Is it a
> git command" anymore).  Wouldn't it be easier to read if you did this part
> like this instead?
>
>  * make load_command_list capable of loading into a "struct cmdnames" (or
>    pair if you want) supplied by the caller;
>
>  * use it to grab all commands whose name begin with "git-merge-" here;
>
>  * Check if name appears in that list; if it doesn't, you already have the
>    list of commands that could be merge strategy for error reporting.
>
> If you also update list_commands() not to run load_command_list() itself
> but take caller-supplied list of commands, then the API would become much
> cleaner.  The caller would not be limited to "filter with prefix" anymore.
>
> Hmm?

I like the idea. ;-)

Here is what I did:

- I changed only load_command_list() and list_commands().
  load_command_list() still supports filtering, but the result is loaded
  to a pair of "struct cmdnames", supplied by the caller.

- list_commands() works from this pair, additionally supporting the
  custom title.

- export add_cmdname(), exclude_cmds() and is_in_cmdlist() without any
  modification in help.h

The rest is done in builtin-merge.c, as you suggested.

The nice thing is that before this change builtin-merge accepted for
example '-s index' (because git-merge-index was a valid command), but
now this is no longer true.

Miklos Vajna (4):
  builtin-help: make some internal functions available to other
    builtins
  builtin-merge: allow using a custom strategy
  Add a new test for using a custom merge strategy
  Add a second testcase for handling invalid strategies in git-merge

 Makefile                |    1 +
 builtin-merge.c         |   42 +++++++++++++++++++++----
 help.c                  |   77 ++++++++++++++++++++++++-----------------------
 help.h                  |   23 ++++++++++++++
 t/t7600-merge.sh        |    5 +++
 t/t7606-merge-custom.sh |   46 ++++++++++++++++++++++++++++
 6 files changed, 149 insertions(+), 45 deletions(-)
 create mode 100644 help.h
 create mode 100755 t/t7606-merge-custom.sh
