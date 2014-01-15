From: Jeff King <peff@peff.net>
Subject: Re: BUG: check-ref-format and rev-parse can not handle branches with
 an @ in their name combined with @{u}
Date: Wed, 15 Jan 2014 00:00:03 -0500
Message-ID: <20140115050003.GA27237@sigill.intra.peff.net>
References: <52D5C296.7050906@lge.com>
 <xmqqvbxm2kmg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 06:00:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3IaJ-0000yb-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 06:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbaAOFAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 00:00:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:60833 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750703AbaAOFAF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 00:00:05 -0500
Received: (qmail 31787 invoked by uid 102); 15 Jan 2014 05:00:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jan 2014 23:00:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 00:00:03 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvbxm2kmg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240431>

On Tue, Jan 14, 2014 at 03:45:27PM -0800, Junio C Hamano wrote:

> > Yet 'git check-ref-format --branch @mybranch@{u}' 
> > claims @mybranch is an invalid branch name.
> 
> I do not think it claims any such thing.
> 
>     $ git check-ref-format --branch @foo@{u}; echo $?
>     fatal: '@foo@{u}' is not a valid branch name
>     128
>     $ git check-ref-format --branch @foo; echo $?
>     @foo
>     0
> 
> The former asks "Is the string '@foo@{u}' a suitable name to give a
> branch?" and the answer is no.  The latter asks the same question
> about the string '@foo', and the answer is yes.

Is that what "--branch" does? I have never used it, but the manpage
seems to suggest it is about _parsing_ (which, IMHO, means it probably
should have been an option to rev-parse, but that is another issue
altogether).

So a more interesting output than the above is:
 
  $ git checkout -t -b @mybranch origin/master
  Branch @mybranch set up to track remote branch master from origin.
  Switched to a new branch '@mybranch'

  $ git check-ref-format --branch @mybranch@{u}; echo $?
  fatal: '@mybranch@{u}' is not a valid branch name
  128

  $ git check-ref-format --branch HEAD@{u}; echo $?
  origin/master
  0

So "check-ref-format --branch" does understand @{u} syntax. But it
doesn't like @mybranch@{u}. You can see the same problem with rev-parse:

  $ git rev-parse --symbolic-full-name HEAD@{u}
  refs/remotes/origin/master
  $ git rev-parse --symbolic-full-name @mybranch@{u}
  @mybranch@{u}
  fatal: ambiguous argument '@mybranch@{u}': unknown revision or path
  not in the working tree.

So I do think there is a bug. The interpret_branch_name parser somehow
gets confused by the "@" in the name.

-Peff
