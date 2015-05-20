From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] for-each-ref: convert to ref-filter
Date: Wed, 20 May 2015 16:50:29 -0700
Message-ID: <xmqqvbfmlsfu.fsf@gitster.dls.corp.google.com>
References: <555C88C2.8060902@gmail.com>
	<1432127904-21070-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 01:50:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvDl1-0006Wi-0F
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 01:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbbETXue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 19:50:34 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33518 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbETXud (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 19:50:33 -0400
Received: by igbpi8 with SMTP id pi8so2763098igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 16:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7lHYok0UvgmibBjB0MAG+wKC+LgrBzYfxQSAJCnKPbg=;
        b=PXhFeNNfEgWlqmSmU8V/YGHWDtIagsfZu4Hv5QN0uT1U68FDUWtEZb8PJuZM6uf1FF
         3jnmRnPU9K8F/m09JeMyBk1wKzGqszoAfqkoOgQpmkhIhd9FL+EUYhV7Vv/dOXBhTI0b
         SGIMeIlearJXw1C8F4h2Zn9epE86Xhjv50807cTXeRYEBopJWNQHEPS64z9E5yuZQnDP
         Q5yJYx21FmZAQJzw2PrhqciJaC60h3oP3kdjSmAugFDj+W2awLp2H/x0AF5Dnu47h1Th
         FT22+lIwdBTs8Uth6ERjzxRzA1YWNAtw5Ok293qyTe8vHJjSMAJf+CJw0N74owt4amls
         IxNg==
X-Received: by 10.107.133.154 with SMTP id p26mr33339ioi.7.1432165832524;
        Wed, 20 May 2015 16:50:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id j20sm2759578igt.5.2015.05.20.16.50.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 16:50:31 -0700 (PDT)
In-Reply-To: <1432127904-21070-3-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Wed, 20 May 2015 18:48:23 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269535>

Karthik Nayak <karthik.188@gmail.com> writes:

> convert 'for-each-ref' to use the common API provided by 'ref-filter'.

Start a sentence with capital?

More importantly, the above is misleading, as if you invented a new
ref-filter API and made for-each-ref build on that new
infrastructure.

This series is in a form that is very unfriendly to reviewers.  The
previous step did not introduce any callers to ref-filter, so for
the purpose of review, it needs to be read together with this step
anyway.

And when reading these patches that way, what this half is really
doing is to move the code from for-each-ref to ref-filter, but it
does unnecessary or unrelated renaming of a handful of symbols.  It
makes it even harder to compare and contrast the original code that
was in the original for-each-ref and moved code that ends up in the
new ref-filter.  Don't do that.

You would probably want to organize them in these two steps instead:

 * Rename symbols as necessary while all the code is still in
   for-each-ref. Do not create ref-filter in this step. Justify it
   along the lines of "some symbol names were fine while they were
   file scope static implementation detail of for-each-ref, but we
   will make the machinery available from other commands by moving
   it to a library-ish place, so rename X to foo_X to clarify that
   this is about foo (which is now necessary as it is not specific
   to for-each-ref"...

 * If you want to do other tweaks like wrapping refs & num_refs into
   a single structure, do so while the code is still in
   for-each-ref.  You can do that in the same patch as the above
   (i.e. it's just part of preparatory step for a move).

 * Create ref-filter by _moving_ code from for-each-ref. Do not
   touch these moved lines in this step. You would need to add
   include at the top of for-each-ref and ref-filter, of course.


> -	for_each_rawref(grab_single_ref, &cbdata);
> -	refs = cbdata.grab_array;
> -	num_refs = cbdata.grab_cnt;
> +	refs.name_patterns = argv;
> +	for_each_rawref(ref_filter_add, &refs);

I think ref_filter_add() may be misnamed as a public API function.
grab_single_ref() was OK only because it was an implementation
dtail, but if you are making it public, the name should make it
clear that it is meant to be used as a for_each_*ref() callback
function.  Otherwise people may be tempted to add random parameter
to it in the future, but the signature of that function is dictated
by for_each_*ref() API.
