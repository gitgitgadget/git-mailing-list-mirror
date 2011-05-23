From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 02/10] send-pack: Attempt to retrieve remote status
 even if pack-objects fails
Date: Mon, 23 May 2011 13:06:49 -0700
Message-ID: <7vei3puqp2.fsf@alter.siamese.dyndns.org>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-3-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 23 22:07:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObP8-0007aF-4B
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198Ab1EWUHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:07:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab1EWUG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:06:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1918052DE;
	Mon, 23 May 2011 16:09:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=69qHOIw0qBMq0l7MH2iy5JmV+n8=; b=o89QP/
	uDphC6YXhvTFWYQ69okUenbDi6VpSzEz7d9Z/vh1pIGahQRM7sS7QkQ6Zt2iUIkX
	RIu0uTSKU6gupswiCtsTCR6hYUHUalTq93Kz8m2mk2zNpv8dvb0NuHjojCAdPg/q
	Cgkgc6w/Ke0qa42K4HBtpvVnkNxkgikxaDYAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GmyM9LpwAsxGV/aKf01/cdbE4DXtnPVu
	fdvePnFI5UhYtXjuWmMGuo1UB8NpwMDZxsGr9TCFb5dJMe5LpjFzgl92bql73V+T
	eLv+ZX5bOmTYn5JWjar+klgKz2ytFowx2vtsqUm0z3azDxKuwLeby6/7zEgZ6WR/
	oi3O1tgt2J0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC49C52DA;
	Mon, 23 May 2011 16:09:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A48BC52D5; Mon, 23 May 2011
 16:08:59 -0400 (EDT)
In-Reply-To: <1306111923-16859-3-git-send-email-johan@herland.net> (Johan
 Herland's message of "Mon, 23 May 2011 02:51:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 819BFD1E-8578-11E0-B12A-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174265>

Johan Herland <johan@herland.net> writes:

> Therefore, we should try to read from the remote end, even when pack-objects
> dies unexepectedly. We accomplish this by _always_ calling receive_status()
> after pack_objects(). If the remote end managed to produce a well-formed
> status report before exiting, then receive_status() simply presents that to
> the user. Even if the data from the remote end cannot be understood by
> receive_status(), it will print that data as part of its error message. In
> any case, we give the user as much information about the failure as possible.

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index c1f6ddd..5ba5262 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -251,7 +251,7 @@ int send_pack(struct send_pack_args *args,
>  	int status_report = 0;
>  	int use_sideband = 0;
>  	unsigned cmds_sent = 0;
> -	int ret;
> +	int ret = 0;
>  	struct async demux;
>  
>  	/* Does the other end support the reporting? */
> @@ -339,25 +339,18 @@ int send_pack(struct send_pack_args *args,
>  	}
>  
>  	if (new_refs && cmds_sent) {
> -		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
> -			for (ref = remote_refs; ref; ref = ref->next)
> -				ref->status = REF_STATUS_NONE;
> +		if ((ret = pack_objects(out, remote_refs, extra_have, args))) {

I am not very familiar with this codepath, but you no longer set ref->status
to REF_STATUS_NONE ...

> ...
>  	if (status_report && cmds_sent)
> -		ret = receive_status(in, remote_refs);
> -	else
> -		ret = 0;
> +		ret |= receive_status(in, remote_refs);

... before calling receive_status() here, and that function can return
early without setting anything.

Would that have any negative effect on the code that comes after this part
in the codepath?  or if receive_status() returns a failure, we do not even
look at ref->status?
