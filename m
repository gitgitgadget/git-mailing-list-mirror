From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/4] completion: be nicer with zsh
Date: Thu, 2 Feb 2012 02:48:59 -0600
Message-ID: <20120202084859.GC3823@burratino>
References: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:49:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RssM6-0003bz-Lc
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab2BBItS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:49:18 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35043 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753755Ab2BBItR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 03:49:17 -0500
Received: by obcva7 with SMTP id va7so2470600obc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 00:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SJcocwNYk4hKMSDgtLnqN7BG3vWoZeIJCjk8IBIerCY=;
        b=N/vTyIg3pYddI76Jh5wWs0Avm1KN7+tB9+jyf+8HX5Wb3EB3/m5XaJgd11eS1BX6H9
         3ANpC0ma3yS9drUWzuXG5DdlFznJAvdqwFHZj85dw15iMCRXqwef35LykR3NIQZdEMQN
         P0FIGxpFN54rhZTOibxfLrH4MNBJi8SgDBEbk=
Received: by 10.50.159.161 with SMTP id xd1mr11130257igb.15.1328172556801;
        Thu, 02 Feb 2012 00:49:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id uy10sm3023777igc.1.2012.02.02.00.49.15
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 00:49:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1328145320-14071-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189604>

Hi,

Felipe Contreras wrote:

> Felipe Contreras (4):
>   completion: be nicer with zsh

Since I can't find this patch in the mail archive, I'll reply here.
Luckily the most important bit is above already.

I think I mentioned before that this subject line is what will appear
in the shortlog and the shortlog is all that some people will see of
the changelog, so it should include a self-contained description of
the impact of the patch.

However, clearly I did not say it clearly enough. :)  I guess it's
better to take a cue from storytellers and show rather than tell.
(Please don't take this as a precedent --- I will not always be doing
the style fixes myself, and sometimes will consider a patch to scratch
someone else's itch not worth the trouble and work on something else.)

-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Thu, 2 Feb 2012 03:15:17 +0200
Subject: completion: avoid default value assignment on : true command

zsh versions from 4.3.0 to present (4.3.15) do not correctly propagate
the SH_WORD_SPLIT option into the subshell in ${foo:=$(bar)}
expressions.  For example, after running

	emulate sh
	fn () {
		var='one two'
		printf '%s\n' $var
	}
	x=$(fn)
	: ${y=$(fn)}

printing "$x" results in two lines as expected, but printing "$y"
results in a single line because $var is expanded as a single word
when evaluating fn to compute y.

So avoid the construct, and use an explicit 'test -n "$foo" ||
foo=$(bar)' instead.  This fixes a bug tht caused all commands to be
treated as porcelain and show up in "git <TAB><TAB>" completion,
because the list of all commands was treated as a single word in
__git_list_porcelain_commands and did not match any of the patterns
that would usually cause plumbing to be excluded.

[jn: clarified commit message, indentation style fix]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/completion/git-completion.bash |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 78be1958..d7965daf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -676,7 +676,8 @@ __git_merge_strategies=
 # is needed.
 __git_compute_merge_strategies ()
 {
-	: ${__git_merge_strategies:=$(__git_list_merge_strategies)}
+	[ -n "$__git_merge_strategies" ] ||
+	__git_merge_strategies=$(__git_list_merge_strategies)
 }
 
 __git_complete_revlist_file ()
@@ -854,7 +855,8 @@ __git_list_all_commands ()
 __git_all_commands=
 __git_compute_all_commands ()
 {
-	: ${__git_all_commands:=$(__git_list_all_commands)}
+	[ -n "$__git_all_commands" ] ||
+	__git_all_commands=$(__git_list_all_commands)
 }
 
 __git_list_porcelain_commands ()
@@ -947,7 +949,8 @@ __git_porcelain_commands=
 __git_compute_porcelain_commands ()
 {
 	__git_compute_all_commands
-	: ${__git_porcelain_commands:=$(__git_list_porcelain_commands)}
+	[ -n "$__git_porcelain_commands" ] ||
+	__git_porcelain_commands=$(__git_list_porcelain_commands)
 }
 
 __git_pretty_aliases ()
-- 
1.7.9
