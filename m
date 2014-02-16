From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] read-cache: add index.version config variable
Date: Sat, 15 Feb 2014 21:10:00 -0500
Message-ID: <CAPig+cTAd4DL3WaCBJ82q5i-7EObER5BrQX92LQozeJqKTaOZQ@mail.gmail.com>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
	<1392492197-7724-4-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 16 03:10:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WErBh-0005Mr-2l
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 03:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbaBPCKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Feb 2014 21:10:24 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:61104 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaBPCKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Feb 2014 21:10:01 -0500
Received: by mail-yk0-f176.google.com with SMTP id 19so27690746ykq.7
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 18:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MBi6mnv62BMvMIx08NbCIKs70rvAE2AvQ0G7RrCuo4g=;
        b=uub/oj55E8h57M0cGT+5JM1opnjYrCd6qjkjiiqftCBriGDv9YnWi3Jykc02RynQCC
         ooUghsDbwId96z7u+CpKSk8H+H+BwVZ6HdfLRq9mnLiCpbOKxIk9CzjNgcqXym9WgLY8
         5EZ+eiXNu9C7nTEFRuLZcMDUjbR6Xvp1Gu9VpszyHzCq1diKoQ6zJvgLatp/ito9Gr92
         YnfwiusOGDj765dYqai6hOsBv3oLIYaB4qiYALz8n0tQRtEypWcM4RWbJTrL9lMGGbG3
         nCykFq2kHNr8J8jTI3dBPQtlWFfy18hP0//8WFCI08uGXtRUDRCwmyb+lysp0WVhf1BV
         C4Yw==
X-Received: by 10.236.7.231 with SMTP id 67mr12746434yhp.30.1392516600351;
 Sat, 15 Feb 2014 18:10:00 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Sat, 15 Feb 2014 18:10:00 -0800 (PST)
In-Reply-To: <1392492197-7724-4-git-send-email-t.gummerer@gmail.com>
X-Google-Sender-Auth: nL2DFTR6GWRmDYC03gm8fAAFyp0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242204>

On Sat, Feb 15, 2014 at 2:23 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Add a config variable that allows setting the default index version when
> initializing a new index file.  Similar to the GIT_INDEX_VERSION
> environment variable this only affects new index files.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> index 37fd84d..bf34985 100755
> --- a/t/t1600-index.sh
> +++ b/t/t1600-index.sh
> @@ -21,4 +21,31 @@ test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
>         )
>  '
>
> +test_expect_success 'out of bounds index.version issuses warning' '

s/issuses/issues/

> +       (
> +               unset GIT_INDEX_VERSION &&
> +               rm .git/index &&
> +               git config --add index.version 1 &&
> +               git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
> +               sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
> +                       warning: index.version set, but the value is invalid.
> +                       Using version Z
> +               EOF
> +               test_i18ncmp expect.err actual.err
> +       )
> +'
> +
> +test_expect_success 'GIT_INDEX_VERSION takes precedence over config' '
> +       (
> +               rm .git/index &&
> +               GIT_INDEX_VERSION=4 &&
> +               export GIT_INDEX_VERSION &&
> +               git config --add index.version 2 &&
> +               git add a 2>&1 &&
> +               echo 4 >expect &&
> +               test-index-version <.git/index >actual &&
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_done
> --
> 1.8.5.2.300.ge613be6.dirty
