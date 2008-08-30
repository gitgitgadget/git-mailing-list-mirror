From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH updated] git wrapper: DWIM mistyped commands
Date: Sat, 30 Aug 2008 08:36:42 -0700
Message-ID: <7vsksm1pmd.fsf@gitster.siamese.dyndns.org>
References: <20080828171533.GA6024@blimp.local>
 <20080828212722.GF6439@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 17:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZSWb-0007Yl-F2
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 17:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbYH3Pgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 11:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbYH3Pgv
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 11:36:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbYH3Pgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 11:36:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E7C2667189;
	Sat, 30 Aug 2008 11:36:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C6B6267188; Sat, 30 Aug 2008 11:36:44 -0400 (EDT)
In-Reply-To: <20080828212722.GF6439@steel.home> (Alex Riesen's message of
 "Thu, 28 Aug 2008 23:27:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 75D48450-76A9-11DD-822E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94380>

Alex Riesen <raa.lkml@gmail.com> writes:

> @@ -257,9 +258,70 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
> ...
> +static const char *levenshtein_cmd;
> +static int similarity(const char *cmd) {
> +	return levenshtein(levenshtein_cmd, cmd, 0, 2, 1, 4);
> +}
> +
> +static int levenshtein_compare(const void *p1, const void *p2)
>  {
> +	const struct cmdname *const *c1 = p1, *const *c2 = p2;
> +	const char *s1 = (*c1)->name, *s2 = (*c2)->name;
> +	int l1 = similarity(s1);
> +	int l2 = similarity(s2);
> +	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
> +}
> ...
> +	levenshtein_cmd = cmd;
> +	qsort(main_cmds.names, main_cmds.cnt,
> +	      sizeof(*main_cmds.names), levenshtein_compare);

Isn't this awfully inefficient?

You have one mistyped command name to compute distance against, and want
to sort the available 100+ command names by that distance.  In qsort(),
levenshtein_compare() will be called O(N log N) times (depending on your
qsort implementation)?

I wonder if it makes sense to give an otherwise unused "score" member to
the "struct cmdname", compute the distance only once per each command, and
use that as the sort key (alternatively you can have a separate int[N]
array to store similarity values for each item in the cmdnames list, only
used inside this codepath).
