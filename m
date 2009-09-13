From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 1/2] gitweb: check given hash before trying to
 create snapshot
Date: Sat, 12 Sep 2009 20:30:38 -0700
Message-ID: <7vmy4z4j35.fsf@alter.siamese.dyndns.org>
References: <4AAC3833.8060905@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sun Sep 13 05:30:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmfni-00061N-VA
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 05:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbZIMDaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 23:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbZIMDap
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 23:30:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51081 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbZIMDao (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 23:30:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1337330045;
	Sat, 12 Sep 2009 23:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d/r2wnCWahBVcthiB2SLFD7l4dc=; b=vEM/da
	4uEN645O6Ii7CtAYLlUKhE8uAO11MfEepkC3r47I5A5tH1p3iNjZxPHqA5eNWlor
	0ctOgPkhPMtSGwI9sGLvaObz/E1IWk/39cFG2vvpNLomlsVFJwcivh9GK2jI/nMg
	S4HQ9WumqUggkDAgqlo9EvSv2Junv521SZ4Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tOK7uEzxyy9uJNLNZPFErzccUhqOxkRG
	FZfupodaRxGNPya4wZwC/yc3lasMp/Zu7TQNyamRedEpw5mFd2hs2kfROytNFA2+
	XBzCyTvDLTw06nWuAhQAjT3rxwR/jYZLB4jBOZsChz+sGInrhHWx0K/gCiv81XcS
	z88jzzeoCRs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA5C030042;
	Sat, 12 Sep 2009 23:30:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 362373003D; Sat, 12 Sep
 2009 23:30:40 -0400 (EDT)
In-Reply-To: <4AAC3833.8060905@mailservices.uwaterloo.ca> (Mark Rada's
 message of "Sat\, 12 Sep 2009 20\:09\:23 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1956B6A-A015-11DE-916E-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128328>

Mark Rada <marada@uwaterloo.ca> writes:

> Makes things nicer in cases when you hand craft the snapshot URL but
> make a typo in defining the hash variable (e.g. netx instead of next);
> you will now get an error message instead of a broken tarball.
>
> To maintain backwards compatibility, git_get_head_hash is now a wrapper
> for git_get_full_hash, as suggested by Jakub Narebski.
>
> Tests for t9501 are included to demonstrate added functionality.
>
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> ---
>
> 	This is just a re-send based on getting torn a new one by Junio.
> 	Changes since v3:
> 		- variables have been renamed for readability

Much nicer to read.  Thanks.

> @@ -5196,8 +5202,9 @@ sub git_snapshot {
>  		die_error(403, "Unsupported snapshot format");
>  	}
>  
> -	if (!defined $hash) {
> -		$hash = git_get_head_hash($project);
> +	my $full_hash = git_get_full_hash($project, $hash);
> +	if (!$full_hash) {
> +		die_error(404, 'Hash id was not valid');
>  	}

This is in the context of "snapshot", so obviously you care more about
just "such an object exists", don't you?  You also want it to be a
tree-ish.  Try giving it $hash = 'junio-gpg-pub' and see how it breaks.

> @@ -5210,7 +5217,7 @@ sub git_snapshot {
>  	$cmd = quote_command(
>  		git_cmd(), 'archive',
>  		"--format=$known_snapshot_formats{$format}{'format'}",
> -		"--prefix=$name/", $hash);
> +		"--prefix=$name/", $full_hash);

Why?  There was no justification as to why this change is necessary in the
commit log message.
