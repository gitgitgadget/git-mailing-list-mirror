From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sat, 20 Sep 2008 15:11:56 -0700
Message-ID: <7vzlm21n83.fsf@gitster.siamese.dyndns.org>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <m31vzen4v5.fsf@localhost.localdomain>
 <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
 <200809202001.28383.jnareb@gmail.com>
 <fcaeb9bf0809201248w2850a243n50596dda3121f2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:13:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAhX-0001cH-DV
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYITWMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 18:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYITWMG
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:12:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbYITWMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 18:12:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A8CE065AC0;
	Sat, 20 Sep 2008 18:12:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B51865ABF; Sat, 20 Sep 2008 18:11:58 -0400 (EDT)
In-Reply-To: <fcaeb9bf0809201248w2850a243n50596dda3121f2c@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Sun, 21 Sep 2008 02:48:44 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2797518C-8761-11DD-A13E-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96370>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
> ...
>>  >>  BTW I think that the same rules are used in gitattributes, aren't
>>  >>  they?
>>  >
>>  > They have different implementations. Though the rules may be the same.
>>
>> Were you able to reuse either one?
>
> No. .gitignore is tied to read_directory() while .gitattributes has
> attributes attached. So I rolled out another one for index.

I am sorry, but that sounds like a rather lame excuse.  It certainly is
possible to introduce an "ignored" attribute and have .gitattributes file
specify that, instead of having an entry in .gitignore file, if you teach
read_directory() to pay attention to the attributes mechanism.  If we had
from day one that a more generic gitattributes mechanism, I would imagine
we wouldn't even had a separate .gitignore codepath but used the attribute
mechanism throughout the system.

Now I do not think we are ever going to deprecate gitignore and move
everybody to "ignored" attributes, because such a transition would not buy
the end users anything, but it technically is possible and would have been
the right thing to do, if we were building the system from scratch.  We
still could add it as an optional feature (i.e. if a path has the
attribute that says "ignored" or "not ignored", then that determines the
fate of the path, otherwise we look at gitignore).

I wouldn't be surprised if an alternative implementation of your code to
assign "sparseness" to each path internally used "to-be-checked-out"
attribute, and used that attribute to control how ls-files filters its
output.

A better excuse might have been that "I am not reading these patterns from
anywhere but command line", but that got me thinking further.

How would that --narrow-match that is not stored anywhere on the
filesystem but used only for filtering the output be any more useful than
a grep that filters ls-files output in practice?

I would imagine it would be much more useful if .git/info/attributes can
specify "checkout" attribute that is defined like this:

        `checkout`
        ^^^^^^^^^^

        This attribute controls if the path can be left not checked-out to the
        working tree.

        Unset::
                Unsetting the `checkout` marks the path not to be checked out.

        Unspecified::
                A path which does not have any `checkout` attribute specified is
                handled in no special way.

        Any value set to `checkout` is ignored, and git acts as if the
        attribute is left unspecified.

Then whenever a new path enters the index, you _could_ check with the
attribute mechanism to set the CE_NOCHECKOUT flag.  Just like an already
tracked path is not ignored even if it matches .gitignore pattern, a path
without CE_NOCHECKOUT that is in the index is checked out even if it has
checkout attribute Unset.

Hmm?
