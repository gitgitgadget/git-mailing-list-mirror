From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 18:30:18 -0700
Message-ID: <CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com> <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 03:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUPdJ-0005tB-9l
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 03:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281AbbHZBgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 21:36:04 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36023 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932758AbbHZBgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 21:36:02 -0400
Received: by vkif69 with SMTP id f69so76081105vki.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 18:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+8881A9YIEUHGL0FnAhycgZBIGzxdBNgIqv+J0Jwf2g=;
        b=qdG0lMk8nxI69h+Fq7C5gh+UFVBnbDYLOFuikyz3mb3wBC93ow9p6zKuFglXEP9Vcj
         FWgpNklWloWCWXPMCd2EhDNuhgX0fMXjxHzC2niDjM6s3nN8zwnnKs9x5JSE33pvIMtl
         NOBe5fU/O3uqPrxn5dcmJSnmMJsHN20FmgE09yviEu2ui9Bo3M25dsngP0IZaAaEORq+
         xZymKTJWl+dsbrtXmsBF/PwijwQJZYf4FaBMMufuvHnQJ+nMAdE/gG7CcFfJvV9XZrne
         1CtK8cS+ENvPygoBzf+nk1415d/osqwySptRi4dC4yPOqziocyLH+fxGrdT4wLdl9AZh
         OZWQ==
X-Received: by 10.52.179.69 with SMTP id de5mr9293411vdc.27.1440552637967;
 Tue, 25 Aug 2015 18:30:37 -0700 (PDT)
Received: by 10.31.165.9 with HTTP; Tue, 25 Aug 2015 18:30:18 -0700 (PDT)
In-Reply-To: <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276589>

On 25 August 2015 at 16:43, Junio C Hamano <gitster@pobox.com> wrote:
> I do not see a good way to do such a safe transition with command
> words approach, *unless* we are going to introduce new commands,
> i.e. "git list-tag", "git create-tag", etc.

Perhaps we could introduce a more explicit notion (in .git/config) of
a Git API version (or, perhaps more accurate, a Git CLI API version)?

The default would be 2 (since we're already at Git 2.x). Git commands
could check for this setting and abort/introduce/prevent/change
behaviour/functionality as appropriate. During Git 2.x the API 2 would
be the default but users could explicitly request 3 in preparation of
Git 3.x. (With the knowledge that API 3 would still be [to some extent
at least] in flux.) API 2 could start warning about future changes
where appropriate. With the introduction of Git 3.x, the default would
become API 3 but users could still request API 2. Then for Git 4.x the
default would go to 4, with an option to request 3 but 2 would no
longer be supported (and all code supporting API 2 could be removed).

I think that from a user's point of view this could work quite well.
Obviously, (worst case scenario) Git commands might have to support up
to 3 APIs at the same time (previous [2], current [3], and future [4]
for Git 3.x) so from a code maintenance POV it would certainly
introduce complexity and probably some duplication of code. I'm
hopeful it would be limited to CL argument processing but I suspect
that when Git code calls other Git code (especially in the Bash based
commands) there might be some more complexity there.

Would something like that be feasible?
