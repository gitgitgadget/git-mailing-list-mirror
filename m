From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log -S doesn't find some commits
Date: Tue, 04 Nov 2008 17:30:20 -0800
Message-ID: <7vy6zzm02b.fsf@gitster.siamese.dyndns.org>
References: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
 <alpine.DEB.1.00.0811050014310.30769@pacific.mpi-cbg.de>
 <7vod0voy22.fsf@gitster.siamese.dyndns.org>
 <877i7jrp67.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Wed Nov 05 02:32:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxXFT-00071b-8l
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 02:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYKEBal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 20:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYKEBal
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 20:30:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYKEBak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 20:30:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DEA8079C1F;
	Tue,  4 Nov 2008 20:30:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1466679C1C; Tue,
  4 Nov 2008 20:30:27 -0500 (EST)
In-Reply-To: <877i7jrp67.fsf@gollum.intra.norang.ca> (Bernt Hansen's message
 of "Tue, 04 Nov 2008 19:29:04 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 599BEA30-AAD9-11DD-AE51-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100134>

Bernt Hansen <bernt@norang.ca> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> There seems to be a misconception on what -S<foo> does.  It does *NOT*
>> grep for string <foo> in the patch text.  It counts number of <foo> in
>> preimage and postimage and decides that the commit is worth showing iff
>> they differ.
>>
>> If you look at, for example (B):
>>
>>     http://repo.or.cz/w/org-mode.git?a=commitdiff;h=837c81ce51
>>
>> You can see that in org-publish.el, org-publish-validate-link appears once
>> as removed and once as added, so the total number of the appearance of the
>> symbol in preimage and postimage are the same.
>
> Now I get it :)
>
> Thanks both of you!

By the way, I would not be opposed to a new feature, perhaps triggered
with -G<foo>, that acts as if it is grepping inside the patch text.

The reason behind -S<foo>'s behaviour is because it was designed as a part
ofa "incremetal digging" tool before the current "git-blame" that allows
to track even line-movements.

That is, you could write a tool to help the following interactively:

 (1) get interested in a block of text in a recent version;

 (2) feed that to 'git log' like this:

 	git log -1 -p -S"$potentially_multi_line_text" $rev

     this will find an old rev R whose parent R^ did not have the lines
     in the exact form you fed with -S.

 (3) inspect the output, and decide what to do next:

     (3-a) you may want to adjust the text you look for, taking into
     account how the neighbouring lines used to look like in R^, and run
     another "git log -S" starting at R^; and/or

     (3-b) you may want to run "git grep" for the text in the entire
     tree in R^, to see if this was a code refactoring that consolidates
     multiple copies of the same thing into a single place.

     and go back to step (2).


cf. http://thread.gmane.org/gmane.comp.version-control.git/27/focus=217
