From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] tree.c: add support for traversal of submodules
Date: Mon, 12 Jan 2009 02:07:19 -0800
Message-ID: <7vab9wj0rs.fsf@gitster.siamese.dyndns.org>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
 <1231717555-10559-2-git-send-email-hjemli@gmail.com>
 <7vr639kyf0.fsf@gitster.siamese.dyndns.org>
 <8c5c35580901120104u418d8d73mad4ab7d71fe8c3f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 11:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJj0-00083D-Es
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 11:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbZALKH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 05:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752105AbZALKH0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 05:07:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbZALKHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 05:07:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BD2B78FB02;
	Mon, 12 Jan 2009 05:07:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF50D8FB00; Mon,
 12 Jan 2009 05:07:20 -0500 (EST)
In-Reply-To: <8c5c35580901120104u418d8d73mad4ab7d71fe8c3f8@mail.gmail.com>
 (Lars Hjemli's message of "Mon, 12 Jan 2009 10:04:29 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CEA1EDD8-E090-11DD-A949-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105322>

Lars Hjemli <hjemli@gmail.com> writes:

> On Mon, Jan 12, 2009 at 04:15, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> When the user explicitly asks you to traverse into submodules and the
>> necessary commit is not available in a submodule, the code goes on without
>> complaining.  I am not saying it is bad, but I wonder if we would want to
>> distinguish these three cases:
>>
>>  (1) the submodule is initialized and the necessary commit is there.
>>
>>  (2) the submodule is initialized, but the necessary commit is missing.
>>
>>  (3) the submodule is not even initialized (aka "the user is not
>>     interested in it"); there is only an empty directory.
>>
>> I think it is perfectly fine not to say anything for (3) but I am unsure
>> about the second case.
>
> Do we want to impose the porcelainish rules of git-submodule
> (.gitmodules, .git/config) in read_tree_recursive()?
>
> If so, I guess a new submodule.h might provide something like this
> (disclaimer: coded in gmail):

I do not see why you would need anything more than we already have to tell
(3) from (1) and (2).  And I do not see why you need to have the Porcelain
policy in the picture for telling these three cases apart, either.

For example, there is this code in read-cache.c::ce_compare_gitlink():

        static int ce_compare_gitlink(struct cache_entry *ce)
        {
                unsigned char sha1[20];

                /*
                 * We don't actually require that the .git directory
                 * under GITLINK directory be a valid git directory. It
                 * might even be missing (in case nobody populated that
                 * sub-project).
                 *
                 * If so, we consider it always to match.
                 */
                if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
                        return 0;
                return hashcmp(sha1, ce->sha1);
        }

It asks resolve_gitlink_ref() to see if the directory (where the submodule
checkout _might_ be present if the user is interested in it) has .git/HEAD
that resolves.  If so, the user has a checkout and is interested in it.
Otherwise, there is no checkout, in other words, we have case (3) above.

Whether you force the user to link the submodule object store to the
primary one as alternates, or do that for the user temporarily inside the
process [*1*], you would then be able to tell (1) and (2) apart by asking
has_sha1_file() if you can see the commit.

One thing that is unclear is to me is for whom the commit is missing (or
present).  I think the outline I gave above follows the design of your
patch to assume that the commit may (or may not) be available to the
superproject and traverse into the commit when that is the case.  It does
not mean the commit is available to the submodule itself (the commit may
have found in the primary project itself, not via the alternates), but
such an arrangement makes it somewhat useless.

What's the typical direction of using alternates in a setting with
superproject with a submodule?  Do people have alternates in the submodule
repository that borrows from the superproject repository?  Or the other
way around?  What's the rationale for having such alternates for normal
use case?  I am suspecting that there is no reason (other than this
"recursive tree traversal") to have an alternates file in either
direction, but I also strongly suspect that I am missing some unwritten
assumption you are making.

[Footnote]

*1* If you want to recurse seemlessly, it might make sense to add (during
the course of this "recursive tree traversal") the object store of the
submodule repository to the process'es list of alternate object databases
yourself, instead of forcing the user to do so permanently by mucking with
the alternates list of the primary project repository.  But that is an
independent issue.
