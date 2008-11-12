From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix pack.packSizeLimit and --max-pack-size handling
Date: Wed, 12 Nov 2008 13:23:09 -0800
Message-ID: <7vmyg4myf6.fsf@gitster.siamese.dyndns.org>
References: <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
 <alpine.LFD.2.00.0811121109420.27509@xanadu.home>
 <7vk5b8q1l4.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0811121255330.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Nelson <jnelson@jamponi.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 22:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0NDS-0003z2-9I
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 22:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbYKLVXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 16:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYKLVXp
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 16:23:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbYKLVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 16:23:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D05EF7CC4B;
	Wed, 12 Nov 2008 16:23:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5706F7CC3C; Wed,
 12 Nov 2008 16:23:16 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811121255330.27509@xanadu.home> (Nicolas
 Pitre's message of "Wed, 12 Nov 2008 13:23:58 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D42350C-B100-11DD-97CA-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100815>

Nicolas Pitre <nico@cam.org> writes:

> @@ -2103,11 +2107,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			continue;
>  		}
>  		if (!prefixcmp(arg, "--max-pack-size=")) {
> -			char *end;
> -			pack_size_limit_cfg = 0;
> -			pack_size_limit = strtoul(arg+16, &end, 0) * 1024 * 1024;
> -			if (!arg[16] || *end)
> +			if (!git_parse_ulong(arg+16, &pack_size_limit))
>  				usage(pack_usage);
> +			else
> +				pack_size_limit_cfg = 0;
>  			continue;
>  		}
>  		if (!prefixcmp(arg, "--window=")) {

Hmm, an unrelated funniness here is why the code even needs to futz with
the value read from the configuration.  Later in the code we have:

	if (!pack_to_stdout && !pack_size_limit)
		pack_size_limit = pack_size_limit_cfg;

and the intent seems to be:

 - if there is nothing on the command line, use config;
 - if there is something on the command line, ignore config.

But if you have a configured limit and would want to override from the
command line, this won't work.

I will apply the wraparound avoidance as a separate "pure fix" patch to
'maint' first.

Besides, --max-pack-size has been defined as megabytes for the entirety of
its existence, and I am a bit worried about changing the semantics at this
point without any warning.  I realize that I am worried too much for
people with a script that give an explicit --max-pack-size=1 to obtain a
set of split packs that would fit on floppies, who probably would not
exist ;-)
