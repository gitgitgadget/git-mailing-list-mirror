From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Thu, 14 Mar 2013 10:33:36 -0700
Message-ID: <7vehfhyjgv.fsf@alter.siamese.dyndns.org>
References: <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org> <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
 <7vtxof48sg.fsf@alter.siamese.dyndns.org>
 <7v1ubj45ac.fsf@alter.siamese.dyndns.org>
 <20130314094300.GN2317@serenity.lan> <20130314172515.GB4256@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 18:34:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGC2X-0001aI-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 18:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933910Ab3CNRdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 13:33:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51826 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755902Ab3CNRdi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 13:33:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A36BC8E;
	Thu, 14 Mar 2013 13:33:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+4zm2reQUtdWNIJVExuSbbok3lA=; b=QxtGe1
	v/vHWPZZshbZMH2R7mN10gEzcVT9g7Sfo1hi6G/yHnj4aFs4IIC3GCtkiPxgOxQx
	Sdak2RHowLrEX4ID12yTVFi+pLp70Yw0abH4bjOtvkKH/XM8B5yOGDG3/4V+tV1w
	BgXdjlt5r5QWeMrBlLi+XS5WRRrbWeZ2eoacM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D3MjJhEEdaQ1oXzvV9W3n6Q+ngQOTO9H
	kbkkin7CmQTq7Ks3sihrw4d4cerhNPyIqoi6VrvmfLmC9Gd7wdIF4qbtSUYiHtTz
	OLD7JBayTGxFWfLs8iergzoY6G3SYlY1z3NK+cPPs/xwtMqt98KFlllco8AVMJMH
	Jl1xtgfkcDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 170E5BC8C;
	Thu, 14 Mar 2013 13:33:38 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CEC3BC8A; Thu, 14 Mar 2013
 13:33:37 -0400 (EDT)
In-Reply-To: <20130314172515.GB4256@serenity.lan> (John Keeping's message of
 "Thu, 14 Mar 2013 17:25:15 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DCADF9C-8CCD-11E2-86E5-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218157>

John Keeping <john@keeping.me.uk> writes:

> The path passed to get_stream_filter is only used to decide what filters
> apply to the file, so shouldn't it be using "ce->name" and not "path"
> for the same reason that the call to convert_to_working_tree() further
> down the same function does?

Correct and well spotted.

>
> -- >8 --
> diff --git a/entry.c b/entry.c
> index 17a6bcc..63c52ed 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -145,7 +145,7 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
>  	struct stat st;
>  
>  	if (ce_mode_s_ifmt == S_IFREG) {
> -		struct stream_filter *filter = get_stream_filter(path, ce->sha1);
> +		struct stream_filter *filter = get_stream_filter(ce->name, ce->sha1);
>  		if (filter &&
>  		    !streaming_write_entry(ce, path, filter,
>  					   state, to_tempfile,
