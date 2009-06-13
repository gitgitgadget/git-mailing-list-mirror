From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 20:49:20 -0400
Message-ID: <ca433830906121749t2cb008b2wf72a95d275277cd9@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	 <20090612084209.6117@nanako3.lavabit.com>
	 <alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
	 <ca433830906121626q52c15f6cjdb91ffee1f2d8652@mail.gmail.com>
	 <7vk53h3rey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Stenberg <daniel@haxx.se>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 02:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFHR8-0004jV-GW
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 02:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbZFMAtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 20:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbZFMAtW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 20:49:22 -0400
Received: from mail-fx0-f216.google.com ([209.85.220.216]:46438 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZFMAtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 20:49:21 -0400
Received: by fxm12 with SMTP id 12so945242fxm.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k1YKncAp0436M+WFUTe+ee4s9+X9GKIapf+PqTdoQyw=;
        b=gTTuBF7hyuNCx5kZKpTbh87cZrCE9d5J7vazjhmcXmwhRUVgvzOLqxgYBQlNBFvixc
         wit1HXyijMZqxlREcpYK0ybN5dgKVPN2IKqyaYHVq3LdFGu0FM1kgGf02TwcDfgR1P72
         QLP4rwmaggPOgaeAVAPOcNHOPalR1my+mUpyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YFIw5MLoUfur1yr0KBcIDUMs/FGLYCbrI2T/llE9Gl9P46v7Ak6+BaBJRjXmj0xmyz
         NRYoAAquPqd3vkKGlBMdUOpCYlLnEyF1gD5cpCVbJ0REQxoc6XlDnAJERW7T6Tcgt4DJ
         0Ybr4I6QWJx3xdwNBy9X0/uLB262kTWWlsLGo=
Received: by 10.223.110.11 with SMTP id l11mr3090306fap.50.1244854162178; Fri, 
	12 Jun 2009 17:49:22 -0700 (PDT)
In-Reply-To: <7vk53h3rey.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121476>

On Fri, Jun 12, 2009 at 8:31 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Mark Lodato <lodatom@gmail.com> writes:
>
>>> And for the libcurl not supporting this, I figure it _could_ be don=
e by
>>> simply letting libcurl prope the remote and see if it can access it=
 without
>>> a passphrase as that would then imply that isn't necessary.
>>>
>>> I'm not familiar enough with the code and architecture to deem how =
suitable
>>> such an action would be.
>>
>> I don't think it is possible to check to see if it is encrypted from
>> within git (without calling OpenSSL directly).
>
> I think what Daniel is suggesting is to attempt making a test connect=
ion
> (that does not have to have anything to do with the real object trans=
fer)
> without passphrase to see if it fails. =C2=A0If it doesn't, you know =
you do not
> need a passphrase to unlock the key/cert.

Hmm, I did not do this initially since I thought it was not possible
without calling OpenSSL directly.  If you do not set
CURLOPT_KEYPASSWD, OpenSSL will prompt the user without telling the
program.  But now that you and Daniel mention it, I think I now
believe it is possible to autodetect by setting CURLOPT_KEYPASSWD to
"" during the trial connection.  But is it OK to perform a trial
connection that serves no other purpose?  If so, I will work on
creating a new patch that does this.

> While I still think that kind of automated detection would be necessa=
ry in
> the longer term (in other words, we do not necessarily have to have i=
t in
> the initial implementation that appears in our official release), unt=
il that
> materializes, I think it is more prudent to follow the approach below=
=2E

Understood.  If the above works, I see no need to go with my original
patch series.


>>> <snip...> If you can't do that, probably you can introduce a config=
 var that says
>>> "this certificate is encrypted", and bypass your new code if that c=
onfig var isn't set.
>
> I think I've said this already in another message, but "I break your
> working setup with my patch, but you can add this configuration to un=
break
> it" should not be done lightly, certainly without a good reason. =C2=A0=
And the
> reason here as far as I can see is that the code chooses not to bothe=
r
> with the autodetection of encryptedness of the cert/key. =C2=A0So...

Again, it wasn't that I didn't bother; it was that I thought this was
not possible.  If the autodetection doesn't pan out, I understand your
reasoning and will change the default to be the old behavior.


Thanks again,
Mark
