From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/6] refs.c: enable large transactions
Date: Fri, 23 Jan 2015 16:14:08 -0800
Message-ID: <xmqqy4otnigf.fsf@gitster.dls.corp.google.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	loic@dachary.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:14:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEoMy-0005ZV-5d
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 01:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbbAXAOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 19:14:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752435AbbAXAOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 19:14:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A051324CD;
	Fri, 23 Jan 2015 19:14:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RoXoijf/wbJRD21TPpBQLzxqBA4=; b=Jc4vEG
	y3niqTWXEtpm7FwErpIY4Qc2pCDytqspykqJMXPv/TAnsMQ3If7/uBeMe4lshgqw
	0LaD2jVFEBODklug7VpR1ChvGgMcRxJG1lFiXVnC9w3rUG1FVrLWNCwsc0CetIt/
	ND4o2+sVTeFVuQcIvi35H7H8UR4BtD7m10bE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VsT999eKWV9HQ5WPN6W432UHQHVcdTOi
	CJAlhnXFIc/WY+GSWHZLoBN2iuYfEHNZ8Co2yhesO6oHHUC99ZlK5IAGsmiiW5OI
	C4NoaT3mAqOqTekgEwWrCiuADQYr9H6PeifrNZRTjEKPJHeN0yDwZ2iLdwGCjjJy
	rzPebzhsiMM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E340324CC;
	Fri, 23 Jan 2015 19:14:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF1FE324C3;
	Fri, 23 Jan 2015 19:14:09 -0500 (EST)
In-Reply-To: <1422043442-30676-7-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 23 Jan 2015 12:04:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EB1ED142-A35D-11E4-ADFE-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262977>

Stefan Beller <sbeller@google.com> writes:

> By closing the file descriptors after creating the lock file we are not
> limiting the size of the transaction by the number of available file
> descriptors.
>
> When closing the file descriptors early, we also need to write the values
> in early, if we don't want to reopen the files.


I am not sure if an early return in write_ref_sha1() is entirely
correct.  The unlock step was split out of write and commit
functions in the previous step because you eventually want to be
able to close the file descriptor that is open to $ref.lock early,
while still keeping the $ref.lock file around to avoid others
competing with you, so that you can limit the number of open file
descriptors, no?

If so, shouldn't the write function at least close the file
descriptor even when it knows that the $ref.lock already has the
correct object name?  The call to close_ref() is never made when the
early-return codepath is taken as far as I can see.

Puzzled...
