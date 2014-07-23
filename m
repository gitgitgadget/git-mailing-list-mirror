From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confused about remote branch management
Date: Wed, 23 Jul 2014 16:51:48 -0700
Message-ID: <xmqqvbqnab1n.fsf@gitster.dls.corp.google.com>
References: <1406083743.29001.139.camel@localhost>
	<53CF66D4.7060201@gmail.com> <1406143336.29001.185.camel@localhost>
	<xmqqmwbzda80.fsf@gitster.dls.corp.google.com>
	<1406158252.29001.223.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Ross Boylan <ross@biostat.ucsf.edu>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA6KI-0006rU-QU
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 01:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758371AbaGWXv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 19:51:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54198 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758227AbaGWXv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 19:51:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9E2022C946;
	Wed, 23 Jul 2014 19:51:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ruu0+LsRP2OBWnMDrCSvGDrjgg=; b=EbYTI4
	3qyJJtAnedPtVyyHT8Jet7yPdLMgjR+WaP8bOnBvrO9rVkksc0F/UymR6HPY7nO7
	TCZnj41jUcp5PAMQ4AIPj+x08EJz6m5KHvraACz2DbxtvAOeNojYLAFMIuJ56k6D
	IaMRmDcVYKCs7QPb7ddPuz4Dux1opbG4soKzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VOYjI5m84O87fGcxo/oQZA2zqDfuXUyo
	6wXq5CWqhuX01ZYMMwzxnyuven7YE34AMWrWb72ZYUc8vrBJj/YUqadtEzjjzjzI
	uuttuFbqr7XS3CM3UuaZ8ib+afYUNZ4Ld5/MAKM7O+6wB2taGOOAUr2nKayu7SxE
	kXAuw2OLz04=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94BE42C945;
	Wed, 23 Jul 2014 19:51:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A8D192C93A;
	Wed, 23 Jul 2014 19:51:49 -0400 (EDT)
In-Reply-To: <1406158252.29001.223.camel@localhost> (Ross Boylan's message of
	"Wed, 23 Jul 2014 16:30:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 503CD450-12C4-11E4-BC9F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254141>

Ross Boylan <ross@biostat.ucsf.edu> writes:

>> Either
>> 
>> 	git fetch origin master:refs/remotes/origin/master
> Great; that works.
> Is that procedure supposed to be the usual way I track upstream in this
> (1.7) version of git?  It seems arcane.

No, and no.  The command is designed so that most of the time you
can just say "git fetch<ENTER>" without anything extra, which will
let the configured remote.*.fetch to kick in as the default refspec
to slurp updates to all the branches.  This is because the branches
of a single project are supposed to be related, and a single "git
fetch" goes over a single network connection, establishment of which
is expected to be a large overhead.  Letting a single invocation of
"fetch" to slurp updates to _all_ the branches is supposed not to be
too much overhead over grabbing updates to everything (let alone
invoking a "git fetch" per each individual branch), and is the
normal mode of operation.

A single-shot "git fetch origin master" to explicitly decline
following of everything other than 'master' *is* the special case.

And it was a very conscious design decision not to molest the remote
tracking branch when this kind of explicit command line request is
made, so that you do not lose track of what commit you _saw_ before
you ran the command.  That way "git log origin/master..FETCH_HEAD"
can be used to inspect what got changed since you fetched last time.

Over the years, with reflogs enabled for everybody, preserving the
remote tracking branches when the user does not explicitly ask to
store the result has become much less important.  For this reason,
modern Git applies, when it sees "git fetch origin master", the
configured remote.*.fetch as refmap to map the name "master",
i.e. the only branch you are fetching, to the remote tracking branch
you use to store the result, i.e. "refs/remotes/origin/master".
