From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 10/11] for-each-ref: introduce filter_refs()
Date: Mon, 08 Jun 2015 11:15:20 -0700
Message-ID: <xmqqd216awxz.fsf@gitster.dls.corp.google.com>
References: <1433598496-31287-10-git-send-email-karthik.188@gmail.com>
	<1433673373-16441-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:15:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21a5-0002WR-Vh
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbbFHSPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:15:24 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37192 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbbFHSPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:15:22 -0400
Received: by igbsb11 with SMTP id sb11so63316120igb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ay4WUZBfE5l3COPwwfBfWhFVkTnSHgE7wILeq1HTNXg=;
        b=Uj4yTZh/Z3RfX0KPP6gjIrvpGzPkdLKF4BziHZaVB1RrLDL9Neec+kkJQujVii+nM/
         rEMzAl4AaRX/dmH7C6WowN5T40ETGCTkAUwA3PsLfDxCG6VJJ1cGjkSbCmaewDi3jpZu
         Wtd5fNKjWvBGE90p6qIobYjVUu5rEbs6yLWgr/OES2KA1nAt3Mr6bEz5iQYnFJ7d4Zkz
         p27RQBwsfD4i3NNhz6H5HtSQ2kn6oON8J67g8pvS7HKRtzBoYoPbZLEhABTI8/15pm1g
         FTyjUD0f4yI9eFZb9bdHrfZt6WThs2wEDXd1s8QFVcVFNmbdO1mk16H3TqYkPXdSCKl+
         SN1w==
X-Received: by 10.50.43.227 with SMTP id z3mr15069062igl.12.1433787322357;
        Mon, 08 Jun 2015 11:15:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id fm3sm5223073igb.1.2015.06.08.11.15.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 11:15:21 -0700 (PDT)
In-Reply-To: <1433673373-16441-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 7 Jun 2015 16:06:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271101>

Karthik Nayak <karthik.188@gmail.com> writes:

> +/*
> + * API for filtering a set of refs. The refs are provided and iterated
> + * over using the for_each_ref_fn(). The refs are stored into and filtered
> + * based on the ref_filter_cbdata structure.
> + */
> +int filter_refs(int (for_each_ref_fn)(each_ref_fn, void *), struct ref_filter_cbdata *data)
> +{
> +	return for_each_ref_fn(ref_filter_handler, data);
> +}

I do not think it is such a good idea to allow API callers to
specify for-each-ref-fn directly.  See my message in an earlier
review.

I also think ref_filter_cbdata is an implementation detail of
filter_refs and may not have to be exposed to the API callers.
It probably is more sensible for them to pass

 - an array of refs to receive filtered results (your ref_array thing)
 - the criteria to use when filtering (your ref_filter thing)

as two separate parameters to this function, together with other
parameters that lets you (meaning the implementation of filter_refs())
to decide which for-each-ref iterator to call, e.g. do you want to
use raw iteration?  do you want to iterate only over refs/heads? etc.

In other words, the caller of this API should not have to know that
you (meaning the implementation of filter_refs()) are internally
using for_each_ref() API.
