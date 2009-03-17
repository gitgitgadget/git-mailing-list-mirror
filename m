From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable post-checkout test on Cygwin
Date: Tue, 17 Mar 2009 13:42:31 -0700
Message-ID: <7v63i7ridk.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
 <7vprggqeh2.fsf@gitster.siamese.dyndns.org> <49BFD6DD.1010800@viscovery.net>
 <20090317202818.GA13458@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljg8z-0007ym-0I
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 21:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbZCQUmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 16:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754233AbZCQUmn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 16:42:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbZCQUmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 16:42:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 054BF71E2;
	Tue, 17 Mar 2009 16:42:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CC97E71E1; Tue,
 17 Mar 2009 16:42:32 -0400 (EDT)
In-Reply-To: <20090317202818.GA13458@blimp.localdomain> (Alex Riesen's
 message of "Tue, 17 Mar 2009 21:28:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 27878EBE-1334-11DE-9A1E-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113525>

Alex Riesen <raa.lkml@gmail.com> writes:

> Johannes Sixt, Tue, Mar 17, 2009 17:59:09 +0100:
>> Junio C Hamano schrieb:
>> > Alex Riesen <raa.lkml@gmail.com> writes:
>> > 
>> >> It is broken because of the tricks we have to play with
>> >> lstat to get the bearable perfomance out of the call.
>> >> Sadly, it disables access to Cygwin's executable attribute,
>> >> which Windows filesystems do not have at all.
>> > 
>> > Hmm, perhaps when checking hooks to see if they are executable, Cygwin
>> > port should avoid using the "tricks"?  Compared to paths inside the
>> > worktree the number of hooks is a lot smaller, no?
>> 
>> Hmm. Nowadays, we run hooks through run_hook() in run_command.c. It uses
>
> The problem is that copy_templates_1 does an lstat on the files in
> templates directory and gets 0666 mode (regular file, non-exec) for
> executable file under current Cygwin port. The st_mode of that lstat
> is passed to copy_file mentioned, which is useless now as we use the
> Win32 version of lstat, which doesn't do x-bit.

Ahhh.

I do not mind the patch as a band-aid to make the testsuite pass, so I'll
apply your patch as-is.  Thanks.

But isn't this something shops that do deploy Cygwin version of git want
to see fixed, so that they can have a site-wide policy implemented in the
hooks copied from templates?  I think we could pass mode 0 to copy_files()
and have the function special case it (and allow a platform specific
copy_files() implementated by Cygwin).  lstat() in the copy_templates_1()
codepath is primarily done to see if we need to descend into a directory
or symlink() and our use of st.st_mode to pass to copy_files() is a no
cost side effect on platforms with x-bit support.

>> access(..., X_OK), not lstat(). We don't play games with access(), do we?
>
> access(..., X_OK) will return -1.

That codepath would also need to be fixed if Cygwin wants to use hooks, I
would guess.
