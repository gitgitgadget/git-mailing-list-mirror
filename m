From: Junio C Hamano <gitster@pobox.com>
Subject: Breaking "git status" (was Re: [PATCH 5/5] shortstatus: a new
 command)
Date: Thu, 06 Aug 2009 09:23:48 -0700
Message-ID: <7vljlwnc6j.fsf_-_@alter.siamese.dyndns.org>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com>
 <1249463746-21538-2-git-send-email-gitster@pobox.com>
 <1249463746-21538-3-git-send-email-gitster@pobox.com>
 <1249463746-21538-4-git-send-email-gitster@pobox.com>
 <1249463746-21538-5-git-send-email-gitster@pobox.com>
 <1249463746-21538-6-git-send-email-gitster@pobox.com>
 <20090806153339.GC1970@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 06 18:24:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ5l9-00076l-Lm
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 18:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbZHFQX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 12:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755844AbZHFQX5
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 12:23:57 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbZHFQX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 12:23:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F341A23305;
	Thu,  6 Aug 2009 12:23:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2EC6223302; Thu, 
 6 Aug 2009 12:23:50 -0400 (EDT)
In-Reply-To: <20090806153339.GC1970@coredump.intra.peff.net> (Jeff King's
 message of "Thu\, 6 Aug 2009 11\:33\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 89BE030C-82A5-11DE-85C6-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125090>

Jeff King <peff@peff.net> writes:

> Missing docs, of course, and tests would be nice. Is this meant to be
> plumbing? If not, the name is too long to type. ;)

As I said, this was more of technology demonstration with an iffy UI.

I've been wondering if this should be "git status -T" (a la "ls-files -t",
but nice short-and-sweet -t is taken for rarely used --template).

> I think one of the most often-requested things for a "git status"
> replacement is that "git status <path>" do path-limiting.

For that matter, as 1.7.0 material that potentially breaks backward
compatibility in a big way, it is tempting to suggest that we might want
to depart from the traditional "status takes the same parameters to commit
and gives a preview of what would happen" semantics.  Even though the
current "status" takes the same set of parameters as "commit" takes, many
of the parameters, especially the ones related to message generation, do
not make sense.

Here is a possible transition plan.  I am not married to it, but throwing
it out as a discussion starter:

 * Introduce "git commit --dry-run", that takes place of the current
   "git status".

   We will keep "git commit --dry-run" forever so that people can simply
   do a "s/git status/git commit --dry-run/" to keep their own scripts
   that currently run "git status" before deciding to run "git commit" (or
   runs their own re-implementation of "git commit") working.

 * Introduce "status.traditional" configuration.  In 1.6.5

   - When set to true, "git status" behaves as "git commit --dry-run";

   - When set to false, "git status" uses a new semantics (TBD);

   - When unconfigured, the user gets a big incompatibility warning.

   and in 1.7.0, we will flip the default (i.e. unconfigured case) to
   false.

 * Implement "git status" that is not a preview of "git commit".  Its new
   semantics would include:

   - Reject any parameter that traditional "git status" ignored (i.e. -m);

   - Pathspecs are not about "git commit -o" anymore.  They are path
     limiters.

   - One of the options, -t, gives the "shortstatus".

If we go a route like this, we do not want to add "shortstatus" as a
standalone command.
