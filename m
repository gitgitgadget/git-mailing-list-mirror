From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow hideRefs to match refs outside the namespace
Date: Wed, 28 Oct 2015 09:21:59 -0700
Message-ID: <xmqq1tcfm09k.fsf@gitster.mtv.corp.google.com>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
	<1446046920-15646-1-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 17:22:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrTUH-0003Dp-N3
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 17:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966042AbbJ1QWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 12:22:05 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965430AbbJ1QWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 12:22:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0F8724B08;
	Wed, 28 Oct 2015 12:22:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8UAPBWd9KKpr7wz3W6V4boHNpUs=; b=FKfXda
	gN+ircfna0/rPLYZwfiPhGu1MXZOHvBnGI0T69nbhu1/bt1BFKs9HVeixEvHVNyC
	+i9il06gb10NznruRE/wF/DS1sf7BXQsSPcHjfdJkKs6J7VR0fk31MITO1xW8hJn
	ahDymD6uDPW2Pn1y+ZWSioFwIZvwsYysNa1IM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nxsbgOW5NjS0wEPRLASxRrswiT1BwzLG
	pYzt+0h/5SR8Q1OvTzK84rqxvr/bcAnwDYYJV1YcomXLogMZSu8uCJqEZq/9NDGE
	hclGYg8A9fL0MJ8OhD6i6nWsOW0VgJ4jaOd3+foBVI7lQdxJsCHfZP57RiSPdF70
	M1ITWscrOTg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2C7724B06;
	Wed, 28 Oct 2015 12:22:01 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C27BD24B05;
	Wed, 28 Oct 2015 12:22:00 -0400 (EDT)
In-Reply-To: <1446046920-15646-1-git-send-email-lfleischer@lfos.de> (Lukas
	Fleischer's message of "Wed, 28 Oct 2015 16:42:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0473BA60-7D90-11E5-997A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280374>

Lukas Fleischer <lfleischer@lfos.de> writes:

> Right now, refs with a path outside the current namespace are replaced
> by ".have" before passing them to show_ref() which in turn checks
> whether the ref matches the hideRefs pattern. Move the check before the
> path substitution in show_ref_cb() such that the hideRefs feature can be
> used to hide specific refs outside the current namespace.
>
> Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> ---
> The other show_ref() call sites are in show_one_alternate_sha1() and in
> write_head_info(). The call site in show_one_alternate_sha1() is for
> alternates and passes ".have". The other one is
>
>     show_ref("capabilities^{}", null_sha1);
>
> and is not relevant to the hideRefs feature. Note that this kind of
> breaks backwards compatibility since the "magic" hideRefs patterns
> ".have" and "capabilities^{}" no longer work, as explained in the
> discussion.

If somebody is using namespaces and has "refs/frotz/" in the
hiderefs configuration, we hide refs/frotz/ no matter which
namespace is being accessed.  With this change, with the removal the
check from show_ref(), wouldn't such a repository suddenly see a
behaviour change?

>  builtin/receive-pack.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index bcb624b..4a5d0ae 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -195,9 +195,6 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  
>  static void show_ref(const char *path, const unsigned char *sha1)
>  {
> -	if (ref_is_hidden(path))
> -		return;
> -
>  	if (sent_capabilities) {
>  		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
>  	} else {
> @@ -221,6 +218,9 @@ static void show_ref(const char *path, const unsigned char *sha1)
>  
>  static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
>  {
> +	if (ref_is_hidden(path))
> +		return 0;
> +
>  	path = strip_namespace(path);
>  	/*
>  	 * Advertise refs outside our current namespace as ".have"
