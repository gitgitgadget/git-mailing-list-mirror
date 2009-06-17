From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] avoid exponential regex match for java and objc function 
	names
Date: Wed, 17 Jun 2009 17:46:54 +0200
Message-ID: <9b18b3110906170846o5b3c3000r72506bf62765a044@mail.gmail.com>
References: <20090617102332.GA32353@coredump.intra.peff.net>
	 <1245248766-14867-1-git-send-email-bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 17:47:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGxMX-0000Su-9W
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 17:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536AbZFQPqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2009 11:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZFQPqw
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 11:46:52 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:52700 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbZFQPqw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 11:46:52 -0400
Received: by an-out-0708.google.com with SMTP id d40so702729and.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Y2V6wOlVY/pZOnfinybUILAQSyCEgC7F51gkx9edWo0=;
        b=P8UAsuXqRl0Knk36EYf3Gyveq7gZ2suOKrTFelWzJ3C3anFtO3UL44/Lyti5bdXsuU
         VQhIMAZRu46pZo0Xtosz1pKofZqhbZdj+J+ruhEX4KE8JMZYNv09WzvSn4mWQnJ9hG2C
         GNeuxgnNsodXqaqwpakGrlwy5pIIklvEl9q2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oYYODlBtPj6fcOqGoOKPUFwBB2L0mtyc8O6Xayx9GfybauRf1UfSkTd7RSmVovqRmn
         PmxrCmxp/8ml6kNj1tVQujumFJOMlYPLcugqxGA4sng1SnZluAy3WErJBkp+7dsXPMfb
         J5XyaSLbWZ63Fjp3j6zz0Xq8oIlicSEtUkebE=
Received: by 10.231.18.5 with SMTP id u5mr105896iba.5.1245253614028; Wed, 17 
	Jun 2009 08:46:54 -0700 (PDT)
In-Reply-To: <1245248766-14867-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121753>

Just  a note, but If the  Java regex library you are using supports
the PCRE compatible (?>...) atomic matching construct (or their
equivalent *+ and ++) then these patterns can be significantly
improved beyond their current state.


2009/6/17 Paolo Bonzini <bonzini@gnu.org>:
> In the old regex
>
> ^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\([^;]*)$
> =A0 =A0 =A0 =A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> you can backtrack arbitrarily from [A-Za-z_0-9]* into [A-Za-z_], thus
> causing an exponential number of backtracks. =A0Ironically it also ca=
uses
> the regex not to work as intended; for example "catch" can match the
> underlined part of the regex, the first repetition matching "c" and
> the second matching "atch".
>
> The replacement regex avoids this problem, because it makes sure that
> at least a space/tab is eaten on each repetition. =A0In other words,
> a suffix of a repetition can never be a prefix of the next repetition=
=2E
>
> Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
> ---
> =A0userdiff.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index d556da9..57529ae 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -13,7 +13,8 @@ PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
> =A0 =A0 =A0 =A0 "[^<>=3D \t]+|[^[:space:]]|[\x80-\xff]+"),
> =A0PATTERNS("java",
> =A0 =A0 =A0 =A0 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switc=
h|throw|while)\n"
> - =A0 =A0 =A0 =A0"^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\(=
[^;]*)$",
> + =A0 =A0 =A0 =A0"^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-=
Za-z_0-9]*[ \t]*\\([^;]*)$",
> + =A0 =A0 =A0 =A0/* -- */
> =A0 =A0 =A0 =A0 "[a-zA-Z_][a-zA-Z0-9_]*"
> =A0 =A0 =A0 =A0 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> =A0 =A0 =A0 =A0 "|[-+*/<>%&^|=3D!]=3D"
> @@ -25,7 +26,7 @@ PATTERNS("objc",
> =A0 =A0 =A0 =A0 /* Objective-C methods */
> =A0 =A0 =A0 =A0 "^[ \t]*([-+][ \t]*\\([ \t]*[A-Za-z_][A-Za-z_0-9* \t]=
*\\)[ \t]*[A-Za-z_].*)$\n"
> =A0 =A0 =A0 =A0 /* C functions */
> - =A0 =A0 =A0 =A0"^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\(=
[^;]*)$\n"
> + =A0 =A0 =A0 =A0"^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-=
Za-z_0-9]*[ \t]*\\([^;]*)$\n"
> =A0 =A0 =A0 =A0 /* Objective-C class/protocol definitions */
> =A0 =A0 =A0 =A0 "^(@(implementation|interface|protocol)[ \t].*)$",
> =A0 =A0 =A0 =A0 /* -- */
> --
> 1.6.0.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
