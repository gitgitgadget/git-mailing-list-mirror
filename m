From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Wed, 08 Jul 2009 17:12:21 +0200
Message-ID: <4A54B755.4090100@viscovery.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <alpine.DEB.2.00.0906221342310.26061@ds9.cixit.se> <200907081558.51767.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 17:12:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOYp1-000610-B3
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 17:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbZGHPM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbZGHPM1
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 11:12:27 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29156 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbZGHPM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 11:12:27 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOYoo-0000d9-CT; Wed, 08 Jul 2009 17:12:23 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 167344E4; Wed,  8 Jul 2009 17:12:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200907081558.51767.johan@herland.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122900>

Johan Herland schrieb:
> +	/* If rev-list --stdin encounters an unknown commit, it terminates,
> +	 * which will cause SIGPIPE in the write loop below. */

Under the conditions you describe here...

> +	signal(SIGPIPE, SIG_IGN);

... and SIGPIPE being ignored...

> +
> +	err = start_command(&revlist);
> +	if (err) {
> +		error("could not run rev-list");
> +		return err;
> +	}
>  
> -	for (i = 0; argv[i]; i++)
> -		free(argv[i]);
> -	free(argv);
> -	return err;
> +	for (ref = ref_map; ref; ref = ref->next) {
> +		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
> +		    write_in_full(revlist.in, "\n", 1) < 0) {
> +			error("failed write to rev-list");
> +			err = errno;

... don't you get this error message with errno set to EPIPE? Previously,
there was no error message.

-- Hannes
