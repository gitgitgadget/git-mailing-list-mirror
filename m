From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Mon, 02 Aug 2010 14:15:23 -0700
Message-ID: <7vwrs8k978.fsf@alter.siamese.dyndns.org>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
 <4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>
 <AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
 <vpqwrs9nxi5.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:15:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2MI-0001At-4l
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363Ab0HBVPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 17:15:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325Ab0HBVPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 17:15:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 16F38CACAB;
	Mon,  2 Aug 2010 17:15:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OEgCSsiYzhECuAy6F9PmjYgZDBA=; b=xiXUV0
	wirMENHoPvqhooISrRqkn/gO283k/mt7hrd6cUPVlacFoyPgwp16tAGq3QSCLg29
	kdyZLiH7wuWLvuLyfBH3TYqQgLuBW61AqkWJsAnnV+5QCl2853gP7FT+SfmLaIXf
	X0s71zTCRO9Y71q8Kn2bZjpVRTU1mv+Mco2qY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HSsWMjeFQL/vExtc2M7bzda5vKDKgTde
	P8U3+oZ+6qANoHwB1BPTggxEobDShMZRqqumneyneYSvzUT+sOaiGGQx3DCwUm4w
	FKXe6Zz/8teYJZjZtT/1Nm7a8Gm7swRt5rYKuAInK2sg/n/aNEZtGFKFhGAGIGiv
	mAQBm7hc+jU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8E6ECACAA;
	Mon,  2 Aug 2010 17:15:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5C1ECACA6; Mon,  2 Aug
 2010 17:15:24 -0400 (EDT)
In-Reply-To: <vpqwrs9nxi5.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon\, 02 Aug 2010 12\:02\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13FD28F8-9E7B-11DF-AE82-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152461>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> That's a good question. My original patch was running the command from
> the toplevel, which is the natural way to implement it. I've changed
> my mind to execute the command from the place where "git rebase -i"
> was started (which means this has to be memorized in a temporary file
> to be persistant accross "git rebase --continue"). I think this makes
> more sense for the user, and I've actually already been biten by the
> old behavior, running "rebase -i" from a doc/ subdirectory, and
> wondering why my "exec make" was rebuilding the code itself.
>
> This comes with at least one drawback: if directory from which the
> rebase was started didn't exist in the past, then we can't do a simple
> "cd" to it. My implementation re-creates the directory temporarily, so
> that the command can run, and cleans it up afterwards. The only really
> problematic case is when the directory can not be created (like
> directory/file conflict). It this case, the command is not ran, and
> the script exits.

Sorry to join the discussion after you have already coded it, but I don't
think running the external command at a random subdirectory that the
operation happened to have started makes much sense, as rebase is a
tree-wide operation.  The user if s/he so chooses can chdir down (if the
directory still exists in the revision in question) in the script, but I
think the built-in behaviour should be to just run it from the toplevel.
