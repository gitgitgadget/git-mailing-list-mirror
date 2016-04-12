From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] format-patch: introduce format.base configuration
Date: Tue, 12 Apr 2016 12:47:23 -0700
Message-ID: <xmqq37qqr4ms.fsf@gitster.mtv.corp.google.com>
References: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
	<1460342873-28900-5-git-send-email-xiaolong.ye@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Xiaolong Ye <xiaolong.ye@intel.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 21:47:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq4Hb-0001fD-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 21:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbcDLTr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 15:47:28 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757078AbcDLTr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 15:47:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B41D65528E;
	Tue, 12 Apr 2016 15:47:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=54uwkl4rU8WKfLWMJ1BgMENwbVQ=; b=HT0RwV
	sSPqZ85W0DNgQwLqA8ubOBOjB99B+NpFuD88PINWuocVdpHxDRzQyQAW17giJYBc
	qM/e/0xoml66iTsASttA0eEIaEfQVr+pF1iDdQmsD4Vvq2yeAUX9rEnJ1L50Wjog
	syboecWBCjjzmr1kCRoBRxb8/hLl65rvpvsbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RbhARA0fVko65xsZfuWwtXMO3US+q1d4
	NAk85OMUldR6jzdmfPPky++RgOX7cZJDayUHn44idHM5cJSuYvxxoXAD1y3nXHYy
	uXzKFy4Gb1iMXPHqatUs1kp9w7RfDNmhGPhoxY7mCRKb+yzZxsZSIDJLYqunZ8Nd
	RGjC8luWe8k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC0835528D;
	Tue, 12 Apr 2016 15:47:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3359A5528C;
	Tue, 12 Apr 2016 15:47:24 -0400 (EDT)
In-Reply-To: <1460342873-28900-5-git-send-email-xiaolong.ye@intel.com>
	(Xiaolong Ye's message of "Mon, 11 Apr 2016 10:47:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60C34080-00E7-11E6-8B4D-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291290>

Xiaolong Ye <xiaolong.ye@intel.com> writes:

> +static int config_base_commit;

This variable is used as a simple boolean whose name is overly broad
(if it were named "config_base_auto" this complaint would not
apply).  If you envision possible future enhancements for this
configuration variable, "int config_base_commit" might make sense
but I don't think of anything offhand that would be happy with
"int".

> @@ -786,6 +787,12 @@ static int git_format_config(const char *var, const char *value, void *cb)
>  	}
>  	if (!strcmp(var, "format.outputdirectory"))
>  		return git_config_string(&config_output_directory, var, value);
> +	if (!strcmp(var, "format.base")){

Style. s/)){/)) {/

> +		if (value && !strcasecmp(value, "auto")) {

Does it make sense to allow "Auto" here?  Given that the command
line parsing uses strcmp() to require "auto", I do not think so.

> +			config_base_commit = 1;
> +			return 0;
> +		}

When a value other than "auto" is given, is it sane to ignore them
without even warning?

I am wondering if this wants to be a format.useAutoBase boolean
variable.

> @@ -1215,7 +1222,12 @@ static void prepare_bases(struct base_tree_info *bases,
>  	DIFF_OPT_SET(&diffopt, RECURSIVE);
>  	diff_setup_done(&diffopt);
>  
> -	if (!strcmp(base_commit, "auto")) {
> +	if (base_commit && strcmp(base_commit, "auto")) {
> +		base = lookup_commit_reference_by_name(base_commit);
> +		if (!base)
> +			die(_("Unknown commit %s"), base_commit);
> +		oidcpy(&bases->base_commit, &base->object.oid);
> +	} else if ((base_commit && !strcmp(base_commit, "auto")) || config_base_commit) {

It may be a poor design to teach prepare_bases() about "auto" thing.
Doesn't it belong to the caller?  The caller used to say "If a base
is given, then call that function, by the way, the base must be a
concrete one", and with the new "auto" feature, the caller loosens
the last part of the statement and says "If a base is given, call
that function, but if it is specified as "auto", I'd have to compute
it for the user before doing so".
