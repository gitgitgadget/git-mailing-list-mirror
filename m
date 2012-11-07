From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH/RFC] launch_editor: ignore SIGINT while the editor has
 control
Date: Wed, 7 Nov 2012 23:00:28 +0100
Message-ID: <20121107220027.GA17463@shrek.podlesie.net>
References: <20121107191652.842C52E8089@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Paul Fox <pgf@foxharp.boston.ma.us>
X-From: git-owner@vger.kernel.org Wed Nov 07 23:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWDfv-00011k-KB
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 23:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab2KGWAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 17:00:31 -0500
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:34998 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752377Ab2KGWAa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 17:00:30 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 22C82524; Wed,  7 Nov 2012 23:00:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121107191652.842C52E8089@grass.foxharp.boston.ma.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209144>

On Wed, Nov 07, 2012 at 02:16:52PM -0500, Paul Fox wrote:
> the user's editor likely catches SIGINT (ctrl-C).  but if the user
> spawns a command from the editor and uses ctrl-C to kill that command,
> the SIGINT will likely also kill git itself.  (depending on the
> editor, this can leave the terminal in an unusable state.)
> 
> Signed-off-by: Paul Fox <pgf@foxharp.boston.ma.us>
> 
>  editor.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/editor.c b/editor.c
> index d834003..775f22d 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -37,8 +37,12 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>  
>  	if (strcmp(editor, ":")) {
>  		const char *args[] = { editor, path, NULL };
> +		int ret;
>  
> -		if (run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env))
> +		sigchain_push(SIGINT, SIG_IGN);
> +		ret = run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env);
> +		sigchain_pop(SIGINT);
> +		if (ret)
>  			return error("There was a problem with the editor '%s'.",
>  					editor);
>  	}

Looks and works good, except for warnings:

editor.c: In function 'launch_editor':
editor.c:42:3: warning: implicit declaration of function 'sigchain_push' [-Wimplicit-function-declaration]
editor.c:44:3: warning: implicit declaration of function 'sigchain_pop' [-Wimplicit-function-declaration]

"sigchain.h" should be included, something like:

diff --git a/editor.c b/editor.c
index 775f22d..3ca361b 100644
--- a/editor.c
+++ b/editor.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "strbuf.h"
 #include "run-command.h"
+#include "sigchain.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"

Krzysiek
