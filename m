From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Can't assign user.name to "E F" in git config
Date: Mon, 29 Mar 2010 16:55:59 -0400
Message-ID: <32541b131003291355k5f93b251vded347e37315fee5@mail.gmail.com>
References: <308d4701003291332s500cbbci68e10a784ac1aa81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Disc Magnet <discmagnet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 22:56:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwM0d-0003ew-7W
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 22:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0C2U4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Mar 2010 16:56:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39311 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979Ab0C2U4U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 16:56:20 -0400
Received: by gyg13 with SMTP id 13so1703560gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YIOW2zpJeVAm6j8l4789i8G2u2vHkFElIlo6sh9tBqQ=;
        b=aZ3z91Yvlvar2BHiDImHXAwPTmqGSdv2vq5FBVy+qAp/s5tpYgyuAP5e3hR+LfH9+l
         HMZiraaSnf2MpXZ048aqQlf8Xo1SSkNZE3NZCsmUA3chfw89UDFjLZhEhhKYXboc8QKE
         pGMWyLCW1kRQ+zc+um2xKub9g4v1sfnGZb7DY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xliqX4MxaCexoWNu0vGOF6wwoecHtSqbsgBUSdfu6JwvT6oGm1weHmZVavTtREd0dg
         L0DrXpqCv3/aFusBEPxQ5qCT6vJ3/rRRTtaRjjMmGAVYrrykFK8axhjgZ2lm76wN0Jpv
         Hp4VYoURnwNS6AzpB8XJsTDt0DsIgyWDZulpc=
Received: by 10.150.203.4 with HTTP; Mon, 29 Mar 2010 13:55:59 -0700 (PDT)
In-Reply-To: <308d4701003291332s500cbbci68e10a784ac1aa81@mail.gmail.com>
Received: by 10.150.254.7 with SMTP id b7mr4406318ybi.293.1269896179118; Mon, 
	29 Mar 2010 13:56:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143517>

On Mon, Mar 29, 2010 at 4:32 PM, Disc Magnet <discmagnet@gmail.com> wro=
te:
> I've never done a git init and I don't have any .git directory in the
> current directory. I get warnings in the following example. Moreover,
> I can't assign user.name to "E F".

Take a look at 'man git-config' and search for "value_regex".  The
behaviour is incredibly non-obvious, but git-config is working as
documented:

> humpty@wall:~/work$ rm ~/.gitconfig
> humpty@wall:~/work$ git config --global user.name A B
> humpty@wall:~/work$ git config --global user.name C D
> humpty@wall:~/work$ git config --global user.name "E F"
> warning: user.name has multiple values
> humpty@wall:~/work$ git config -l
> user.name=3DA
> user.name=3DC
> humpty@wall:~/work$ cat ~/.gitconfig
> [user]
> =A0 =A0 =A0 =A0name =3D A
> =A0 =A0 =A0 =A0name =3D C

The A B line means "remove any user.name options containing B and then
add A".  Similarly with C D.  But the "E F" line means "there is only
one value of user.name, and it should be E F."  At that time,
user.name has more than one value, so git assumes you've made a
mistake and refuses to perform the operation (which would have
resulted in potentially many lost lines of config information).

You can fix it with "git config --global --unset-all user.name".

> However, everything works fine here.
>
> humpty@wall:~/work$ rm ~/.gitconfig
> humpty@wall:~/work$ git config --global user.name A
> humpty@wall:~/work$ git config --global user.name C
> humpty@wall:~/work$ git config --global user.name "E F"
> humpty@wall:~/work$ git config -l
> user.name=3DE F
> humpty@wall:~/work$ cat ~/.gitconfig
> [user]
> =A0 =A0 =A0 =A0name =3D E F

In the above, you never created multiple values, because the first two
lines didn't have extra parameters.

> Is this an expected behavior or is it a bug?

I didn't know about it before, and to be honest, it seems a little
insane.  But I found it by reading the man page, so it's clearly
"expected" behaviour, in the sense that we're told to expect it.  And
now that it exists, removing it would break backward compatibility.

Have fun,

Avery
