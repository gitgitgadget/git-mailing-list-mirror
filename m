From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH v2 1/3] Introduce die_errno() that appends strerror(errno) 
	to die()
Date: Sun, 7 Jun 2009 15:12:39 +0400
Message-ID: <2325a7950906070412k3a440558h35db7511cc390e4b@mail.gmail.com>
References: <200906061509.15870.trast@student.ethz.ch>
	 <cover.1244299302.git.trast@student.ethz.ch>
	 <3672f22723a4c14c4a6d67278e9865424c0c68dc.1244299302.git.trast@student.ethz.ch>
	 <20090606221320.GB30064@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Petr Baudis <pasky@suse.cz>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 07 13:15:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDGLE-0005oN-S6
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 13:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbZFGLMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 07:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbZFGLMj
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 07:12:39 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:47927 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753652AbZFGLMi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 07:12:38 -0400
Received: by fxm9 with SMTP id 9so1544509fxm.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dnCSnGkuHs23Zi2/MLVvZx8rMho1W2K4shWwMjDrW0U=;
        b=hln70Ch9ZDge0T/Vg+lXJ5Fff8oJwa3kki/n49mOjmFezKXHyoTvD08X+CtRu00K63
         TH9bfNsaL0NIhcaHFkVUkT9BRpoOPD4JSm9xMpt9wauUfonuZ7TnP3Sshfmq1YlT45Yx
         Pe4OJ4VMjGJbgzFaimQzNtpX+H8lBIP4brjiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sfjs5TmGiBsTI72tNvYT6g7Ps22RtiHuNnf/Km9AEXoR9sLxTNw/pfM0d6BdlLFdyQ
         lzI/IkgzaKgX6Ii8CW3MEAkd92Qz5LGMBFI7gQH7HOYNgRuJbjKjK4OeumTpHrte19+z
         yuQLwyily2hFfv8CAlLt1We7V3e80y53Yes/g=
Received: by 10.223.113.9 with SMTP id y9mr3117863fap.19.1244373159924; Sun, 
	07 Jun 2009 04:12:39 -0700 (PDT)
In-Reply-To: <20090606221320.GB30064@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120963>

2009/6/7 Jeff King <peff@peff.net>:
> On Sat, Jun 06, 2009 at 04:44:51PM +0200, Thomas Rast wrote:
>
>> Code by Jeff King and Alexander Potashev, name by Johannes Sixt.
>> [...]
>> +void die_errno(const char *err, ...)
>> +{
>> + =C2=A0 =C2=A0 va_list params;
>> + =C2=A0 =C2=A0 char msg[1024];
>> +
>> + =C2=A0 =C2=A0 va_start(params, err);
>> +
>> + =C2=A0 =C2=A0 vsnprintf(msg, sizeof(msg), err, params);
>> + =C2=A0 =C2=A0 die("%s: %s", msg, strerror(errno));
>> +
>> + =C2=A0 =C2=A0 va_end(params);
>> +}
>> +

This breaks theoretical usage of custom format string in custom die
routines:
        1. A custom die routine might not support %s.
        2. If the die routine adds a custom format specifier, vsnprintf
                will fail.

But I'm not sure that passing a format string and a va_list to
die_routine/error_routine/warn_routine is really necessary. If there
is no much external code depending on them, I would convert them to the
style of usage_routine:
        void (*usage_routine)(const char *err)

CC'ing Petr Baudis <pasky@suse.cz>, see commit 39a3f5ea


>
> No, this approach is much more elegant than what I posted, so no need=
 to
> credit me, at least. ;)

It was your idea of using 1024-character buffer here ;)


                                        Alexander
