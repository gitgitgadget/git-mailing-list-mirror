From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Wed, 10 Dec 2014 10:00:44 -0800
Message-ID: <xmqqoarbidv7.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:00:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylZF-0004l1-Hm
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbaLJSAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:00:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932167AbaLJSAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:00:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B6D222727;
	Wed, 10 Dec 2014 13:00:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O8b+lrbkFvMSzYmh6a9KX/Z7yx8=; b=GjDISK
	X7ykF0gRZ//CVxTeBFwc0tIjiWiSI6DdZlyMpJItqOoqWtGz3Bs8ysEA+jypq+9O
	4eW86lrGxN4L0Zo9NZJZOBPBNYWv1XAObYlU/SrI6sNqveZEl5Hqc0P6MfYjdYSW
	16TT4SzfGeOt1U3gGiP/loTUsPSGdTxRuS89E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wqt3tKZhvunmlBZLawylt/1rhDJKvyrg
	XlXCyk1eAuZSl7alf1Rd25Esz2A2RkSTW1/Q9hbU7MuAqRGpWt9Zbqa+AGDGyKwK
	S6QXCbSEOcoVCwTY+ob1XXntXLVGTh71O/CeWhHve2IYdXr/cRt8b1ki+12Mnr5H
	ug4EIXTI+r4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3294F22724;
	Wed, 10 Dec 2014 13:00:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF37222723;
	Wed, 10 Dec 2014 13:00:45 -0500 (EST)
In-Reply-To: <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:14:30 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76F6CAFC-8096-11E4-B0FD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261228>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There are legacy repositories out there whose older commits and tags
> have issues that prevent pushing them when 'receive.fsckObjects' is set.
> One real-life example is a commit object that has been hand-crafted to
> list two authors.
>
> Often, it is not possible to fix those issues without disrupting the
> work with said repositories, yet it is still desirable to perform checks
> by setting `receive.fsckObjects = true`. This commit is the first step
> to allow demoting specific fsck issues to mere warnings.
>
> The function added by this commit parses a list of settings in the form:
>
> 	missing-email=warn,bad-name=warn,...
>
> Unfortunately, the FSCK_WARN/FSCK_ERROR flag is only really heeded by
> git fsck so far, but other call paths (e.g. git index-pack --strict)
> error out *always* no matter what type was specified. Therefore, we
> need to take extra care to default to all FSCK_ERROR in those cases.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  fsck.h |  7 +++++--
>  2 files changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 05b146c..9e6d70f 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -97,9 +97,63 @@ static int parse_msg_id(const char *text, int len)
>  
>  int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
>  {
> +	if (options->strict_mode && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> +		return options->strict_mode[msg_id];
> +	if (options->strict)
> +		return FSCK_ERROR;
>  	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
>  }

Hmm, if you are later going to allow demoting (hopefully also promoting)
error to warn, etc., would the comparison between msg_id and FIRST_WARNING
make much sense?

In other words, at some point wouldn't we be better off with
something like this

	struct {
        	enum id;
                const char *id_string;
                enum error_level { FSCK_PASS, FSCK_WARN, FSCK_ERROR };
	} possible_fsck_errors[];
