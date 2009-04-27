From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) &&
 unlink(src) when that is unreliable
Date: Mon, 27 Apr 2009 12:55:25 -0700
Message-ID: <7vljpl3m8i.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain>
 <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyWva-0003Ua-PU
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 21:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934AbZD0Tzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 15:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756850AbZD0Tzf
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 15:55:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbZD0Tze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 15:55:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E19A12E61;
	Mon, 27 Apr 2009 15:55:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8E71412E60; Mon,
 27 Apr 2009 15:55:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DBCEC3A-3365-11DE-B0C7-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117709>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> 	Junio, do you want me to remove the config variable?
>
> I'd keep it. But I'd suggest that the naming is odd. Why talk about 
> "unreliable hardlinks", when that's just a particular symptom. Why not 
> just talk about whether hardlinks should be used or not?
>
> And to avoid double negative, make it
>
> 	[core]
> 		usehardlinks = true/false
>
> and then default it to 'true' for Unix.

I am a bit worried about this name, too.  It may lead people to a
misunderstanding that we would do something magical when they do this with
the configuration set:

	wget http://some.where/huge-file.mpg 1.mpg
        ln 1.mpg 2.mpg
        git add 1.mpg 2.mpg
        rm -f 1.mpg 2.mpg
        git checkout-index -a
	ls -i ?.mpg

> The thing is, maybe people would prefer to use 'rename' over the
> link/unlink games even on some unixes, and not because of 'reliability'
> issues, but because they may have some filesystems that don't do
> hardlinks, and they'd just rather speed things up by avoiding the
> 'link()' system call that will just error out.

> So naming matters. Calling it 'unreliablehardlinks' in that case would be 
> odd. They're not unreliable - you just don't want to try to use them.

This part I agree with.

> I also do wonder if we could/should make this one of those options that 
> get set automatically at 'git init' time, rather than silently hardcoded 
> as a compile option. I thought hardlinks at least sometimes worked fine on 
> Windows too, don't they? 
>
> I do detest _hidden_ default values for config options, unless those 
> hidden defaults are "obviously always correct" as a default. This one 
> smells a bit uncertain, and as a result I think it's ok to default to not 
> using hardlinks, but doing it with .gitconfig would be nicer.

The coda hack comment in move_temp_to_file() shows what we can do to
autodetect (i.e. try cross directory hardlink), but I somehow thought that
we changed the code enough to ensure that we create the tmpfiles in the
same directory as their final destination?
