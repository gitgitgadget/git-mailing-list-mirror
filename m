From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 4/6] git submodule update: have a dedicated helper for cloning
Date: Tue, 09 Feb 2016 13:24:54 -0800
Message-ID: <xmqq8u2t37bt.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:25:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFmP-0006KZ-77
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbcBIVY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:24:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932421AbcBIVY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DA3A43439;
	Tue,  9 Feb 2016 16:24:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kkcx0/i75ALv06HaJ8f9KLCZZLw=; b=wSj8+G
	UV0/yedfG/owH0/xOVmtB42X+3PFO364Vuc6yF7gXGEdk1Z9vK52GBGycED4pAux
	Zc10dEFV5uMp3Tq9uuob2S77AdV5ZRUNj4BCYAkRADtFMtDJnyqZjQulkNydwXGf
	Y5laAd02OhTK7fTPCbZhLIhL91cRRCC+v5BOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZgbfaUUYaJ6fyFNMzWpFh63RxY+smBtP
	yXYS+VPZWuJik9ysu1D1o2n9eSetZ2pGrH7PNHSoZN1xBdVMmVPHHztQTA60UK7s
	8tRpLpK7m2HUPBMo9K0QSfGF3Ehe/F+NNlQ0ffFae+pQc0hWReW76zw/Al8tffUt
	KzJCjGtVCJY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2384543438;
	Tue,  9 Feb 2016 16:24:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 900DA43435;
	Tue,  9 Feb 2016 16:24:55 -0500 (EST)
In-Reply-To: <1455051274-15256-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 9 Feb 2016 12:54:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 906F6EBC-CF73-11E5-993D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285869>

Stefan Beller <sbeller@google.com> writes:

> +	for (; pp->count < pp->list.nr; pp->count++) {
> +		const struct submodule *sub = NULL;
> +		const struct cache_entry *ce = pp->list.entries[pp->count];
> +		struct strbuf displaypath_sb = STRBUF_INIT;
> +		struct strbuf sb = STRBUF_INIT;
> +		const char *displaypath = NULL;
> +		char *url = NULL;
> +		int needs_cloning = 0;
> +
> +		if (ce_stage(ce)) {
> +			if (pp->recursive_prefix)
> +				strbuf_addf(err,
> +					"Skipping unmerged submodule %s/%s\n",
> +					pp->recursive_prefix, ce->name);

The funny indentation of the string is a workaround for overly deep
nesting, but is the overly deep nesting telling us that perhaps one
iteration of this loop can be an invocation of a helper function, I
wonder?

> +			else
> +				strbuf_addf(err,
> +					"Skipping unmerged submodule %s\n",
> +					ce->name);
> +			goto cleanup_and_continue;
> +		}

> +
> +		sub = submodule_from_path(null_sha1, ce->name);
> +
> +		if (pp->recursive_prefix)
> +			displaypath = relative_path(pp->recursive_prefix,
> +						    ce->name, &displaypath_sb);
> +		else
> +			displaypath = ce->name;
> +
> +		if ((pp->update && !strcmp(pp->update, "none")) ||
> +		    (!pp->update && sub->update == SM_UPDATE_NONE)) {

This looks a bit strange.  I wonder pp->update should also become
enum for the same reason why sub->update has become enum.  That way,
we need to be worried about parsing these tokens in one place where
a textual string "none" is translated to SM_UPDATE_NONE.  If we
started allowing "None" in the sub->update parse_config() in
submodule-config.c, we would want that new parsing rule propagated
to pp->update, right?

> +			strbuf_addf(err, "Skipping submodule '%s'\n",
> +				    displaypath);
> +			goto cleanup_and_continue;
> +		}
