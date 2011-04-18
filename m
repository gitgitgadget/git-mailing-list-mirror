From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 14:16:18 -0700
Message-ID: <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:16:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBvoA-00021q-T2
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436Ab1DRVQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:16:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab1DRVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 17:16:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7DFD44763;
	Mon, 18 Apr 2011 17:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=knt/pAunjctujRLwZKjJHD1uP+I=; b=GXnp+0
	0LMWcaWYs8Lgin1qM4DFjTWXxQm5ozWcNa4s+BFSItMvnpNrBig1Gj5Tvu7Rk+aX
	zC6wABOiiKjTLqqkQhaAOQN8EHPA+06yLSCS4Ux2c9I3WqxqJ9YW/CTvM66nsU2M
	5RZWME/ljmOaiAdaJjpJYf8HD6QtPN0yhHcOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jJjMCEQ3yz6+8ezp4WfB2aJBoYmLQDyX
	RXjM9A304mOA37V9TYwelV/VWNA7QgNkOwLlCg7enb331BNjygFT6o4HtwknQ3ii
	WsrIyOvLfVFe0ffN//WjVpM6utWqXHEs2+pPZE62ZEWz6YVazZOZlatKjhv+K6QQ
	bCS4hkquNIU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D1F54762;
	Mon, 18 Apr 2011 17:18:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 67E29475E; Mon, 18 Apr 2011
 17:18:21 -0400 (EDT)
In-Reply-To: <7v8vv78eld.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 18 Apr 2011 13:54:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64FE33DA-6A01-11E0-B1E8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171758>

Junio C Hamano <gitster@pobox.com> writes:

> There appears to be a regression in the codepath between git wrapper and
> run_commands API.
>
> 	$ T=/var/tmp/test-commands
> 	$ mkdir $T
> 	$ cat >$T/git-hello <<\-EOF
> 	#!/bin/sh
> 	echo hello
> 	EOF
> 	$ chmod +x $T/git-hello
> 	$ oPATH=$PATH
> 	$ PATH=$T:$PATH
> 	$ export PATH
> 	$ git hello
> 	hello
>
> So far, I added a "hello" subcommand to "git", and it runs correctly.
>
> Now, when I make the script non-executable, this is what I get from
> 'maint':
>
> 	$ chmod a-x $T/git-hello
> 	$ git hello
> 	fatal: cannot exec 'git-hello': Permission denied
>
> But with 'master', we get a disturbing output:
>
> 	$ git hello
>         fatal: $
>
> Note that we can observe the same regression if you instead make $T
> unreadable with:
>
> 	$ chmod 755 $T/git-hello ;# make it executable again
> 	$ chmod a-rwx $T ;# but that directory cannot be read
>         $ git hello
>
> So that is the "regression" part.

This bisects down to ebec842 (run-command: prettify -D_FORTIFY_SOURCE
workaround, 2011-03-16).

And we should really have been more careful.  Look at what the patch does:

    Sometimes when there is an output error, especially right before exit,
    there really is nothing to be done.  The obvious solution, adopted in
    v1.7.0.3~20^2 (run-command.c: fix build warnings on Ubuntu,
    2010-01-30), is to save the return value to a dummy variable:
    
    	ssize_t dummy;
    	dummy = write(...);
    
    But that (1) is ugly and (2) triggers -Wunused-but-set-variable
    warnings with gcc-4.6 -Wall, so we are not much better off than when
    we started.

    Instead, use an "if" statement with an empty body to make the intent
    clear.
    
    	if (write(...))
    		; /* yes, yes, there was an error. */
    
No, a non-zero return is not an error from the write(2) system call.
I cannot believe both of us didn't spot it.  What were we smoking?

I'm reverting it for now, but am open to a submission of a proper fix
after 1.7.5.
