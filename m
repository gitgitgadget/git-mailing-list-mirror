From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default
 configuration setting.
Date: Thu, 05 Jul 2012 15:50:59 -0700
Message-ID: <7v4nplrfe4.fsf@alter.siamese.dyndns.org>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com>
 <1341526277-17055-3-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Fri Jul 06 00:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmutC-0002BM-NP
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 00:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757440Ab2GEWvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 18:51:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38913 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681Ab2GEWvC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 18:51:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94F4A960B;
	Thu,  5 Jul 2012 18:51:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jVGOiPmPR+aLj1F6yoM2x5hdqRg=; b=pxQKYZ
	ud0lrOthiQ44pWN784gsNI/UWAwxD6jNJbc8Wz+dtlOikgsjuKS/DTBUC+kKBkaU
	MTLOym8IrQn2Gu6FNSTYfFdIw4h92m10Aat4iy2/9dpoZ9CwHuUWZDIHT+6P7XBF
	osQEb8RlYrZodr6qmFpSMzFnx3WqwWgNJmYs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tzkobqNWPnklC0Vui97lkhnxnh1PzsaH
	LlkudsZZPNkXtJhuSnRPdNXL4/arr2s47EqeYDo1Cz1h/ueseF61Ulw7tKgGWV+v
	NGUnZZZxba/ny+7mmfCfb+THS+oQErg+RlDb9VpCSvmNrGHYxWem0owoLPC+/N8P
	SfSUDHjw05I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C87D960A;
	Thu,  5 Jul 2012 18:51:01 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0638A9608; Thu,  5 Jul 2012
 18:51:00 -0400 (EDT)
In-Reply-To: <1341526277-17055-3-git-send-email-marcnarc@xiplink.com>
 (marcnarc@xiplink.com's message of "Thu, 5 Jul 2012 18:11:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E479FA2C-C6F3-11E1-B1E3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201073>

marcnarc@xiplink.com writes:

> From: Marc Branchaud <marcnarc@xiplink.com>
>
> The code now has a default_remote_name and an effective_remote_name:
>  - default_remote_name is set by remote.default in the config, or is "origin"
>    if remote.default doesn't exist ("origin" was the fallback value before
>    this change).


>  - effective_remote_name is the name of the remote tracked by the current
>    branch, or is default_remote_name if the current branch doesn't have a
>    remote.

The explanation of the latter belongs to the previous step, I think.
I am not sure if "effective" is the best name for the concept the
above explains, though.

> @@ -390,6 +391,7 @@ static int handle_config(const char *key, const char *value, void *cb)
>  	}
>  	if (prefixcmp(key,  "remote."))
>  		return 0;
> +

Why?

>  	name = key + 7;
> @@ -671,6 +680,18 @@ static int valid_remote_nick(const char *name)
>  	return !strchr(name, '/'); /* no slash */
>  }
>  
> +const char *remote_get_default_name()

const char *remote_get_default_name(void)

> +{
> +	read_config();
> +	return default_remote_name;
> +}

Hrmph.  I am too lazy to read outside the context of your patch to
make sure, but isn't the root cause of the problem that when we try
to find which remote the current branch is configured to interact
with, we grab branch->remote_name (and this is done by calling
git_config() to open and read the configuration file once already)
and if it is empty we default to "origin"?  Wouldn't the callback
function that is used for that invocation of git_config() a much
better place to set "default_remote_name" variable, instead of
having us to read the entire configuration file one more time only
to get the value of this variable?

> +int remote_count()

int remote_count(void)

> +{
> +	read_config();
> +	return remotes_nr;
> +}

Likewise.  Especially it is unclear who benefits from the function
until a new caller is introduced.  I would prefer not to see the
addition of this function in this patch.

>  struct remote *remote_get(const char *name)
>  {
>  	struct remote *ret;
> diff --git a/remote.h b/remote.h
> index 251d8fd..f9aac87 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -52,6 +52,8 @@ struct remote {
>  
>  struct remote *remote_get(const char *name);
>  int remote_is_configured(const char *name);
> +const char *remote_get_default_name();
> +int remote_count();

const char *remote_get_default_name(void);
int remote_count(void);
