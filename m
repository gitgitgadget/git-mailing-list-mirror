From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] read-cache: avoid memcpy in expand_name_field in index v4
Date: Tue, 19 Mar 2013 08:29:01 +0700
Message-ID: <CACsJy8DhMpQsNY3f4U3FmE1Bd1PvrxDLTYWT6boycrJVtv8WVg@mail.gmail.com>
References: <1363611482-1015-1-git-send-email-pclouds@gmail.com> <7vboagoav9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 02:30:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHlNK-0006qH-Nv
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 02:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141Ab3CSB3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 21:29:33 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43842 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab3CSB3d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 21:29:33 -0400
Received: by mail-ob0-f178.google.com with SMTP id wd20so6007198obb.37
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 18:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=coRSky9E0DImfbdlSvKLvyeXSJj0S3w/2LESdzmFMRE=;
        b=Yp6Nqe68d+viCRLBe2CXg6JkaGq+wc1g8HTgE+ZOVmpexUZqlj8wow+sKSYUGCC1LZ
         ace25nnHb9kA/AJqVq1Q4Euk875YQfEasVxNDEZm3uXPQ5l74cU6dI+Bcye296mAX9FV
         ZYxt+mOiiRX9gR1wMXZVT7/Wd/hpK6pQvxoH3jQ7/wGOwayecd800KF0T0ri0DoyY2xz
         a/jcjZzwjeXsTefCOxzshTZ6N8MlO01IbgI1gFCaIAERTxuIP48G4XRJmSkaYANtWbya
         Q0uCj7PBICyXR0li3xwNF1vuBUcytvQWc/UKAbNU7ENV9DMBLVLf7zkR4DsAnZ3tgcZe
         EggQ==
X-Received: by 10.60.171.230 with SMTP id ax6mr156876oec.25.1363656572449;
 Mon, 18 Mar 2013 18:29:32 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Mon, 18 Mar 2013 18:29:01 -0700 (PDT)
In-Reply-To: <7vboagoav9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218466>

On Tue, Mar 19, 2013 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> While it is true that strbuf_remove(&sb, sb.len - trim, trim) is
> equivalent to strbuf_setlen(&sb, sb.len - trim), I wonder why we see
> any memcpy() in the first place.
>
> strbuf_remove(&sb, sb.len - trim, trim) is turned into
> strbuf_splice(&sb, sb.len - trim, trim, NULL, 0) and then in turn it
> does these two:
>
>         memmove(sb.buf + (sb.len - trim) + 0,
>                 sb.buf + sb.len, 0);
>         memcpy(sb.buf + (sb.len - trim), NULL, 0);
>
> both of which should be a no-op, no?

Apparently my memcpy does not bail out early when the third arg is
zero (glibc 2.11.2 on gentoo, x86). It cares more about memory
alignment. This is the beginning of memcpy:

mov    %edi,%eax
mov    0x4(%esp),%edi
mov    %esi,%edx
mov    0x8(%esp),%esi
mov    %edi,%ecx
xor    %esi,%ecx
and    $0x3,%ecx
mov    0xc(%esp),%ecx
cld
jne    75946 <memcpy+0x56>
cmp    $0x3,%ecx
jbe    75946 <memcpy+0x56>


> There also is this call that has the same "trim at the right end":
>
>     pretty.c:       strbuf_remove(sb, sb->len - trimlen, trimlen);
>
> It almost makes me suggest that it may be a better solution to make
> strbuf_remove() more intelligent about such a call pattern _if_
> these empty memmove/memcpy are so expensive, perhaps like the
> attached.  It could be that strbuf_splice() should be the one that
> ought to be more intelligent, but I'll leave it up to you to
> benchmark to find out where the best place to optimize is.

memcpy is not expensive per-se, but this is (again) webkit, where
expand_name_field (and memcpy) is called ~200k times. At that quantity
I still prefer fixing in the "hot" call site expand_name_field(), and
because strbuf_setlen is an inline function, we make no extra calls.

Making strbuf_remove/strbuf_splice more intelligent may be good (or
may make it harder to read), I don't know. But I think it could be a
separate topic.
-- 
Duy
