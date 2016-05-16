From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 8/9] connect: actively reject git:// urls with a user part
Date: Mon, 16 May 2016 15:41:20 -0700
Message-ID: <xmqqmvnpzkvj.fsf@gitster.mtv.corp.google.com>
References: <20160516000740.19042-1-mh@glandium.org>
	<20160516000740.19042-9-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 17 00:41:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2RCb-0007et-GO
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148AbcEPWlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:41:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752113AbcEPWlY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:41:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E323519036;
	Mon, 16 May 2016 18:41:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WYPQoWPIXVohMoRQOSdlj7g8myI=; b=G+PJPO
	FMClUBPWgUWA57gd8/weFg9mv+xv+gHycyOQ4Pl6pYwno28Q2AUt/IWsPCmkaFvS
	MZ3hrNL7HKZh1gZV1Obr3V8acWoJ0ggNfkJqYsRMRS7UHAOohIRlzJYclJXAHjo1
	y47twBmDl9QUaPaLcqBGzZAPoJjEsAsFI/iYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O7Tth3LRBZPyqkIjwagkTMkxmz8REP5E
	9sDM8ZgyLvsbU/pYeISriuszsEyK3rpXPDf26dVy7vWcX09H0c4kGEqO19yN7Qpy
	AXdogexlRyN5x7Q5E6A8bGPy4UkV82muzKyaQYjEDWLldP1PPjo+doWn+hdDLDgQ
	xZdaGxYswb4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DB9951902F;
	Mon, 16 May 2016 18:41:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 527591902E;
	Mon, 16 May 2016 18:41:23 -0400 (EDT)
In-Reply-To: <20160516000740.19042-9-mh@glandium.org> (Mike Hommey's message
	of "Mon, 16 May 2016 09:07:39 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51032DF0-1BB7-11E6-8B60-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294811>

Mike Hommey <mh@glandium.org> writes:

> Currently, urls of the for git://user@host don't work because user@host
> is not resolving at the DNS level, but we shouldn't be relying on it
> being an invalid host name, and actively reject it for containing a
> username in the first place.

Makes sense.  Connecting to host by stripping user@ would probably
give us a better behaviour, but this is a good first step even if we
are aiming for that endgame state.

>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  connect.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/connect.c b/connect.c
> index df15ff3..fdd40b0 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -716,6 +716,9 @@ struct child_process *git_connect(int fd[2], const char *url,
>  		 */
>  		struct strbuf target_host = STRBUF_INIT;
>  		char *override_vhost = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
> +		if (user)
> +			die("user@host is not allowed in git:// urls");
> +
>  		if (override_vhost)
>  			strbuf_addstr(&target_host, override_vhost);
>  		else {
