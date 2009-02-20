From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recovering from missing objects?
Date: Thu, 19 Feb 2009 16:29:12 -0800
Message-ID: <7vvdr6j6hz.fsf@gitster.siamese.dyndns.org>
References: <alpine.LRH.2.00.0902191447040.16988@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaJI1-0007TP-Dp
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 01:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZBTA3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 19:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbZBTA3V
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 19:29:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbZBTA3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 19:29:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A859C2B80E;
	Thu, 19 Feb 2009 19:29:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D41292B800; Thu,
 19 Feb 2009 19:29:14 -0500 (EST)
In-Reply-To: <alpine.LRH.2.00.0902191447040.16988@vixen.sonytel.be> (Geert
 Uytterhoeven's message of "Thu, 19 Feb 2009 15:08:23 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82D1C3C4-FEE5-11DD-BF8A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110772>

Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> writes:

> 	Hi all,
>
> I start to see suspicious messages about missing objects in one of my working
> repositories:
>
> | vixen$ git gc
> | error: Could not read c406ab0be69c912ea59233595a071478103cdad8
> | fatal: bad tree object c406ab0be69c912ea59233595a071478103cdad8
> | error: failed to run repack
> | vixen$ 
>
> My setup:
>   - I have one reference repository (cloned from Linus' linux-2.6.git)
>   - I have several working repositories, cloned using --reference to my
>     reference repository. A working repository has several remotes (cloned from
>     other Linux kernel repositories).
>
> I always do a `git pull' in the reference repository, before doing a `git
> remote update' in a working repository. When I do `git gc' in a working
> repository, it cleans up all objects that are not in the reference repository.
> Hence I only need to care about backup of the .git directories in the working
> repositories (the stuff I'm working on), and not about the reference
> repository (its objects are publicly available and replicated all over the
> world).
>
> I identified the missing object listed above to be part of a remote repository.
> Doing a `git remote update' doesn't fetch it again, as git is too smart and
> thinks I already have everything.
>
> If I clone the remote repository, I have the object in the new clone.
> However, how do I get the missing object back into the .git directory of my
> working repository?

In the new clone:

	$ IT=c406ab0be69c912ea59233595a071478103cdad8
	$ TYPE=$(git cat-file -t $IT)
        $ git cat-file $TYPE $IT >/var/tmp/$IT.raw

Go to the repository that lacks the object and then

	$ git hash-object -t $TYPE -w --stdin </var/tmp/$IT.raw

After that you may find objects that $IT needs to reference.  You can
obviously repeat the above procedure until you have nothing missing.


I also suspect you could do this instead; I haven't thought things through
and that is why I say "suspect" but this is safe (i.e. not destructive)
and may worth a try.

In the new clone:

	$ IT=c406ab0be69c912ea59233595a071478103cdad8
	$ H=$(git rev-list --objects $IT | git pack-objects mine)
        $ mv mine-$H.pack /var/tmp

Go to the repository that lacks the object and then

	$ git unpack-objects </var/tmp/mine-$H.pack
