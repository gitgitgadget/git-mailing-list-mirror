From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for
 external diff
Date: Sat, 21 Mar 2009 17:03:21 -0700
Message-ID: <7v8wmybf06.fsf@gitster.siamese.dyndns.org>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
 <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> <7vocvuekjb.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 22 01:05:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlBBU-0000WB-EM
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 01:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbZCVADa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 20:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZCVADa
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 20:03:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbZCVAD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 20:03:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 60C0EA3713;
	Sat, 21 Mar 2009 20:03:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1AFA5A3712; Sat,
 21 Mar 2009 20:03:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 22 Mar 2009 00:54:43 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DE908CBC-1674-11DE-B759-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114103>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 21 Mar 2009, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > When preparing temporary files for an external diff, the files should 
>> > be handled as if they were worktree files.
>> 
>> I do not think so.  convert_to_working_tree() aka "smudge" means you 
>> would be feeding crap like $Id$ expansion to the external diff, which we 
>> chose not to do quite on purpose.
>
> You might have missed me mentioning that we often can do without temporary 
> files, taking the working directory copies right away?
>
> And if you think about it, it makes complete sense.

Not "complete".

What is at issue is how consistent the codepath that calls out to an
external diff should be with the rest of git that solely work with the
"clean" version of blob contents.  If you value consistency, I would say
that it is valid to argue that letting it borrow from a work tree is a
bug.  It should be always feeding a clean version.

But if you think that we do not care really about the correctness of the
external diff codepath, because it is a mechanism used mostly for giving
output to humans (as opposed to feeding the output of the external diff
program back to programs to be processed further) , I can understand why
you think it is easier to the external programs if "smudged" version is
fed to them.

Not just I can _understand_, but I think I could be pursuaded to agree
with that position, iff you try harder.

But the assumption/rationale behind this change needs to be spelled out.
In essence, we are sacrificing purity and correctness because we consider
ease of building external diff filter is more important.

Or something like that.
