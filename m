From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t7508: demonstrate status's failure to use
 --porcelain format with -z
Date: Thu, 26 May 2011 14:45:01 -0700
Message-ID: <7v4o4hw2zm.fsf@alter.siamese.dyndns.org>
References: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 26 23:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPiMu-0000yB-QO
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab1EZVpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:45:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab1EZVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:45:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B349259B3;
	Thu, 26 May 2011 17:47:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C36ln/TPoMjYA6d4HlrIKeR+dzA=; b=hCoVpj
	lhPWU7z9MSZHnlSd8p7yV5Kd5NiblfbihwnIGZda6RSqmEQ2UNHDP/gWqUYCsroK
	XDptdt1oXuX8w7iNzeA9vF+acGevEdLKpr/UjpPpTs+24A9vo6jAKd4cfR7vb54C
	PZE8VsDauKGg+eo0Zhiou/DXop16r8f0Sadmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cbXfn5b8NaIzvami2RRlT5BcJAS8OS9f
	go4QT70aiLBg1L31bUvi0q0Ew3L3g5sF8qGOaBgpFFZH67usAuf7AktENPcJviky
	8wvfflLWVzbJfbfaHm8UyNcklolnU7zuSRFE/DxUmngoiWCk7hC/kHABAdRQlPwi
	EVT8l75MVH8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 71CF759AE;
	Thu, 26 May 2011 17:47:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E4AC45988; Thu, 26 May 2011
 17:47:09 -0400 (EDT)
In-Reply-To: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 26 May 2011 13:43:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B87EA6FE-87E1-11E0-A803-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174578>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> When 'git status' is supplied the -z switch, and no output format has been
> selected, it is supposed to use the --porcelain format.  This does not
> happen.  Instead, the standard long format is used.  Add a test to
> demonstrate this failure.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>

I didn't even know we attempted to default to porcelain when -z is given,
even though it is a logical thing to do in the sense that nobody sane
would want to read a NUL-terminated human readable format.

I'll rewrite the test to avoid hardcoded and context dependent
test vector, like this:

    test_expect_failure 'status -z implies porcelain' '
           git status --porcelain |
           perl -pe "s/\012/\000/g" >expect
           git status -z >output &&
           test_cmp expect output
    '

as the only thing you are interested in is the two output to match
identically modulo the record termination.

By the way, don't we however also want to make sure -z does not kick in
automatically when other options like "short" or "normal" is given?
