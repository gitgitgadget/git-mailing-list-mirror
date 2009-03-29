From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Resolve double chmod() in move_temp_to_file()
Date: Sun, 29 Mar 2009 13:31:32 -0700
Message-ID: <7vfxgwqdej.fsf@gitster.siamese.dyndns.org>
References: <200903250105.05808.johan@herland.net>
 <200903261617.48362.johan@herland.net>
 <7viqlu1837.fsf@gitster.siamese.dyndns.org>
 <200903281201.35409.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 22:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo1hZ-00011U-3j
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 22:33:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbZC2Ubm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbZC2Ubm
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 16:31:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40819 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbZC2Ubl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 16:31:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FCE6A6E97;
	Sun, 29 Mar 2009 16:31:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 605EEA6E96; Sun,
 29 Mar 2009 16:31:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9AD47D9E-1CA0-11DE-A4CC-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115035>

Johan Herland <johan@herland.net> writes:

> On Saturday 28 March 2009, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:
>> > -	if (chmod(filename, 0444) || adjust_shared_perm(filename))
>> > +	if (chmod(filename, get_shared_perm(0444)))
>>
>> Your get_shared_perm() will end up feeding 0444 to S_ISDIR(), which would
>> most likely say "no" and cause real harm, but there is no guarantee that
>> we won't start checking S_ISREG() or other things in get_shared_perm()
>> later.  I do not like this.

... should have been s/and cause/and cause no/; I think you read it correctly, though...

> ...
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 8869488..5bfc36c 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -2263,7 +2263,7 @@ int move_temp_to_file(const char *tmpfile, const
>> char *filename) *
>>  	 * The same holds for FAT formatted media.
>>  	 *
>> -	 * When this succeeds, we just return 0. We have nothing
>> +	 * When this succeeds, we just return; we have nothing
>
> Small nit: This belongs in the previous patch, doesn't it?

Thanks for all the above fixes.
