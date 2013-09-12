From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 14:08:24 -0700
Message-ID: <xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
	<CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 23:08:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKE7r-0000B5-R2
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 23:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751Ab3ILVI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 17:08:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab3ILVI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 17:08:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8127E412B8;
	Thu, 12 Sep 2013 21:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hdeNvxgvur8tf02ZkyA4QXm+UYw=; b=RbJHqd
	C0LNHg4kEQ47dk/FrfnfJ5jfUJLl582sITMtcLSaL5FXcW2zc6OdVzmVL+gIqZnU
	xtuzAgCUFRp3j14d/YpDrJyFp9ByRTXszTCWIz805VCrmNhqtLs5FVrV8+JYyBwd
	o1DvIzqK9mJTtJFmwAq/xyhrpMC4g/ttopfR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZbQmtseyOFrOKGfQqNTDSof8MZJPZJzQ
	yayURoCT3I/gKii4+RkuLYL+8HLgfGXJGkAFV1AiOf5SUvUB08GdwVrJaf/ai2MB
	ksv80LKvTC7dHmLqMWdt91u7kUmSVgM0CWGBaZEGS8Dpa+wRAF8av370BQvpc7lt
	0FtqOiLJYvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 757C1412B7;
	Thu, 12 Sep 2013 21:08:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D21F7412AF;
	Thu, 12 Sep 2013 21:08:25 +0000 (UTC)
In-Reply-To: <CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
	(Eugene Sajine's message of "Thu, 12 Sep 2013 16:30:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 76FD9F56-1BEF-11E3-97C7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234697>

Eugene Sajine <euguess@gmail.com> writes:

> So are you really sure that it is a non-starter to have
> --before-service/--after-service options for access-hook?

Given the definition of "--access-hook" in "git help daemon":

    --access-hook=<path>::
            Every time a client connects, first run an external command
            specified by the <path> ... The external command can decide
            to decline the service by exiting with a non-zero status (or
            to allow it by exiting with a zero status)....

There is *NO* way in anywhere --after-service makes any sense (and
by definition --before-service is redundant).

What you _could_ propose is to define a *new* hook that is run when
the spawned service has returned, with the same information that is
fed to the access hook (possibly with its exit status).

I do not offhand know if we retain the original service information
that long after the main daemon process has spawned the service
process, though.  With the current system, the only thing it needs
to know is the PID of the service processes that are to be culled by
calls to waitpid().  So you may have to extend existing bookkeeping
data structures a bit to keep those pieces of information around if
you wanted to add such a new hook.
