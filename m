From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 5/5] test-lib-functions: detect test_when_finished in
 subshell
Date: Sun, 6 Sep 2015 12:46:35 +0100
Message-ID: <20150906114635.GF27660@serenity.lan>
References: <20150905085429.GB25039@sigill.intra.peff.net>
 <cover.1441458341.git.john@keeping.me.uk>
 <59a8583f79c5ac4661f140262e01cd602286f740.1441458341.git.john@keeping.me.uk>
 <CAPig+cR+_nPFbJmOf3s90oB=Jedg1B3YgOCzSwWa8nwP8-QbeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 13:47:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYYPf-0004VW-G4
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 13:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbbIFLrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 07:47:00 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:44790 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828AbbIFLqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 07:46:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8BAF9CDA54D;
	Sun,  6 Sep 2015 12:46:51 +0100 (BST)
X-Quarantine-ID: <KOnZ5U2AilGl>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KOnZ5U2AilGl; Sun,  6 Sep 2015 12:46:50 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 11879CDA565;
	Sun,  6 Sep 2015 12:46:37 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAPig+cR+_nPFbJmOf3s90oB=Jedg1B3YgOCzSwWa8nwP8-QbeA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277423>

On Sun, Sep 06, 2015 at 05:51:43AM -0400, Eric Sunshine wrote:
> On Sat, Sep 5, 2015 at 9:12 AM, John Keeping <john@keeping.me.uk> wrote:
> > test_when_finished does nothing in a subshell because the change to
> > test_cleanup does not affect the parent.
> >
> > There is no POSIX way to detect that we are in a subshell ($$ and $PPID
> > are specified to remain unchanged), but we can detect it on Bash and
> > fall back to ignoring the bug on other shells.
> 
> I'm not necessarily advocating this, but think it's worth mentioning
> that an alternate solution would be to fix test_when_finished() to work
> correctly in subshells rather than disallowing its use. This can be done
> by having test_when_finished() collect the cleanup actions in a file
> rather than in a shell variable.
> 
> Pros:
> * works in subshells
> * portable across all shells (no Bash special-case)
> * one less rule (restriction) for test writers to remember
> 
> Cons:
> * slower
> * could interfere with tests expecting very specific 'trash' directory
>   contents (but locating this file under .git might make it safe)

Another con is that we have to worry about the working directory, and
since we can't reliably detect if we're in a subshell every cleanup
action probably has to be something like:

	( cd '$(pwd)' && $* )

It's certainly possible but it adds another bit of complexity.

Since there are only 3 out of over 13,000 tests that use this
functionality (and it's quite easy to change them not to) I'm not sure
it's worth supporting it.

> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  t/test-lib-functions.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> > index 0e80f37..6dffb8b 100644
> > --- a/t/test-lib-functions.sh
> > +++ b/t/test-lib-functions.sh
> > @@ -736,6 +736,11 @@ test_seq () {
> >  # what went wrong.
> >
> >  test_when_finished () {
> > +       # We cannot detect when we are in a subshell in general, but by
> > +       # doing so on Bash is better than nothing (the test will
> > +       # silently pass on other shells).
> > +       test "${BASH_SUBSHELL-0}" = 0 ||
> > +       error "bug in test script: test_when_finished does nothing in a subshell"
> >         test_cleanup="{ $*
> >                 } && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
> >  }
> > --
> > 2.5.0.466.g9af26fa
