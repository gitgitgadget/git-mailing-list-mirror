From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv2 05/12] git p4: standardize submit cancel due to unchanged
 template
Date: Sat, 15 Sep 2012 22:58:03 +0100
Message-ID: <5054F9EB.7060708@diamand.org>
References: <1347221773-12773-1-git-send-email-pw@padd.com> <1347221773-12773-6-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 23:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD0NU-0006PX-MR
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab2IOV6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:58:08 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35858 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab2IOV6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:58:06 -0400
Received: by weyx8 with SMTP id x8so3118166wey.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=EtylmXKK8Iou7sU0agKbOwQ+yONpuNuSAZBLKoIGURE=;
        b=dsgrwvEBAicg9/qD24bI8lISpCMYztBJm8E6KbHMh39siw3f+BRcjCjaXURkWNgg6O
         PHnbDEkQKed3XXf0x1WYuxFlcDAW0tRdj1nqumDaJS+qCTdDfEjIJKTKNN+Bez37Es7T
         w0v0DIuyyUuS2Mfy96wwv4QDMGZe0DKXDhFUqgVD3/fSPAvp43UuOT6nWiLQ6EBDU4ao
         VQ+FhODpxobsFY+AiCCWq3qRE58liuBLBOG+98m+V8MN1GwcIdFW8XNwXEFetTX2aYWA
         Bp1SC6sKPG6ALOuK684HVdw6netzQ+dpClaI1jqOj5NWnCzpEVsKP5fpqW+l2fhy20Aa
         Nu1g==
Received: by 10.180.24.197 with SMTP id w5mr6623333wif.22.1347746285504;
        Sat, 15 Sep 2012 14:58:05 -0700 (PDT)
Received: from [86.6.26.120] (cpc21-cmbg14-2-0-cust119.5-4.cable.virginmedia.com. [86.6.26.120])
        by mx.google.com with ESMTPS id hv8sm12099878wib.0.2012.09.15.14.58.04
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 14:58:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120510 Icedove/10.0.4
In-Reply-To: <1347221773-12773-6-git-send-email-pw@padd.com>
X-Gm-Message-State: ALoCoQlx9pRag+gKlAKmnU2g9z5I8H9S79TLSVzDqQCq0gl4hMm63VstbFFQgzvd3WQT4FUY0GQo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205587>

Ack.

On 09/09/12 21:16, Pete Wyckoff wrote:
> When editing the submit template, if no change was made to it,
> git p4 offers a prompt "Submit anyway?".  Answering "no" cancels
> the submit.
>
> Previously, a "no" answer behaves like a "[s]kip" answer to the
> failed-patch prompt, in that it proceeded to try to apply the
> rest of the commits.  Instead, put users back into the new
> "[s]kip / [c]ontinue" loop so that they can decide.  This makes
> both cases of patch failure behave identically.
>
> The return code of git p4 after a "no" answer is now the same
> as that for a "skip" due to failed patch; update a test to
> understand this.
>
> Signed-off-by: Pete Wyckoff<pw@padd.com>
> ---
>   git-p4.py                          | 4 +++-
>   t/t9805-git-p4-skip-submit-edit.sh | 2 +-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 479f1fc..39fa2e1 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1262,6 +1262,7 @@ class P4Submit(Command, P4UserMap):
>
>           if self.edit_template(fileName):
>               # read the edited message and submit
> +            ret = True
>               tmpFile = open(fileName, "rb")
>               message = tmpFile.read()
>               tmpFile.close()
> @@ -1285,6 +1286,7 @@ class P4Submit(Command, P4UserMap):
>
>           else:
>               # skip this patch
> +            ret = False
>               print "Submission cancelled, undoing p4 changes."
>               for f in editedFiles:
>                   p4_revert(f)
> @@ -1293,7 +1295,7 @@ class P4Submit(Command, P4UserMap):
>                   os.remove(f)
>
>           os.remove(fileName)
> -        return True  # success
> +        return ret
>
>       # Export git tags as p4 labels. Create a p4 label and then tag
>       # with that.
> diff --git a/t/t9805-git-p4-skip-submit-edit.sh b/t/t9805-git-p4-skip-submit-edit.sh
> index fb3c8ec..ff2cc79 100755
> --- a/t/t9805-git-p4-skip-submit-edit.sh
> +++ b/t/t9805-git-p4-skip-submit-edit.sh
> @@ -38,7 +38,7 @@ test_expect_success 'no config, unedited, say no' '
>   		cd "$git"&&
>   		echo line>>file1&&
>   		git commit -a -m "change 3 (not really)"&&
> -		printf "bad response\nn\n" | git p4 submit&&
> +		printf "bad response\nn\n" | test_expect_code 1 git p4 submit&&
>   		p4 changes //depot/...>wc&&
>   		test_line_count = 2 wc
>   	)
