From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] close another possibility for propagating pack
 corruption
Date: Fri, 31 Oct 2008 01:46:15 -0700
Message-ID: <7vod11884o.fsf@gitster.siamese.dyndns.org>
References: <1225321372-6570-1-git-send-email-nico@cam.org>
 <1225321372-6570-2-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 09:49:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvpgw-0005Lc-Cn
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 09:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbYJaIq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 04:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbYJaIq2
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 04:46:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbYJaIq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 04:46:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B436977562;
	Fri, 31 Oct 2008 04:46:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BA9B67755F; Fri, 31 Oct 2008 04:46:22 -0400 (EDT)
In-Reply-To: <1225321372-6570-2-git-send-email-nico@cam.org> (Nicolas Pitre's
 message of "Wed, 29 Oct 2008 19:02:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6774480A-A728-11DD-A074-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99567>

Nicolas Pitre <nico@cam.org> writes:

> Abstract
> --------
>
> With index v2 we have a per object CRC to allow quick and safe reuse of
> pack data when repacking.  this, however, doesn't currently prevent a

s/this/This/;

> stealth corruption from being propagated into a new pack when _not_
> reusing pack data as demonstrated by the modification to t5302 included
> here.
>
> The Context
> -----------
>
> The Git database is all checksumed with SHA1 hashes.  Any kind of

s/checksumed/checksummed/;

> ...
> What about the streamed pack case?  Well, any client receiving a pack
> must always consider that pack as untrusty and perform full validation
> anyway, hence no such stealth corruption could be propagated to remote
> repositoryes already.  It is therefore worthless doing local validation
> in that case.

Very nicely done.  I've never seen a commit message that needs its own
Abstract ;-)

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 59c30d1..0366277 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1689,6 +1689,8 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
>  	return 0;
>  }
>  
> +extern int do_check_packed_object_crc;
> +

This ought to belong to cache.h or some other header file.  Perhaps you
did this to avoid unnecessary recompilation (we've discussed this at
GitTogether)?

> @@ -1697,6 +1699,16 @@ static void prepare_pack(int window, int depth)
>  
>  	get_object_details();
>  
> +	/*
> +	 * If we're locally repacking then we need to be doubly careful
> +	 * from now on in order to make sure no stealth corruption gets
> +	 * propagated to the new pack.  Clients receiving streamed packs
> +	 * should validate everything they get anyway so no need to incure

s/incure/incur/;
