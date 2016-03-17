From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 00:51:58 -0700
Message-ID: <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com>
References: <56E9F5B3.6030903@fb.com>
	<20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Durham Goode <durham@fb.com>, git@vger.kernel.org,
	Mateusz Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:52:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agSj0-0007vo-BP
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 08:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbcCQHwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 03:52:02 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:61204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752002AbcCQHwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 03:52:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DDC1544461;
	Thu, 17 Mar 2016 03:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=doYHFgaG2yOkHccNhd50EuWCtag=; b=As4fTj
	qDN8FNzbcCUQcTl9husiiSuC7zMnfwKQBK3/ur5P1DnzUqBukzhG5NTiWqo1XEUv
	hQFN8e1Rtnm1rgJcaepsuFth3EG8NeYNH/zy7tqcNqjbaIlXf2cr9utl8IIYmQXM
	ZtpUkNj11Aa3YcHIk2D/q5oeBIgzwi9prDViU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RTa6tW7X5lvZpkXgIF1SdCKzInVjDJVo
	ehGo+Nnw5ryuepY7D2/yZS2O0wbyx8V9QeLIbCwkSKLjD798lUyKm5RxOJtDzc/n
	6JPCEiowAmtY9X9sDXgVZZtFj2kSQZKn075q5v9VpjGsMbIMUFLHWu30DqYI9bkK
	vq0L3FYsXfY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D5F4C4445E;
	Thu, 17 Mar 2016 03:51:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5BEDF4445D;
	Thu, 17 Mar 2016 03:51:59 -0400 (EDT)
In-Reply-To: <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal> (Duy
	Nguyen's message of "Thu, 17 Mar 2016 07:56:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 20D3E4CA-EC15-11E5-BBF2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289085>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Mar 16, 2016 at 05:09:23PM -0700, Durham Goode wrote:
>> Using git 2.8.0-rc2, given a repo with the following files:
>> 
>> - one/hideme
>> - one/donthide
>> - two/foo
>> 
>> A sparse config of:
>> 
>> cat > .git/info/sparse-checkout <<EOF
>> /*
>> !one/hideme
>> EOF
>> 
>> Results in a repository that only has `one/donthide` in it.  I would
>> expect `two/foo`to be present as well.  This worked in 2.6, and
>> bisecting it points to d589a67eceacd1cc171bbe94906ca7c9a0edd8c5
>> "dir.c: don't exclude whole dir prematurely" (author cc'd).
>
> Thank you. This should fix it. I think I understand why it goes
> wrong. I'm going to run some more tests and post a proper patch later.

I admit that I've always considered "sparse checkout" was an
uninteresting experimental feature that I do not want to pay too
much attention to, and the only review I did carefully myself was to
make sure that patches around that area would not change the
behaviour of the original code in repositories that do not use that
feature, so please do not laugh too loudly at me if I ask the
obvious ;-) So the pattern list in that info/sparse-checkout file
shares the same logic with the gitignore mechanism, and the paths
that would have been "ignored" if the pattern list were in the
.gitignore file are the ones that would be included in the checkout?

If so, among the three paths Durham lists:

 * one/hideme matches !one/hideme the last, i.e. it would not be
   ignored if the pattern appeared in .gitignore, hence it should not
   be in the checkout;

 * one/donthide matches * the last, i.e. would be ignored, hence it
   should be in the checkout;

 * two/foo (or really anything) matches * the last, i.e. would be
   ignored, hence it should be in the checkout.

Am I reading the bug correctly?

> -- 8< --
> diff --git a/dir.c b/dir.c
> index 69e0be6..77f38a5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1027,7 +1027,6 @@ static struct exclude *last_exclude_matching_from_list(const char *pathname,
>  				exc = x;
>  				break;
>  			}
> -			continue;
>  		}
>  
>  		if (x->flags & EXC_FLAG_MUSTBEDIR) {
> -- 8< --
> --
> Duy
