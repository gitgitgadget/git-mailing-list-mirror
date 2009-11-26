From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 07/11] run-command: support input-fd
Date: Thu, 26 Nov 2009 22:53:59 +0100
Message-ID: <200911262253.59641.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-7-git-send-email-kusmabite@gmail.com> <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	dotzenlabs@gmail.com, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 22:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmI8-0003T4-M2
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 22:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbZKZVyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 16:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbZKZVyI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 16:54:08 -0500
Received: from [93.83.142.38] ([93.83.142.38]:59424 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751350AbZKZVyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 16:54:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id B9E9A19F4D0;
	Thu, 26 Nov 2009 22:53:59 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133838>

On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
> This patch adds the possibility to supply a non-0
> file descriptor for communucation, instead of the
> default-created pipe. The pipe gets duplicated, so
> the caller can free it's handles.
>
> This is usefull for async communication over sockets.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  run-command.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index e5a0e06..98771ef 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -327,7 +327,10 @@ int start_async(struct async *async)
>  {
>  	int pipe_out[2];
>
> -	if (pipe(pipe_out) < 0)
> +	if (async->out) {
> +		pipe_out[0] = dup(async->out);
> +		pipe_out[1] = dup(async->out);
> +	} else if (pipe(pipe_out) < 0)
>  		return error("cannot create pipe: %s", strerror(errno));
>  	async->out = pipe_out[0];

Hm. If async->out != 0:

	pipe_out[0] = dup(async->out);
	async->out = pipe_out[0];

This is confusing.

Moreover, you are assigning (a dup of) the same fd to the writable end. This 
assumes a bi-directional channel. I don't yet know what I should think about 
this (haven't studied the later patches, yet).

It would be great if you could add a few words to 
Documentation/technical/api-runcommand.txt.

-- Hannes
