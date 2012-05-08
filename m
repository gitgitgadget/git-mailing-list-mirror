From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 08 May 2012 08:19:27 -0700
Message-ID: <7v62c6zon4.fsf@alter.siamese.dyndns.org>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue May 08 17:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRmCN-0000CP-NP
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 17:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab2EHPTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 11:19:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755671Ab2EHPTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 11:19:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E19B77276;
	Tue,  8 May 2012 11:19:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aJPQ1uJnOy1QcHpGbskh5f0KeQM=; b=dt8AFg
	bL7xwvr961dCQOqXEEjcQ1i12IlUlz+uo5CS8AheY0DF0MAJPloT+wLZF/HQ9NzC
	xv966xbSuaw8hdpLiHVXSNowPzHyWx7VdGW9eSHB+D2oNMwyeVJoHnxbjsTOcyud
	5PtCGVLf6ruy+n0dK1ZYO3kvzfBUHeoS4h8uk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xVMSixiCb8y4/cDyNhF1eP1uDR+bNqRq
	1MFSGKuieAtE1jQxLv2QHMC3cIQXcBkRy6NrQRBxv5u4eoh6I4ywaslTU017LPuG
	UJsAO4zcT0Qf8OW3KgmrWSg7DxVwCRCylrsPmIQke+qjd6VsMb2rtFgzVlAPcjXy
	GJ4Y2+3sa4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D80D8726E;
	Tue,  8 May 2012 11:19:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E329726D; Tue,  8 May 2012
 11:19:29 -0400 (EDT)
In-Reply-To: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com> (Erik
 Faye-Lund's message of "Tue, 8 May 2012 13:24:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 34A4262C-9921-11E1-8295-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197374>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> +	test_create_repo empty-repo &&
> +	git submodule add ./empty-repo empty-submodule

You have an empty-repo but that is not part of the superproject; the
superproject will have empty-submodule submodule which is a clone of
empty-repo.

    $ git submodule add ./empty-repo empty-submodule
    Cloning into 'empty-submodule'...
    warning: You appear to have cloned an empty repository.
    done.

And after that, without you doing anything in empty-submodule, that
repository already exhibits the (null) problem.  Perhaps somebody, after
calling a successfull "git clone" of an empty repository (which is a silly
thing to do to begin with, with or without submodules involved, but at
least we do have a defined semantics of what happens when you do that),
tried to run "git checkout", even though there is nothing to be checked
out?  The culprit in that case to suspect would be "git submodule" script.
Does it blindly assume that it can do a "git checkout" and runs that
command?
