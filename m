From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 5/3] Alternative --dirstat implementation, based on
 diffstat analysis
Date: Tue, 12 Apr 2011 11:34:46 -0700
Message-ID: <7voc4bpbcp.fsf@alter.siamese.dyndns.org>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
 <201104121122.56870.johan@herland.net> <201104121126.49881.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:35:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9iQc-0006RW-OF
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 20:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab1DLSfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 14:35:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab1DLSe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 14:34:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DC753628;
	Tue, 12 Apr 2011 14:36:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=noA6kXMc4lKJl+mGOkbZPNoZzPY=; b=cyi6Nx
	ZAABRUaxN94ybUGBrHYw2cxVIDOfYjums45VOtd349vfXJY3PaxS4thgCqHdaArh
	+8HxQ6z3UQfxTAq7zuWExB46Pb1rbtS2OPzVOOh9JHpAyO8PLh7ZZBuXr2A5MOiX
	7RKlFIgWFreERa+xJ2qDh8pb4NVia0fhkJG3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K28ctWhdmSZvbAJbWYVjPG5tusfNYkH/
	0OKG6+z0HvNYNBQ9zv+dYs/7MAckXa9HU1Q9YlL4WaGoIGUfQxP6VIjqqTzNBsa4
	h/qEOvfNip8MrSEPoPsiXcoY/v2tP1j4ya15U8d9yXmF5Rwx5fWD/T2Jevgbg8+g
	z5KAqyTX8Nc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B05C3627;
	Tue, 12 Apr 2011 14:36:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DD7433626; Tue, 12 Apr 2011
 14:36:45 -0400 (EDT)
In-Reply-To: <201104121126.49881.johan@herland.net> (Johan Herland's message
 of "Tue, 12 Apr 2011 11:26:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D4D65296-6533-11E0-B981-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171410>

Johan Herland <johan@herland.net> writes:

> This patch adds an alternative implementation of show_dirstat(), called
> show_dirstat_based_on_diffstat(), which uses the more expensive diffstat
> analysis (as opposed to --dirstat's own (inexpensive) analysis) to derive
> the numbers from which the --dirstat output is computed.
> ...
> diff --git a/diff.c b/diff.c
> index 5376d01..a496ba6 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -31,6 +31,7 @@ static const char *external_diff_cmd_cfg;
>  int diff_auto_refresh_index = 1;
>  static int diff_mnemonic_prefix;
>  static int diff_no_prefix;
> +static int dirstat_based_on_diffstat;
>  static struct diff_options default_diff_options;
>  
>  static char diff_colors[][COLOR_MAXLEN] = {
> @@ -103,6 +104,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>  		diff_no_prefix = git_config_bool(var, value);
>  		return 0;
>  	}
> +	if (!strcmp(var, "diff.dirstatbasedondiffstat")) {
> +		dirstat_based_on_diffstat = git_config_bool(var, value);
> +		return 0;
> +	}

People may think of other damage calculator, so the variable shouldn't be
a boolean that says "dirstat-based-on-diffstat" but rather an enum.

We would need a command line interface for this.  How about something like
"--dirstat=lines" vs "--dirstat=changes", and default "--dirstat" without
an explicit type to traditional "--dirstat=changes"?  
