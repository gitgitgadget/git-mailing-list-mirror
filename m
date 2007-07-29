From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 18:08:32 -0700
Message-ID: <7vzm1gnhin.fsf@assigned-by-dhcp.cox.net>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
	<7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
	<20070728101156.20304d11.seanlkml@sympatico.ca>
	<7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Jul 29 03:08:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IExGv-0000pU-BE
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 03:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758618AbXG2BIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 21:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758600AbXG2BIe
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 21:08:34 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58369 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbXG2BId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 21:08:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729010833.GUCK23215.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 28 Jul 2007 21:08:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VD8Y1X0081kojtg0000000; Sat, 28 Jul 2007 21:08:32 -0400
In-Reply-To: <7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 28 Jul 2007 13:41:56 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54070>

Junio C Hamano <gitster@pobox.com> writes:

> Sean <seanlkml@sympatico.ca> writes:
>
>> I would argue that you shouldn't try to have it both ways.
>
> You cannot have it both ways as-is, but this is solvable.  The
> invocation of am from rebase needs an extra (internal to
> implementation) option to use the code it patches, and the
> regular am can fold what are found on Subject: lines it used
> to.
>
> The patch as-is breaks the more important case of e-mail
> acceptance codepath, because MUAs are free to fold the Subject:
> line when the original line is long, and what the user (the
> original patch submitter) expects to happen is that a
> single-line-ness of the original Subject: of the message to be
> kept.  The patch breaks such a line at the place MUA happens to
> fold such a long, single line, for comforming messages.

So here comes an updated series, properly split along the
logical lines.

  0001-log_ref_write-do-not-chomp-reflog-message-at-the.txt
  0002-symbolic-ref-update-ref-do-not-refuse-reflog-message.txt
  0003-rebase-try-not-to-munge-commit-log-message.txt

I am not absolutely sure about the implications of mailinfo
change.  I tried to be careful by making sure that:

 - the updated code kicks in when "format-patch piped to am"
   toolchain uses the -k option on both ends, as rebase/am
   does.  This is the case where we would want to keep the
   way original commit log message was formatted.

 - otherwise the original "line folding" clean-up is used, so
   that usual e-mailed patch acceptance codepath cleanses the
   oneline summary obtained from the "Subject:" header.

Because it would be a serious regression to break the latter,
while the former is just "an improvement" [*1], somebody really
should double check the change for me.

[Footnote]

*1* It does not mean that improved support for foreign SCM
interoperation does not matter.  It is "merely an improvement"
in the sense that people do not like what the code currently
does anyway, and if the updated code is still not liked, then
not having such "an improvement" does not matter.
