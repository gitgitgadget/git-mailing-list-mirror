From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH] fix deletion of .git/objects sub-directories
 in git-prune/repack
Date: Tue, 06 Mar 2012 13:49:57 -0800
Message-ID: <7vmx7tqu0q.fsf@alter.siamese.dyndns.org>
References: <7v4nu1scsl.fsf@alter.siamese.dyndns.org>
 <OFBC9E02C9.526DB40C-ONC12579B9.00726ECA-C12579B9.00763181@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Stefan Naewe <stefan.naewe@gmail.com>
To: karsten.blees@dcon.de
X-From: git-owner@vger.kernel.org Tue Mar 06 22:50:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S52Gn-0000fH-Qy
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 22:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758314Ab2CFVuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 16:50:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45333 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755606Ab2CFVuC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 16:50:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AAC752D9;
	Tue,  6 Mar 2012 16:50:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jggx97b23DEBfzj1p8p4lUIV6g8=; b=HPwjT/
	5Yxk68/K8oxHWjnPyfwF0NuAz6XDVmsnQZYjzhnthixpDqQGO6Sm/WEBwZ/IBmTv
	hQFawldXTcS/kRt6wP9nnAZeSNpSuoYM0AcNLvuyfsG27mR/ThDvzoNV3pwiJvQu
	UazGLEXjr8sfvSWT7Ko4beuFJOTV371svY/Dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IoOMjnpR0uxrhZuFMVTmNrxMbAHqmVzk
	Ul7wKv22Cj4a/11jXV8qEgXX4EVLwl3yePUQ6SJmmvOHo740Q8BFkhyAp3hMcWMa
	CYA9WR4rPnkgU4jmiXFjBGjfikZVF0IUdqXZM9ILRlUoayMKwQm5+Xz3gIT63pa/
	7qpbpw6iTS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A96352D8;
	Tue,  6 Mar 2012 16:50:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 757DB52D6; Tue,  6 Mar 2012
 16:49:59 -0500 (EST)
In-Reply-To: <OFBC9E02C9.526DB40C-ONC12579B9.00726ECA-C12579B9.00763181@dcon.de> (karsten
 blees's message of "Tue, 6 Mar 2012 22:30:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 520F1B9E-67D6-11E1-B113-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192402>

karsten.blees@dcon.de writes:

> Junio C Hamano <gitster@pobox.com> wrote on 06.03.2012 21:19:06:
>> Johannes Sixt <j6t@kdbg.org> writes:
>> 
>> >> diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
>> >> index f9463de..a834417 100644
>> >> --- a/builtin/prune-packed.c
>> >> +++ b/builtin/prune-packed.c
>> >> @@ -36,7 +36,6 @@ static void prune_dir(int i, DIR *dir, char 
> *pathname, 
>> >> int len, int opts)
>> >>                 display_progress(progress, i + 1);
>> >>         }
>> >>         pathname[len] = 0;
>> >> -       rmdir(pathname);
>> >
>> > After moving the rmdir() away from prune_dir(), the truncation of the
>> > pathname does not logically belong here anymore. It should be moved 
> with
>> > the rmdir(). Looks good otherwise.
>> 
>> I agree that it is better to have the NUL termination close to where
>> it actually matters.
>> 
>
> The pathname is extended in prune_dir, so I think it should be reset there
> as well; moving it to prune_packed_objects would be quite obscure:

This depends entirely on how you look at it.

You can certainly stare at the original code and declare that the
contract between the caller and the callee was that the caller gives
pathname[] and len (len+3 for the caller) to the callee, and allows
the callee to play with the rest of the pathname[] array but expects
that pathname[] to be properly NUL-terminated when the callee comes
back.  From that point of view, "pathname[len] = 0" can belong to
the callee.

But while you are staring the original code, notice that "expects
that pathname[] to be NUL-terminated when the callee comes back" is
not something the caller even depends on.  That expectation starts
to matter _only_ if you move rmdir(pathname) to the caller.

That is why I said "where it actually matters."

In other words, "The caller allows the callee to play with the rest
of the pathname[]; as long as the callee does not touch earlier
parts of the array, it can do anything before it returns", without
requiring the callee to NUL-terminate the pathname[] to restore to
its original state, is equally a valid contract between the caller
and the callee in the original code.

And that also holds true for the updated code that has rmdir() in
the caller.

> OT: While looking at the code I just stumbled across this immediately
> above the patch (prune-packed.c line 32ff):
>
>                 memcpy(pathname + len, de->d_name, 38);
>                 if (opts & DRY_RUN)
>                         printf("rm -f %s\n", pathname);
>                 else
>                         unlink_or_warn(pathname);
>
> Shouldn't this be memcpy(..., 39) (i.e. including '\0')?

That is not necessary, I think, as get_sha1_hex() does not look at
that NUL in the first place.
