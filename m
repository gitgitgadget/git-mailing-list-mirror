From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-tag: don't use gpg's stdin, stdout when signing tags
Date: Fri, 20 Feb 2009 18:56:58 +0100
Message-ID: <499EEEEA.2040600@kdbg.org>
References: <20090220113856.6612.qmail@0bbdb5719a4668.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaZe4-0001Dr-A0
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbZBTR5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 12:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbZBTR5I
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 12:57:08 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:28968 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbZBTR5H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 12:57:07 -0500
Received: from [77.117.34.56] (77.117.34.56.wireless.dyn.drei.com [77.117.34.56])
	by bsmtp.bon.at (Postfix) with ESMTP id C0EFECDF9C;
	Fri, 20 Feb 2009 18:57:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090220113856.6612.qmail@0bbdb5719a4668.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110873>

Gerrit Pape schrieb:
>  	memset(&gpg, 0, sizeof(gpg));
>  	gpg.argv = args;
> -	gpg.in = -1;
> -	gpg.out = -1;
> +	gpg.in = 0;
> +	gpg.out = 1;

I assume you mean with this that gpg should read from fd 0 and write to 
fd 1, IOW, it should use the standard channels. If I am right, then the 
memset above has initialized gpg as needed already. Then gpg.argv is the 
only thing you are setting up in struct child_process gpg; but in this 
case you can use a convenience function...

>  	args[0] = "gpg";
>  	args[1] = "-bsau";
>  	args[2] = signingkey;
> -	args[3] = NULL;
...
> +	args[3] = "-o";
> +	args[4] = signpath;
> +	args[5] = unsignpath;
> +	args[6] = NULL;
...
> +	if (run_command(&gpg)) {

... here (note: no struct child_process needed):

	if (run_command_v_opt(args, 0)) {

(Just in case this patch is required...)

-- Hannes
