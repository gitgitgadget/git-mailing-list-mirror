From: "Krzysztof Kowalczyk" <kkowalczyk@gmail.com>
Subject: Re: [PATCH] Optimize common pattern of alloc_ref from string
Date: Sat, 10 May 2008 17:30:56 -0700
Message-ID: <7ce338ad0805101730n5b964a0em39d9fdcd9fc45f00@mail.gmail.com>
References: <1210462018-47060-1-git-send-email-kkowalczyk@gmail.com>
	 <20080510233918.GA315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 11 02:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuzTi-0004TT-Rm
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 02:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbYEKAbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 20:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbYEKAbA
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 20:31:00 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:55481 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYEKAa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 20:30:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1020807ywe.1
        for <git@vger.kernel.org>; Sat, 10 May 2008 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=s9qa9qQ2LNtdciwyBwhBkL95qyzoghoXuMjzc4APbx4=;
        b=N0945XKWGkZtTl/SwXsTS3UpuVBK/U3yQyyR1bgOmHJtaM9aCv+QNx5UydmgEGZSA9ky/ll8e03n2nYTM9i5i4phSTgOCxL5uXO3vzUY4AU6Bsu899kCnnzs1+QZGF+QfA7Jnlnzj89a8OQd2Q4jdZY6OzcymMVU5LwlUggu+bU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uUlPQZMwsnAtWeJsaBg0M6gUx2TZ1jpKqZ8gmMAMWLBeoUw2OQSXoRNXdkuBkfAro0fuJjVEOalr+GopUKAs4Djg49VJgonb02At4byF34BqU4irli5d75fJsGT7PMPpox/DZu3dTcm4og91TnfPLdvli0jh7YQuSTDhdvIIo7Q=
Received: by 10.150.83.22 with SMTP id g22mr4026664ybb.134.1210465856493;
        Sat, 10 May 2008 17:30:56 -0700 (PDT)
Received: by 10.150.134.9 with HTTP; Sat, 10 May 2008 17:30:56 -0700 (PDT)
In-Reply-To: <20080510233918.GA315@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81721>

On Sat, May 10, 2008 at 4:39 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 10, 2008 at 04:26:58PM -0700, kkowalczyk@gmail.com wrote:
>
>> As a byproduct, fixes one place where string wasn't properly terminated.
>
> Great. Does this fix a user-visible bug? It would be nice to mention in
> the commit log _which_ place (though after reading the patch carefully,
> it looks like the one interpret_target) so that people looking at the
> commit later can understand exactly what was fixed.

It was a subtle memory corruption that wouldn't cause problems in
99.99% cases, but valgrind would probably catch it. And yes, it's the
interp_target().

>> -     ref = alloc_ref(strlen(refname) + 1);
>> -     strcpy(ref->name, refname);
>> +     ref = alloc_ref_from_str(refname);
>
> So this turns a 2-line construct into a 1-line construct...

And avoids future prossible mistakes with not terminating the string,
like the one just commited.

>> +struct ref *alloc_ref_from_str(const char* str)
>> +{
>> +     struct ref *ret;
>> +     unsigned len = strlen(str) + 1;
>> +     char *tmp = xmalloc(sizeof(struct ref) + len);
>> +     ret = (struct ref*)tmp;
>> +     memset(tmp, 0, sizeof(struct ref));
>> +     tmp += sizeof(struct ref);
>> +     memcpy(tmp, str, len);
>> +     return ret;
>> +}
>
> But why do we need an 8-line function to do it?
>
> The only difference I can see over
>
>  struct ref *alloc_ref_from_str(const char *str)
>  {
>    unsigned len = strlen(str) + 1;
>    struct ref *ret = alloc_ref(len);
>    memcpy(ret->name, str, len);
>    return ret;
>  }
>
> is that we avoid memsetting the name portion of the struct to 0 before
> copying to it. It seems like an unproven micro-optimization that makes
> it a bit harder to read.

You're absolutely right - it's a micro-optimization and your version
might be preferred for clarity. This is the first time I submit a
patch to git so I don't have a good feel for what kind of treadoffs
people find acceptable.

I should also mention that
static struct ref *try_explicit_object_name(const char *name)
{
	unsigned char sha1[20];
	struct ref *ref;

	if (!*name) {
		ref = alloc_ref(20);
		strcpy(ref->name, "(delete)");
		hashclr(ref->new_sha1);
		return ref;
	}
...

could also be replaced with alloc_ref_str() - I just wasn't 100% sure
if overallocating 10 bytes (20 - strlen("(delete)")) was just sloppy
code or does other code relies on that (which is unlikely and if true
then it wouldn't be good).

Regards,

-- kjk
