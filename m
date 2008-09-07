From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Alternates and push
Date: Sun, 07 Sep 2008 11:56:42 -0700
Message-ID: <7vhc8rn5sl.fsf@gitster.siamese.dyndns.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
 <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org>
 <20080907184922.GA3909@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Sep 07 20:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcPTc-0008Bg-5N
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 20:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbYIGS4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 14:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754561AbYIGS4y
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 14:56:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbYIGS4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 14:56:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83D865ADB1;
	Sun,  7 Sep 2008 14:56:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A86B85ADB0; Sun,  7 Sep 2008 14:56:44 -0400 (EDT)
In-Reply-To: <20080907184922.GA3909@efreet.light.src> (Jan Hudec's message of
 "Sun, 7 Sep 2008 20:49:22 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA0AE202-7D0E-11DD-B28A-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95161>

Jan Hudec <bulb@ucw.cz> writes:

> On Sat, Sep 06, 2008 at 11:06:49 -0700, Junio C Hamano wrote:
>> Theodore Tso <tytso@MIT.EDU> writes:
>> 
>> > Long-standing mis-feature in git's logic in deciding what to push.
>> > It's been reported a few times, but apparently it's hard to fix, or at
>> > least it never hsa been fixed as far as I know.
>> 
>> This comes from an early (mis)design of git.
>> [...]
>>  * The existing alternates mechanism is not about alternate repositories.
>>    It is about alternate object stores.  That is why each line of this
>>    file points at "objects" directory elsewhere, not the ".git" directory
>>    that is typically at one level above that "objects" directory.
>> 
>>    The fact your repository's object store points at the object store that
>>    happens to be inside Linus's repository does not imply that Linus's
>>    object store is associated with refs in Linus's repository in any way
>>    (that's the early _mis_design part).
>
> Why is this a *mis*design? Couldn't push be fixed by redesigning it's
> protocol along the lines of:
>  - clients sends a list of sha1s it wants to push, from the tip down
>  - server stops it when it sees an object it has -- this check can be done
>    against the object store without having a ref for it.

Because your second step is *BROKEN*.

Think of a case where an earlier commit walker started fetching into that
"server" end, which got newer commits and their associated objects first
and then older ones, and then got killed before reaching to the objects it
already had.  In such a case, the commit walker will *not* update the refs
on the server end (and for a very good reason).

After that, the server end would have:

 * refs that point at some older commits, all objects from whom are
   guaranteed to be in the repository (that's the "ref" guarantee);

 * newer commits and their objects, but if you follow them you will hit
   some objects that are *NOT* in the repository.

Now imagine starting your broken procedure to serve clients from such a
repository.  Your second step would cause the server to attempt to pack
the difference from the latter classes of incomplete objects and makes the
pack generation fail.
