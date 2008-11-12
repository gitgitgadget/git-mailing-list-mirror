From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix pack.packSizeLimit and --max-pack-size handling
Date: Wed, 12 Nov 2008 09:46:31 -0800
Message-ID: <7vk5b8q1l4.fsf@gitster.siamese.dyndns.org>
References: <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
 <alpine.LFD.2.00.0811121109420.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Nelson <jnelson@jamponi.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:48:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Jp6-0005Ij-0X
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbYKLRq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYKLRq5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:46:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYKLRq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:46:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 116A616863;
	Wed, 12 Nov 2008 12:46:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 89AA81684F; Wed, 12 Nov 2008 12:46:35 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811121109420.27509@xanadu.home> (Nicolas
 Pitre's message of "Wed, 12 Nov 2008 11:17:22 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E49CB1C4-B0E1-11DD-9497-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100783>

Nicolas Pitre <nico@cam.org> writes:

> First, pack.packSizeLimit and --max-pack-size didn't use the same base
> unit which was confusing.  They both use MiB now.
>
> Also, if the limit was sufficiently low, having a single object written
> could bust the limit (by design), but caused the remaining allowed size 
> to go negative for subsequent objects, which for an unsigned variable is 
> a rather huge limit.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---

> @@ -1844,7 +1848,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>  	if (!strcmp(k, "pack.packsizelimit")) {
> -		pack_size_limit_cfg = git_config_ulong(k, v);
> +		pack_size_limit_cfg = git_config_ulong(k, v) * 1024 * 1024;

The fix to tweak the limit for subsequent split pack is a good thing to
have, but this change would break existing repositories where people
specified 20971520 (or worse yet "20m") to limit the size to 20MB.

I think --max-pack-size is what should be fixed to use git_parse_ulong()
to match the configuration, if you find the discrepancy disturbing.
