From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible Solaris problem in 'checkout_entry()'
Date: Tue, 18 Mar 2008 18:05:24 -0700
Message-ID: <7vwsnz5xrf.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0803170756390.3020@woody.linux-foundation.org>
 <118833cc0803170823q1e1e29a9p18b9a41f6975e268@mail.gmail.com>
 <alpine.LFD.1.00.0803170832280.3020@woody.linux-foundation.org>
 <alpine.LFD.1.00.0803170850090.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:32:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc41J-0006jn-9H
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbYCSTaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbYCSTaF
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:30:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118AbYCSTaB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:30:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A2F322D5;
	Tue, 18 Mar 2008 21:05:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 534EE22C6; Tue, 18 Mar 2008 21:05:26 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.00.0803170850090.3020@woody.linux-foundation.org>
 (Linus Torvalds's message of "Mon, 17 Mar 2008 08:56:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77511>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 17 Mar 2008, Linus Torvalds wrote:
>>
>> IOW, the real "checking" is taking place in "create_file()", so if the 
>> unlinking failed (due to a read-only directory or something), that's where 
>> we'll do the proper error reporting.
>
> Thinking about this, I'm probably full of sh*t.
>
> My argument is admittedly true in general, but there is one case it is 
> *not* true for: if the old entry was a symlink.
>
> IOW, let's imagine that the directory is read-only (or other permission 
> issue), and we want to unlink the old symlink, which points somewhere we 
> can write to. In that case, the symlink removal is important, because we 
> won't necessarily catch the error when we create the file in place later 
> (because that will just follow the symlink).
>
> So I retract my statement. We *should* check the result of the unlink.

While I agree we should check the result, I think we are safe against the
un-unlinkable symlink case.  If you have a stale symlink at "dir/file"
where you are checking out a new blob, and the directory "dir" the symlink
is in is unwritable, then our callpath would look like this:

	checkout_entry()
         unlink("dir/file") -- failure silently ignored which is bad
	 write_entry()
          create_file("dir/file")
           open("dir/file", O_WRONLY | O_CREAT | O_EXCL)

which would fail, and we get:

    error: git-checkout-index: unable to create file a/b (File exists)

from around ll.135 in entry.c::write_entry()

So I'll apply the patch purely as "Root on Solaris safety fix".
