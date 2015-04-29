From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: redo tasks that die during cherry-pick
Date: Wed, 29 Apr 2015 10:15:55 -0700
Message-ID: <xmqq7fsu6ek4.fsf@gitster.dls.corp.google.com>
References: <1430261720-9051-1-git-send-email-hordp@cisco.com>
	<42512fad738e0ec47a8cdb6e6e92e994@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	phil.hord@gmail.com, Fabian Ruch <bafain@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 29 19:16:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnVac-0004Bb-PU
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 19:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966366AbbD2RP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 13:15:58 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966266AbbD2RP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 13:15:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E0E8C4CB1E;
	Wed, 29 Apr 2015 13:15:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=edpX0kKopu1OVJQfz1xth5clcqg=; b=aISljT
	3c0gEwpI6ldX46kJxMmhWccQBZlQCrEd0AR/W5AGoh0MGy1yj/EkcS2AIIVziwdx
	DBGq7gWk9Kok/Dfl62JF+ajRQDTj6wY/ZdrPE/wHphV2DBTnmRVUJK7B0rx824Ks
	3DyyOzbRLkuoscJHqnhwc/k3ewR6WbMra3kwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvcJN4ZgvGz52E6mkeCTHT7mSECcaF7L
	OcXdRVUe0bByzqAR92FgzkodjoXPNuCH2QiN2TTIyKYqZr4OVsr7M+l5deuBIDBF
	0y4prsSSUICahaCax6fngUyB5eR5exKiGm2QErBBevkke59/Z2n0/BYWu4XojDLP
	ni2JSFQSuU0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D99954CB1D;
	Wed, 29 Apr 2015 13:15:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BAD14CB1C;
	Wed, 29 Apr 2015 13:15:56 -0400 (EDT)
In-Reply-To: <42512fad738e0ec47a8cdb6e6e92e994@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 29 Apr 2015 01:17:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 65C97B10-EE93-11E4-8700-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267985>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi,
>
> On 2015-04-29 00:55, Phil Hord wrote:
>> When rebase--interactive processes a task, it removes the item from
>> the todo list and appends it to another list of executed tasks. If a
>> pick (this includes squash and fixup) fails before the index has
>> recorded the changes, take the corresponding item and put it on the todo
>> list again. Otherwise, the changes introduced by the scheduled commit
>> would be lost.
>> 
>> That kind of decision is possible since the cherry-pick command
>> signals why it failed to apply the changes of the given commit. Either
>> the changes are recorded in the index using a conflict (return value 1)
>> and rebase does not continue until they are resolved or the changes
>> are not recorded in the index (return value neither 0 nor 1) and
>> rebase has to try again with the same task.
>> 
>> Add a test cases for regression testing to the "rebase-interactive"
>> test suite.
>> 
>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>> Signed-off-by: Phil Hord <hordp@cisco.com>
>> ---
>
> ACK.
>
> It would be even nicer to avoid removing the task from the `todo` list
> until it has been performed correctly, of course, but I believe that
> would require a much more invasive patch. So this here patch is fine
> with me.

Thanks, will queue.

Aside from the "much more invasive" possibility, the patch makes me
wonder if it would have been a better design to have a static "todo"
with a "current" pointer as two state files.  Then reschedule would
have been just the matter of decrementing the number in "current",
instead of "grab the last line of one file and prepend to the other
file, and then lose the last line".
