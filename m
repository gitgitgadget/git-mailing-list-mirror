From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 3/4] Support ref namespaces for remote repositories via
 upload-pack and receive-pack
Date: Thu, 02 Jun 2011 16:05:23 -0700
Message-ID: <7v8vtjdebw.fsf@alter.siamese.dyndns.org>
References: <1306887870-3875-1-git-send-email-jamey@minilop.net>
 <1306887870-3875-3-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Jeff King <peff@peff.net>,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSGxX-0004D8-Bd
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 01:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab1FBXFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 19:05:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab1FBXFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 19:05:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D8A94686;
	Thu,  2 Jun 2011 19:07:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dao8TV5M6eFI2ckGc51wU8kkNaU=; b=asK24x
	MBJrrsG5D6n2NsKP65CXhsvBmheg4sMP7rTvSa3NwMfXyv6BGOmuNMWIoA/dJ3rQ
	sSlZIQgZ4v/uKGCF42xunucdsqfeMdeo6q+Icsddb3Az1SlYBzERQNQjIVLbAhda
	v4MZUyp1KCLa6uRab1qLMjVy30/In3NF2Gtvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G8mbIld4YJKX0nNQ7SNg3UwCUCnbM9XE
	GCYsqRAALhkQxwSYkx1nRuxB1aoDd+O4r9zSjDzYjdVTYZmmLgnQz2LSzJSqxcqI
	YW4DsLu4oyHhLQ5h6M5hQUtTiIUf3YOczyGLgydvLxfCZjRIXrx/WSp2LUPxT0CS
	X0zKtE8ZAM4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D89484682;
	Thu,  2 Jun 2011 19:07:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D1CBB4675; Thu,  2 Jun 2011
 19:07:32 -0400 (EDT)
In-Reply-To: <1306887870-3875-3-git-send-email-jamey@minilop.net> (Jamey
 Sharp's message of "Tue, 31 May 2011 17:24:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E28BD38-8D6D-11E0-B73C-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174986>

Jamey Sharp <jamey@minilop.net> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index e1a687a..9bb268a 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -109,6 +109,7 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  
>  static int show_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
>  {
> +	path = path ? strip_namespace(path) : "capabilities^{}";
>  	if (sent_capabilities)
>  		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
>  	else

This feels really ugly.

Logically the stripping of "path" should happen before the caller calls
this function, as the purpose of this function is "given a token and
object name, produce one line of 'I have this at here' protocol message,
which is defined to have the capability list tucked after the first of
such messages in an exchange". It now is "the token has to be a path in a
namespace; the only exception is when the token is NULL, in which case we
always send 'capabilities^{}'".

It also is a very selfish solution for an immediate issue(*) that does not
give much considertation for people who may want to add new things in the
future, as the _only_ possible special case is to send in NULL.

The immediate issue you wanted to solve, I think, is that it is not
convenient to strip in the caller as this is a callback. Still, I think it
should be easy to do something like...

	static int show_ref_message(const char *path,
        				 const unsigned char *sha1)
	{
		... original show_ref() implementation comes here ...
	}

        static int show_ref_cb(const char *path,
			        const unsigned char *sha1,
                                int flag, void *cb_data)
	{
		return show_ref_message(strip_namespace(path), sha1);
        }
        
and give the latter as the callback to for_each_ref_in_namespace().

And the call to run "capabilities^{}" when there is no ref can call
show_ref_message() directly.
