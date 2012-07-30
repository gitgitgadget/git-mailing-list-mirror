From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] link_alt_odb_entry: fix read over array bounds reported
 by valgrind
Date: Sun, 29 Jul 2012 18:01:58 -0700
Message-ID: <7vzk6it62h.fsf@alter.siamese.dyndns.org>
References: <20120728154635.GB98893@book.hvoigt.net>
 <7v4noqul05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Torsten =?utf-8?Q?B=C3=83=C2=B6gershausen?= <tboegi@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:02:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SveN6-0005mu-Cx
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab2G3BCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 21:02:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460Ab2G3BCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 21:02:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D2B59E7F;
	Sun, 29 Jul 2012 21:02:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RzTmR/sIl89uAkC4lolSR9BLqYc=; b=k6gRYv
	LAZEA+2X3LviQg+amkVm4yN1R3qoRmQ0VBuXeMJIE72oGxMAJqlR0jGVje9pou0l
	st7tnzJI6PCA1lD7T8jRQTqCv64/+/1cpqegtTt/K5blTUlXZIXWcJkpx3uGbF3S
	TZxLA/vgEuT2IHAmZxF35PJqFj/L5x6+WsaOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pl/QBJM96WFXhC+qtGYwXY7wP5Iq2hm3
	vUPhzYN1kryGCL+20xDn8VpNVZs45R3z9vj/l0PvHlQ+3ZapFautlWsISWWrdTuK
	cfQF4Cg3K0bfcOnA9eCiY1YWKuzmZiksoJvzE9aoHoDjKqCx/BBHHCvRvb7bCWal
	2Rppny0j/+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A7429E7E;
	Sun, 29 Jul 2012 21:02:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C69ED9E7D; Sun, 29 Jul 2012
 21:01:59 -0400 (EDT)
In-Reply-To: <7v4noqul05.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 29 Jul 2012 17:54:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A9739A6-D9E2-11E1-96FE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202512>

Junio C Hamano <gitster@pobox.com> writes:

> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>> pfxlen can be longer than the path in objdir when relative_base contains
>> the path to gits object directory.
>
> s/gits/????/ perhaps "Git's", but I am not sure.
>
>> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
>> ---
>>  sha1_file.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 4ccaf7a..631d0dd 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>>  			return -1;
>>  		}
>>  	}
>> -	if (!memcmp(ent->base, objdir, pfxlen)) {
>> +	objdirlen = strlen(objdir);
>> +	if (!memcmp(ent->base, objdir, pfxlen > objdirlen ? objdirlen : pfxlen)) {
>
> The new code tells us to compare up to the shorter length between
> objdir (i.e. path/to/.git/objects) and the given alternate object
> directory (i.e. alt/path/to/.git/objects), but is that really what
> we want?  What happens if the given alternate object directory were
> "path/to/.git/objects-not-quite", with objdir "path/to/.git/objects"?
>
> They are not the same directory, and this check is about avoiding
> "the common mistake of listing ... object directory itself", no?
>
>>  		free(ent);
>>  		return -1;
>>  	}

In other words, wouldn't this be sufficient?  We NUL terminate
ent->base[pfxlen] when we prepare that buffer with

	LEADING PATH\0XX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\0

in preparation for these "duplicate check" step, and then we turn
the NUL at ent->base[pfxlen] to '/' before leaving the function to
make it

	LEADING PATH/XX/XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\0

so that we can fill XX when probing for loose objects.

 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4f06a0e..a1f3bee 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -298,7 +298,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 			return -1;
 		}
 	}
-	if (!memcmp(ent->base, objdir, pfxlen)) {
+	if (!strcmp(ent->base, objdir)) {
 		free(ent);
 		return -1;
 	}
