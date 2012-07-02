From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 14/18] sha1_name.c: many short names can only be
 committish
Date: Mon, 02 Jul 2012 16:01:52 -0700
Message-ID: <7vipe5ydgf.fsf@alter.siamese.dyndns.org>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <1341268449-27801-15-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 01:02:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Slpd9-0006KO-Na
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 01:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456Ab2GBXCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 19:02:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51094 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab2GBXBz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 19:01:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D59409653;
	Mon,  2 Jul 2012 19:01:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ixj51j50H4Z2jHig8PEhGqTN0YQ=; b=fqoTqZ
	XDXKZmWrzETgVvcgFSiwSsth7B25zh9glk2kOi/5s7o/xY7sinhnlvCpgLscvamj
	mY16bAPKNaaEeeDqNE6D5gfRSSdw6JeCEdIvDaAfCmZOjpG+CLP5Rag/UuTc2iez
	whDFaSBLN8Uj4cQfaA3PORRmAoLvv79Tqes+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lvgF9bpXngiH5isXObjUhW4bxCcqe0l1
	SYBWo1bjza656f1AAAIFAPWPA4m1aXcipqOZkiIeZX5D0M5HCVxvADEFBoO2i/aj
	/rv5jcokj4WslygsXFil08olDayvw69JeMfF+PlpdoaKHsv5JVtNL1N/VaQfgn7/
	/vaOtH7x41k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9D29652;
	Mon,  2 Jul 2012 19:01:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60A2F9651; Mon,  2 Jul 2012
 19:01:54 -0400 (EDT)
In-Reply-To: <1341268449-27801-15-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Mon, 2 Jul 2012 15:34:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAACCC1E-C499-11E1-B5B6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200889>

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/sha1_name.c b/sha1_name.c
> index 6f6c49c..35ad473 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -519,6 +539,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  	unsigned char outer[20];
>  	const char *sp;
>  	unsigned int expected_type = 0;
> +	unsigned lookup_flags;

This needs to be initialized to 0, i.e.

	unsigned lookup_flags = 0;

for the following two hunks to make sense.

> @@ -554,7 +575,10 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
>  	else
>  		return -1;
>  
> -	if (get_sha1_1(name, sp - name - 2, outer, 0))
> +	if (expected_type == OBJ_COMMIT)
> +		lookup_flags = GET_SHA1_COMMITTISH;
> +
> +	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
>  		return -1;
>  
>  	o = parse_object(outer);
> @@ -666,7 +690,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned l
>  	if (!ret)
>  		return 0;
>  
> -	return get_short_sha1(name, len, sha1, 0);
> +	return get_short_sha1(name, len, sha1, lookup_flags);
>  }
>  
>  /*
