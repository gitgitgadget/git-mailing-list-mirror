From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] git submodule update: have a dedicated helper for cloning
Date: Wed, 03 Feb 2016 15:24:36 -0800
Message-ID: <xmqqr3gtjs23.fsf@gitster.mtv.corp.google.com>
References: <1454435497-26429-1-git-send-email-sbeller@google.com>
	<1454435497-26429-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 00:24:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR6my-00019y-Pu
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 00:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbcBCXYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 18:24:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61685 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754874AbcBCXYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2016 18:24:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEF0B41232;
	Wed,  3 Feb 2016 18:24:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=WtknkQ1+58ea96JLn5gqgTxZG0c=; b=wcUBeO7EWnRblxdgqK7P
	A40ZDrTm3CnWZYiWEiNgojIAB/CPX7A58hHIu7XWsjVx5Yw7Kb6O1zD4Pm/H5kF0
	/X7pRRWjwi8AlCglOmal8XpdHwxC1xrFP+uUhPGJSMqBCyO0aryHUSaH36bivqdq
	uCvARqJxxt+bPXBZMAKKt3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VkL1TpfSokBut8w1IAtD11TaTRRGNWXBk6v0Oh35iYqNL7
	3Glwbq8a+9VA7ZTQ8LvAInIBkfto5lzOavB1Ka9+36vuG6r6+OcGglPdoT1pOIeW
	hmXB/eIyLCbQSqt+LDLHQ3hCE5WQ5vsjBz/c8IS7RcLvhT2XqU5Wc0kW00Ngg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C596941231;
	Wed,  3 Feb 2016 18:24:37 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 46D484122E;
	Wed,  3 Feb 2016 18:24:37 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A950208-CACD-11E5-9A0B-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285382>

Stefan Beller <sbeller@google.com> writes:

> +		if (ce_stage(ce)) {
> +			if (pp->recursive_prefix)
> +				strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
> +					pp->recursive_prefix, ce->name);
> +			else
> +				strbuf_addf(err, "Skipping unmerged submodule %s\n",
> +					ce->name);
> +			continue;

This raised my eyebrow somewhat, until I realized that it is OK
because module_list prepared by the caller has only one of the
unmerged entries for the same path to avoid duplicates.

> +		}
> +
> +		sub = submodule_from_path(null_sha1, ce->name);
> +		if (!sub) {
> +			strbuf_addf(err, "BUG: internal error managing submodules. "
> +				    "The cache could not locate '%s'", ce->name);
> +			pp->print_unmatched = 1;
> +			continue;

Interesting.

I am wondering if this check should go to module_list_compute().

> +		}
> +
> +		if (pp->recursive_prefix)
> +			displaypath = relative_path(pp->recursive_prefix, ce->name, &sb);
> +		else
> +			displaypath = ce->name;
> +
> +		if (pp->update)
> +			update_module = pp->update;
> +		if (!update_module)
> +			update_module = sub->update;
> +		if (!update_module)
> +			update_module = "checkout";
> +		if (!strcmp(update_module, "none")) {
> +			strbuf_addf(err, "Skipping submodule '%s'\n", displaypath);
> +			continue;
> +		}
> +
> +		/*
> +		 * Looking up the url in .git/config.
> +		 * We must not fall back to .gitmodules as we only want to process
> +		 * configured submodules.
> +		 */
> +		strbuf_reset(&sb);

Doesn't this invalidate displaypath, when pp->recursive_prefix is in
effect?  It still seems to be used to create an error message just a
few lines below...

> +		strbuf_addf(&sb, "submodule.%s.url", sub->name);
> +		git_config_get_string(sb.buf, &url);
> +		if (!url) {
> +			/*
> +			 * Only mention uninitialized submodules when its
> +			 * path have been specified
> +			 */
> +			if (pp->pathspec.nr)
> +				strbuf_addf(err, _("Submodule path '%s' not initialized\n"
> +					"Maybe you want to use 'update --init'?"), displaypath);
> +			continue;
> +		}
