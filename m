From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 40/94] builtin/apply: move 'ws_error_action' into 'struct apply_state'
Date: Thu, 12 May 2016 12:48:36 -0700
Message-ID: <xmqqfutndpm3.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-41-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:49:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wbg-0000kH-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbcELTsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:48:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932334AbcELTsj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:48:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D8FE1BE7C;
	Thu, 12 May 2016 15:48:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9YxEm8uYFdEl4Go4YhpdZVRQBNs=; b=TP5mAB
	IUNM9SkW1U77REa7boDIujl1B8A7IJmAmhSJNrkwIBFqoGM+Cw10F8pFAKP7TdDm
	FAPrGvL27Y1Tf9EbMR9uRQN2xqF+8It6viiVcSjCvLV8wBZ8aS23WGvrCNmEWBWP
	qf6nmX3uRQssAfsI0FeCCT+h8FU7Je20wjQfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u6qk24Q4BjR4xZOyui/v0PnfkO8BiZ0x
	cnFfzL8mpNQ/qooU0QDFK6De+8mI+v1j8FXCb9GaOSPcM55ddEbdSwQw57KJqjsU
	6bxV6uL6ItTyd9UYtyFNtJcKUdT/B/gms/f9fHfRrHn5epPIZ6PNQsKVL4LgvE0c
	HnNoDVY1Ts4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 44D5F1BE7B;
	Thu, 12 May 2016 15:48:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD2111BE7A;
	Thu, 12 May 2016 15:48:38 -0400 (EDT)
In-Reply-To: <20160511131745.2914-41-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 859A024A-187A-11E6-A6B2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294438>

Christian Couder <christian.couder@gmail.com> writes:

>  struct apply_state {
>  	const char *prefix;
>  	int prefix_length;
> @@ -71,6 +78,8 @@ struct apply_state {
>  	int whitespace_error;
>  	int squelch_whitespace_errors;
>  	int applied_after_fixing_ws;
> +
> +	enum ws_error_action ws_error_action;

It is very good that these whitespace-error related things are
sitting next to each other.  I do not think the extra blank line is
warranted, though.

If anything, I'd say error-action should come at the beginning (as
it is an end-user input that is set before the processing happens),
and other three are states (that get new values after processing is
done) that should be listed after, to preserve the rough
chronological order the variables are used (which translates to the
order the readers need to become aware of and understand these
variables).
