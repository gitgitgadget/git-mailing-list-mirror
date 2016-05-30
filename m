From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/1] t6038-merge-text-auto.sh
Date: Mon, 30 May 2016 11:48:21 -0700
Message-ID: <xmqqy46r8jre.fsf@gitster.mtv.corp.google.com>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
	<1464627642-23994-1-git-send-email-tboegi@web.de>
	<xmqqzir7o286.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon May 30 20:48:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7SEm-0007VB-Og
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161859AbcE3Ss0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:48:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161557AbcE3SsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:48:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA4C9203C5;
	Mon, 30 May 2016 14:48:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=892rezKc3YtcnfNAcHHy0qZhgBk=; b=xVJ+xu
	Y8huxMZSUpuB2T0MHfZ6borpnormx9P4i0TuMZ1/lhGyML4TZLXbousQopyvnNJQ
	IlKzj4gkHctLWEWDcpCP2RsIdz9OPFY35okgAw+ctGXFvJiM7ZRfGKlfoxVtLemy
	gBfCnJ4RZdZ/ngLskNrgqnipiznzNl5T5zpt4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mMt5UDP34Yj+M7QMsAmBshCYxKLx6onM
	6TWS+H4E4NCnVh93o4J24KMixU84frvsI0NnZyK/+aVCxNfJo3LS9K8XSNzw9JKd
	CjmrbmaavEqtUc4jEeqB2KipiflyrnC7rc3XHYQVoG1376tn/sTQgK2tHmrt6B06
	itx/X37/CQs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D1806203C4;
	Mon, 30 May 2016 14:48:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E5B4203C3;
	Mon, 30 May 2016 14:48:23 -0400 (EDT)
In-Reply-To: <xmqqzir7o286.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 30 May 2016 11:00:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1618534C-2697-11E6-B99D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295923>

Junio C Hamano <gitster@pobox.com> writes:

> Imagine that you started from a history where somebody recorded a
> text file with CRLF in the blob, unconverted.  Later the project
> decided to express their text with LF to support cross-platform
> development better, and sets up the Auto-CRLF.  Your user is working
> near the tip of that history after the eol correction happened.  Now
> she gets a pull-request of a branch that forked from an old point in
> the history, before the eol correction and full of CRLF.  Yes, to
> integrate the change being proposed, she needs to look at "theirs";
> that's the whole point of a "merge".  Why should she revert the eol
> correction her history has by getting fooled by the fact that the
> update was based on a part of the history before the eol correction?

Thinking aloud along this line a bit further, if you really cared
(and I don't feel very strongly, as I think "safe crlf" is an ugly
workaround that lets users keep their misconfiguration by penalizing
their day-to-day operation), you may want to think about doing a
3-way merge of "eol preference" beween all stages.

That is, if the common ancestor in stage #1 and the current version
in stage #2 both have its text in LF, and the data being merged in
stage #3 is in CRLF, you sayr "do not convert; the change being
brought in wants to have CRLF endings, while our history did not
care".  Similarly, if the common ancestor in stage #1 and the data
being merged in stage #3 both have CRLF, and your version in stage
#2 has LF, you say "We wanted to fix eol since the side branch
forked, and the side branch predates that fix, so we keep the eol
fix we did since we diverged", i.e. "Do convert".

For doing this, you may want to refactor the codepath that decides
"Auto-CRLF usually wants to turn CRLF in text to LF, but should we
disable that logic now, because the user already has CRLF in the
current one?" into a function that takes a single parameter, `path`,
and returns "Yes, do convert CRLF to LF / No, do not convert"
boolean.  Having a low level function that says "What's the blob at
this path in the index" and have the caller run that logic feels
unwieldy if we want to go that route.
