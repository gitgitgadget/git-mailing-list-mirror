From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Improve parent blame to detect renames by using the 
	previous information
Date: Wed, 9 Jun 2010 22:23:56 -0400
Message-ID: <AANLkTilpMcHi4ZrrEmG4hi3TVo1IK4C-skq8cRADvAPf@mail.gmail.com>
References: <20100523075503.GA24598@coredump.intra.peff.net> 
	<1275767765-8509-1-git-send-email-fonseca@diku.dk> <20100606223545.GA11424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 04:24:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMXRO-0000PE-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 04:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab0FJCYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 22:24:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44526 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219Ab0FJCYQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 22:24:16 -0400
Received: by iwn37 with SMTP id 37so6530932iwn.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 19:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=h2EbpUXNnejUgdsp7JyEhypuVkOp7PVpBuYwMrq4gFE=;
        b=xvOtjuK2bJZZAOWgO6+tVNnpDjtsnltpVwcvVRrd14H41vYVVoAcZQQOKC1LgmQuQM
         TJhG3iZNj6mcaevdug7UryEU6wQoBS2QQU7pJqRVcJum68/jZJinFO9p2Cb/Ljvb339M
         nwsrF1iPz7S/haltCaJopc+B9Sq7f/BBSJBaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=NBSZdgw5AZ2y7dKkqVPgJW4waTEpsfQbFvAkwHwXmNQHCvz8CJ/ATd/ODGDH4A32f2
         BJrLJEhzlIZ6bgw2Sct9K3Y/4/yVy36dsa6zKdhDKVEeMdHx7YTt4djb1CTpT2yQaMPU
         wMlQvmB9mVEBvFkuPrQnxNPZAu+zjFTVwjxOQ=
Received: by 10.231.36.13 with SMTP id r13mr4115727ibd.50.1276136656065; Wed, 
	09 Jun 2010 19:24:16 -0700 (PDT)
Received: by 10.231.206.145 with HTTP; Wed, 9 Jun 2010 19:23:56 -0700 (PDT)
In-Reply-To: <20100606223545.GA11424@coredump.intra.peff.net>
X-Google-Sender-Auth: hAtzS16LffRDSreOU8pYYCqt4A8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148829>

On Sun, Jun 6, 2010 at 18:35, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 05, 2010 at 03:56:05PM -0400, Jonas Fonseca wrote:
>
> So I think it does the right thing, and I see you also included my fi=
x:
>
>> + =C2=A0 =C2=A0 char from[SIZEOF_REF + SIZEOF_STR];
>> + =C2=A0 =C2=A0 char to[SIZEOF_REF + SIZEOF_STR];
>> =C2=A0 =C2=A0 =C2=A0 const char *diff_tree_argv[] =3D {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "git", "diff-tree", "-U0=
", blame->commit->id,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "--", blame->commit->filename, NULL
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "git", "diff", "--no-tex=
tconv", "--no-extdiff", "--no-color",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "-U0", from, to, "--", NULL
>> =C2=A0 =C2=A0 =C2=A0 };
>> =C2=A0 =C2=A0 =C2=A0 struct io io;
>> =C2=A0 =C2=A0 =C2=A0 int parent_lineno =3D -1;
>> =C2=A0 =C2=A0 =C2=A0 int blamed_lineno =3D -1;
>> =C2=A0 =C2=A0 =C2=A0 char *line;
>>
>> + =C2=A0 =C2=A0 snprintf(from, sizeof(from), "%s:%s", opt_ref, opt_f=
ile);
>> + =C2=A0 =C2=A0 snprintf(to, sizeof(to), "%s:%s", blame->commit->id,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0blame->commit->fil=
ename);
>> +
>
> to handle the line-jumping properly.

Yes, I accidently squashed everything together in the patch I sent.
Before pushing the final version I move this part to a separate commit
with you as the author and made it use string_format.

--=20
Jonas Fonseca
