From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3] refs: loosen restrictions on wildcard '*' refspecs
Date: Wed, 22 Jul 2015 14:21:01 -0400
Organization: Twitter
Message-ID: <1437589261.4520.2.camel@twopensource.com>
References: <1437581180-26883-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:21:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHydk-0006fE-27
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 20:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbGVSVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 14:21:06 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34356 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbGVSVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 14:21:05 -0400
Received: by qkfc129 with SMTP id c129so115897092qkf.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=JWOg92eurY3MSdKbH6u4FevCrCClxv1PbTT7sRLG0cc=;
        b=inwb0u6xFfHVE83BBhdl73hMtOPZrC+6IZNxECxqVXHcJKL9TDMF3W+BtbnUMJK2XL
         K5lxzme0lFVaOT5fuMwrIZN7S1UJKfFLCsYcLdUmMqxPgEhqHWPFtEO5CJEj91s4wUdp
         3YEaaV0MgPj1RlzjGIusEHZm4KNE7SfEigOviCsWJA3zoHF3yLxA3wK+sdu28w3sxEU2
         Itau5rKquqD6QKuaK8DQ55fKJe8pi6cLy6UW8Kr5XvFYkesXDzefT/fdCVjc1kWBeZks
         Pw5I/owM4MD69eMjIczKcDvzLn3FLBFxjkuLSuH1PBhrIR9udn67ttCAQTV+15Ll8Q24
         4SqA==
X-Gm-Message-State: ALoCoQlukQRFpKM9v9mjk1EqaNFBlbXOqZBLTNXBrShdZrhXEoxeHyp51NssQ675R6A1vGcKMm7e
X-Received: by 10.140.97.230 with SMTP id m93mr5863689qge.32.1437589264041;
        Wed, 22 Jul 2015 11:21:04 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f189sm1074956qhe.43.2015.07.22.11.21.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 11:21:02 -0700 (PDT)
In-Reply-To: <1437581180-26883-1-git-send-email-jacob.e.keller@intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274448>

On Wed, 2015-07-22 at 09:06 -0700, Jacob Keller wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Update the check_refname_component logic in order to allow for a less
> strict refspec format in regards to REFNAME_REFSPEC_PATTERN. Previously
> the '*' could only replace a single full component, and could not
> replace arbitrary text. Now, refs such as `foo/bar*:foo/bar*` will be
> accepted. This allows for somewhat more flexibility in references and
> does not break any current users. The ref matching code already allows
> this but the check_refname_format did not. Note this does also allow
> refs such as `foo/bar*:foe/baz*`, that is, arbitrary renames. This was
> already possible with namespace sections before, but now is possible
> even as part of the pattern section. Since users have to explicitly type
> these into the configuration it does not seem an issue.
> 
> Also streamline the code by making this new check part of
> check_refname_component instead of checking after we error during
> check_refname_format, which fits better with how other issues in refname
> components are checked.
> 
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> Cc: Daniel Barkalow <barkalow@iabervon.iabervon.org>
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
> 
> I updated the patch description a bit. This is also re-based onto the
> next/ branch in-case. This is mostly a resend so that anyone interested
> in review has another chance to see the patch.
> 
>  Documentation/git-check-ref-format.txt |  4 ++--
>  refs.c                                 | 39 +++++++++++++++++++---------------
>  refs.h                                 |  4 ++--
>  t/t1402-check-ref-format.sh            |  8 ++++---
>  4 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
> index fc02959ba4ab..9044dfaadae1 100644
> --- a/Documentation/git-check-ref-format.txt
> +++ b/Documentation/git-check-ref-format.txt
> @@ -94,8 +94,8 @@ OPTIONS
>  	Interpret <refname> as a reference name pattern for a refspec
>  	(as used with remote repositories).  If this option is
>  	enabled, <refname> is allowed to contain a single `*`
> -	in place of a one full pathname component (e.g.,
> -	`foo/*/bar` but not `foo/bar*`).
> +	in the refspec (e.g., `foo/bar*/baz` or `foo/bar*baz/`
> +	but not `foo/bar*/baz*`).
>  
>  --normalize::
>  	Normalize 'refname' by removing any leading slash (`/`)
> diff --git a/refs.c b/refs.c
> index ce8cd8d45001..3002015ff289 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -20,11 +20,12 @@ struct ref_lock {
>   * 2: ., look for a preceding . to reject .. in refs
>   * 3: {, look for a preceding @ to reject @{ in refs
>   * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
> + * 5: check for patterns to reject unless REFNAME_REFSPEC_PATTERN is set

How about this:
+ 5: *, reject unless REFNAME_REFSPEC_PATTERN is set

(I guess it's possible that we would later allow other pattern chars,
but we could change the message then).
