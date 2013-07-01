From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/4] contrib: contacts: add support for multiple patches
Date: Mon, 01 Jul 2013 11:50:30 -0700
Message-ID: <7v7ghaglmx.fsf@alter.siamese.dyndns.org>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 20:50:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtjBN-0008S5-Of
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 20:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab3GASud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 14:50:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37466 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298Ab3GASud (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 14:50:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B35F62D82C;
	Mon,  1 Jul 2013 18:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2gKGQ2EFmOpXaI2iG6MLyXyzp64=; b=JPKAFx
	ItosqGDa+eERARTByYd/LNyfesbF9FgJ3H1mtue370p4zHM6mCiN0fSl4jqUnr6I
	3MgwjDZ/faeGQdOp+CRJGk5C2qhKXrWAvjL6Q1YrUKsrqJiwvgp0rMfGURvirnZz
	UvjNR9GiW16Ov/NZ60hyQaEjpYlYvT/d0YhPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gGSQuQXzySYWsqY7GvOBkTpA/VJWs+zq
	IYhFd7UDhPXjHXLVQtbXbsximIStPi0obLcYKcedP865mXcB35NU1uUYWNEUPPGO
	7GK6bBz2gxtzBIft95LoyhsWsC+IKXYdPXvr7S/KCiV/CLDRIxNs1YIulYddXmuM
	cEzqsmOs+ds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAE572D82B;
	Mon,  1 Jul 2013 18:50:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1784C2D82A;
	Mon,  1 Jul 2013 18:50:32 +0000 (UTC)
In-Reply-To: <1372590512-21341-3-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 30 Jun 2013 07:08:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B496C52-E27F-11E2-9E3A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229319>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Accept multiple patch files rather than only one. For example:
>
>   % git contacts feature/*.patch
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

> @@ -93,6 +96,7 @@ sub commits_from_patch {
>  	while (<$f>) {
>  		if (/^From ($id_rx) /o) {
>  			$id = $1;
> +			$seen{$id} = 1;
>  			last;
>  		}
>  	}

This looks less useful than it could be.

	$ git format-patch --stdout -4 >P.mbox
        $ git contacts P.mbox

would have the same number of patches but in a single file.

Wouldn't it be more useful to do something like

	$id = undef;
	while (<$f>) {
		if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
			# beginning of a patch
			$id = $1;
		}
                next if (!defined $id);
		# inline the body of scan_hunks here...
		if (m{^--- (a/.*|/dev/null)$}) {
			$source = ...
		} elsif (/^@@ -(\d+)...) {
			get_blame();
		}
	}

> @@ -100,10 +104,8 @@ sub commits_from_patch {
>  	close $f;
>  }
>  
> -exit 1 unless @ARGV == 1;
> -
>  my %commits;
> -commits_from_patch(\%commits, $ARGV[0]);
> +commits_from_patch(\%commits, $_) for (@ARGV);

This change does not seem to account for an invocation without any
argument.  Perhaps write it like so to make it more readable?

	if (!@ARGV) {
		die "No input file?\n";
	}

	for (@ARGV) {
		commits_from_patch(\%commits, $_);
	}	        

>  import_commits(\%commits);
>  
>  my %count_per_person;
