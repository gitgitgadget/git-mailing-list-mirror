From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] gitweb: Add a feature for adding more branch refs
Date: Tue, 03 Dec 2013 12:15:59 -0800
Message-ID: <xmqqr49tn11c.fsf@gitster.dls.corp.google.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
	<1386082603-8404-3-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 21:16:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnwOG-0002Ez-B3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 21:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab3LCUQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 15:16:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366Ab3LCUQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 15:16:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57CBA56A36;
	Tue,  3 Dec 2013 15:16:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u3HZGR6+Ibdi2exWaEmhNhovIyU=; b=PHD6Ps
	bo1cQkRzivR16+I9owCge6Sn8MBtnjBCdKtlskHwm1IcOJXYj/Ng237u7tIf1H4n
	G1WI3BXdviASBUG6qkhd6kgLaEWUHg9eAo26CoxSEuksr1j6tajNkqS530DexjYP
	UTTAkRj+Z2Q6+UVUNfIa1Kvl/nhB2G9iE4cwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZ04azYpdydwDJ2FFldihkbc7ZOqzzQX
	cIVaBhnEh8hB33Xu4bsv/PiTz4fF0dpY6SomgjcZ8+kXwwcWSvKYtRy6vGaGb18/
	lBeiAGZoZDk2oK1DLkKSM1lAeQXKQqVyUBNuVuQNEZy/UItzsR8PHvg/sSM2Zllm
	OepndgCwNNI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BCA856A35;
	Tue,  3 Dec 2013 15:16:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEF2356A30;
	Tue,  3 Dec 2013 15:16:06 -0500 (EST)
In-Reply-To: <1386082603-8404-3-git-send-email-krzesimir@endocode.com>
	(Krzesimir Nowak's message of "Tue, 3 Dec 2013 15:56:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BDF256B0-5C57-11E3-B71D-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238731>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> @@ -626,6 +640,17 @@ sub feature_avatar {
>  	return @val ? @val : @_;
>  }
>  
> +sub feature_extra_branch_refs {
> +	my (@branch_refs) = @_;
> +	my $values = git_get_project_config('extra_branch_refs');

Hmph.  Three points.

* Almost all callers of this function use

    my ($val) = git_get_project_config(...);
    my @val = git_get_project_config(...);

  to expect that the function returns a list of things (and grab the
  first one among them, not the length of the list).  Shoudln't this
  part do the same?


* Wouldn't this be a good candidate for a multi-valued configuration
  variable, e.g. shouldn't this

	[gitweb]
		extraBranchRefs = wip
		extraBranchRefs = sandbox other

  be parsed as a three-item list, qw(wip sandbox other)?
                

* I think the $key parameter to git_get_project_config() eventually
  is used to look up a key in the Git-style configuration file, and
  the 'words_with_underscore' goes against our convention (cf. see
  how 'show-sizes' feature is spelled as 'showsizes' there).

> +	if ($values) {
> +		@branch_refs = split /\s+/, $values;
> +	}
> +
> +	return @branch_refs;
> +}
