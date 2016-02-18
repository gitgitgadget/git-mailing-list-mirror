From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] submodule: port init from shell to C
Date: Thu, 18 Feb 2016 15:15:37 -0800
Message-ID: <xmqqmvqxehk6.fsf@gitster.mtv.corp.google.com>
References: <1455320356-15778-1-git-send-email-sbeller@google.com>
	<1455320356-15778-3-git-send-email-sbeller@google.com>
	<xmqqmvqxg30y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:15:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWXnV-0005gL-1L
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 00:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947281AbcBRXPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 18:15:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1946276AbcBRXPk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 18:15:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EC06462AA;
	Thu, 18 Feb 2016 18:15:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5m2bUFpA3+nw3lOD0tPYhq1TVt0=; b=fSsdmQ
	F3QFLuJuzQHxcVD4YZ4MVJmFG9PaS1uAMUDu793YQFGqeJFIUfxGdbtlskIBlfMl
	TZFsqRb90dazKLjmgkR1lgxG79pvk0EWMTSiQ1IWKIfjSam8+qMr3grs7CICaUji
	skpxC1ClpxIsR3Vse2gZnUWvH+uLugsJqsY6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lx3tRIrhBtMbwRW00ltoysgLE/sEbizB
	EhzjWz6yifotC23PfQ/jYQCdT/6t4nPAWI2RPXNqHL4Q/5yMZOunCbwrHQDWoZPU
	wPgrWGuiDekdOusB2RtppwyD15PNJqd9mZIKyomIvr6YeGDeRfYzoSQUJ9pXcM2m
	yVTaMlypb6g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 590E9462A9;
	Thu, 18 Feb 2016 18:15:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C1DD5462A8;
	Thu, 18 Feb 2016 18:15:38 -0500 (EST)
In-Reply-To: <xmqqmvqxg30y.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 18 Feb 2016 12:46:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 85CF292E-D695-11E5-8A51-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286640>

Junio C Hamano <gitster@pobox.com> writes:

>> +	strbuf_reset(&sb);
>> +	strbuf_addf(&sb, "submodule.%s.url", sub->name);
>> +	if (git_config_get_string(sb.buf, &url)) {
>> +		url = xstrdup(sub->url);
>> +		if (!url)
>> +			die(_("No url found for submodule path '%s' in .gitmodules"),
>> +				displaypath);
>
> I am assuming that this corresponds to these lines in the original
> scripted version:
>
> 		url=$(git config -f .gitmodules submodule."$name".url)
> 		test -z "$url" &&
> 		die "$(eval_gettext "No url found for submodule path...
>
> but what makes git_config_get_string() to read from ".gitmodules"
> file?  Doesn't it read from $GIT_DIR/config & ~/.gitconfig instead?

I am starting to suspect that reading of ".gitmodules" in the
context of "git submodule" command is a good use case for the
configset API.  It wants to read variables from ".gitmodules" and
the regular configuration file, and cares about where they come
from, illustrated by this codepath.  Read URL from .gitmodules, do
something to it, and update the regular configuration file.  Read
Update from .gitmodules, do some verification, and selectively store
it in the regular configuration file.  There may be cases where you
want to check if a variable is in the regular configuration file
(i.e. read from there), see its value in ".gitmodules", and
conditionally update the regular configuration file (i.e. write into
it).  The configset API was designed to help implement this kind of
thing in a clean manner (i.e. initialize one, add ".gitmodules"
file, and then configset_get_* on it, without affecting what you
read and write with the regular config_get_*/config_set_* to the
regular configuration file).
