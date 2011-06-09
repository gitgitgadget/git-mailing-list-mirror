From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/19] transport-helper: export is no longer always the
 last command
Date: Wed, 08 Jun 2011 18:07:10 -0700
Message-ID: <7vsjrjzubl.fsf@alter.siamese.dyndns.org>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-18-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 03:07:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUTie-0003X2-Jy
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 03:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab1FIBH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 21:07:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59365 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab1FIBH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 21:07:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A090959B5;
	Wed,  8 Jun 2011 21:09:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cKmd4sIoMd1WU++Pp01z9GGxLIk=; b=A8O9GX
	1CJUyqba8hQPop/80ztMgDT68soYLP0KiWJgxkv1FVq5rJ79dBvWVZAZ313M8UVr
	HZSB7YNVBgWCychb3XDfrdLls03nP5FVrG5XwcDymBSTVBsGdo+AFL9M5QGysZhZ
	mBIOa1m6wOI7PrUhDyDwmhVD0Mv94eAzBZ3cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QZwqouZEfYDpEd/uF65tNMXZwUOcROvA
	7lCjMNOccM9UJi+DUivE8bD8AlWcYhoJ25sNw7DOq9gAtqRMB9x3Iz7S8k9K+fHj
	vBNnBMZa1Fn4ro0i5sPh+2bQze1p12+kJ6OayED6Cisre0x1rSD/pRtJhLKEtFET
	FvN+tZMO764=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DA3E59AB;
	Wed,  8 Jun 2011 21:09:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6432559A9; Wed,  8 Jun 2011
 21:09:21 -0400 (EDT)
In-Reply-To: <1307558930-16074-18-git-send-email-srabbelier@gmail.com>
 (Sverre Rabbelier's message of "Wed, 8 Jun 2011 20:48:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20292FCE-9235-11E0-B23A-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175482>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Now that the remote helper protocol uses the new done command in its
> fast-import streams, export no longer needs to be the last command in
> the stream.
>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> ...
> diff --git a/transport-helper.c b/transport-helper.c
> index c089928..f78b670 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -762,7 +762,6 @@ static int push_refs_with_export(struct transport *transport,
>  			 export_marks, import_marks, &revlist_args))
>  		die("Couldn't run fast-export");
>  
> -	data->no_disconnect_req = 1;
>  	if (finish_command(&exporter))
>  		die("Error while running fast-export");
>  	push_update_refs_status(data, remote_refs);

I've looked at fa8c097 (Support remote helpers implementing smart
transports, 2009-12-09) which introduced this no_disconnect_req field,
73b49a7 (remote-helpers: add support for an export command, 2010-03-29)
which added push_refs_with_export() and made it set the field to 1, and
also have read Documentation/git-remote-helpers.txt, but fail to see the
connection between "this command no longer needs to be the last one" and
"we do not set no-disconnect-req to 1, so that we do not send an empty
line when we disconnect the helper".

Could you clarify the logic, perhaps by commenting a bit more where this
field is examined and code changes its behaviour in disconnect_helper()?
