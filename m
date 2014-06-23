From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Mon, 23 Jun 2014 16:14:42 -0700
Message-ID: <xmqqwqc79q1p.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:14:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzDRt-0004Uw-8R
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 01:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbaFWXOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 19:14:49 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61862 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbaFWXOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 19:14:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37BB523266;
	Mon, 23 Jun 2014 19:14:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SJVzAPBmMq4lGBcPG6zAePYnoyE=; b=D+Aq9H
	0eXkwRXeLWGMcvLlF56L37un9jb/tkH7Ifnfv6pPri4eaDEZegnOurPQpwtbHGGT
	+ylMFonDMR1A2yAM8N15NuEMxgwPHbHCDwAebdBjFl9tc3m2zlHGJIhESbHd0Tna
	Ny1jBQwuBtoJ/qIj9ZvPrV8Gqzq/hu3dUj22Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TXg7gUYbtdrRm7XUBzmzvJyzMPXV0VZi
	6idH79PQmETglzJ/m7kXiYPsgSJhW/yZjEKmBYe7xc3qgfTqtI8rgw6jPDvD+LI8
	XwRsPVGevMpBwvcMoIlyo0JJYG+YLwh9+Y1l7iyMI2wo+qJR7lXJumcvDYRqJI9n
	X3J777UQZJk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D93123265;
	Mon, 23 Jun 2014 19:14:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B376D23264;
	Mon, 23 Jun 2014 19:14:39 -0400 (EDT)
In-Reply-To: <1403518300-23053-3-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 23 Jun 2014 03:11:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 26B07650-FB2C-11E3-BC9E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252377>

Tanay Abhra <tanayabh@gmail.com> writes:

> +static int hashmap_initialized;
> + ...
> +static struct hashmap *get_config_cache(void)
> +{
> +	static struct hashmap config_cache;
> +	if (!hashmap_initialized) {
> +		config_cache_init(&config_cache);
> +		hashmap_initialized = 1;

I find the arrangement of these two variables somewhat dubious at
the API design level.

If you are going to keep the singleton "config_cache" as a function
scope static, shouldn't the corresponding guard also be in the same
scope?

If you ever need to "uninitialize" to force re-read the file to the
in-core cache, such an uninitializer will need access to not just
the "is hashmap initialized?" boolean (which you do by having it as
a file-scope global like this patch does) but also the thing that
may need to be uninitialized (i.e. the hashmap that may already be
populated), but a function scope static variable config_cache does
not allow access from other places, so you end up calling this
function to initialize it if necessary only to get the pointer to
that structure in order to uninitialize it.

Sounds very twisted and ugly, doesn't it?
