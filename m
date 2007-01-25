From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Documentation: --amend cannot be combined with -c/-C/-F.
Date: Thu, 25 Jan 2007 12:29:30 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnerh8la.7v0.mdw@metalzone.distorted.org.uk>
References: <20070124195446.GA13817@bohr.gbar.dtu.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 25 14:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA4Tk-0003Uh-01
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 14:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965321AbXAYNRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 08:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbXAYNRT
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 08:17:19 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:18145 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S965321AbXAYNRS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jan 2007 08:17:18 -0500
X-Greylist: delayed 872 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jan 2007 08:17:18 EST
Received: (qmail 18509 invoked by uid 110); 25 Jan 2007 12:29:30 -0000
Received: (qmail 18496 invoked by uid 9); 25 Jan 2007 12:29:30 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1169728170 18494 172.29.199.2 (25 Jan 2007 12:29:30 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 25 Jan 2007 12:29:30 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37721>

Peter Eriksen <s022018@student.dtu.dk> wrote:

> We used to get the following confusing error message:
>
> % git commit --amend -a -m foo
> Option -m cannot be combined with -c/-C/-F

Hmm.  The log-message options to git commit seem confused to me.

The default behaviour is to fire up an editor for the user to provide a
message.  The editor buffer may be pre-initialized, e.g., because
MERGE_MSG exists.

This default behaviour can be overridden in a number of ways:

  * -m forces the message to be its argument;
  * -F forces the message to be the contents of some file;
  * -C forces the message to be a copy of some other commit message.

So far, so good.  One can see why all of these options are mutually
exclusive.  The problem is in the mess of other options like -c and
--amend.

Currently -c (copy some other commit message, and then edit it) is
considered to be a `force message to be...' kind of option, like the
others I've listed above.

So, for some reason, is --amend.  This last is really annoying.  I
frequently find that I end up typing

  VISUAL=: git commit --amend ...

to fix the stupid thing I forgot to do before I committed last time.
No, dammit, I don't want to mess with the editor.

Somewhere in all of this is a fairly nice, regular set of operations trying to
escape.  There are two processes at work:

  * setting a default message, and
  * maybe getting the user to edit it.

The first part is slightly complicated: there are a number of places to
get a default message from, and several might be possible:

  * explicitly specified by the user (e.g., -m);
  * found lying about in MERGE_MSG;
  * picked up from the HEAD commit (for --amend); or
  * empty.

Choosing between MERGE_MSG and --amend is difficult; indeed, they
probably ought to be mutually exclusive.  But both should obviously win
over an empty initial message, and (I think) just as obviously lose to
an explicit message -- after all, the purpose of --amend is primarily to
replace the current HEAD commit, not to fill in a default message.

-- [mdw]
