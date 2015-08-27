From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv1 1/3] git-p4: failing test for ignoring invalid p4 labels
Date: Thu, 27 Aug 2015 08:53:53 -0400
Message-ID: <CAPig+cQUX5sD5Bh7bS6PaNeYiBw413vk2+TLTPzFi0AQwt+8nA@mail.gmail.com>
References: <1440659938-12952-1-git-send-email-luke@diamand.org>
	<1440659938-12952-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, marcus.holl@sap.com
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 14:54:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUwgo-00057Z-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 14:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289AbbH0Mxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 08:53:54 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33506 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbbH0Mxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 08:53:54 -0400
Received: by ykll84 with SMTP id l84so18262021ykl.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 05:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Eq7KImctP2nlzhhjrEx3NvpRvJPGTQJV8741HR21KUc=;
        b=GQpoGm8qN54QvtU/y6UoAuCdb18xNYDOWOCjU9U+YNwlLlcs64eDLOVRHhh9a3Hdb5
         YzuO0U2BRPZSqF46ky2h+kbkcghwT2S8IbeFoI0ffGGzvab1dqhp2VSo5+I9jWx0Dnh9
         OcJD8/yFZWhmCbW0upYMaknvOfCQbnN86cFjMfEsvgXcfjxGkGw8cNkaS7e868ggNKB9
         0udNGv8n5OzAGjLgOGQ5HtrrB1jB+6qWLcwdrvHtqaKlTwcXniI4vwo+RBpHU6GrnQiZ
         h9L/e0A26LFTl6yU6cSEEDde6JkPmppm1+0HLLn57+VO0z52u1yc66lvtMtJbNbNHkmD
         /I7Q==
X-Received: by 10.13.202.80 with SMTP id m77mr3153379ywd.166.1440680033393;
 Thu, 27 Aug 2015 05:53:53 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 27 Aug 2015 05:53:53 -0700 (PDT)
In-Reply-To: <1440659938-12952-2-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: 4SC3oUD2_lFLz0bzOM41FhOdCrs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276672>

On Thu, Aug 27, 2015 at 3:18 AM, Luke Diamand <luke@diamand.org> wrote:
> When importing a label which references a commit that git-p4 does
> not know about, git-p4 should skip it and go on to process other
> labels that can be imported.
>
> Instead it crashes when attempting to find the missing commit in
> the git history. This test demonstrates the problem.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 095238f..f7d5048 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -214,6 +214,51 @@ test_expect_success 'use git config to enable import/export of tags' '
>         )
>  '
>
> +p4_head_revision() {
> +       p4 changes -m 1 "$@" | awk '{print $2}'
> +}
> +
> +# Importing a label that references a P4 commit that has
> +# has not been seen. The presence of a label on a commit

s/has has/has/

> +# we haven't seen should not cause git-p4 to fail. It should
> +# merely skip that label, and still import other labels.
> +test_expect_failure 'importing labels with missing revisions' '
