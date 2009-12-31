From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [Updated PATCH 2/2] Improve transport helper exec failure reporting
Date: Thu, 31 Dec 2009 16:44:37 +0100
Message-ID: <4B3CC6E5.7090404@kdbg.org>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi> <1262170338-11574-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 31 16:44:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQNCc-0006oF-CY
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 16:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbZLaPoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 10:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbZLaPoh
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 10:44:37 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:11537 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750722AbZLaPoh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 10:44:37 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5FFB710017;
	Thu, 31 Dec 2009 16:44:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1262170338-11574-3-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135955>

Ilari Liusvaara schrieb:
> @@ -31,13 +31,19 @@ static struct child_process *get_helper(struct transport *transport)
>  	helper->out = -1;
>  	helper->err = 0;
>  	helper->argv = xcalloc(4, sizeof(*helper->argv));
> -	strbuf_addf(&buf, "remote-%s", data->name);
> +	strbuf_addf(&buf, "git-remote-%s", data->name);
>  	helper->argv[0] = strbuf_detach(&buf, NULL);
>  	helper->argv[1] = transport->remote->name;
>  	helper->argv[2] = transport->url;
> -	helper->git_cmd = 1;
> -	if (start_command(helper))
> -		die("Unable to run helper: git %s", helper->argv[0]);
> +	helper->git_cmd = 0;
> +	if (start_command(helper)) {
> +		if (errno == ENOENT)
> +			die("Unable to find remote helper for \"%s\"",
> +				data->name);

You should set helper->silent_exec_failure = 1 when you give your own 
error message for the ENOENT case.

BTW, which error message do you see without your change in this case? You 
only say "pretty much useless", but do not give an example.

> +		else
> +			die("Unable to run helper %s: %s", helper->argv[0],
> +				strerror(errno));

You shouldn't write an error message here because start_command has 
already reported the error.

-- Hannes
