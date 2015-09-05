From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/5] disallow test_when_finished in subshells
Date: Sat, 5 Sep 2015 18:57:56 +0100
Message-ID: <20150905175756.GE27660@serenity.lan>
References: <20150905085429.GB25039@sigill.intra.peff.net>
 <cover.1441458341.git.john@keeping.me.uk>
 <CAPc5daUsd8KD77EfF-SBwwOKn0hNPvYXo8UmY-sHBg9S4vUQXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYHjE-0000eT-Gd
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 19:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbbIER6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 13:58:14 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:52386 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbIER6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 13:58:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0AD02CDA548;
	Sat,  5 Sep 2015 18:58:12 +0100 (BST)
X-Quarantine-ID: <C+p0QG4btIUk>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C+p0QG4btIUk; Sat,  5 Sep 2015 18:58:11 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id E0959CDA510;
	Sat,  5 Sep 2015 18:57:58 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAPc5daUsd8KD77EfF-SBwwOKn0hNPvYXo8UmY-sHBg9S4vUQXg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277393>

On Sat, Sep 05, 2015 at 10:36:29AM -0700, Junio C Hamano wrote:
> On Sat, Sep 5, 2015 at 6:12 AM, John Keeping <john@keeping.me.uk> wrote:
> >
> > I don't think it's worth trying to clear $BASH_SUBSHELL before the tests
> > start because to do so we have to reliably detect that we're not running
> > under Bash, and if we don't trust people not to set $BASH_SUBSHELL why
> > do we trust them not to set $BASH?
> 
> I am not worried about evil people who do funny things to deliberately break
> other people's arrangement. I am more worried about stupid people (e.g. those
> who export CDPATH).
> 
> In bash a stupid person may attempt to export BASH_SUBSHELL and then
> have a script that runs our test suite, setting SHELL_PATH to point at a
> non-bash while building Git and running the tests under a non-bash shell. I
> am hesitant to believe that we will know the variable will never leak through
> to the test via environment.
> 
> Isn't it just the matter of resetting the variable regardless of $BASH
> (and ignoring
> a possible refusal to do so under bash) at the beginning of the test, or do you
> really have to rely on the value of $BASH and do things differently?

Bash doesn't refuse to set it, it lets you update the value; I did think
that it wouldn't update it if the user had overridden the value, but it
looks like that was only because I had unset it first.  It seems that
the variable is magic (autoincrementing in subshells and can only be set
to integer values) but if you unset it then it becomes a normal
variable.

I'm wary of relying on that behaviour being unchanged across all
versions of bash, so I'd prefer to avoid writing the variable if running
under bash.

We do already have t/lib-bash.sh which has an optimization to avoid
exec'ing bash if "$BASH" is set, which will break in the same way if
someone exports BASH and then runs t9902 or t9903 under non-bash.
