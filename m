From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/4] git-imap-send: Implement CRAM-MD5 auth method
Date: Tue, 9 Feb 2010 15:22:47 +0100
Message-ID: <40aa078e1002090622vb65027xa53acff95557a183@mail.gmail.com>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
	 <1265717345-2118-4-git-send-email-mitake@dcl.info.waseda.ac.jp>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Tue Feb 09 15:22:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeqzP-0005oY-Fy
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 15:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab0BIOWu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 09:22:50 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:42437 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab0BIOWt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 09:22:49 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1588054eyd.19
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 06:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V6QEBUgFgqI7nAJfZc1CvaL+bYHH1x1V2qldRRRLkBE=;
        b=VScSWR8HvjF1x5EhCItHTJAf8Zgbt+oH5yRJNgjHisZMq9nOqVX8ItP1ao5pEGDmSQ
         zXCBygEth5wmlvrPhtnhfeZ1HPKFosbgfjmwG94tajgtXhWB6xuUvay2I7XxUnWLnClY
         tJlc2yduM5RyUxKk1dABEVcB2X4wkNkBu1tMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=OL1Qfcw1HkkjtDKTgLmCkHwqyuigN4CaY271l2FAaDDJ8UFr6bJm8BegBvvpJEPcVs
         KAzBiMwF7zqqFb5zjmh1r+2SlE0nwV4gGe0LnDykWW35TDrCx0ejD3Tvmw/LrkMTlcee
         cUnl+XPAUbNhWegMM1UPn6w2hiXsuLW9VFph0=
Received: by 10.216.93.18 with SMTP id k18mr130795wef.218.1265725367566; Tue, 
	09 Feb 2010 06:22:47 -0800 (PST)
In-Reply-To: <1265717345-2118-4-git-send-email-mitake@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139405>

On Tue, Feb 9, 2010 at 1:09 PM, Hitoshi Mitake
<mitake@dcl.info.waseda.ac.jp> wrote:
> +static int auth_cram_md5(struct imap_store *ctx, struct imap_cmd *cm=
d, const char *prompt)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 char digest[DIGEST_HEX_LEN];
> + =A0 =A0 =A0 char buf[256], base64_out[256];
> +
> + =A0 =A0 =A0 memset(buf, 0, 256);
> + =A0 =A0 =A0 base64_decode(buf, prompt, strlen(prompt));
> +
> + =A0 =A0 =A0 memset(digest, 0, DIGEST_HEX_LEN);
> + =A0 =A0 =A0 md5_hex_hmac(digest, (const unsigned char *)buf, strlen=
(buf),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(const unsigned char *)serve=
r.pass, strlen(server.pass));
> +
> + =A0 =A0 =A0 memset(buf, 0, 256);
> + =A0 =A0 =A0 strcpy(buf, server.user);
> + =A0 =A0 =A0 strcpy(buf + strlen(buf), " ");
> + =A0 =A0 =A0 strcpy(buf + strlen(buf), digest);
> + =A0 =A0 =A0 memset(base64_out, 0, 256);
> + =A0 =A0 =A0 base64_encode(base64_out, buf, strlen(buf));
> +
> + =A0 =A0 =A0 ret =3D socket_write(&ctx->imap->buf.sock, base64_out, =
strlen(base64_out));

Since this is the only location in this function that accesses
anything inside ctx, how about just passing the imap_socket itself to
the function? That'd make it a bit simpler if, say, I was rewriting
send-email in C and wanted to add CRAM-MD5 AUTH support (given that
I'd done the work to use imap_socket first)...

--=20
Erik "kusma" Faye-Lund
