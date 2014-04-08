From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove the close_ref function.
Date: Tue, 08 Apr 2014 14:50:06 -0700
Message-ID: <xmqqeh173301.fsf@gitster.dls.corp.google.com>
References: <1396991830-20938-1-git-send-email-sahlberg@google.com>
	<1396991830-20938-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 23:50:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXduN-0004UV-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 23:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689AbaDHVuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 17:50:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757133AbaDHVuL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 17:50:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD33879C1B;
	Tue,  8 Apr 2014 17:50:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dc4GJbfhX72HEB+R82zB1G7srcc=; b=SULTnl
	Rp7LecAcNXWuNKotwcCCE2GgDyOtF3kbiqDsOH1oxPbziKmpgoiRfSO6oOheUW2L
	eMVFhvqfPeN+5NHb4I2U7eYs/RPBm8aF7vf1x6ayvaEogsoD/RonPUE3jgnPDwsS
	Mm31nnKp92N0BQ0HghOuMk2Blo80EdPwh8cT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DX0D/0nv+/gtcHUp72xBnuyTuZa9A4ft
	89/CWM51L0aYBx8hu/qIVb5LJF0jxpQrm6xtJGVAS2TM4begNrEUdrKGHy88FrRO
	F8BvL1vTkU07N9pW720lo16vCO3M/5QIykbsEI1TLGkOt6uA5eDDNrh1z2VnFaH8
	MMYJAXYu+/Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F55579C1A;
	Tue,  8 Apr 2014 17:50:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 98D3279C0C;
	Tue,  8 Apr 2014 17:50:08 -0400 (EDT)
In-Reply-To: <1396991830-20938-2-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Tue, 8 Apr 2014 14:17:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C0ACED48-BF67-11E3-AED6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245962>

Ronnie Sahlberg <sahlberg@google.com> writes:

> @@ -2824,8 +2816,7 @@ int write_ref_sha1(struct ref_lock *lock,
>  		return -1;
>  	}
>  	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
> -	    write_in_full(lock->lock_fd, &term, 1) != 1
> -		|| close_ref(lock) < 0) {
> +	    write_in_full(lock->lock_fd, &term, 1) != 1) {

In the original code, we try to write the new object name and the
line terminator, and also try to make sure that the file descriptor
is successfully closed here.  Only when all of that is done
successfully we go update the reflog and then after that, we commit
the lockfile by renaming.

With the updated code, these two write(2)s may succeed, but we would
not know if the close(2) would succeed, until commit_lock_file() is
called much later in this codepath.

We would end up updating the reflog even when the close(2) of the
ref fails.

To be really paranoid, we should probably be doing an fsync(2)
to make sure that the bytes written hit the disk platter, not just
close(2), and such a change may be a good step in the direction to
make the code more robust; in that light, the patch goes in the
opposite direction "what it does is not robust enough anyway, so
let's loosen it further".

Hmm...
