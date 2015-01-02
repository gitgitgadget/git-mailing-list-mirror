From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] for-each-ref: Always check stat_tracking_info()'s return value.
Date: Fri, 2 Jan 2015 13:31:26 -0500
Message-ID: <CAPig+cRfUkbD0jHUM0XOGH5=NqD2bzQ_y3vPPULjJR-aRSpCGg@mail.gmail.com>
References: <1420213442-5310-1-git-send-email-raphael.kubo.da.costa@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 19:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y770W-0005pP-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 19:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbbABSb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 13:31:28 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:37070 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbbABSb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 13:31:27 -0500
Received: by mail-yh0-f42.google.com with SMTP id v1so9081939yhn.15
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m94bFz5JQT2JwPC+9bmRMxmIXAW1vtnTfJir9cF1Eeg=;
        b=bbgsLcFdSreKFI4Spf86kHIyPRkmopvAJ22qlovZdFxDewWC512lmNkWz1NEuhyREy
         SDIFq7B4DLrfk772w2floBopr+GIYIc0jNIGXAizmAt6B6E33UiWCNAUh/pbj8nacb8+
         SYqf+KoBnKIEq4C72JNsG6vOd0ajA6aXBSCg5H3B08RN6rFrJeCvU1zqb2dmD7+D5Smw
         N4qImVIWGD7LTqwGfzDGk1+s8R/SVByPipFeuoIlQf5v4GFK4EOPv4ceRxMcm78ECaY2
         aFJ8szEvsEG+K5p7cPf+VlsQPpcE9CQG88OV8xdsm4krppCWPLOWIn3+onbMnNpk7xNn
         XH6w==
X-Received: by 10.236.89.172 with SMTP id c32mr51366448yhf.180.1420223486581;
 Fri, 02 Jan 2015 10:31:26 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 2 Jan 2015 10:31:26 -0800 (PST)
In-Reply-To: <1420213442-5310-1-git-send-email-raphael.kubo.da.costa@intel.com>
X-Google-Sender-Auth: POsr5oS1sATm2R1gymuKMlyG6Ro
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261979>

On Fri, Jan 2, 2015 at 10:44 AM, Raphael Kubo da Costa
<raphael.kubo.da.costa@intel.com> wrote:
> The code handling %(upstream:track) and %(upstream:trackshort) assumed
> it always had a valid branch that had been sanitized earlier in
> populate_value(), and thus did not check the return value of the call to
> stat_tracking_info().
>
> While there is indeed some sanitization code that basically corresponds
> to stat_tracking_info() returning 0 (no base branch set), the function
> can also return -1 when the base branch did exist but has since then
> been deleted.
>
> In this case, num_ours and num_theirs had undefined values and a call to
> `git for-each-ref --format="%(upstream:track)"` could print spurious
> values such as
>
>   [behind -111794512]
>   [ahead 38881640, behind 5103867]
>
> even for repositories with one single commit.
>
> We now properly verify stat_tracking_info()'s return value and do not
> print anything if it returns -1. This behavior also matches the
> documentation ("has no effect if the ref does not have tracking
> information associated with it").
>
> Signed-off-by: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
> ---
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index bda354c..775c255 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -335,6 +335,21 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
>  '
>
>  cat >expected <<EOF
> +
> +
> +EOF
> +
> +test_expect_success 'Check that :track[short] works when upstream is gone' '
> +       git branch --track to_delete master &&
> +       git branch --track parent_gone to_delete &&
> +       git branch -D to_delete &&
> +       git for-each-ref --format="%(upstream:track)" refs/heads/parent_gone >actual &&
> +       git for-each-ref --format="%(upstream:trackshort)" refs/heads/parent_gone >>actual &&

Minor comment: If any of the above code fails...

> +       git branch -D parent_gone &&

then this cleanup will not be performed. To ensure cleanup even if the
test fails, employ test_when_finished().

> +       test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
>  $(git rev-parse --short HEAD)
>  EOF
>
> --
> 2.1.4
