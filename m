From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCHv3 6/6] entry.c: fix a memleak
Date: Tue, 31 Mar 2015 09:36:47 +0100
Message-ID: <20150331083647.GA2248@serenity.lan>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
 <1427764931-27745-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 10:46:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcroA-0000Rp-Nz
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 10:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbCaIp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 04:45:58 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:54978 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbCaIpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 04:45:54 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2015 04:45:54 EDT
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4543CCDA5B6;
	Tue, 31 Mar 2015 09:37:04 +0100 (BST)
X-Quarantine-ID: <wnKS1iuSnTXb>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wnKS1iuSnTXb; Tue, 31 Mar 2015 09:37:03 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 00DE886600A;
	Tue, 31 Mar 2015 09:36:52 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1427764931-27745-7-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266516>

On Mon, Mar 30, 2015 at 06:22:11PM -0700, Stefan Beller wrote:
> From: John Keeping <john@keeping.me.uk>
> 
> stream_blob_to_fd() always frees the filter now, so there is no memory
> leak in entry.c:152 just before the `goto finish`.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  
>  I added Johns signoff here tentatively, John can you confirm the sign off?

Signed-off-by: John Keeping <john@keeping.me.uk>

>  streaming.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/streaming.c b/streaming.c
> index 2ff036a..811fcc2 100644
> --- a/streaming.c
> +++ b/streaming.c
> @@ -507,8 +507,11 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
>  	int result = -1;
>  
>  	st = open_istream(sha1, &type, &sz, filter);
> -	if (!st)
> +	if (!st) {
> +		if (filter)
> +			free_stream_filter(filter);
>  		return result;
> +	}
>  	if (type != OBJ_BLOB)
>  		goto close_and_exit;
>  	for (;;) {
> -- 
> 2.3.0.81.gc37f363
> 
