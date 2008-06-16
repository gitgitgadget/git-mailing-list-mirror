From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: return correct HTTP status codes
Date: Mon, 16 Jun 2008 15:38:50 -0700
Message-ID: <7vy75580p1.fsf@gitster.siamese.dyndns.org>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com>
 <m37icqpb5f.fsf@localhost.localdomain> <48568D5C.5090909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:40:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8NMl-00009M-Ns
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 00:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402AbYFPWjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756202AbYFPWjE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 18:39:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbYFPWjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 18:39:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 85412DA8B;
	Mon, 16 Jun 2008 18:38:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4525DDA82; Mon, 16 Jun 2008 18:38:53 -0400 (EDT)
In-Reply-To: <48568D5C.5090909@gmail.com> (Lea Wiemann's message of "Mon, 16
 Jun 2008 17:57:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 030F2194-3BF5-11DD-A474-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85244>

Lea Wiemann <lewiemann@gmail.com> writes:

> Jakub Narebski wrote:
>...
>>> I recommend that you apply [PATCH] gitweb: remove git_blame
>>
>> I think it is not possible, as IIRC [it] got already applied.
>
> It isn't applied on master (at the time I'm writing this), only on next.
> Should I be working on the next branch?

I think it was sensible for you to mention the patch dependency, and if
you said the same thing with a different phrasing "this depends on remove
git_blame patch" you wouldn't have opened yourself up to such a nitpick
;-)

Since you are working on something that is outside the current 1.5.6
freeze, and removal of the unused "other" blame sub was something nobody
seemed to have objected to, I think it is Ok to assume that the removal
will happen when this new code is ready and after 1.5.6 ships.

It's up to you to work on 'next' or 'master with extra patches'.  Just
state what you are basing your development on and with what extra patches
if there is a risk of confusion among your readers.

>>>  	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
>>> -		or die_error(undef, "Open git-ls-tree failed");
>>> +		or die_error(500, "Open git-ls-tree failed");
>>
>> Should we really use "500 Internal Server Error" here?  Usually this
>> would be not an error at all, but wrong parameters to git command,
>> i.e. it is _user_ who erred, not some error on _server_ side.
>
> You cannot tell for sure -- all you know here is that the command
> somehow failed when it shouldn't have, and so all you can give is 500;
> see below.  I don't think we should apply reasoning like "most commonly
> it's a wrong hash, so let's return 404" -- we don't know, and we
> shouldn't assume.
>
>>> ... I suspect that the error could be triggered by non-existent hashes
>>> as well, in which case the more specific 404 would be more appropriate
>>> -- however, the current implementation oftentimes doesn't allow for
>>> more fine-granulared checking
>>
>> ...that is why I'd rather have "403 Forbidden" as catch-all error, as
>> it was done in gitweb.  But that also seems not very good idea.
>
> [IANA HTTP expert, but:] All we have in cases like the one above is "I
> cannot deliver the content you requested, but I'm so confused that I
> don't even know why" -- which sounds like 500 to me (definitely not
> 403).  403 would be used for some deactivated feature (commonly for
> disabled directory listings I think) or something that shouldn't be
> accessible to the public.

Hmph... if we cared deeply enough about this issue, isn't it possible for
you to unconfuse yourself in a slow path and figure out exactly why it
failed?

        unless (open $fd, '-|', ls-tree $base -- $path) {
                # Oh, an error?  why?
                if (!object_exists($base)) {
                        die_error(404, "No such object $base");
                } elsif (!is_a_treeish($base)) {
                        die_error(404, "No such tree-ish $base");
                } else {
                        die_error();
                }
        }
