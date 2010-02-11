From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 1/2] git-imap-send: Add CRAM-MD5 authenticate method 
	support
Date: Thu, 11 Feb 2010 15:55:07 +0100
Message-ID: <40aa078e1002110655n120b14b9y242a57d0e1bd3e96@mail.gmail.com>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
	 <1265899135-11488-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.org>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Thu Feb 11 15:55:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfaRp-0004eQ-0d
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 15:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab0BKOzL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 09:55:11 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:42307 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab0BKOzJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 09:55:09 -0500
Received: by fxm7 with SMTP id 7so1281761fxm.28
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kTnIIbySHxUi+lkme2ZUSQWqyO+pcTxiGW/fowiYjNc=;
        b=ewdadvMp2f9MLCEwz+xUKC3miWzKNEuWdSi1DiPysgtvp3Up4L44KFKsjOjvKE9cK6
         3RWr0OEoLSiKF6Ijj+N5GwBHeYEszp7pcK/Un/tUx/fkJ9sbEG/JdJtRjobVzGTDEAKc
         01X47KwFbMN+c0tABHafc931WMDAJFLkNGe8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=eAwcDtqL7Pt4fFcgw0yrls/IarpAguO9DzjJWzT+xZ39RVexx1Q0rlv586L2Gv/iwb
         IyzAj7cJueC4DKaNPI43hzXPeh0s7n9u44ibZZaonn2jqGbrJCSL0nBzhOIS4ATf751W
         xuOvr9RWYybTrkMI71InNp2LxXu5gDjfyxvis=
Received: by 10.216.86.193 with SMTP id w43mr1088039wee.16.1265900107321; Thu, 
	11 Feb 2010 06:55:07 -0800 (PST)
In-Reply-To: <1265899135-11488-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139600>

On Thu, Feb 11, 2010 at 3:38 PM, Hitoshi Mitake
<mitake@dcl.info.waseda.ac.jp> wrote:
> @@ -1101,6 +1190,7 @@ static struct store *imap_open_store(struct ima=
p_server_conf *srvc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0imap_info("Logging in...\n");
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!srvc->user) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf(stderr, "Skipp=
ing server %s, no user\n", srvc->host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto bail;
> @@ -1258,6 +1375,7 @@ static int read_message(FILE *f, struct msg_dat=
a *msg)
>
> =A0 =A0 =A0 =A0msg->len =A0=3D buf.len;
> =A0 =A0 =A0 =A0msg->data =3D strbuf_detach(&buf, NULL);
> +
> =A0 =A0 =A0 =A0return msg->len;
> =A0}
>
> @@ -1307,21 +1425,10 @@ static int split_msg(struct msg_data *all_msg=
s, struct msg_data *msg, int *ofs)
>
> =A0 =A0 =A0 =A0msg->data =3D xmemdupz(data, msg->len);
> =A0 =A0 =A0 =A0*ofs +=3D msg->len;
> +
> =A0 =A0 =A0 =A0return 1;
> =A0}
>

There's not much point in having three hunks with a single added
newline in each...


--=20
Erik "kusma" Faye-Lund
