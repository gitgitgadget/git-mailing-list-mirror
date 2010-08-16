From: Petr Onderka <gsvick@gmail.com>
Subject: Re: [PATCH/RFC] Add global and system-wide gitattributes
Date: Mon, 16 Aug 2010 18:51:54 +0200
Message-ID: <AANLkTi=2tRjGicxJxnJ3xccCGxcP3bLUy8u0O7q85D=R@mail.gmail.com>
References: <1281488646-7108-1-git-send-email-gsvick@gmail.com>
	<7vzkwsvllz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Henrik Grubbstrm <grubba@grubba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 18:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol2un-0008Dn-Dx
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 18:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347Ab0HPQv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 12:51:56 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39581 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0HPQvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 12:51:55 -0400
Received: by qwh6 with SMTP id 6so5136286qwh.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 09:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8ikx5V10dQHhVTvgRLO9y5KHerrriYY0qluy1r3fsjY=;
        b=GFBgYFR2TLCvHo+K6A4j/5KAcspcz8AhfB52BZTOc8JBnxHIxAcc1i7bHETy/fammY
         2M/RXz6AXJQEwxuBKEa2LEaO0LNoQOSLTluNTEPkzfT/6x9d00As8xdlEwOeThAO4P1z
         J3oIuRR0U/O8ahfLm72sbiq4sVeohwJDHTkT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l7XyUT/dCUaGfrFsucQ+Cq4zDYgedsIz22GpDb9093OvXccnOnV5Qfv6m9UNYr7Dky
         QIhP1I+TmH8J2faAhmzLlYl9DLhjcrO6xyjC/bOGcncbB3+/YZCmmBvcRd7ocaW/LjYa
         t4YmzhuBsc73Qq9uudUd9nz9OAA6aO7my/UaQ=
Received: by 10.229.117.136 with SMTP id r8mr48502qcq.201.1281977514835; Mon,
 16 Aug 2010 09:51:54 -0700 (PDT)
Received: by 10.229.28.196 with HTTP; Mon, 16 Aug 2010 09:51:54 -0700 (PDT)
In-Reply-To: <7vzkwsvllz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153663>

Hi,

On Thu, Aug 12, 2010 at 00:19, Junio C Hamano <gitster@pobox.com> wrote=
:
> Have you read the comment at the top of prepare-attr-stack? =A0This p=
atch
> feels triply wrong:
>
> =A0- The attribute stack is arranged to have higher precedence file n=
ear the
> =A0 top ($GIT_DIR/info/attributes used to be the highest). =A0The abo=
ve
> =A0 addition means that ~/.gitattributes from user's home trumps what=
 is in
> =A0 a particular repository. =A0That is backwards. =A0You may work on=
 more than
> =A0 one projects and have more than one repositories. =A0What you sha=
re among
> =A0 them personally will go to ~/.gitattributes, while a setting spec=
ific
> =A0 to a particular repository goes to $GIT_DIR/info/attributes and t=
he
> =A0 latter needs to be able to override the former.
>
> =A0- Same thing for git_attr_system() being at the end, which means y=
ou set
> =A0 up your own $GIT_DIR/info/attributes (or ~/.gitattributes) carefu=
lly
> =A0 but that can be broken by a selfish sysadmin who puts stuff that =
is
> =A0 only useful to him in /etc/gitattributes, which is not what you w=
ant.
>
> =A0- Whenever we enter a new directory (either recursing into, or com=
ing
> =A0 back up), prepare_attr_stack() is called to pop the attributes re=
cords
> =A0 from now-exited directories and push the attributes records from
> =A0 directories we are about to descend into. =A0The current code kno=
ws that
> =A0 the topmost element on the stack is special ($GIT_DIR/info/attrib=
utes)
> =A0 and first pops it, adjust the stack for elements that came from t=
he
> =A0 directory hierarcy, and then pushes that back. =A0I don't see any=
 code in
> =A0 the patch to do the equivalent for these two new attribute source=
s.

Yeah, I realize now that I got the precedence wrong, the corrected
patch is in the following email.

But to your third point, I read the comment and the code worked,
because I put all the attributes from the 3 files into one attr_stack
struct (the one at the top of the stack). That's why I changed
read_attr_from_file too. Of course this is irrelevant now that those
attributes will be at the bottom of the stack.

Petr Onderka
