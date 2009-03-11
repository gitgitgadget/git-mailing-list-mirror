From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] connect.c: remove a few globals by using git_config
 callback data
Date: Wed, 11 Mar 2009 12:52:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111251160.10279@pacific.mpi-cbg.de>
References: <1236739092-8280-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 12:52:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhMzB-0007mC-PV
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 12:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbZCKLvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 07:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbZCKLvF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 07:51:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:51371 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751764AbZCKLvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 07:51:02 -0400
Received: (qmail invoked by alias); 11 Mar 2009 11:50:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp067) with SMTP; 11 Mar 2009 12:50:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18W5LNrHvgWBOrnSOTFYdB+1fZvXp7e1ZxdZBR/bl
	AepqCBSbnDbFvI
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1236739092-8280-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112911>

Hi,

On Wed, 11 Mar 2009, Erik Faye-Lund wrote:

> Since ef90d6d (Provide git_config with a callback-data parameter,
> 2008-05-14), git_config() takes a callback data pointer that can be
> used to pass extra parameters to the parsing function.  The codepath
> to parse configuration variables related to git proxy predates this
> facility and used a pair of file scope static variables instead.
> 
> This patch removes the need for these global variables by passing the
> name of the host we are trying to access as the callback data.
> 
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

Thanks!

> @@ -383,6 +381,8 @@ static int git_proxy_command_options(const char *var, const char *value,
>  		const char *for_pos;
>  		int matchlen = -1;
>  		int hostlen;
> +		const char *rhost_name = cb;
> +		int rhost_len = strlen(rhost_name);

I see that you still calculate the length everytime 
git_proxy_command_options() is called -- which is for every config 
variable.

> @@ -426,11 +426,8 @@ static int git_proxy_command_options(const char *var, const char *value,
>  
>  static int git_use_proxy(const char *host)
>  {
> -	rhost_name = host;
> -	rhost_len = strlen(host);
>  	git_proxy_command = getenv("GIT_PROXY_COMMAND");
> -	git_config(git_proxy_command_options, NULL);
> -	rhost_name = NULL;
> +	git_config(git_proxy_command_options, (void*)host);

The (void *) should not be needed.

Thanks,
Dscho
