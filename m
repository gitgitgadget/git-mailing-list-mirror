From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 8 May 2012 18:04:58 +0200
Message-ID: <CABPQNSYzxDoer_Xhf+8EEU4zz58PLRQiZAsg_CWzP3ps6f_4rw@mail.gmail.com>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
 <7v62c6zon4.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 18:05:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRmv2-0003Zp-8T
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 18:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924Ab2EHQFk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 12:05:40 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48301 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756337Ab2EHQFj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 12:05:39 -0400
Received: by pbbrp8 with SMTP id rp8so8208783pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=zoNUXQvP41PoZfVzwwONYF8ePXpRxcQFbyHO5OXz9wE=;
        b=MtuxZlaJoh0mC7zs4FKORoutgT30GYJY8qfjK5eOKOdkI1sBjWOwXxkvc2q7o6FknN
         1TjHY3eqZS+nC6NN4fPSApMvZbOPC/8zJsUj+30c2Zi381dRcdXr7dCmm0eBRpyZ/H5G
         PQR8dMR1ToJ+/DpnqrN/jIr5qSuQQ3grjMxMuDxqHKBUY9fSUGRl8FqH58qMeaVqJxUV
         y8EVUlN3Wf3aYly7RrekJMOQ6VGr9McPjOGCs4JKR0OCbXN5SXIj2VClqU+G0fLjqATp
         ci26DmdoVxbSbCQR3UFoW5cUxeYKPF/e/3+KVRl41wIrJSK0xXsVJw8Spcn1p82wQpYJ
         OdJA==
Received: by 10.68.202.167 with SMTP id kj7mr9233641pbc.9.1336493138663; Tue,
 08 May 2012 09:05:38 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Tue, 8 May 2012 09:04:58 -0700 (PDT)
In-Reply-To: <7v62c6zon4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197380>

On Tue, May 8, 2012 at 5:19 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> + =A0 =A0 test_create_repo empty-repo &&
>> + =A0 =A0 git submodule add ./empty-repo empty-submodule
>
> You have an empty-repo but that is not part of the superproject; the
> superproject will have empty-submodule submodule which is a clone of
> empty-repo.
>
> =A0 =A0$ git submodule add ./empty-repo empty-submodule
> =A0 =A0Cloning into 'empty-submodule'...
> =A0 =A0warning: You appear to have cloned an empty repository.
> =A0 =A0done.
>
> And after that, without you doing anything in empty-submodule, that
> repository already exhibits the (null) problem. =A0Perhaps somebody, =
after
> calling a successfull "git clone" of an empty repository (which is a =
silly
> thing to do to begin with, with or without submodules involved, but a=
t
> least we do have a defined semantics of what happens when you do that=
),
> tried to run "git checkout", even though there is nothing to be check=
ed
> out? =A0The culprit in that case to suspect would be "git submodule" =
script.
> Does it blindly assume that it can do a "git checkout" and runs that
> command?

Yes, it does. Basically, it calls "git checkout -f -q" from cmd_add if
$branch is empty. And it fails if the checkout-call fails.

I'm not saying it's a sane thing to do. But to me, it kind of feels
natural to initialize the shared (i.e bare) repos for both the
superproject and the submodule, clone the superproject, add the
submodule, and populate these from there. But that won't work the way
things currently are, because you can't "git submodule add" an empty
project.

To allow that, we would have to make sure "git submodule add" works
with empty repositories. And we can probably archive this in multiple
ways.

But for now, I'm happy with just erroring out on the "git submodule
add"-call. I didn't really expect adding an empty submodule to work, I
was just hoping it did ;)

I'm sending a proper patch with a saner test soon.
