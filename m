From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] for-each-ref: Always check stat_tracking_info()'s return value.
Date: Fri, 2 Jan 2015 15:51:19 -0500
Message-ID: <CAPig+cR4KgM6iH8Y6w6Hscq_U-usbukwU259chsN6L8vxmc74A@mail.gmail.com>
References: <1420230521-8365-1-git-send-email-raphael.kubo.da.costa@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 21:51:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y79Bt-00058q-Js
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 21:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbABUvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 15:51:21 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:65036 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbABUvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 15:51:20 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so9856978yhl.37
        for <git@vger.kernel.org>; Fri, 02 Jan 2015 12:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+ZwkZz7inway4MGrJsA/18WpNzbKMz21xU4jz61aOGI=;
        b=GSNHLfsSffLbEGdCFbOkA31BLe1WuypNeo5A4SFLr+G31k5Wf2XQx+ok/bUV4lQ3oF
         bYSUqDW/ezq3X8c3iCO/Qi5TTqkWeyoG/x8YmZtM7tE5/f/QOyPpvY5Bs384i2P+T1sa
         XaXIe6PJ7eDtIlZbHWYjgOC+F2NCymNYdryrlPMnybyr+91ggPToAnqxFgbNFMN779dp
         Ro+atpBelMJ8buxhcLQcejt3SaT1E6aK885IqQXVrD0sN+oDJC74e/YjoOGxQf0xiigk
         xK4t60M0R2b7z4tSuDiq76rGOr6kfp8LN6P6ybCUhcE5rqNk1gkA7C/54/M1AcuuRog+
         qcpw==
X-Received: by 10.170.127.5 with SMTP id t5mr39626904ykb.2.1420231879639; Fri,
 02 Jan 2015 12:51:19 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Fri, 2 Jan 2015 12:51:19 -0800 (PST)
In-Reply-To: <1420230521-8365-1-git-send-email-raphael.kubo.da.costa@intel.com>
X-Google-Sender-Auth: IwBKpMyDGeMb6_mmw3dd5Y68QdU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261985>

On Fri, Jan 2, 2015 at 3:28 PM, Raphael Kubo da Costa
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
> index bda354c..df9c3bd 100755
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
> +       test_when_finished "git branch -D parent_gone" &&

This still has the same problem. If the commands prior to
test_when_finish() fail, the test_when_finished() will never be
invoked. To fix, move test_when_finished() to just after the command
which creates the "parent_gone" branch.

> +       test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
>  $(git rev-parse --short HEAD)
>  EOF
>
> --
> 2.1.4
