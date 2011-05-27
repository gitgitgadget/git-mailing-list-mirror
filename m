From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Fri, 27 May 2011 20:58:59 +0200
Message-ID: <4DDFF473.7030104@kdbg.org>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com> <1306512040-1468-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	Theo Niessink <theo@taletn.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 27 20:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ2Fh-0005Kl-Hu
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 20:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab1E0S7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 14:59:07 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47208 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750977Ab1E0S7F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 14:59:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 65BC41000B;
	Fri, 27 May 2011 20:59:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9EED019F359;
	Fri, 27 May 2011 20:58:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <1306512040-1468-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174638>

Am 27.05.2011 18:00, schrieb Erik Faye-Lund:
> If someone manage to create a repo with a 'C:' entry in the
> root-tree, files can be written outside of the working-dir. This
> opens up a can-of-worms of exploits.
> 
> Fix it by explicitly checking for a dos drive prefix when verifying
> a paht. While we're at it, make sure that paths beginning with '\' is
> considered absolute as well.

I think we do agree that the only way to avoid the security breach is to
check a path before it is used to write a file. In practice, it means to
disallow paths in the top-most level of the index that are two
characters long and are letter-colon.

IMHO, it is pointless to avoid that an evil path enters the repository,
because there are so many and a few more ways to create an evil repository.

> diff --git a/read-cache.c b/read-cache.c
> index f38471c..68faa51 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -753,11 +753,14 @@ int verify_path(const char *path)
>  {
>  	char c;
>  
> +	if (has_dos_drive_prefix(path))
> +		return 0;
> +

Isn't verify_path used to avoid that a bogus path enters the index? (I
don't know, I'm not familiar with this infrastructure.)

>  	goto inside;
>  	for (;;) {
>  		if (!c)
>  			return 1;
> -		if (c == '/') {
> +		if (is_dir_sep(c)) {
>  inside:

And if so, at this point, all backslashes should have been converted to
forward-slashes already. If not, then this would just paper over the
real bug.

>  			c = *path++;
>  			switch (c) {

-- Hannes
