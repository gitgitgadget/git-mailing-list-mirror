From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] Make "subtree" part more orthogonal to the rest of
 merge-recursive.
Date: Wed, 25 Nov 2009 22:17:07 -0800
Message-ID: <7v638xeroc.fsf@alter.siamese.dyndns.org>
References: <cover.1259201377.git.apenwarr@gmail.com>
 <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
 <73a42e99b4a083c74b017caf2970d1bbf5886b96.1259201377.git.apenwarr@gmail.com>
 <1ff0b2f7e3fae4cc6c7610c92711f33df9a3d07c.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <c78d4c177f470e0f2f64314321df12e1a59077bf.1259201377.git.apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:17:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDXfO-0008DO-L4
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 07:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbZKZGRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 01:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754568AbZKZGRJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 01:17:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbZKZGRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 01:17:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FA14A1BB8;
	Thu, 26 Nov 2009 01:17:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=GB5bSazWOS/rWS8bjbQ1wjrdt+w=; b=qw7+PhE4BeH9PB+/SYwVx/d
	pADk8QAXWXyT338he4IdEn+z7Xj5l5eecDshei52MagaHcdOsqkl266LcHMTUuYy
	yxjyuAukgN0UuvcUUxnDzr5R9PNvVIt5wMsaJufeXH6lJHQqAymaCz8A8XTZCGVg
	NJqqwhBpfvfgAkFfDlzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JnS92ljKTlyXOd8gIdCTyaTPzFlaTUy95Fa+SY8c6ScEGj6jn
	KsoTLM/CKYZrmeUR1aEx8WrDDg/1Eh8fUbCg80Bn2k0x839xSxcmHuLy2p6XfmTr
	poEbUNx9daiWWlvkKtNXJOmhuxMO7g1CjXwuRE2bD4K6DKYqXCZRJ5zvQA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3F423A1BB7;
	Thu, 26 Nov 2009 01:17:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB7F7A1BB6; Thu, 26 Nov 2009
 01:17:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56446876-DA53-11DE-A04D-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133768>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 257bf8f..79b45ed 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -21,7 +21,8 @@
>  #include "merge-recursive.h"
>  #include "dir.h"
>  
> -static struct tree *shift_tree_object(struct tree *one, struct tree *two)
> +static struct tree *shift_tree_object(struct tree *one, struct tree *two,
> +				      const char *subtree_shift)
>  {
>  	unsigned char shifted[20];
>  
> @@ -29,7 +30,12 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two)
>  	 * NEEDSWORK: this limits the recursion depth to hardcoded
>  	 * value '2' to avoid excessive overhead.
>  	 */
> -	shift_tree(one->object.sha1, two->object.sha1, shifted, 2);

The block comment with NEEDSWORK should be removed from here.  I may have
forgotten to in the original one, but that is not an excuse to replicate a
bad job ;-)
