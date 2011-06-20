From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 15/20] transport-helper: use the new done feature
 where possible
Date: Mon, 20 Jun 2011 06:45:56 -0500
Message-ID: <20110620114556.GA29818@elie>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
 <1308496725-22329-16-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>, Ramkumar@elie
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 13:46:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYcvk-0004I5-HK
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 13:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab1FTLqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 07:46:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61369 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab1FTLqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 07:46:06 -0400
Received: by iyb12 with SMTP id 12so1887723iyb.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jW08MKi9W7czASkZMbneKMbZYHb/r26zPTL/8vQqrNs=;
        b=Y/wq7K/oX71qBWgt3XVsOcqLbAilrK3r6usOujkV+3jM1PvY1O9/b5aXGeJ0Il4xKg
         CE+5y3dSc4+0ynmGgT0/BCdWaajvmPx4ROpzmSYIbeFB3xzo7miPqAxnxoIIa4mndNQ2
         VJMAX6XV2OfYPhssCpjQJiB/eoVkJiFMj+kEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=An12tnylMuLveJTB9MaIhIzaD+dJ88q8QhrEIyNiNdsaaJPf+yZZl6ksAOQ+8Nqlfz
         /IcgI0khduXUiD9WMIluAeLuNEkkaEbAIPWwR5G8yQ618eH1AL0Ncrfa+pJQahUrQprP
         UbDkDHInZqUVxFq+QBYUlQ8kIUL/TdSxZ7ivI=
Received: by 10.42.19.2 with SMTP id z2mr5779603ica.498.1308570365335;
        Mon, 20 Jun 2011 04:46:05 -0700 (PDT)
Received: from elie (adsl-69-209-50-158.dsl.chcgil.ameritech.net [69.209.50.158])
        by mx.google.com with ESMTPS id ly7sm5597042icb.12.2011.06.20.04.46.02
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Jun 2011 04:46:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308496725-22329-16-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176064>

Hi,

Sverre Rabbelier wrote:

> In other words, use fast-export --use-done-feature to add a 'done'
> command at the end of streams passed to remote helpers' "import"
> commands, and teach the remote helpers implementing "export" to use
> the 'done' command in turn when producing their streams.

Sounds like a reasonable thing to do.  One puzzle:

[...]
> +++ b/transport-helper.c
> @@ -375,8 +375,9 @@ static int get_exporter(struct transport *transport,
>  	/* we need to duplicate helper->in because we want to use it after
>  	 * fastexport is done with it. */
>  	fastexport->out = dup(helper->in);
> -	fastexport->argv = xcalloc(4 + revlist_args->nr, sizeof(*fastexport->argv));
> +	fastexport->argv = xcalloc(5 + revlist_args->nr, sizeof(*fastexport->argv));
>  	fastexport->argv[argc++] = "fast-export";
> +	fastexport->argv[argc++] = "--use-done-feature";
>  	if (export_marks)
>  		fastexport->argv[argc++] = export_marks;
>  	if (import_marks)
> @@ -412,11 +413,8 @@ static int fetch_with_import(struct transport *transport,
>  		sendline(data, &buf);
>  		strbuf_reset(&buf);
>  	}
> -	if (disconnect_helper(transport))
> -		die("Error while disconnecting helper");
>  	if (finish_command(&fastimport))
>  		die("Error while running fast-import");
> -

What is this change about?  Is the plan to allow other commands after
a fetch_with_import?  Sounds reasonable; I think it should be
advertised in the log message, though.

When does the disconnect_helper call happen (to avoid leaks)?  Ah, in
release_helper; phew.

The disconnect_helper call writes the blank line that terminates the
list of "import %s" commands to start the import, so there would need
to be a

	strbuf_reset(&buf);
	strbuf_addf(&buf, "\n");
	sendline(data, &buf);

in its place.
