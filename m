From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's static analysis
Date: Thu, 05 Feb 2009 17:19:15 -0800
Message-ID: <7v63jo9xbg.fsf@gitster.siamese.dyndns.org>
References: <1233870004-63540-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Fri Feb 06 02:20:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVFOk-0003Dh-N2
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 02:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbZBFBTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 20:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbZBFBTY
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 20:19:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbZBFBTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 20:19:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 298822A834;
	Thu,  5 Feb 2009 20:19:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6580F2A832; Thu, 
 5 Feb 2009 20:19:19 -0500 (EST)
In-Reply-To: <1233870004-63540-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Thu, 5 Feb 2009 21:40:04 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2F40090E-F3EC-11DD-BD72-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108643>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> I played around a bit with the 'Clang' static analyser, and tried to run git's
> source code through it. It comes up with a few possible errors, so I thought
> you might find it interesting. I took a quick glance, and it also seems to
> have a few false positives, but it might still be worth to take a look.
>
> The results can be found here:
>
> 	http://frim.frim.nl/git-analyse/

Hmm, I took a quick look at a few, and they looked nonsense, but perhaps I
am misreading things.

For example:

    http://frim.frim.nl/git-analyse/report-uxXiUR.html#EndPath

I am assuming that we follow the control flow of the labelled comments, so
I followed along from [1] to [7] and then saw these:

    [8] loop condition is false, execution continues on line 1492
    1483:   for (i = 0; i < array->nr; i++) {
                ...
            }

    [9] taking false branch
    1492:   if (array->nr <= i)
                return NULL;

    [10] dereference of null pointer.
    1495:   c->object.flags |= ...

The thing is, if [8] exits, "i < array->nr" is not true anymore, and there
is no way you can take false branch of  "if (array->nr <= i)" in the
immediately next step [9]. and reach point [10].

So it is either that the tool does not know how "for" and "if" statement
works in C language, or I am completely misunderstanding what the in-line
comments are trying to tell me.
