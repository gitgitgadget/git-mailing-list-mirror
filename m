From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] First step, making setup (somewhat) reentrant
Date: Mon, 7 Jan 2008 08:50:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801070845270.10101@racer.site>
References: <1199684855-14246-1-git-send-email-ct@pipapo.org> <1199684855-14246-2-git-send-email-ct@pipapo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Christian Thaeter <ct@pipapo.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 09:51:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBnhU-0001Ia-OP
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 09:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620AbYAGIut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 03:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754208AbYAGIut
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 03:50:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:51259 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754163AbYAGIus (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 03:50:48 -0500
Received: (qmail invoked by alias); 07 Jan 2008 08:50:46 -0000
Received: from host86-137-198-115.range86-137.btcentralplus.com (EHLO racer) [86.137.198.115]
  by mail.gmx.net (mp047) with SMTP; 07 Jan 2008 09:50:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194w8QNfQV41+pKivFflXrPLMvGks2rqaUhEjPufW
	dCZqfogST25xZ5
X-X-Sender: gene099@racer.site
In-Reply-To: <1199684855-14246-2-git-send-email-ct@pipapo.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69771>

Hi,

[I assume that you mean this series post-1.5.4]

On Mon, 7 Jan 2008, Christian Thaeter wrote:

> diff --git a/environment.c b/environment.c
> index 18a1c4e..492d87c 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -38,31 +38,48 @@ int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
>  unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
>  
>  /* This is set by setup_git_dir_gently() and/or git_default_config() */
> -char *git_work_tree_cfg;
> -static const char *work_tree;
> +char *git_work_tree_cfg = NULL;
> +static char *work_tree = NULL;
> +static int work_tree_initialized = 0;

Global variables do not need initialisation, if all what you do is set 
them to NULL.  Therefore, most of this hunk is not necessary, and only 
distracts from what is really relevant, "work_tree_initialized = 0".

>  static void setup_git_env(void)
>  {
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
>  	if (!git_dir)
>  		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> +	if (git_object_dir)
> +		free(git_object_dir);

Logically, this belongs into a "cleanup_git_env()" function, no?

>  	git_object_dir = getenv(DB_ENVIRONMENT);
> -	if (!git_object_dir) {
> +	if (git_object_dir) {
> +		git_object_dir = xstrdup(git_object_dir);
> +	}

Are you sure that you want to keep the object directory, even if you want 
to initialise to a new repository?

Which brings me to a more fundamental question: what do you need reentrant 
setup_directory() for?  If it is just to allow multiple calls to that 
function for the _same_ repository, I say clean up your code.

Ciao,
Dscho
