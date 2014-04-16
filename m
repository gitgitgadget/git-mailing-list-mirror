From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Wed, 16 Apr 2014 11:11:18 -0700
Message-ID: <xmqqtx9tgn5l.fsf@gitster.dls.corp.google.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqob03le3v.fsf@gitster.dls.corp.google.com>
	<FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com>
	<xmqqsipdi5lw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 20:11:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaUIz-0003bu-3b
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 20:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295AbaDPSLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 14:11:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349AbaDPSLW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 14:11:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E39D47B598;
	Wed, 16 Apr 2014 14:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vKm0RqQGrhtUzQ3SS4WYAU7ZALU=; b=ld8tyH
	/sIek6q4+xgq76O1IaV6enroB2jS+9JRdFRw9JT5TSJfaRqDcBU7xWiNqTPO7oz9
	czbot/Qe7nAUOZLWCCG5HFDDTMIjAnVnPFUrnfYXKN3XRJOIKFFHtMr7Tc/xT3NU
	9JpcVOVjHL6LmoRNM5mVHnwrrlVFUXgkxgOlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q0AQl5HGE/Ivy/oBLtsGmDgUxXwtGfGg
	aeGL2Ld6INEEHiFiTCjD9HRNcKsyE5YqpU7bFA7rfRv1C1bYZxOfIr6/0h9I/0XZ
	AsKH+S7sTGnuAtVmn0zBWIO/xtLAjeb8OkaGp03U74D/WC4NJqLurRL5Aod12rAV
	FD4FkAIJTlM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C485D7B597;
	Wed, 16 Apr 2014 14:11:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BAB17B592;
	Wed, 16 Apr 2014 14:11:20 -0400 (EDT)
In-Reply-To: <xmqqsipdi5lw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Apr 2014 09:47:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82F6E324-C592-11E3-B406-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246369>

Junio C Hamano <gitster@pobox.com> writes:

> "Kyle J. McKay" <mackyle@gmail.com> writes:
>
>> If I'm the only one getting a wrong meaning from the comments, then no
>> reason to change them.
>
> I agree that the description does not read well with the work-around
> already there.  I am not sure what would be a better way to phrase
> it, though.

Here is a tentative rewrite at the beginning and the end of rebase-am:

    # The whole contents of the file is run by dot-sourcing this
    # file from inside a shell function.  It used to be that
    # "return"s we see below were not inside any function, and
    # expected to return from the function that dot-sourced us.
    #
    # However, FreeBSD /bin/sh misbehaves on such a construct and
    # continues to run the statements that follow such a "return".
    # As a work-around, we introduce an extra layer of a function
    # here, and immediately call it after defining it.
    git_rebase__am () {

    ...

    }
    # ... and then we call the whole thing.
    git_rebase__am


By the way, you have this in your log message:

    ... the git-rebase--*.sh scripts have used a "return" to return
    from the "dot" command that runs them.  While this is allowed by
    POSIX,...


Is it "this is allowed", or is it "this should be the way and shells
that do not do so are buggy"?
