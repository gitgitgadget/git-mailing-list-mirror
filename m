From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jn/fast-import-fix v3] fast-import: treat filemodify with
 empty tree as delete
Date: Wed, 26 Jan 2011 16:04:23 -0800
Message-ID: <7vd3nji54o.fsf@alter.siamese.dyndns.org>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino> <20110103082458.GC8842@burratino>
 <20110126224104.GA20388@burratino>
 <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
 <20110126230608.GA26787@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 01:04:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiFM4-0006Ts-Am
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 01:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab1A0AEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 19:04:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484Ab1A0AEn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 19:04:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3894E4D79;
	Wed, 26 Jan 2011 19:05:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FQBzco6MMdxCJ4yc/zOXZWEUAzw=; b=vHALHlmdZJoPe8dfF7ukHNt
	1BOvahEBYD9KMiPTB+1RB8qMrI8l67Ip0WdCc+oT6XipwUsfQOSmXsNvAE1iiYuy
	JUmO12bqV23kpmIbaLo/nVbEO0o16R1BYxkxXJtXf6F6wgzLa2d9ZUjafRPDCWUs
	mZm6Wn1npBz49aLy9oIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RO+JGoZmDEw4U3TBTcgcx2jCwz4mgyGo0Xht+EJLibTg0jkSM
	XHx92hjH0pl5fEz2TFuWOhiZRWljjqo+r9XBA1Ux2r0LO/y4uOM3p5s986GybGQ3
	Zy+k5baFIhwqG645W+yg9WyG2Y5H9b6ehDcUr7V2K21/vl2dvHRSntTHLA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 447104D77;
	Wed, 26 Jan 2011 19:05:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3FC924D6D; Wed, 26 Jan 2011
 19:05:16 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 241132AC-29A9-11E0-8FEC-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165563>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Sverre Rabbelier wrote:
>
>> Should it go on maint now that it's factored out, since it shipped in
>> 1.7.3, or just master?
>
> Hmm.  I suppose on top of b2124125 (jn/fast-import-fix).

Hmm, why not on top of v1.7.3-rc0~75^2 aka 334fba6 (Teach fast-import to
import subtrees named by tree id, 2010-06-30) then?

> While applying it there I noticed that the change to t9300 includes an
> unrelated change (residue of an old rebase).  Here's a fixed version.

> diff --git a/fast-import.c b/fast-import.c
> index d881630..9cf26f1 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2194,6 +2194,16 @@ static void file_change_m(struct branch *b)
>  		p = uq.buf;
>  	}
>  
> +	/*
> +	 * Git does not track empty, non-toplevel directories.
> +	 */
> +	if (S_ISDIR(mode) &&
> +	    !memcmp(sha1, (const unsigned char *) EMPTY_TREE_SHA1_BIN, 20) &&

Do you need this cast?
