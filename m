From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] status: really ignore config with --porcelain
Date: Mon, 24 Jun 2013 09:35:44 -0700
Message-ID: <7vk3ljbh5r.fsf@alter.siamese.dyndns.org>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
	<1372077912-18625-2-git-send-email-artagnon@gmail.com>
	<vpqhagnwraj.fsf@anie.imag.fr>
	<CALkWK0=F_i95S+53eZmOAJtA+jG=jvi5-sDc3BgW3rNQo=n3Ng@mail.gmail.com>
	<vpqhagnv9xq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:35:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9kB-0005Mp-4i
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab3FXQfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:35:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050Ab3FXQfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:35:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F07C2BCFC;
	Mon, 24 Jun 2013 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m1LbaybTQy7/PhTDMVvhaDZIMWk=; b=Qdk9ah
	7VW0rrxeMCljRmeI53djxN+RFJ2OSS0vdRgSiscZjE++c68mBatMZKwCKcemL1PE
	4jHCEcI8TJiMtJlC3bbZv+JJhBMcOGEyVFHTFnqkTywb38h30rGeqARKWjs7LrFK
	HZUNRfHy9onkRm9MAm6KVBDren8vf5aqxR3QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nUrwK6DmmlDInLbqmIHCh+LiHM8PLEeS
	PsSLRGeP/iYM2PUE1fbZyJAAA+fHnBX3flFBSPH2sH7jQsGAPVqW2HSKc/7ixQuj
	IHDUK+I1ydcF3lIrjUTv/pxIAOt2njMNZcSe7umSBHr/lX4pDhtweMaes25pS6v+
	zXKUAm1gw+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 243642BCFB;
	Mon, 24 Jun 2013 16:35:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 815A42BCF9;
	Mon, 24 Jun 2013 16:35:45 +0000 (UTC)
In-Reply-To: <vpqhagnv9xq.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	24 Jun 2013 16:51:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E6D44B4-DCEC-11E2-B3B0-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228848>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Basically, having the CLI parser and the config parser flip two
>> different sets of variables, so we can discriminate who set what.
>> What annoys me is that this is the first instance of such a
>> requirement.
>
> I don't think it's the first instance, but I can't remember precise
> examples.

"First read config, override with command line" is what we always
do.  One recent workaround with selective exception I can think of
offhand is in diff config parser 6c374008 (diff_opt: track whether
flags have been set explicitly, 2013-05-10), but I am fairly sure
there are others.  An older example is how show_notes_given is used
in the revision traversal machinery to conditionally set show_notes.

>> The approach I'm currently tilting towards is extending the
>> parse-options API to allow parsing one special option early.  I would
>> argue that this is a good feature that we should have asked for when
>> we saw 6758af89e (Merge branch 'jn/git-cmd-h-bypass-setup',
>> 2010-12-10).  What do you think?
>
> That's an option too, yes. But probably not easy to implement :-(.

Isn't it essentially your second option (running the CLI parser
before once, then read config, and then run the CLI parser for
real)?

In any case, I am still not convinced yet that status.short is a
real problem if --porcelain readers trip with "## branchname"
output.  Isn't it that the readers are broken and need fixing?
They should pick out what they care about and ignore the rest.
