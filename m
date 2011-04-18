From: Jeff King <peff@peff.net>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 17:11:02 -0400
Message-ID: <20110418211102.GA13566@sigill.intra.peff.net>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:11:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBvj3-0007PR-NK
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab1DRVLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:11:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33573
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab1DRVLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 17:11:07 -0400
Received: (qmail 3878 invoked by uid 107); 18 Apr 2011 21:11:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Apr 2011 17:11:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Apr 2011 17:11:02 -0400
Content-Disposition: inline
In-Reply-To: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171757>

On Mon, Apr 18, 2011 at 01:54:54PM -0700, Junio C Hamano wrote:

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

The good news is that the bug is trivial. It bisects Jonathan's ebec842
(run-command: prettify -D_FORTIFY_SOURCE workaround, 2011-03-16), which
introduces:

-       unused = write(child_err, "fatal: ", 7);
-       unused = write(child_err, msg, len);
-       unused = write(child_err, "\n", 1);
+       if (write(child_err, "fatal: ", 7) ||
+           write(child_err, msg, len) ||
+           write(child_err, "\n", 1))
+               ; /* yes, gcc -D_FORTIFY_SOURCE, we know there was an error. */

Stare at that for a minute and see if you can guess what's wrong. :)

-Peff
