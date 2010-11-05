From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/H] Makefile fix for FC13?
Date: Sat, 06 Nov 2010 00:43:02 +0100
Message-ID: <4CD49686.3070800@op5.se>
References: <7vr5ezqsv9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 06 00:43:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEVwA-0007Yi-0a
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 00:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab0KEXnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 19:43:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44656 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089Ab0KEXnG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 19:43:06 -0400
Received: by ewy7 with SMTP id 7so2117854ewy.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 16:43:04 -0700 (PDT)
Received: by 10.14.119.135 with SMTP id n7mr1311778eeh.29.1289000583934;
        Fri, 05 Nov 2010 16:43:03 -0700 (PDT)
Received: from clix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id b52sm1568362eei.13.2010.11.05.16.43.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 16:43:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7 ThunderGit/0.1a
In-Reply-To: <7vr5ezqsv9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160831>

On 11/05/2010 11:59 PM, Junio C Hamano wrote:
> As k.org is migrating to FC13, I'm also adding an FC13 bochs to my
> collection so that I can cut releases for 32-bit i?86 archs.  I noticed
> that the compilation fails with this:
> 
>        LINK git-imap-send
>    /usr/bin/ld: imap-send.o: undefined reference to symbol 'EVP_DecodeBlock'
>    /usr/bin/ld: note: 'EVP_DecodeBlock' is defined in DSO
>    /lib/libcrypto.so.10 so try adding it to the linker command line
> 
> I understand that this is because the linker policy changed in the release
> to make things safer.  My understanding of the rationale for the change
> goes like this:
> 
>    When a binary (e.g. imap-send) wants a symbol X (e.g. EVP_DecodeBlock)
>    from a library A (e.g. -lcrypto), and the binary also wants a different
>    symbol from another library B (e.g. -lssl), and if the library B happens
>    to depend on library A, it used to be sufficient to link the binary with
>    library B, without explicitly linking it with library A, as library A
>    will be pulled in at the runtime because library B wants it anyway.
> 
>    This however would break if library B stops depending on library A
>    (i.e. library B gets updated while remaining compatible with its own
>    older version, but its implementation no longer requries library A).  It
>    is therefore safer to force programs to list their dependencies
>    explicitly at link time.
> 

That's probably fairly accurate.

> So, I need a patch like the following to make things compile on FC13.
> 
> Thoughts?  Ideas for doing this (specifically, "make rpm") in better ways?
> 

Not better, no. There are macros to distinguish the release type and version
though, so if you want to enable this only for FC13 and later, you could use
one of those. I have no idea what they're named, but google might provide
insight. See my next comment first though.

> On my FC11 bochs and my other Linux boxes, the linker is loose but it does
> not seem to hurt (and I do not think it should, as openssl-dev package
> seems to have almost always shipped with both -lssl and -lcrypto) to add
> this unconditionally.
> 

This has been working since RH6, and probably earlier too. I doubt it will
break anything. It doesn't on FC12 anyways.

> diff --git a/Makefile b/Makefile
> index 1f1ce04..18c7e8e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -776,6 +776,7 @@ ifeq ($(uname_S),Linux)
>   	NO_STRLCPY = YesPlease
>   	NO_MKSTEMPS = YesPlease
>   	HAVE_PATHS_H = YesPlease
> +	NEEDS_CRYPTO_WITH_SSL = YesPlease
>   endif
>   ifeq ($(uname_S),GNU/kFreeBSD)
>   	NO_STRLCPY = YesPlease
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
