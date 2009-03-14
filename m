From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Sat, 14 Mar 2009 11:45:52 -0700
Message-ID: <7viqmcaqov.fsf@gitster.siamese.dyndns.org>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
 <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
 <49BA39A1.9090203@drmicha.warpmail.net>
 <200903131215.49336.trast@student.ethz.ch>
 <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com>
 <49BA6606.1070403@fastmail.fm> <7vy6v9f9zn.fsf@gitster.siamese.dyndns.org>
 <49BB920A.20301@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Mar 14 19:48:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiYtm-0005f8-4v
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 19:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbZCNSqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 14:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756802AbZCNSqI
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 14:46:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756739AbZCNSqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 14:46:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E1BA95DA2;
	Sat, 14 Mar 2009 14:46:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DD38C5DA1; Sat,
 14 Mar 2009 14:45:53 -0400 (EDT)
In-Reply-To: <49BB920A.20301@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sat, 14 Mar 2009 12:16:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5D1984C4-10C8-11DE-B5FC-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113256>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Since both the cleaned and the smudged version are supposed to be
> "authoritative" (as opposed to the textconv'ed one) one may argue either
> way what's the right approach.

Smudged one can never be authoritative.  That is the whole point of smudge
filter and in general the whole convert_to_working_tree() infrastructure.
It changes depending on who you are (e.g. on what platform you are on).
So running comparison between two clean versions is the only sane thing to
do.

You could argue textconv should work on smudged contents or on clean
contents before smudging.  As long as it is done consistently, I do not
care either way too deeply, as its output is not supposed to be used for
anything but human consumption.  Two equally sane arrangement would be:

 (1) Start from two clean contents (run convert_to_git() if contents were
     obtained from the work tree), run textconv, run diff, and output the
     result literally; or

 (2) Start from two smudged contents (run convert_to_working_tree() for
     contents taken from the repository), run textconv, run diff, and
     run clean before sending the result to the output.

The former assumes a textconv filter that wants to work on clean
contents, the latter for a one that expects smudged input.  I probably
would suggest going the former approach, as it is consistent with the
general principle in other parts of the system (the internal processing
happens on clean contents).

Both of the above two assumes that the output should come in clean form;
it is consistent with the way normal diff is generated for consumption by
git-apply. You can certainly argue that the final output should be in
smudged form when textconv is used, as it is purely for human consumption,
and is not even supposed to be fed to apply.
