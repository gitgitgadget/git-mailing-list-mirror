From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-config: document interactive.singlekey requires Term::Readkey
Date: Mon, 03 Mar 2014 10:58:58 -0800
Message-ID: <xmqq1tyjqfbh.fsf@gitster.dls.corp.google.com>
References: <6157736903dbcb3359eda07eff6f0faf832ef256.1393790234.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 20:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKY5w-0005rJ-Vo
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 20:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbaCCS7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 13:59:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755196AbaCCS7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 13:59:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DA666FE3F;
	Mon,  3 Mar 2014 13:59:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FpMH6X8frzBFo6LOAfZ4PQK6MNI=; b=g4unb0
	akCBXkHf0ON7ehxMRSALZHN7lxVgYH6nIVEm3s+U5hokxbwF3pKXkrwgmeIhbbts
	yKSOVB/a7koS5tglVS8bxZovIegx8k8Uadk1CUXsTKpZ6UPcDWf81D6hZ2/0oJvQ
	opeCobWjqPgASgzXXEM9gYztJX8BTDWIJBEqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pAA5Cgx3NO18Xq/0Hdy4SJV+b6/42yNY
	99vY74QosMBl8Rv36DpkGzhFka4S4HQ1esf6/iuvGdCWSj6OXufs51zpau/eo7TP
	SQ/YBNBSXrn+RpK5NTrXyqrxxfXhrMHB9/2QMpWlGw2qv9nVKGFwMsDBgfR7XAM/
	C9joo62HuXg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E02B6FE3B;
	Mon,  3 Mar 2014 13:59:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 380DF6FE37;
	Mon,  3 Mar 2014 13:59:01 -0500 (EST)
In-Reply-To: <6157736903dbcb3359eda07eff6f0faf832ef256.1393790234.git.simon@ruderich.org>
	(Simon Ruderich's message of "Sun, 2 Mar 2014 20:58:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1F61EB2-A305-11E3-949C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243254>

Simon Ruderich <simon@ruderich.org> writes:

> Most distributions don't require Term::Readkey as dependency,
> leaving the user to wonder why the setting doesn't work.
>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>

Thanks, but is it true that interactive.singlekey "requries"
Term::ReadKey?

The relevant part of git-add--interactive reads like so:

if ($repo->config_bool("interactive.singlekey")) {
	eval {
		require Term::ReadKey;
		Term::ReadKey->import;
		$use_readkey = 1;
	};
	eval {
		require Term::Cap;
		my $termcap = Term::Cap->Tgetent;
		foreach (values %$termcap) {
			$term_escapes{$_} = 1 if /^\e/;
		}
		$use_termcap = 1;
	};
}

The implementation of prompt_single_character sub wants to use
ReadKey, but can still let the user interact with the program by
falling back to a cooked input when it is not available, so perhaps
a better fix might be something like this:

        if (!$use_readkey) {
        	print STDERR "missing Term::ReadKey, disabling interactive.singlekey\n";
        }

inside the above if() that prepares $use_readkey?

You also misspelled the package name it seems ;-)
