Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF0681F404
	for <e@80x24.org>; Tue,  6 Mar 2018 06:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbeCFGKK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 01:10:10 -0500
Received: from mail4.protonmail.ch ([185.70.40.27]:14054 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeCFGKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 01:10:09 -0500
Date:   Tue, 06 Mar 2018 01:09:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urandom.co.uk;
        s=protonmail; t=1520316607;
        bh=Os1AxbnggGUIJepGBaXcZzFGOJQ3KmuT/lRBzBe7zt4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=YwBfeAJSNi/2JgriwaqZpangqSfmnfJad2iv1Dz1yoaB61gGg/qQlipF/8cGef/Ds
         GuryZxRzhpdWCmrkklx8ORqA8MR6MJVEvdNEfJ87YgEj5729ux1rZQIg1PTZ+w4d2M
         SNV4oCqDsdeiIlSaxprzP/K7ZiQiM23hUNvprUXI=
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
From:   Colin Arnott <colin@urandom.co.uk>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Colin Arnott <colin@urandom.co.uk>
Subject: Re: [PATCH] http.c: shell command evaluation for extraheader
Message-ID: <-mpHjLv0pGYld30rBagku1GYfPM2FqZQubWD4rHt2K_uijQg0ehMjeBnZgr4K77zc2E4HAlm3eqNtP7-lXzhR8o7udP0TdNHMJK7WRauzmk=@urandom.co.uk>
In-Reply-To: <nycvar.QRO.7.76.6.1803051437000.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CngnTUCx1pVSyKUzINZV972DlD_JMH53F-L2PZtx0_RKMiwXYY4f2UzDPeJaC5fL-6oJBXAxQ5f0OC76I_fagEWxch5csI716N7bQDh3gR8=@urandom.co.uk>
 <nycvar.QRO.7.76.6.1803051437000.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Feedback-ID: yOOU7P6jxO77HcrFw4SgItADp6aEzrzaBrsweNUU3GchxkXYtI8xYBc21P-ZUn-yQhUSAkQaHpx8GP3vtEZa9g==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes,

On March 5, 2018 1:47 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> =
wrote:

> As the credential-helper is already intended for sensitive data, and as i=
t
> already allows to interact with a helper, I would strongly assume that it
> would make more sense to try to extend that feature (instead of the simpl=
e
> extraHeader one).

To confirm you are suggesting that the credential struct, defined in creden=
tial.h, be extended to include a headers array, like so:
--- a/credential.h
+++ b/credential.h
@@ -15,6 +15,7 @@ struct credential {
        char *protocol;
        char *host;
        char *path;
+       char **headers
 };
=20
 #define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }

> This would also help alleviate all the quoting/dequoting issues involved
> with shell scripting.
>=20
> Besides, the http.extraHeader feature was designed to accommodate all
> kinds of extra headers, not only authentication ones (and indeed, the
> authentication was only intended for use in build agents, where both
> environment and logging can be controlled rather tightly).

I realise that my examples are scoped for auth, but I can conceive of other=
 mutating headers that are not explicitly authentication related, and could=
 benefit from shell execution before fetch, pull, push actions.

> I also see that in your implementation, only the extraHeader value is
> evaluated, without any access to the rest of the metadata (such as URL,
> and optionally specified user).
>
> It would probably get a little more complicated than a shell script to
> write a credential-helper that will always be asked to generate an
> authentication, but I think even a moderate-level Perl script could be
> used for that, and it would know the URL and user for which the
> credentials are intended...

You are correct; the scope provided by http.<url>.* is enough to meet my us=
e cases, however I agree the lack of access to metadata limits what can be =
done within in the context of the shell, and makes the case for a credentia=
l-helper implementation stronger. I think there is something to be said abo=
ut the simplicity and user-friendliness of allowing shell scripts for semi-=
complex config options, but authentication is a task that should be handled=
 well and centrally, thus extending the credential-api makes sense.

=E2=80=8BWithout Wax,
Colin Arnott=E2=80=8B
