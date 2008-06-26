From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pre-commit hook should ignore carriage returns at EOL
Date: Thu, 26 Jun 2008 16:01:40 -0700
Message-ID: <7vprq3ol63.fsf@gitster.siamese.dyndns.org>
References: <3BA781AD-4C44-4F43-902A-07580B6CA075@gmail.com>
 <20080625181422.GC4039@steel.home>
 <5B163827-204D-4F76-88C9-8F0C93E60AF3@gmail.com>
 <7vhcbh1g4e.fsf@gitster.siamese.dyndns.org>
 <635350D7-2CC0-4FA6-BB74-CE9ED930ECE8@gmail.com>
 <7vk5gbq10p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Christian Holtje <docwhat@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 01:03:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC0UZ-00024O-Bk
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 01:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbYFZXB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 19:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYFZXB5
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 19:01:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYFZXB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 19:01:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 63CF32210D;
	Thu, 26 Jun 2008 19:01:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 682472210C; Thu, 26 Jun 2008 19:01:48 -0400 (EDT)
In-Reply-To: <7vk5gbq10p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 26 Jun 2008 15:33:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DEAC18AC-43D3-11DD-A7F9-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86500>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Holtje <docwhat@gmail.com> writes:
>
>>> I suggested using "diff --check" (and possibly teaching "diff --check"
>>> other things the scripted example checks, such as conflict markers),
>>> which would know to honor the line endings specified per path via
>>> gitattributes(5), instead of building on top of the big Perl script,
>>> and I
>>> had an impression that you agreed to the approach.
>>
>> I'm completely confused how gitattributes and core.autocrlf interact,
>> etc.
>
> Here is a series I just cooked up so that we can remove the whole Perl
> script and replace it by adding --check to "diff-index" used there. 
>
> The first three are code clean-ups and the last two implements necessary
> new features to "diff --check".  The whole series somewhat depend on the
> fix to 'maint' not to lose the exit status I sent earlier.
>
> [PATCH 1/5] diff --check: explain why we do not care whether old side is binary
> [PATCH 2/5] check_and_emit_line(): rename and refactor
> [PATCH 3/5] checkdiff: pass diff_options to the callback
> [PATCH 4/5] Teach "diff --check" about a new blank lines at end
> [PATCH 5/5] diff --check: detect leftover conflict markers

With these enhancements in place, I think the pre-commit hook to find
problematic change would become essentially a one-liner, something like:

	git diff-index --check -M --cached

and the checking will obey what you configured with core.whitespace, which
globally defines what kind of whitespace breakages are "problematic",
and/or whitespace attribute which determines the same per path.

If you have for example Python source files that you would want all the
default whitespace checks (that is, trailing whitespaces are not allowed,
initial indentation part should not have SP followed by HT), you would
have

	*.py whitespace=trail,space-before-tab

in your .gitattributes, and the above command would catch such a
breakage.  If you further want to catch indentation with more than 8
SPs that can be replaced with HTs in your C sources, you would say:

	*.[ch] whitespace=indent-with-no-tab,trail,space-before-tab

You could choose to have CRLF line endings in the repository [*1*], and
for such projects, diff output would have tons of lines that end with
CRs.  To consider these CRs part of the line terminator, add cr-at-eol
to the value of whitespace attribute, like so:

	*.py whitespace=trail,space,cr-at-eol
	*.[ch] whitespace=indent,trail,space,cr-at-eol

[Footnote]

*1* I do not do Windows, but my understanding is that this practice is not
recommended because it would hurt cross-platform use of the project.  You
would instead keep your repository copy with LF line endings, and make
your checkouts have CRLF line endings by core.autocrlf configuration.
