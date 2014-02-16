From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/5] notes-utils: handle boolean notes.rewritemode correctly
Date: Sun, 16 Feb 2014 17:22:45 +0100
Message-ID: <87txbzvxgq.fsf@fencepost.gnu.org>
References: <cover.1392565571.git.john@keeping.me.uk>
	<be9b384ec77fc39b939b8c5505862a6e1c641faa.1392565571.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 16 17:22:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF4UW-0000bI-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 17:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbaBPQWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 11:22:48 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:46234 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbaBPQWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 11:22:47 -0500
Received: from localhost ([127.0.0.1]:45275 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WF4UQ-0005S2-D6; Sun, 16 Feb 2014 11:22:46 -0500
Received: by lola (Postfix, from userid 1000)
	id 02B27E067D; Sun, 16 Feb 2014 17:22:45 +0100 (CET)
In-Reply-To: <be9b384ec77fc39b939b8c5505862a6e1c641faa.1392565571.git.john@keeping.me.uk>
	(John Keeping's message of "Sun, 16 Feb 2014 16:06:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242235>

John Keeping <john@keeping.me.uk> writes:

> If we carry on after outputting config_error_nonbool then we're
> guaranteed to dereference a null pointer.

Not really relevant to this patch, but looking at the output of

git grep config_error_nonbool

seems like a serious amount of ridiculousness going on.  The header
shows

cache.h:extern int config_error_nonbool(const char *);
cache.h:#define config_error_nonbool(s) (config_error_nonbool(s), -1)

and the implementation

config.c:#undef config_error_nonbool
config.c:int config_error_nonbool(const char *var)

Presumably this was done so that the uses of config_error_nonbool can be
recognized as returning -1 unconditionally.

But is that worth the obfuscation?  Why not let config_error_nonbool
return -1 in the first place?  It does not appear like any caller would
call the function rather than the macro, so why declare the function as
returning an int at all?  And why give it the same name as the macro
(risking human/computer confusion and requiring an explicit #undef for
the definition or was that declaration?) instead of
config_error_nonbool_internal or whatever else?

-- 
David Kastrup
