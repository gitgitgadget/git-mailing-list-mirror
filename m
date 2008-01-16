From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file descriptor
Date: Tue, 15 Jan 2008 17:27:49 -0800
Message-ID: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
References: <4787E981.7010200@nrlssc.navy.mil>
	<478C1D7A.6090103@nrlssc.navy.mil>
	<alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>
	<478CECAB.2030906@nrlssc.navy.mil>
	<alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
	<478CFAFF.6010006@nrlssc.navy.mil>
	<alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org>
	<7vzlv6d6sa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:28:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEx55-0000rT-4p
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbYAPB2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbYAPB2L
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:28:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbYAPB2K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:28:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EBAC515A5;
	Tue, 15 Jan 2008 20:28:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 275B8159F;
	Tue, 15 Jan 2008 20:28:02 -0500 (EST)
In-Reply-To: <7vzlv6d6sa.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 15 Jan 2008 15:10:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70595>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Tue, 15 Jan 2008, Brandon Casey wrote:
>>>
>>> Linus Torvalds wrote:
>>> > It would obviously be interesting to see the base repository and the 
>>> > commit you are trying to do - is that possibly publicly available?
>>> 
>>> I wish it was.
>>
>> It's ok, I found the bug in your full strace.
>>
>> The bug really is pretty stupid:
>>
>>  - prepare_index() does a 
>>
>> 	fd = hold_lock_file_for_update(&false_lock, ...
>> 	...
>> 	if (write_cache(fd, active_cache, active_nr) || close(fd))
>> 		die("unable to write temporary index file");
>>
>> and the magic here is that *it*closes*the*fd*.
>
> While I think the ones that are immediately followed by
> commit_locked_index() can drop the close(fd) safely, I am not
> sure about Kristian's changes to the other ones that we
> currently close(fd) but do not commit nor rollback immediately.
> These indices are now shown to the hook with open fd to it if
> you choose not to close them.  Is that okay for Windows guys?  I
> somehow had an impression that the other process may have
> trouble accessing a file that is still open elsewhere for
> writing.
>
> So I think the approach along the lines of your "hack" to close
> and tell lockfile API not to double-close is more appropriate.
> We would perhaps want "close_lock_file(struct lock_file *)" that
> calls close(lk->fd) and does lk->fd = -1 without rename/unlink,
> and replace these close() with that.
>
> I am sick today, feeling feverish, and not thinking straight,
> so I may be talking total nonsense...

I'll aplly and push out Kristian's one that apparently got
Tested-by from Brandon for tonight.
