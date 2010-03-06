From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Determining if a tree is clean
Date: Sat, 06 Mar 2010 11:23:06 -0800
Message-ID: <7vy6i5fe5h.fsf@alter.siamese.dyndns.org>
References: <799406d61003060712t120d7f11me6e2ab212c55271@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:28:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No173-0004YU-2u
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0CFTXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 14:23:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0CFTXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 14:23:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A4A9F414;
	Sat,  6 Mar 2010 14:23:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OLL4jvkwm/CrHI8vntDev9rsT4k=; b=BcqItU
	Lx9W/2YYIdTMrB6EXDj12KuMPj/jKlzAA8qhSooZz/1jN84BzrkHOx8U4eBINvFD
	fycIvV7dAN7tACYcmS0MNI9YcfJvSw1nWXRfWW5lUFDZ8nYjIS6KzjxkS/kHEwqH
	z1sN0RgiEQn87TTSMniP4G4tov+akmsAFAtjs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fjlrd8b2juPDuR0rj05lnprqf2Y6JKpH
	Aq5Q6Iylc17qjNL/HTaVZyBhPpCpSq4dTj+2XGBogxr4d1qdIMVbzPUBj+s9uQkP
	wRktXQOD/HV9YgZeI80r5MWWzwpLJo/bDZ67Nh8hSt1de3wjISs4t+kVd1cRoyaw
	yXGpInPbp20=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6059F412;
	Sat,  6 Mar 2010 14:23:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C876D9F411; Sat,  6 Mar
 2010 14:23:07 -0500 (EST)
In-Reply-To: <799406d61003060712t120d7f11me6e2ab212c55271@mail.gmail.com>
 (Adam Mercer's message of "Sat\, 6 Mar 2010 09\:12\:42 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B36B8416-2955-11DF-BF90-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Mercer <ramercer@gmail.com> writes:

> git diff-index --quiet HEAD

It is expected that a Porcelain script that implements a custom feature
may call diff-files, diff-index and other plumbing commands many times
during its lifetime, and that it knows what it is doing (namely, when
it touches the working tree itself and why).

For this reason, most plumbing commands do not refresh the cached stat
information in the index.  A Porcelain script is responsible for running
"update-index --refresh" once before it makes a call that cached stat
information matters, and as long as it doesn't touch the files in the
working tree, it doesn't have to run it again and again.

Porcelain commands like "git diff" that are expected to be run directly by
the end user cannot assume that, so they do not optimize---they typically
refresh the cached stat information by themselves internally whey they
start up.

Your Porcelain script should look something like:

    git update-index --refresh
    git diff-files -q || { echo "modified working tree"; exit 1 }
    git diff-index --cached -q HEAD || { echo "modified index"; exit 2 }

See contrib/examples/*.sh for examples.
