From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #06; Sat, 21)
Date: Wed, 25 Mar 2009 11:06:19 -0700
Message-ID: <7vzlf94gv8.fsf@gitster.siamese.dyndns.org>
References: <7vk56jfgt2.fsf@gitster.siamese.dyndns.org>
 <20090323144650.GA20058@pvv.org> <7v4oxk6wk2.fsf@gitster.siamese.dyndns.org>
 <7vljqv2t05.fsf@gitster.siamese.dyndns.org>
 <7vhc1j2si9.fsf@gitster.siamese.dyndns.org> <20090324111645.GA6084@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXWC-000477-Mu
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760854AbZCYSG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759206AbZCYSG3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:06:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759236AbZCYSG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:06:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 45CF791B7;
	Wed, 25 Mar 2009 14:06:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 83B2191B4; Wed,
 25 Mar 2009 14:06:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A675E1C4-1967-11DE-9E87-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114635>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Tue, Mar 24, 2009 at 02:13:18AM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> >   $ git push --dry-run sf.net
>> >   warning: ...
>> >   warning: You can specify what action you want to take in this case, and
>> >   warning: avoid seeing this message again, by configuring 'push.default' to:
>> >...
>> >   warning:   'current'  : Push the current branch
>> >   fatal: 'sf.net' does not appear to be a git repository
>> >   fatal: The remote end hung up unexpectedly
>> >
>> > The final, most important error messages are dwarfed out by the warning
>> > that talks about setting configuration on the remote that does not even
>> > exist.
>
> I actually agree, but that final error is printed in a very ugly
> place! It would require some surgery to pause the warning until we
> figure out that sf.net is not a valid remote in the current setup.
>
> get_refs_via_connect->connect_setup->git_connect-> .. fork()s .., runs
>    "sh -c git-receive-pack 'sf.net'" (which prints the first error)
> and get_remote_heads->packet_read_line->safe_read() dumps the final error
> and dies.
>
> Is there any reason why remote_get needs to return a valid remote for
> a value like "sf.net"?  If it didn't, the error message would be even
> better, and not complain about a "remote end".

Yeah, you could work around by special casing colon-less ones as you
suggested, but I do not think it is worth it.

Instead of "sf.net", the example could have been

	git-core.git.sourceforge.net:/gitroot/gut-core

which looks like a perfectly valid push destination, but it has a typo in
the pathname, and the remote end will hang up unexpectedly in such a case,
too.  I do not think remote_get() is a wrong thing to blame; in that
codepath you simply do not know.

If you want to remove warning when we will eventually go "fatal", the way
to do so is to remember you need to issue a warning but defer it until you
actually start telling the other end in do_send_pack(), or something like
that.

I do not think we would want nor need to go that route.  This warning is
about a local configuration that applies to _all_ remotes, and setting the
configuration once will squelch it for future push to any remotes.  Giving
the warning even for an _incorrect_ remote is not wrong per-se.

Issuing the warning at first looked incorrect to me, but it warns exactly
about what the patch that added the warning messages wanted to warn about:

    If you did not misspell the name of the remote or the URL, you would
    have triggered the default "matching refs" semantics, but you may not
    have meant to do so, hence we are warning.  If you want to change the
    default, here is how.  If you find this message irritating, you can
    squelch it this way.

In this particular case, I _did_ want the default matching refs semantics,
so it was irritating whether I had the last two "fatal" lines or not.  But
the point of your patch was to help new people for the cost of irritating
people like me (once), so...
