From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git pull REMOTE" question
Date: Wed, 22 Aug 2007 13:29:36 -0700
Message-ID: <7vmywjia8f.fsf@gitster.siamese.dyndns.org>
References: <fc339e4a0708212123p6e922b4cy3f5f19bfafafa395@mail.gmail.com>
	<7vy7g4jids.fsf@gitster.siamese.dyndns.org>
	<buo8x84kwkq.fsf@dhapc248.dev.necel.com>
	<7vtzqsjgq2.fsf@gitster.siamese.dyndns.org>
	<1187801063.15321.4.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Git List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 22:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INwpx-0008Ev-K0
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 22:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760777AbXHVU3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 16:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760093AbXHVU3w
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 16:29:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758709AbXHVU3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 16:29:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C8EF126608;
	Wed, 22 Aug 2007 16:30:10 -0400 (EDT)
In-Reply-To: <1187801063.15321.4.camel@ld0161-tx32> (Jon Loeliger's message of
	"Wed, 22 Aug 2007 11:44:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56418>

Jon Loeliger <jdl@freescale.com> writes:

> On Wed, 2007-08-22 at 00:11, Junio C Hamano wrote:
> ...
>>  ;; new -- when on "master', and the user says to pull from "usb"
>>  ;; without saying which branch to merge, use '[remote "usb"] url'
>>  ;; and '[remote "usb"] fetch' to decide where to fetch from,
>>  ;; and merge their refs/heads/xprm to our branch.
>>  [branch "master:usb"]
>>  	merge = refs/heads/xprm
>> 
>> The trick in the new syntax is that you cannot have a colon in
>> refname, so there is no way for existing [branch $name] section
>> to crash with the new style definition.
>
> Wasn't there was a brief alternate notion to add a "for <remote>"
> clause and allowing something like this?:
>
>     [branch "master"]
>         merge = refs/heads/xprm for usb
>         merge = refs/heads/stuff for otherremote

Yeah, I remember that one (I do not think nobody implemented it,
though).  Thanks for reminding.

So...

	[branch "master"]
        	remote = origin
                merge = refs/heads/xprm for usb
                merge = refs/heads/stuff for otherremote
                merge = refs/heads/master

and when you are on your "master", 

	$ git fetch
        $ git pull

goes to "origin" (because you did not even say the remote name).

	$ git fetch usb
        $ git pull usb

goes to "usb".  And "git pull" from such a nicknamed remote
looks up merge lines with "for nickname" to find the branch(es)
to merge.  If there is no merge line with "for nickname" for the
remote (e.g. "git pull origin" in the above example does not
have any), and if there is a merge line without "for nickname",
then that line can be used (e.g. "git pull" which is exactly the
same as "git pull origin" will use the 'master' branch from the
remote).

I think that is much easier to understand and maintain for the
end users than the [branch "master:usb"].  The latter is wrong
to begin with -- it is not about branch anymore.
