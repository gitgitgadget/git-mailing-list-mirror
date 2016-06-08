From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 5/6] send-email: --in-reply-to=<file> populate header fields
Date: Wed, 08 Jun 2016 11:23:50 -0700
Message-ID: <xmqqvb1jletl.fsf@gitster.mtv.corp.google.com>
References: <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130736.32163-1-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:27:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAi93-0001Ck-QM
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 20:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161196AbcFHSX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 14:23:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752104AbcFHSX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 14:23:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D0261F78E;
	Wed,  8 Jun 2016 14:23:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=twXZ4A9nUm0tQMX5YDBiS2Pvp7o=; b=msBTNw
	Q7Ed4pRFakp8Il8PnvtSso99ADuHn3/C2ZO4En6pGw65Z13LE11nV4119kpGtAD3
	vNUPu0W2uwXNKGWIw489OyMFloEo3jN2/EZ6F6X+RCWs2kLyNcxSvzFnxlYixY0q
	4312+aVnSf+w2r4OecLl7M90ffyc++5gsnz8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y0iVbChxytlA4sHLhVeEmZWYjNK+WE2E
	+JPQxXvLb49K/kCQBiVEf1KIfOxqvAWIjP/INa3piuXnALjWRlYiK7b6jz0Wt08o
	6Sgx1ege/dE1C/YCebdzOWDJ04QVKUAoxG1ss/B+MjNg+PMEAstrLVONJl/4xED1
	LuP97fITQbY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 93D971F78D;
	Wed,  8 Jun 2016 14:23:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14A961F78C;
	Wed,  8 Jun 2016 14:23:52 -0400 (EDT)
In-Reply-To: <20160608130736.32163-1-samuel.groot@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 15:07:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26E2D114-2DA6-11E6-9E42-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296828>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> +if ($initial_reply_to && -f $initial_reply_to) {
> +	my $error = validate_patch($initial_reply_to);

This call is wrong, isn't it?

You are not going to send out the message you are responding to (the
message may not even be a patch), and you do not want to die with an
error message that says "patch contains an overlong line".

> +	die "fatal: $initial_reply_to: $error\nwarning: no patches were sent\n"
> +		if $error;
> +
> +	open my $fh, "<", $initial_reply_to or die "can't open file $initial_reply_to";
> +	my $mail = Git::parse_email($fh);
> +	close $fh;

	my $header = Git::parse_email_header($fh);

perhaps?

> +	my $initial_sender = $sender || $repoauthor || $repocommitter || '';
> +
> +	my $prefix_re = "";
> +	my $subject_re = $mail->{"subject"}[0];
> +	if ($subject_re =~ /^[^Re:]/) {
> +		$prefix_re = "Re: ";
> +	}
> +	$initial_subject = $prefix_re . $subject_re;

I am not sure what the significance of the fact that the subject
happens to begin with a letter other than 'R', 'e', or ':'.

Did you mean to do something like this instead?

	my $subject = $mail->{"subject"}[0];
	$subject =~ s/^(re:\s*)+//i; # strip "Re: Re: ..."
        $initial_subject = "Re: $subject";

instead?

By the way, this is a good example why your "unfold" implementation
in 4/6 is unwieldy for the caller.  Imagine a rather long subject
that is folded, i.e.

	To: Samuel
        Subject: Help! I am having a trouble running git-send-email
            correctly.
	Message-id: <...>
