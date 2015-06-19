From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 19:33:01 +0600
Message-ID: <CANCZXo72BscpXKGAtVPt_1QuffcOpTz6nGB+__q0JLisuTaKsQ@mail.gmail.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net>
	<20150618202205.GA16517@peff.net>
	<xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 15:33:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wPw-0007Xu-8c
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbbFSNdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:33:06 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:34208 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbbFSNdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:33:03 -0400
Received: by labbc20 with SMTP id bc20so74262667lab.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HgpQ612FviRS3OGXWuHz/GY5I4x6+v7pBf4smGz0OxU=;
        b=Cm2Ov3CzxQwS26Ko1HEjj+1m1vq0kQwk3L22i05aCP0Pqw3V69Y0A8tpQedMgLdAlf
         GmG7wRgHiZrMTB9KKoovLSyu+5mldxM2pYrasRJ7Q7xq1yGGiwczGWc8wBRB58ddPRDi
         ikW6r65PPjfQu236y2Z49h0y23BaByJCFogp9wvUggcBPmbs/j2rLtnnjYFr/kc0gkVF
         h/gQko3msgBHxXuKyDla5WXF0lGo2sOfCWwyncY9J63/uzVjg4dXhBJiI5dTiY4rYFRS
         lqsP19t2WyBWg8WfveKt0btlPKE35aoeff6TOmc8+iufGQMv4m5D8dulavT/qzcPKt4J
         6lnA==
X-Received: by 10.112.209.106 with SMTP id ml10mr17655016lbc.112.1434720781923;
 Fri, 19 Jun 2015 06:33:01 -0700 (PDT)
Received: by 10.25.62.150 with HTTP; Fri, 19 Jun 2015 06:33:01 -0700 (PDT)
In-Reply-To: <xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272139>

2015-06-19 3:46 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
> I agree with "later -o should override an earlier one", but I do not
> necessarily agree with "'-o -' should be --stdout", for a simple
> reason that "-o foo" is not "--stdout >foo".
>
> Perhaps something like this to replace builtin/ part of Alexander's
> patch?
>
> @@ -1337,6 +1342,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 die (_("--subject-prefix and -k are mutually exclusive."));
>         rev.preserve_subject = keep_subject;
>
> +       if (!output_directory && !use_stdout)
> +               output_directory = config_output_directory;
> +
>

But there is following condition above:

 if (!use_stdout)
      output_directory = set_outdir(prefix, output_directory);

After which output_directory will be "./" everytime and

>
> +       if (!output_directory && !use_stdout)
> +               output_directory = config_output_directory;
> +
>

will not work here. What if we remove if (output_directory) {}....
and update it as:

    if (!use_stdout) {
        if (!config_output_directory && !output_directory)
            output_directory = set_outdir(prefix, output_directory);
        else if (config_output_directory)
            output_directory = config_output_directory;

        if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
            die_errno(_("Could not create directory '%s'"),
                  output_directory);
    }
    else
        setup_pager();

?
