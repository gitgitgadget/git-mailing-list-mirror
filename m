From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [Updated PATCH 1/2] Report exec errors from run-command
Date: Wed, 30 Dec 2009 14:47:11 +0100
Message-ID: <40aa078e0912300547r407efb74xb821345a54a87277@mail.gmail.com>
References: <1262170338-11574-1-git-send-email-ilari.liusvaara@elisanet.fi>
	 <1262170338-11574-2-git-send-email-ilari.liusvaara@elisanet.fi>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 30 14:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPytS-0007BY-8s
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 14:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbZL3NrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 08:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbZL3NrO
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 08:47:14 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:43553 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZL3NrN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Dec 2009 08:47:13 -0500
Received: by ewy19 with SMTP id 19so3672860ewy.21
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 05:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hjQ3HosSd7bSOd2aC2Jn2ms1lJXTLJYNUM2wT46Q5mI=;
        b=ja1px2daxNOZtx0otAzCPap0nabxRZ09DXLVUWtueVpFrx0ISTXBiVP6h8QEEr2vBl
         WX51x977zuW1kl3SJJNroagayNj23K0M6dd6EGtQc03YzIFsgbPVupdxsXYbnGvPCY6l
         WNyxdvpu74lucDzngUCM6E05nw+8OPgxkMqXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=p3NKpAEFcIvr1gUqppv5s+ARj4qhjyxqoiCyFfZJVkGIRI/Z8XLT/CuVL7il8sElr0
         kHIZRK9K2nNpgaaGFllmXcRDq/brZK1UQy9y/zuAixQFBkIPYlozx0T/wszucEORdc3J
         UWvdochfYxT22nczlEp1AX/swBpDF8Ejw8FXw=
Received: by 10.216.87.71 with SMTP id x49mr2285578wee.11.1262180831797; Wed, 
	30 Dec 2009 05:47:11 -0800 (PST)
In-Reply-To: <1262170338-11574-2-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135897>

On Wed, Dec 30, 2009 at 11:52 AM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> +static inline void force_close(int fd)
> +{
> + =A0 =A0 =A0 while (close(fd) < 0 && errno !=3D EBADF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* No-op */
> +}
> +

According to http://linux.die.net/man/2/close, close can set errno to
EBADF, EINTR, or EIO. Currently, you're retrying on EINTR and EIO.
When we get EIO, are you sure it makes sense to retry? I'd imagine
that error would most likely just repeat itself, leading to an
infinite loop. How about "while (close(fd) < 0 && errno =3D=3D EINTR)"
instead? I've seen other functions (like xread in wrapper.c) only
retry on those errors that it expects. In xreads case, it's not
retrying on EIO.

Perhaps it's OK still, since force_close() is only used on pipes. I
don't know if closing a pipe can generate EIO or not.

--=20
Erik "kusma" Faye-Lund
