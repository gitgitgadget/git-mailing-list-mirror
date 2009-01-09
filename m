From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Use is_pseudo_dir_name everywhere
Date: Fri, 09 Jan 2009 00:33:53 -0800
Message-ID: <7vy6xk280e.fsf@gitster.siamese.dyndns.org>
References: <1231457063-29186-1-git-send-email-aspotashev@gmail.com>
 <1231457063-29186-2-git-send-email-aspotashev@gmail.com>
 <1231457063-29186-3-git-send-email-aspotashev@gmail.com>
 <4966F6BB.90408@viscovery.net> <4966FB36.2030409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLCq1-0007FR-D0
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 09:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZAIIeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 03:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbZAIIeD
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 03:34:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbZAIIeB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 03:34:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F2F71C1CA;
	Fri,  9 Jan 2009 03:34:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 441481C1C9; Fri, 
 9 Jan 2009 03:33:54 -0500 (EST)
In-Reply-To: <4966FB36.2030409@viscovery.net> (Johannes Sixt's message of
 "Fri, 09 Jan 2009 08:22:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 435C2992-DE28-11DD-B3B4-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104987>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Sixt schrieb:
>> Alexander Potashev schrieb:
>>> -		if ((ent->d_name[0] == '.') &&
>>> -		    (ent->d_name[1] == 0 ||
>>> -		     ((ent->d_name[1] == '.') && (ent->d_name[2] == 0))))
>>> +		if (is_pseudo_dir_name(ent->d_name))
>> 
>> Nit-pick: When I read the resulting code, then I will have to look up that
>>   is_pseudo_dir_name() indeed only checks for "." and "..". But if it were
>> named is_dot_or_dotdot(), then I would have to do that.
>
> ... then I would *not* have to do that, of course.

I think the unstated motivation of this choice of the name is to keep the
door open to include lost+found and friends to the repertoire, and perhaps
to have an isolated place for customization for non-POSIX platforms and
for local conventions.  It is more like is_uninteresting_dirent_name().

As long as this function is used only to detect and skip "uninteresting"
dirent, I think that is not a bad direction.

On the other hand, I am a bit worried about is_empty_dir() abused outside
its intended purpose to say "this directory does not have anything
interesting".  E.g. "Oh, it's empty so we can nuke it":

	if (is_empty_dir(dir))
        	rmdir(dir);

even though the current callers do not do something crazy like this (the
usual order we do things is rmdir() and then check for errors).
