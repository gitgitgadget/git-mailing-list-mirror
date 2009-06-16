From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 2/2] http.c: add http.sslCertType and http.sslKeyType
Date: Mon, 15 Jun 2009 20:55:10 -0400
Message-ID: <ca433830906151755t783fbf98k3fd09e4bdd6781e8@mail.gmail.com>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
	 <1245033541-15558-2-git-send-email-lodatom@gmail.com>
	 <alpine.OSX.2.00.0906151927010.816@xor.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Daniel Stenberg <daniel@haxx.se>
To: Karsten Weiss <knweiss@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 16 03:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGN3y-0001wz-3V
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 03:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbZFPBBw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbZFPBBv
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 21:01:51 -0400
Received: from mail-fx0-f211.google.com ([209.85.220.211]:62262 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbZFPBBv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 21:01:51 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2009 21:01:50 EDT
Received: by fxm7 with SMTP id 7so303771fxm.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 18:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PFoZDEr9Wn1WvUywxVX6qkPDzn+qu6/4DUVoP/c8s1I=;
        b=LBXewgc9mOfgGfeFn3pyRbcC36AB5xK7ESGt2p9beDSZGENj8O4N01xwWveODSD5hO
         n3/3wKMCARLJUiincYR+brDkr4V+W3+z4AxAx2DUyjYeX+E8keUSk6emYf4kK6MKuBpd
         LK8iYe4zM29nzthAxxXtzUhpVm9nkWZrCon1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sAqTF9fcVvbwX2e/gAq5i+gz287CDi8TAnzlOMzpFc/gTkU+Ul/7sK6RZTKtpQXgBj
         bPhANe3g/+nKJn3ZDbdMv8yT++FDCDBKp95nuqbWVq00rA1xO5VXWmzjUkHYDNB5fmMS
         ODYg0qWNhEpkURhZsEBtUbAQ3pneDQP45vy+c=
Received: by 10.223.108.75 with SMTP id e11mr4768227fap.97.1245113710168; Mon, 
	15 Jun 2009 17:55:10 -0700 (PDT)
In-Reply-To: <alpine.OSX.2.00.0906151927010.816@xor.localnet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121641>

On Mon, Jun 15, 2009 at 1:43 PM, Karsten Weiss<knweiss@gmx.de> wrote:
> Hi Mark!
>
> On Sun, 14 Jun 2009, Mark Lodato wrote:
>
>> Add two new configuration variables, http.sslCertType and
>> http.sslKeyType, which tell libcurl the filetype for the SSL client
>> certificate and private key, respectively. =C2=A0The main benefit is=
 to allow
>> PKCS12 certificates for users with libcurl >=3D 7.13.0.
>
> This is interesting. Thanks for working on that!
>
> (However, it's a similar issue like the question whether the private =
key is
> encrypted or not: Usability would be better if the certificate type c=
ould be
> determined automatically (without having to violate the layering)).

Just as with determining if the certificate is password protected, it
is equally difficult to tell what type of file it is without calling
OpenSSL directly.

This brings up a good point: Should we (I) try to implement (client
certificate) usability features in git to work around deficiencies in
libcurl, or should we (I) write patches to fix/enhance libcurl
directly?  The latter would be much easier (though I could be wrong)
and would benefit other programs using libcurl, but would require
users to upgrade libcurl to get these new features, and of course
would rely on the libcurl developers accepting the patches.  I am
willing to do either, but I think the libcurl route would be better.
Any thoughts?


Anyway, to implement this in git, the algorithm would be something like=
:

for password in [None, "", prompt()]:
 for type in ["PEM", "DER", (if libcurl >=3D 7.13.0) "P12"]:
  try to make a connection with password and type
  if not certificate error:
   return success
else:
 return failure

This is much more difficult than it may at first appear.  I'm sure it
can be done, but it will take a while to get it right.


Mark
