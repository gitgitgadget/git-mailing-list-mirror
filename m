From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/7] Windows: Add workaround for MSYS' path conversion
Date: Sun, 21 Sep 2008 23:57:23 +0200
Message-ID: <200809212357.23228.johannes.sixt@telecom.at>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de> <1222014278-11071-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Sep 21 23:58:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhWwu-0001Mx-VS
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 23:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbYIUV52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbYIUV52
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 17:57:28 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:45150 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbYIUV51 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 17:57:27 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 8AB8FBEEAC;
	Sun, 21 Sep 2008 23:57:24 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AA4501D22C;
	Sun, 21 Sep 2008 23:57:23 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1222014278-11071-2-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96439>

On Sonntag, 21. September 2008, Steffen Prohaska wrote:
> MSYS' automatic path conversion causes problems when passing paths as
> defines ('-D' arguments to the compiler).  MSYS tries to be smart and
> converts absolute paths to native Windows paths, e.g. if MSYS sees
> "/bin" it converts it to "c:/msysgit/bin".  But we want completely
> unmodified paths; e.g. if we set bindir in the Makefile to "/bin", the
> define BINDIR shall expand to "/bin".  Conversion to absolute Windows
> path will takes place later, during runtime.
>
> This commit adds a workaround by replacing "/" with its octal
> representation "\057", effectively hiding the path from MSYS' path
> conversion mechanism.  MSYS does no longer see the absolute path and
> therefore leaves it alone.

This is disgusting, don't you think so, too?

The reason that you need this patch is because you insist that paths in the 
Makefile remain defined as:

bindir = $(prefix)/bin
mandir = $(prefix)/share/man
infodir = $(prefix)/share/info
gitexecdir = $(prefix)/libexec/git-core
etc...

even if RUNTIME_PREFIX is enabled (and you seem to imply that $(prefix) is 
empty, but this is not enforced by any patch).

Wouldn't it be quite natural that enabling RUNTIME_PREFIX implies that the 
above paths are relative, and, therefore, the Makefile must define them as

bindir = bin
mandir = share/man
infodir = share/info
gitexecdir = libexec/git-core
etc...

because the prefix is ... determined at runtime? Now the paths should not be 
mangled anymore.

-- Hannes
