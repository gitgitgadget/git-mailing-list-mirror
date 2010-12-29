From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack_trees(): skip trees that are the same in all
 input
Date: Wed, 29 Dec 2010 11:15:51 -0800
Message-ID: <7vd3oktmoo.fsf@alter.siamese.dyndns.org>
References: <7vr5d94fs4.fsf@alter.siamese.dyndns.org>
 <AANLkTinm=k_84Nh4YakbkdNNLO4-yeVxGF+p_rR5TFB=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 29 20:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PY1VL-0000A0-An
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 20:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab0L2TQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Dec 2010 14:16:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab0L2TQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 14:16:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 916B73385;
	Wed, 29 Dec 2010 14:16:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLLFPy5oFuK4LPLotvSJIym/YaU=; b=dUHPFF
	LaMMniX1OlRIwNGOlgnVnRgzqayjxZWytmggakw5WdgOYEjI3Canwx4CnWcHlSPj
	pihEHlFDKfBKamljRk7FteRjBxC+gsmE/Sp1yQTv3/DJe1Dkv2if96NUWwwmUuqu
	cJ0VXiXMcT1PUdjvLdXHoU3Qwaa4heJPkJsCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xb8M6QthujoyRW9KyQ4N7v6muDbQRa25
	wqdWG8s6zPbvJv1Bkr2LtCetzh/oTrnUjVaBAV2W80FDKDnojVYfrAYmOzXcTceo
	dC4nMXqXhDnzeAshf+vvLSJsNUmwp8lo5x6MIebhAQsR77gl/KA87g5AGomrhOuJ
	ZBpsTLToq9A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D0A93383;
	Wed, 29 Dec 2010 14:16:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B3913366; Wed, 29 Dec 2010
 14:16:26 -0500 (EST)
In-Reply-To: <AANLkTinm=k_84Nh4YakbkdNNLO4-yeVxGF+p_rR5TFB=@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed\, 29 Dec 2010 21\:43\:09 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24B06424-1380-11E0-A1A2-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164322>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Dec 23, 2010 at 5:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -447,6 +451,11 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
>>        struct traverse_info newinfo;
>>        struct name_entry *p;
>>
>> +       if (!df_conflicts) {
>> +               int status = fast_forward_merge(n, dirmask, names, info);
>> +               if (status)
>> +                       return status;
>> +       }
>
> Also skip the optimization when sparse checkout is active
> (info->data->skip_sparse_checkout == 0). People may need to just
> update skip-worktree bits and add/remove worktree files along the
> line.

Sounds sensible and safer to special case that one, I would agree.

By the way, I think info->data->skip_sparse_checkout should be fixed by
renaming it to info->data->sparse_checkout.  The flag controls a special
case logic that should not be in effect unless explicitly asked, and
forcing normal codepath to say "If skip_sparse_checkout is not false, do
this" in double-negative is unnice than "If sparse_checkout is in effect,
please run this special case" when reading the code.
