From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-remote-helpers.txt: explain how import works with
 multiple refs
Date: Thu, 1 Sep 2011 18:17:34 -0500
Message-ID: <20110901231734.GA21945@elie>
References: <CAGdFq_gooPGQMa5D19-wag=X+mDntHF1MwXiYF0zovB=L-Sybw@mail.gmail.com>
 <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Sep 02 01:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzGWD-0003Z8-41
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 01:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599Ab1IAXRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 19:17:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38046 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab1IAXRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 19:17:43 -0400
Received: by gwaa12 with SMTP id a12so1300781gwa.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 16:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nNSZ65fiAbFacPak57XbbapIH6VrarhLkjFtegALRKQ=;
        b=rT73VfMhvt+KUO3kVogQqeN65n3dbTT8gjpI2ehljQdCpT62wOd0v4uJsvhsoSnm58
         BrwgR5ik815QG+qHYz7BJd1788VN8Rpgw0PDON6fqVTS/2gTxeO8QpRbQFBfcRtDG1+C
         0F14DY2BeCQWhDyyvJY6+50NlJ2DScgLyoClI=
Received: by 10.91.177.13 with SMTP id e13mr385209agp.69.1314919063151;
        Thu, 01 Sep 2011 16:17:43 -0700 (PDT)
Received: from elie (adsl-76-193-166-2.dsl.chcgil.sbcglobal.net [76.193.166.2])
        by mx.google.com with ESMTPS id w2sm221256anm.21.2011.09.01.16.17.40
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Sep 2011 16:17:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180582>

Hi Matthieu,

Matthieu Moy wrote:

> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -241,7 +241,22 @@ Supported if the helper has the "fetch" capability.
>  'push' +<src>:<dst>::
>  	Pushes the given local <src> commit or branch to the
>  	remote branch described by <dst>.  A batch sequence of
> -	one or more push commands is terminated with a blank line.
> +	one or more 'push' commands is terminated with a blank line
> +	(if there is only one reference to push, a single 'push' command
> +	is followed by a blank line). For example, the following would
> +	be two batches of 'push', the first asking the remote-helper
> +	to push the local ref 'master' to the remote ref 'master' and
> +	the local 'HEAD' to the remote 'branch', and the second
> +	asking to push ref 'foo' to ref 'bar' (forced update requested
> +	by the '+').
> ++
> +------------
> +push refs/heads/master:refs/heads/master
> +push HEAD:refs/heads/branch
> +\n
> +push +refs/heads/foo:refs/heads/bar
> +\n
> +------------

Probably examples like this could go in a later EXAMPLES section.

At first I was worried about this not actually working, thinking
"push" might have traditionally had the newline-ends-command-stream
semantics that "connect" has.  But the push codepath does not set the
no_disconnect_req flag, so I was worrying in vain. :)  The stream
passed to the helper ends with two newlines when git pushes.

>  +
>  Zero or more protocol options may be entered after the last 'push'
>  command, before the batch's terminating blank line.
> @@ -266,6 +281,11 @@ Supported if the helper has the "push" capability.
>  Especially useful for interoperability with a foreign versioning
>  system.
>  +
> +Just like 'push', a batch sequence of one or more 'import' is
> +terminated with a blank line. For each batch of 'import', the remote
> +helper should produce a fast-import stream terminated by a 'done'
> +command.
> ++
>  Supported if the helper has the "import" capability.

This documents v1.7.7-rc0~61^2~3 (transport-helper: change import
semantics, 2011-07-16).  Such a documentation fix was desperately
needed; thank you!

For what it's worth, with or without a change to prevent the example
from interrupting the flow of description,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
