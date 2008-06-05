From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Wed, 04 Jun 2008 23:07:14 -0700
Message-ID: <7vd4mw4dpp.fsf@gitster.siamese.dyndns.org>
References: <940824.46903.qm@web31808.mail.mud.yahoo.com>
 <200806032331.44514.jnareb@gmail.com>
 <7v3ant213k.fsf@gitster.siamese.dyndns.org>
 <200806041603.49555.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luben Tuikov <ltuikov@yahoo.com>,
	Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 08:08:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K48e7-0006kb-Q7
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 08:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbYFEGHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 02:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbYFEGHa
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 02:07:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYFEGHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 02:07:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A122F3D3C;
	Thu,  5 Jun 2008 02:07:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5DC873D3B; Thu,  5 Jun 2008 02:07:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD2F158C-32C5-11DD-8469-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83861>

Jakub Narebski <jnareb@gmail.com> writes:

> On Wed, 4 Jun 2008, Junio C Hamano wrote:
>> Yes, but the current scheme breaks down in another way.  When $full_rev
>> added many lines to the file, and you are adding the link to for a line
>> near the end of the file and such a line may not exist.  This cannot be
>> cheaply done even inside blame itself.
>
> I think the scheme could be fixed by proposed belo git-blame porcelain
> format output extension.

For the line number information, I do not think so.

Luben's "continue from the same line number in the parent commit" is a
cute hack, but that strategy needs a qualifying comment "because hoping
that the same line number in the parent commit might have something
relevant would be better than stopping and giving up sometimes."  It
cannot reliably work (and it is not Luben's fault).

But the #l<lno> fragment is just a hint to scroll to that point after
restarting the blame from previous commit and jumping to the result, so it
may not be too big a deal.  Such a line may not exist in the resulting
blame page, but that's Ok.

>> Another breakage is even though $full_rev^ _may_ exist (iow, $full_rev
>> might not be the root commit), the file being blamed may not exist there
>> (iow $full_rev might have introduced the file).  Instead of running
>> "rev-parse $full_rev^", you would at least need to ask "rev-list -1
>> $full_rev^ -- $path" or something from the Porcelain layer, but
>> unfortunately this is rather expensive.
>
> Doesn't blame know revision graph for history of a given file already?

Not in the sense of "rev-list -2 $full_rev -- $path | sed -e 1d".  It
builds the graph as it digs deeper, and when it stops, it stopped digging,
so all it knows at that point without further computation is $full_rev^@,
and not "the previous commit that touched the path".

But as Luben explained (and you drew a simple strand of pearls history to
illustrate), immediate parent is just for the purpose of restarting the
computation.

>> Because blame already almost knows if the commit the final blame lies on
>> has a parent, it would be reasonably cheap to add that "parent or nothing"
>> information to its --porcelain (and its --incremental) format if we wanted
>> to.
>
> It would be easy to add 'parents' header, perhaps empty if we blame
> root commit, or a boundary commit (do we say 'boundary' then?) when
> doing revision limited blaming.

It shouldn't be too hard to say "parents of the blamed commit that has the
corresponding preimage of the file is this", and the history does not have
to be limited.  You need to also handle "the commit that introduced the
path" case just like "root" and "boundary" that we cannot dig further than
that point.

I'll follow this message up with two weatherballoon patches.
