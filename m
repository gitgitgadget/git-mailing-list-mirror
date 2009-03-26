From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Thu, 26 Mar 2009 09:41:04 +0100
Message-ID: <49CB3FA0.8030408@viscovery.net>
References: <200903250105.05808.johan@herland.net> <200903260122.24770.johan@herland.net> <7vprg4rbmp.fsf@gitster.siamese.dyndns.org> <200903260929.58321.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 09:42:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmlAg-0004sy-Hp
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 09:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868AbZCZIlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 04:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbZCZIlN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 04:41:13 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29060 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757868AbZCZIlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 04:41:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lml96-0006tc-KW; Thu, 26 Mar 2009 09:41:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 59E4E4E4; Thu, 26 Mar 2009 09:41:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200903260929.58321.johan@herland.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114751>

Johan Herland schrieb:
> For the two cases index-pack.c, the chmod(foo, 0444) happens AFTER the
> corresponding call to move_temp_to_file(xyzzy, foo). The chmod() in
> adjust_shared_perms() would thus be overridden by the chmod(foo, 0444),
> which is not what we want. In both cases, I think the chmod(foo, 0444)
> can safely be moved up above the call to move_temp_to_file(). Something
> like this (although I'm not sure about the semantics of 'from_stdin'):
> 
> diff --git a/index-pack.c b/index-pack.c
> index 7546822..d289b6a 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -815,6 +815,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		}
>  	}
>  
> +	if (from_stdin)
> +		chmod(final_pack_name, 0444);
>  	if (final_pack_name != curr_pack_name) {
>  		if (!final_pack_name) {
>  			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
> @@ -824,9 +826,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		if (move_temp_to_file(curr_pack_name, final_pack_name))
>  			die("cannot store pack file");
>  	}
> -	if (from_stdin)
> -		chmod(final_pack_name, 0444);
>  
> +	chmod(final_index_name, 0444);
>  	if (final_index_name != curr_index_name) {
>  		if (!final_index_name) {
>  			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
> @@ -836,7 +837,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
>  		if (move_temp_to_file(curr_index_name, final_index_name))
>  			die("cannot store index file");
>  	}
> -	chmod(final_index_name, 0444);
>  
>  	if (!from_stdin) {
>  		printf("%s\n", sha1_to_hex(sha1));

You certainly meant to use the curr_*_name variants in the chmod lines,
no? This effectively undoes 33b65030, but that is not so good: On Windows
we cannot rename read-only files.

-- Hannes
