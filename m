From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix relative built-in paths to be relative to the command
 invocation
Date: Sun, 13 Jul 2008 21:43:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807132141130.8950@racer>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org> <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at>
 <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Jul 13 22:44:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI8R5-0000Ej-O9
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 22:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793AbYGMUnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 16:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754702AbYGMUnJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 16:43:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33599 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752085AbYGMUnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 16:43:08 -0400
Received: (qmail invoked by alias); 13 Jul 2008 20:43:06 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp032) with SMTP; 13 Jul 2008 22:43:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CYdwqAWIC/bhEIpDtnnoPRLL5teUfmoBOfKqgmI
	gwmxKn8dFZNLUk
X-X-Sender: gene099@racer
In-Reply-To: <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88336>

Hi,

On Sun, 13 Jul 2008, Johannes Sixt wrote:

> diff --git a/Makefile b/Makefile
> index 4796565..2bdb9bf 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1301,7 +1301,7 @@ remove-dashes:
>  ### Installation rules
>  
>  ifeq ($(firstword $(subst /, ,$(template_dir))),..)
> -template_instdir = $(gitexecdir)/$(template_dir)
> +template_instdir = $(shell cd '$(bindir_SQ)/$(template_dir_SQ)' && pwd)

What is this for?  Did the original line stop working?

> diff --git a/exec_cmd.c b/exec_cmd.c
> index 8899e31..45f92eb 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -5,6 +5,7 @@
>  
>  extern char **environ;
>  static const char *argv_exec_path;
> +static const char *argv0_path;
>  
>  static const char *builtin_exec_path(void)
>  {
> @@ -42,14 +43,19 @@ static const char *builtin_exec_path(void)
>  
>  const char *system_path(const char *path)
>  {
> -	if (!is_absolute_path(path)) {
> +	if (!is_absolute_path(path) && argv0_path) {
>  		struct strbuf d = STRBUF_INIT;
> -		strbuf_addf(&d, "%s/%s", git_exec_path(), path);
> +		strbuf_addf(&d, "%s/%s", argv0_path, path);
>  		path = strbuf_detach(&d, NULL);
>  	}
>  	return path;
>  }
>  
> +void git_set_argv0_path(const char *path)
> +{
> +	argv0_path = path;
> +}
> +
>  void git_set_argv_exec_path(const char *exec_path)
>  {
>  	argv_exec_path = exec_path;
> @@ -84,7 +90,7 @@ static void add_path(struct strbuf *out, const char *path)
>  	}
>  }
>  
> -void setup_path(const char *cmd_path)
> +void setup_path(void)

It seems to me that this patch would not do anything different, but with 
less code change, if setup_path() would set argv0_path, and not a new 
function was introduced.

Ciao,
Dscho
