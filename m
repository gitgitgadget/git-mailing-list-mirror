From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Mon, 09 Mar 2009 17:07:08 -0700
Message-ID: <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 01:08:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgpWh-00023d-9l
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 01:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbZCJAHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 20:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbZCJAHT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 20:07:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbZCJAHS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 20:07:18 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A71DA0C64;
	Mon,  9 Mar 2009 20:07:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 733A7A0C63; Mon,
  9 Mar 2009 20:07:10 -0400 (EDT)
In-Reply-To: <1236638151-6465-1-git-send-email-finnag@pvv.org> (Finn Arne
 Gangstad's message of "Mon, 9 Mar 2009 23:35:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68744A58-0D07-11DE-BFA3-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112764>

Finn Arne Gangstad <finnag@pvv.org> writes:

> "-" is now an alias for the current remote (the remote of the current
> branch or "origin" as a fallback). This works both for push, fetch,
> pull, remote (and possibly some others), creating a lot of nice
> shortcuts I think:
> git remote prune - : prune the current remote
> git push - HEAD : push the current branch to a branch of the same name
> git fetch - next : fetch the next branch from the current remote
>
> git push has learned two new command line options --matching and
> --current, which override any configuration.  'matching' pushes all
> branches that already exist at the remote, while 'current' pushes the
> current branch to whatever it is tracking
>
> I chose this behaviour for 'current', since it is the one that I find
> most useful, and there seems to be no good way of expressing it from
> the command line.  Pushing a branch to an identically named branch on
> a remote can now easily be done by "git push - HEAD".
>
> Also added a new configuration option push.default, which can have values
> "nothing", "matching" and "current". This variable will only be used if
> you have not specificed any refspecs at all, no command line options imply
> any refspecs, and the current branch has no push configuration.
>
> This is implemented in 1-3

I think the last four are more or less sane, but I am not sure about the
first three, which makes it very unfortunate that the former depends on
the latter.

Some design issues and questions regarding the first three; not all of
them are objections:

 * Do we use a short-hand for "the default thing" anywhere else in the
   current UI (not just "git push" but in the "git" command set)?

   - If the answer to the above question is "yes", does it use '-' as the
     short-hand too?  In other words, is this new short-hand consistent
     with it, or is it introducing "git-push uses '-' as the short-hand
     for the default, while git-frotz uses something else" confusion?

   - Even if the answer to the above question is "no", are there other
     commands that we currently do not allow a quick shorthand to mean
     "the default thing", but would benefit from having one?  If so, how
     good does it look to use '-' as such a short-hand?

     In other words, is it safe to establish a precedent to use '-' to
     denote "the default thing"?  Would we later regret, saying that
     "'git-frotz command would benefit from a short-hand notation for 'the
     default thing', but - is already taken -- it means send the output to
     the stdout"?

   - Do we use a short-hand '-' to mean something entirely different in
     the UI, making this new use of '-' to mean the default confusing?

     I think '-' for checkout means "the previous one", which already
     answers this question somewhat.

 * What's the point of having --matching option, when you can already say
   ':', i.e.

	$ git push origin :

 * What's the point of having --current option, when you can already say
   HEAD, i.e.

	$ git push origin HEAD

 * Is push.default still necessary if we had "remote.*.push" (where '*' is
   literally an "asterisk") that is used as a fall-back default when there
   is no "remote.<name>.push" for the remote we are about to push to?
