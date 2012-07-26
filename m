From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC 14/16] transport-helper: add import|export-marks to fast-import command line.
Date: Thu, 26 Jul 2012 18:15:54 +0200
Message-ID: <2151883.HpdNaV7ITK@flomedio>
References: <1343287957-22040-1-git-send-email-florian.achleitner.2.6.31@gmail.com> <1343287957-22040-14-git-send-email-florian.achleitner.2.6.31@gmail.com> <1343287957-22040-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 18:16:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuQjf-000135-5P
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 18:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab2GZQQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 12:16:11 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33487 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab2GZQQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 12:16:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1384527bkw.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=q3Kjaz+SFF5dzcYRO3LnaoSip82VNlo1E9MSJqpl5Vc=;
        b=UnukgsI3lK6FnnZ9G/a2hT/+xbGfqYLd2iehgcpmTCEsWOQUbFjB4MteiQkHncU8Z7
         ZjQ/pctoknWyZuqeXNJugywiJrgwL2L8yPzBR5+XmV4wqgu+eVDP4qZaQG/rD0x2e5W/
         BC/CIUFArWpahYmmB2W090wKDFVmAWsMj6Dpkzh8CBhPu1pvXi8496O/3YEND63X9VHT
         sn4Qp6m6MjkBCDfNmtAj1VLZ5mJF0SmxxSNO26pM2Y892NHXM8VyHTh/PTE0pB75nKQZ
         qi08Dn8DMjN05P9iioybNfgjjMTdvNTB03uui7+VrT7ihqBFnxULQXIWYlx12mw3gGPV
         JyAw==
Received: by 10.204.152.15 with SMTP id e15mr13869217bkw.18.1343319360226;
        Thu, 26 Jul 2012 09:16:00 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id hg13sm14907725bkc.7.2012.07.26.09.15.56
        (version=SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 09:15:58 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-26-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1343287957-22040-15-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202271>


I just found that for fast-export something similar was added to transport-
helper in a515ebe9.
By adding a capabilities advertised by the remote helper. Probably that would 
be a nicer way to do that.
Btw, these added capabilities are not mentioned in Docs.

On Thursday 26 July 2012 09:32:35 Florian Achleitner wrote:
> fast-import internally uses marks that refer to an object via its sha1.
> Those marks are created during import to find previously created objects.
> At exit the accumulated marks can be exported to a file and reloaded at
> startup, so that the previous marks are available.
> Add command line options to the fast-import command line to enable this.
> The mark files are stored in info/fast-import/marks/<remote-name>.
> 
> Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> ---
>  transport-helper.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/transport-helper.c b/transport-helper.c
> index e10fd6b..74f9608 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -394,6 +394,9 @@ static int get_importer(struct transport *transport,
> struct child_process *fasti argv_array_push(argv, "fast-import");
>  	argv_array_push(argv, debug ? "--stats" : "--quiet");
>  	argv_array_pushf(argv, "--cat-blob-pipe=%s", data->report_fifo);
> +	argv_array_push(argv, "--relative-marks");
> +	argv_array_pushf(argv, "--import-marks-if-exists=marks/%s",
> transport->remote->name); +	argv_array_pushf(argv,
> "--export-marks=marks/%s", transport->remote->name); fastimport->argv =
> argv->argv;
>  	fastimport->git_cmd = 1;
