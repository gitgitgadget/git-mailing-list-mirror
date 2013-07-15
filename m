From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/5] diff: allow --no-patch as synonym for -s
Date: Mon, 15 Jul 2013 10:35:36 -0700
Message-ID: <20130715173536.GB14690@google.com>
References: <7vppujbwuh.fsf@alter.siamese.dyndns.org>
 <1373907914-8020-1-git-send-email-Matthieu.Moy@imag.fr>
 <1373907914-8020-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, stefanbeller@googlemail.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 19:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uymge-0002Fd-BW
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 19:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987Ab3GORfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 13:35:44 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54744 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264Ab3GORfn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 13:35:43 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so11546710pbc.15
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XwfL4DoMY7mYXw7xA89BUofrEiFMaUdvici6tG+2mZE=;
        b=g2yNv/S8/PfBLs3/ePmKdQ0HCw+EqbVigMuDTl9Ud6IrXuXwi7NncgyFy9Ki+iEUl0
         V2M+zeUF4ZKxpn/P30TYuX4NIUJx3PvuwGaTIcntllIbRmPG86RhEB1w35F3I8lp3y7f
         fVvOnLBJypR/ch7+05pF3kItcQ2SDX2+dth1T8cApbn+SrArTxCfIBNRMkkHfiU5dRgR
         4mFjkFelfyNgJaS4eUaKvVEk5px82/cAgiwJ7ycY5/8uYbTjgOrIFch207JfVtxLV+Bq
         DYahNRuLkS5qiqo2lJ8TNeKCUFan6N9Uxa3BShmNqH66VIWTnLYb1PTz8EOAgj8s/lXj
         ezLQ==
X-Received: by 10.68.163.131 with SMTP id yi3mr55095475pbb.55.1373909742929;
        Mon, 15 Jul 2013 10:35:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ne6sm57563639pbc.28.2013.07.15.10.35.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 10:35:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373907914-8020-2-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230497>

Matthieu Moy wrote:

> --- a/diff.c
> +++ b/diff.c
> @@ -3551,7 +3551,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
>  		options->output_format |= DIFF_FORMAT_NAME;
>  	else if (!strcmp(arg, "--name-status"))
>  		options->output_format |= DIFF_FORMAT_NAME_STATUS;
> -	else if (!strcmp(arg, "-s"))
> +	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
>  		options->output_format |= DIFF_FORMAT_NO_OUTPUT;

Very nice idea.

Tests?  E.g.:

diff --git i/t/t4000-diff-format.sh w/t/t4000-diff-format.sh
index 6ddd469..0fa7380 100755
--- i/t/t4000-diff-format.sh
+++ w/t/t4000-diff-format.sh
@@ -59,4 +59,18 @@ test_expect_success \
     'validate git diff-files -p output.' \
     'compare_diff_patch current expected'
 
+test_expect_success \
+    'git diff-files -s after editing work tree' \
+    '>empty &&
+    git diff-files -s >diff-s-output 2>err &&
+    test_cmp empty diff-s-output &&
+    test_cmp empty err'
+
+test_expect_success \
+    'git diff-files --no-patch as synonym for -s' \
+    '>empty &&
+    git diff-files --no-patch >diff-np-output 2>err &&
+    test_cmp empty diff-np-output &&
+    test_cmp empty err'
+
 test_done
