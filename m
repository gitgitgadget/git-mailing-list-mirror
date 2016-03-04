From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Fri, 04 Mar 2016 10:36:44 -0800
Message-ID: <xmqqsi06yts3.fsf@gitster.mtv.corp.google.com>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com>
	<56D97C8C.1060205@web.de>
	<D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Alexander Rinass <alex@fournova.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:37:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abuar-0001rd-2k
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:36:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759470AbcCDSgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 13:36:49 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752942AbcCDSgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2016 13:36:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D78E46871;
	Fri,  4 Mar 2016 13:36:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9cqNFZXFH7Pu
	LfME4oPJuQ5Kmww=; b=S2NBCMAf7bXApf1pJj4QlWq/HzioMyfKRfdvaZPRJYct
	/F+d53nr+1HRrEvCXANSUjNYCTORdtvhyFZjEf9w+X+QiADkI6kdxm2euGfX+7ma
	VmF1kMjYcjZma3XhHxp1K8ZP/g1NEHNOGITnmleT7n7Zbcyrllkfet8HAJg7yyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wY5862
	B9Hpm5ZzwUApWfAIa03cjosWjpTFZd6D+tpLS10GI/EeC0h31ZdBzBe6IBXKNV8a
	+rm+NhH9EZlmZs80AhT1sAl9Jxdb/fHXrpBc25MAVtp/XvVsD+uKbN0gSjNC5JV9
	xxxu7JvxALlYGdbZ3l6DSTf1G+hPnt+RrOUdY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D338946870;
	Fri,  4 Mar 2016 13:36:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D6AA4686D;
	Fri,  4 Mar 2016 13:36:46 -0500 (EST)
In-Reply-To: <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com> (Alexander
	Rinass's message of "Fri, 4 Mar 2016 15:37:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0C9808C4-E238-11E5-90E3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288265>

Alexander Rinass <alex@fournova.com> writes:

> Sticking a precompose_argv(argc, argv) into diff.c=E2=80=99s cmd_diff
> function fixes the issue.
>
> But I had to disable the check (precomposed_unicode !=3D 1) in
> precompose_argv to make it work. That=E2=80=99s probably because
> precompose_argv is usually called from parse_options and is
> missing some other call before it?

The "precomposed_unicode" bit comes from your configuration file,
so it won't be usable before you call into git_default_core_config
and that happens via a call to "git_config(git_diff_ui_config, NULL)".

So perhaps you'd want to add the argv munging immediately before
init_revisions() call there?
