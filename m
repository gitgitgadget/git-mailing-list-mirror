From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/14] remote.c: introduce branch_get_upstream helper
Date: Thu, 21 May 2015 11:07:33 -0700
Message-ID: <xmqqbnhdkdne.fsf@gitster.dls.corp.google.com>
References: <20150521044429.GA5857@peff.net> <20150521044528.GG23409@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 21 20:07:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUsf-0000ng-5f
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 20:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232AbbEUSHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 14:07:37 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36063 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbbEUSHg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 14:07:36 -0400
Received: by igbpi8 with SMTP id pi8so16649372igb.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qqM3DclJLkBS6EPsOSdKvbLkmqO3nwQ0IIHj+zEscms=;
        b=tAJER7xooXIID4mef0MHL0cU3gY0R0v2kaTam+L5H7bk2Nqq4mVhuPwUGMpH3qHTI1
         uQ348U3V2bEzxXQ5dXQz7Z205I4UKagUWDh6Sva1k6LCTx13FV6OFlfsWPthF9FoVgY3
         GwD96eKsr611u3W+17mUA37RDGYYTKVrtdoUIzdayZunzoSb5oKznG5WbLmwniFDAkV7
         /RgRX2psCUyB0tBOrxRkm/S29dc/mZp6r3SE3Qe2W95dyuDgr065WdiuUbj1WSlX2qXK
         uUdQoAHbEcaDYhCxAs6X4E/J+CuvMlSvZKNxJWGPL7ewzi04Ic/Xua8DO3x0UN8WTvIr
         rQAg==
X-Received: by 10.107.131.141 with SMTP id n13mr5129929ioi.74.1432231655706;
        Thu, 21 May 2015 11:07:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id l30sm15417420iod.12.2015.05.21.11.07.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 11:07:35 -0700 (PDT)
In-Reply-To: <20150521044528.GG23409@peff.net> (Jeff King's message of "Thu,
	21 May 2015 00:45:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269632>

Jeff King <peff@peff.net> writes:

> All of the information needed to find the @{upstream} of a
> branch is included in the branch struct, but callers have to
> navigate a series of possible-NULL values to get there.
> Let's wrap that logic up in an easy-to-read helper.
>
> Signed-off-by: Jeff King <peff@peff.net>

This step in the whole series is a gem.  I cannot believe that we
were content having to repeat that "branch->merge[0]->dst if we can
dereference down to that level" this many times.  Nice clean-up.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index 258fe2f..1eb6215 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -123,14 +123,12 @@ static int branch_merged(int kind, const char *name,
>  
>  	if (kind == REF_LOCAL_BRANCH) {
>  		struct branch *branch = branch_get(name);
> +		const char *upstream = branch_get_upstream(branch);
>  		unsigned char sha1[20];
>  
> -		if (branch &&
> -		    branch->merge &&
> -		    branch->merge[0] &&
> -		    branch->merge[0]->dst &&
> +		if (upstream &&
>  		    (reference_name = reference_name_to_free =
> -		     resolve_refdup(branch->merge[0]->dst, RESOLVE_REF_READING,
> +		     resolve_refdup(upstream, RESOLVE_REF_READING,
>  				    sha1, NULL)) != NULL)
>  			reference_rev = lookup_commit_reference(sha1);
