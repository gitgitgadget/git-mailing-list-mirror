From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 3/6] http-backend: handle refspec argument
Date: Sat, 16 Apr 2016 21:51:29 -0400
Message-ID: <CAPig+cRSE-BCPdrSbrCYmTcT6EsabKnekr2GEAbmBsc5=jxnHQ@mail.gmail.com>
References: <1460747949-3514-1-git-send-email-dturner@twopensource.com>
	<1460747949-3514-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 03:51:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arbs7-0003xb-9A
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 03:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbcDQBvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 21:51:31 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:36695 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbcDQBva (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 21:51:30 -0400
Received: by mail-ig0-f195.google.com with SMTP id kb1so7106611igb.3
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 18:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=+Q+IaTdPWytQuYhh5dZtWw6aVSmyM6U2HPCvAg96NLc=;
        b=qDhIUo/NWS6MpY/tCVwIYTENCMXJAN81itzMHymrD/r3rbl2UBr+rznFWwh+V0YaZ6
         nktYbiWoM2a6FXbRcToPSStuAErziEfVvJBapv62UbPDUvo37a/R6GAHpznQdS4tjsBM
         Z0r9yAax3d6EifNHqzE4e/bvVNINEvWmbS8D5NfjbTBPJuRJ5luqwW8+Hh9Z1CrR5iFL
         MHRdwnE+qFtXTu0AmxTbaS7zN+Z0FlzfGzBy55zJzJNsxc/K236+xbfxDPESXDFaVxAG
         erk9OJquXwQHiyatazB2oxn9Q/5KfWozy+xDIB13cB4eU2qstLJw0/+8nwJNduRAjrxP
         KSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+Q+IaTdPWytQuYhh5dZtWw6aVSmyM6U2HPCvAg96NLc=;
        b=QUCxVqCSWwVKX1T8ENOoG9tmXexbyPrrBu2etLXLfLXYhtKW4q9QKjEFpWAhGjOdSa
         oGquIksYEwHZyreNJk5Xl6u7Sl9GdjVRgrNwz3gtsxcfxxUARDIkr7ogC6y7zSUq7Iwi
         B4rlkTnATP26AJv8xHD3w1H0dGtaL5utGdFYXrnoKd6AfimfjtxlYW3CJzVje9BQJa9P
         sRLiDhzmUN7A1L7Mj2Ebxoxh5efKdHmMubx+aEZ0ar2hDybonCAYC/NG4nHUlHrFAndY
         hLZUDvaSBuORW+BESkJ0fyCjrdpfVFixmeE6aZZGh7ZZu2qPHdS22zy8cNUAYwVPeb9Y
         zx6w==
X-Gm-Message-State: AOPr4FUZp4LYS9NcD2lOcuDjMIJoJmJ0UaxeRb0QvBpfey4orBuRn6LKlxPpsANFmBKBuwLwgrINsq6DWk0qBw==
X-Received: by 10.50.92.37 with SMTP id cj5mr12704522igb.91.1460857889087;
 Sat, 16 Apr 2016 18:51:29 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Sat, 16 Apr 2016 18:51:29 -0700 (PDT)
In-Reply-To: <1460747949-3514-4-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: ULNmLWUS-y763kGOGIBNfenBRQM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291737>

On Fri, Apr 15, 2016 at 3:19 PM, David Turner <dturner@twopensource.com> wrote:
> Allow clients to pass a "refspec" parameter through to upload-pack;
> upload-pack will only advertise refs which match that refspec.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/http-backend.c b/http-backend.c
> @@ -465,6 +466,14 @@ static void get_info_refs(char *arg)
>                 argv_array_push(&argv, "--stateless-rpc");
>                 argv_array_push(&argv, "--advertise-refs");
>
> +               refspec = get_parameter("refspec");
> +               if (refspec) {
> +                       struct strbuf interesting_refs = STRBUF_INIT;
> +                       strbuf_addstr(&interesting_refs, "--interesting-refs=");
> +                       strbuf_addstr(&interesting_refs, refspec);
> +                       argv_array_push(&argv, interesting_refs.buf);
> +                       strbuf_release(&interesting_refs);
> +               }

    if (refspec)
        argv_array_pushf(&interesting_refs,
            "--interesting-refs=%s", refspec);

>                 argv_array_push(&argv, ".");
>                 run_service(argv.argv, 0);
>                 argv_array_clear(&argv);
> @@ -841,6 +905,19 @@ int main(int argc, char **argv)
> +               if (starts_with(arg, "--interesting-refs=")) {
> +                       struct string_list_item *item;
> +
> +                       string_list_split(&interesting_refspecs, arg + 19,
> +                                         ' ', -1);
> +                       for_each_string_list_item(item, &interesting_refspecs) {
> +                               if (check_refname_format(item->string,
> +                                                        REFNAME_REFSPEC_PATTERN))
> +                                       die("invalid refspec %s", item->string);
> +                               item->util = make_refspec_data(item->string);
> +                       }
> +                       continue;
> +               }

Is this leaking the string list?

>                 if (!strcmp(arg, "--stateless-rpc")) {
>                         stateless_rpc = 1;
>                         continue;
> --
> 2.4.2.767.g62658d5-twtrsrc
