From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add commands that git-gc runs underneath
Date: Fri, 31 Aug 2007 14:12:13 -0700
Message-ID: <7vlkbrxvbm.fsf@gitster.siamese.dyndns.org>
References: <lkbtwek0.fsf@cante.net>
	<Pine.LNX.4.64.0708301107320.28586@racer.site>
	<46D6984D.9040802@op5.se> <7v7inc907e.fsf@gitster.siamese.dyndns.org>
	<46D7E058.9050001@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDmy-0008Ui-38
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761216AbXHaVMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761190AbXHaVMU
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:12:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761092AbXHaVMT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:12:19 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 540DA12BBBE;
	Fri, 31 Aug 2007 17:12:37 -0400 (EDT)
In-Reply-To: <46D7E058.9050001@op5.se> (Andreas Ericsson's message of "Fri, 31
	Aug 2007 11:33:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57212>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>
>>> When gc was a shell-script, it was fairly easy to find out the command-
>>> sequence...
>>
>> Maybe referring more advanced/curious users to contrib/examples/
>> directory is a good idea, but not necessarily from manpages of
>> the commands that have been rewritten in C.
>>
>> I think contrib/examples/ needs a README file that effectively
>> say "these are the last versions of shell script implementation
>> of the commands before they were rewritten in C.  New features
>> may have been added to the built-in ones but these example
>> scripts are not kept up to date.  They are here to serve as
>> examples to show you how you would pipeline the plumbing level
>> commands."
>
> Sensible, and also avoids the possible bitrot problem with the
> man-page should there be additional actions added to standard
> git-gc operations.

Oh, I did not mean to address bit-rot issue.  I was addressing
"ah, in good old days we had tons of example scripts" issue.

If we want the manual to be explicit about what exactly happens
when you run "git-gc" (and I think we do), that needs to be done
independently.  But my feeling is that we do not want to
describe what happens solely in terms of what other individual
commands do.  Referring to other manual pages for more details
is fine, but that should not be the sole description.

In other words, instead of saying:

 - runs "git pack-refs", "git reflog expire --all", "git repack
   -a -d -l", ...

I think we would want to say it this way:

 * Under such-and-such condition, loose refs are packed for
   quicker access in $GIT_DIR/packed-refs file (runs "git
   pack-refs --prune");

 * Old reflog entries that record how tips of each branches were
   moved are expired (runs "git-reflog expire --all");

 * Packfiles are repacked along with loose object files, while
   exclusing objects that are available from the alternates
   (runs "git repack -a -d -l");

 * Unreferenced loose objects are removed if --prune is given
   (runs "git prune");
  
 * Old rerere records that record resolutions to previously
   conflicted merges are expired (runs "git rerere gc").
