From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git wrapper: also uses aliases to suggest mistyped
 commands
Date: Wed, 10 Sep 2008 14:44:03 -0700
Message-ID: <7vtzcnvfq4.fsf@gitster.siamese.dyndns.org>
References: <1221062068-5660-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:45:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdXV0-0004tf-Po
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 23:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYIJVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 17:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbYIJVoL
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 17:44:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbYIJVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 17:44:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D3BA7709;
	Wed, 10 Sep 2008 17:44:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7202D7707; Wed, 10 Sep 2008 17:44:06 -0400 (EDT)
In-Reply-To: <1221062068-5660-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Wed, 10 Sep 2008 17:54:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 99A6E630-7F81-11DD-854C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95557>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> @@ -280,6 +284,15 @@ static int levenshtein_compare(const void *p1, const void *p2)
>  	return l1 != l2 ? l1 - l2 : strcmp(s1, s2);
>  }
>  
> +static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
> +{
> +	int i;
> +	ALLOC_GROW(cmds->names, cmds->cnt + old->cnt, cmds->alloc);
> +
> +	for (i = 0; i < old->cnt; i++)
> +		cmds->names[cmds->cnt++] = old->names[i];
> +}
> +
>  const char *help_unknown_cmd(const char *cmd)
>  {
>  	int i, n, best_similarity = 0;
> @@ -287,11 +300,13 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  	memset(&main_cmds, 0, sizeof(main_cmds));
>  	memset(&other_cmds, 0, sizeof(main_cmds));
> +	memset(&aliases, 0, sizeof(aliases));
>  
>  	git_config(git_unknown_cmd_config, NULL);
>  
>  	load_command_list("git-", &main_cmds, &other_cmds);
>  
> +	add_cmd_list(&main_cmds, &aliases);
>  	ALLOC_GROW(main_cmds.names, main_cmds.cnt + other_cmds.cnt,
>  		   main_cmds.alloc);
>  	memcpy(main_cmds.names + main_cmds.cnt, other_cmds.names,

I think your add_cmd_list() to smash two lists into one is a good
abstraction to use here, but the existing code that can be seen at the
tail end of the context already does that between main and other command
list in a slightly different way.

Aliases should not hide the commands available elsewhere, and the actual
execution codepath around ll.480-490 in git.c avoids getting fooled by
misconfigured aliases, but you do not protect yourself from that kind of
misconfiguration in this patch.  You can have both "git-foo" command on
your private $PATH and alias.foo in your configuration, and they will have
the same levenshtein score.  I suspect this will cause the same "foo"
suggested twice when the user types "git fo" from the command line.

Here is a suggested fix-up on top of your patch to address these issues.

---
 help.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git i/help.c w/help.c
index 595342f..fd87bb5 100644
--- i/help.c
+++ w/help.c
@@ -291,6 +291,9 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 
 	for (i = 0; i < old->cnt; i++)
 		cmds->names[cmds->cnt++] = old->names[i];
+	free(old->names);
+	old->cnt = 0;
+	old->names = NULL;
 }
 
 const char *help_unknown_cmd(const char *cmd)
@@ -307,12 +310,10 @@ const char *help_unknown_cmd(const char *cmd)
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	add_cmd_list(&main_cmds, &aliases);
-	ALLOC_GROW(main_cmds.names, main_cmds.cnt + other_cmds.cnt,
-		   main_cmds.alloc);
-	memcpy(main_cmds.names + main_cmds.cnt, other_cmds.names,
-	       other_cmds.cnt * sizeof(other_cmds.names[0]));
-	main_cmds.cnt += other_cmds.cnt;
-	free(other_cmds.names);
+	add_cmd_list(&main_cmds, &other_cmds);
+	qsort(main_cmds.names, main_cmds.cnt,
+	      sizeof(main_cmds.names), cmdname_compare);
+	uniq(&main_cmds);
 
 	/* This reuses cmdname->len for similarity index */
 	for (i = 0; i < main_cmds.cnt; ++i)
