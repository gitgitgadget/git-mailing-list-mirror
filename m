From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] builtin-merge: allow using a custom strategy
Date: Tue, 29 Jul 2008 12:47:05 -0700
Message-ID: <7v4p68eame.fsf@gitster.siamese.dyndns.org>
References: <cover.1217344802.git.vmiklos@frugalware.org>
 <fd19583955e9cea5b78a465d23bc127a51940048.1217344803.git.vmiklos@frugalware.org> <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217344803.git.vmiklos@frugalware.org> <5ad105819efb1c905bd01db3d08eb3422d283b3b.1217344803.git.vmiklos@frugalware.org> <722d66a5a897b694f374aa96bd58aff01a2a5932.1217344803.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:48:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNvBE-0005tA-L7
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYG2TrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYG2TrN
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:47:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbYG2TrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:47:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1572B4AAA4;
	Tue, 29 Jul 2008 15:47:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 198254AAA2; Tue, 29 Jul 2008 15:47:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21E7E58C-5DA7-11DD-9310-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90675>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Allow using a custom strategy, as long as it's named git-merge-foo. The
> error handling is now done using is_git_command(). The list of available
> strategies is now shown by list_commands().
>
> If an invalid strategy is supplied, like -s foobar, then git-merge would
> list all git-merge-* commands. This is not perfect, since for example
> git-merge-index is not a valid strategy.
> ...
> +	if (!is_git_command(name, "git-merge-")) {
> +		struct cmdnames not_strategies;
> +
> +		memset(&not_strategies, 0, sizeof(struct cmdnames));
> +		for (i = 0; i < main_cmds.cnt; i++) {
> +			int j, found = 0;
> +			struct cmdname *ent = main_cmds.names[i];
> +			for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
> +				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
> +						&& !all_strategy[j].name[ent->len])
> +					found = 1;
> +			if (!found)
> +				add_cmdname(&not_strategies, ent->name, ent->len);
> +		}

This feels overly wasteful.  Granted, this is not a performance critical
codepath, but you list all commands that begin with "git-merge-" in
is_git_command(), only to discard it and then iterate over 140+ main_cmds
list only to cull the ones whose name do not appear in the strategies
list.

Perhaps this shows that changing the function is_git_command() is a wrong
approach (for one thing, with the custom prefix, it is not about "Is it a
git command" anymore).  Wouldn't it be easier to read if you did this part
like this instead?

 * make load_command_list capable of loading into a "struct cmdnames" (or
   pair if you want) supplied by the caller;

 * use it to grab all commands whose name begin with "git-merge-" here;

 * Check if name appears in that list; if it doesn't, you already have the
   list of commands that could be merge strategy for error reporting.

If you also update list_commands() not to run load_command_list() itself
but take caller-supplied list of commands, then the API would become much
cleaner.  The caller would not be limited to "filter with prefix" anymore.

Hmm?
