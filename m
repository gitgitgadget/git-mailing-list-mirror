From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 5/6] Introduce the git fast-import-helper
Date: Mon, 4 Oct 2010 01:15:36 +0200
Message-ID: <AANLkTi=RASZU2e+WV6kXnUH=afE=g2SoGuJFZF1QJ4=D@mail.gmail.com>
References: <4CA86A12.6080905@dbservice.com> <1286108511-55876-5-git-send-email-tom@dbservice.com>
 <20101003153144.GA18001@burratino> <4CA8A504.50009@dbservice.com>
 <AANLkTinZ6NCvKeALDBfP4z=ewkwWVwHBk=C_LmXM7OFh@mail.gmail.com> <4CA8BFB7.2050707@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:16:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Xmz-0001bU-Bl
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab0JCXP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 19:15:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45113 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab0JCXP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 19:15:58 -0400
Received: by iwn5 with SMTP id 5so6167436iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 16:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6/7RhZsZ3KtX0Y6repNQULLBGehixLGmxA10wAsu+DM=;
        b=X5J9fPFVuY5s3G8Y/WCDjBx/zAVRG6sKAZQgQ3n15BZyw5AN/H0nHh/8C8d31TGfg3
         fuMIgUkJ6yZD1MyotSn8hDFBtZFA7u65N1nsvY+RR/eZgz9VmoA9ClmOYsCDauujmeg/
         SsiNCWGJ8z9NFSpJrgFkEgF2hkLmF5CSr0MlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nWlffsJuIMkNOz+iQXI1WInBb7wLl7kFAvYxrZjqdgk8Rm1kBm4ao3IUkt2Z+Yvr+B
         JnmP55UF1ETn1Lx0RYJavjeJqYFEeboUKI3zPZ4IRy+aBOcc1xfG8XJRJPFo9rXiTdKI
         Wm+EZFdI90DFb8tB/C5nRKhp/PMmKmLmhzDMY=
Received: by 10.231.190.149 with SMTP id di21mr9135564ibb.166.1286147757850;
 Sun, 03 Oct 2010 16:15:57 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Sun, 3 Oct 2010 16:15:36 -0700 (PDT)
In-Reply-To: <4CA8BFB7.2050707@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157944>

Heya,

On Sun, Oct 3, 2010 at 19:39, Tomas Carnecky <tom@dbservice.com> wrote:
> I also use a hash table (struct hash_table from hash.h). It's indexed=
 by
> the atom. So it's about equally fast as the existing one but uses
> slightly more memory. I measured the speed and fih is about 5% slower
> than fi. Also, I found out that setting max_packfile to 32MB makes th=
e
> import much faster (from 10 minutes down to 3m to import the sources =
of
> git itself).

That's curious.

A 5% increase is significant. Imagine importing netbeans, (which is
actually a use case of git-remote-hg), which takes about 4 hours. A 5%
slowdown means the process will take more than 10 minutes longer.

> I do: fprintf(stdout, "mark :%s %s\n", mark, sha1_to_hex(sha1));
> One reason why not just write the plain hash is because that's the sa=
me
> syntax as the fih accepts in its input. This way you can do:
> =C2=A0$ ( cat marks; cat fast-export-stream ) | git fast-import-helpe=
r >> marks
> and can restart at any time. Also, making the output a bit more
> structured allows it to be easily extended in the future.

I don't see much benefit tbh, if we want to do something like that it
could (relatively) easy be added to regular git fast-import with a
feature. So you'd start the stream with "feature new-marks-format" and
only then follow up with "feature import-marks=3D...". Ditto on the
commandline, `git fast-import --new-marks-format --import-marks=3D...".
If it turns out to be very useful/popular it can be made the default
after warning for a full release first.

--=20
Cheers,

Sverre Rabbelier
