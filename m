From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Not going beyond symbolic links
Date: Fri, 08 Aug 2008 13:55:30 -0700
Message-ID: <7vod43b519.fsf@gitster.siamese.dyndns.org>
References: <20080721002354.GK10151@machine.or.cz>
 <20080721002508.26773.92277.stgit@localhost>
 <7v8wvpm9cl.fsf@gitster.siamese.dyndns.org>
 <7vej5543v5.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808041719380.3299@nehalem.linux-foundation.org>
 <7vk5etjozt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 08 22:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRZ0v-0007fl-FP
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 22:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbYHHUzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 16:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbYHHUzm
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 16:55:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752557AbYHHUzl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 16:55:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D027D4A0B9;
	Fri,  8 Aug 2008 16:55:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F30F14A0B4; Fri,  8 Aug 2008 16:55:33 -0400 (EDT)
In-Reply-To: <7vk5etjozt.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 06 Aug 2008 23:52:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5BA5A358-658C-11DD-A634-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91715>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Mon, 4 Aug 2008, Junio C Hamano wrote:
>>> 
>>> I started to revisit this issue and patched "git update-index --add"
>>> and "git add" so far.  Patches follow.
>>
>> Patches look good to me, but did you check the performance impact?
>>
>> The rewritten 'has_symlink_leading_path()' should do ok, but it migth 
>> still be a huge performance downside to check all the paths for things 
>> like "git add -u".
>
> I couldn't quite measure much meaningful performance impact.
>
> My test repository was the kernel tree at v2.6.27-rc2-20-g685d87f, without
> any build products nor editor temporary crufts.
>
> By the way, if anybody wants to reproduce this, be careful with the tests
> that run "rm -f .git/index" before adding everything.  After doing so, if
> you check the result with "git diff --stat HEAD", you will notice many
> missing files --- I almost got a heart attack before inspecting this file:
>
> 	$ cat arch/powerpc/.gitignore
>         include
>
> Yes, it excludes 261 already tracked files.  Is it intended?  I dunno.
> ...

Seeing that you applied my arch/powerpc/.gitignore patch to the kernel
(Yaay, I now have a short-log entry in the kernel history ;-), you have
seen the message with some benchmarks I am replying to as well?

I actually was expecting to see measurable slowdown by checking leading
symbolic link more often, but I couldn't, which means either there is not
much downside that the bugfix would hurt real-life usage, or I was too
incompetent to come up with an example to show that the bugfix actually
hurts the performance.

If the former, I think it is a very good news (If the latter, well, we
have a bigger problem :-<), as the affected codepaths are exactly the ones
that need to be fixed when somebody tries to add files in a submodule
directory by mistake, which is an issue (iirc) Dscho had a separate patch
to fix earlier.  Tracked symbolic links may be rare, but it seems that
many people are using submodules, and that case cannot be hand-waved
around by calling it is a feature.
