From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix buffer overflow in git-grep
Date: Wed, 16 Jul 2008 12:35:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807161232110.8503@eeepc-johanness>
References: <1216203345-18233-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:35:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4MQ-0000Vh-Cg
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759790AbYGPKea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759775AbYGPKe3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:34:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:60836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759758AbYGPKe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:34:28 -0400
Received: (qmail invoked by alias); 16 Jul 2008 10:34:26 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp035) with SMTP; 16 Jul 2008 12:34:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+swHkjuQOsOB3GIl9LyPmOrayOoqVT3oHG0ZQ1Ya
	Rt2x6zfV8l9Yaj
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216203345-18233-1-git-send-email-dpotapov@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88659>

Hi,

On Wed, 16 Jul 2008, Dmitry Potapov wrote:

> If PATH_MAX on your system is smaller than any path stored in the git 
> repository, that can cause memory corruption inside of the grep_tree 
> function used by git-grep.

Let me guess: Windows? *giggles*

> diff --git a/builtin-grep.c b/builtin-grep.c
> index ef29910..530a53d 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -441,14 +441,17 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
>  	len = strlen(path_buf);
>  
>  	while (tree_entry(tree, &entry)) {
> -		strcpy(path_buf + len, entry.path);
> +		int te_len = tree_entry_len(entry.path, entry.sha1);
> +		if (len + te_len >= PATH_MAX + tn_len)
> +			die ("path too long: %s", path_buf+tn_len);
> +		memcpy(path_buf + len, entry.path, te_len);

That is brutal.  Does grep_tree() not work on tree objects in memory?  In 
that case, you prevent the user from grepping, only because she is on a 
suboptimal platform, _even if_ even that platform could cope with it.

It's not like the path is ever used to access a file, right?

Maybe you should convert the path_buf to a strbuf instead.

Ciao,
Dscho
