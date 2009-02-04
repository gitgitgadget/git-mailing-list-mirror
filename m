From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when   file is open
Date: Wed, 04 Feb 2009 10:41:26 -0800
Message-ID: <7vfxiut57t.fsf@gitster.siamese.dyndns.org>
References: <cover.1233751281.git.barvik@broadpark.no>
 <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
 <49899FA4.2020003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:44:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmjp-0006vn-LY
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759656AbZBDSlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 13:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759646AbZBDSlg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:41:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759636AbZBDSlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:41:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A4E79618D;
	Wed,  4 Feb 2009 13:41:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 065AA9618B; Wed,
  4 Feb 2009 13:41:28 -0500 (EST)
In-Reply-To: <49899FA4.2020003@viscovery.net> (Johannes Sixt's message of
 "Wed, 04 Feb 2009 15:01:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 71FEE42E-F2EB-11DD-A2E7-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108409>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Kjetil Barvik schrieb:
>> Currently inside write_entry() we do an lstat(path, &st) call on a
>> file which have just been opened inside the exact same function.  It
>> should be better to call fstat(fd, &st) on the file while it is open,
>> and it should be at least as fast as the lstat() method.
> ...
>> @@ -145,6 +146,11 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
>>  		}
>>  
>>  		wrote = write_in_full(fd, new, size);
>> +		/* use fstat() only when path == ce->name */
>> +		if (state->refresh_cache && !to_tempfile && !state->base_dir_len) {
>> +			fstat(fd, &st);
>> +			fstat_done = 1;
>> +		}
>>  		close(fd);
>
> I've a bad gut feeling about this: It may not work as expected on Windows
> because there is this statement in the documentation:
>
>   "The only guarantee about a file timestamp is that the file time is
>    correctly reflected when the handle that makes the change is closed."
>
> (http://msdn.microsoft.com/en-us/library/ms724290(VS.85).aspx)
>
> We are operating on a temporary file. It could happen that the fstat()
> returns the time when the file was created, as opposed to when the
> write_in_full() was completed successfully. The fstat()ed time ends up in
> the index, but it can be different from what later lstat() calls report
> (and the file would be regarded as modified).
>
> I have the suspicion that the gain from this patch is minimal. Would you
> mind playing it safe and drop this patch?

Hmm, write_entry() is actually called once per one path we write out, and
the fstat() is added to the common case (no --tempfile, no --prefix=<dir>
checkout), which would mean that if there were any performance gain from
this change, it was obtained by trading correctness away.  Sad.
