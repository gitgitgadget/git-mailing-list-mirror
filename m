From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: what's the current wisdom on git over NFS/CIFS?
Date: Fri, 3 Jul 2009 06:22:01 +0530
Message-ID: <2e24e5b90907021752t10243468sc07be88cd88ac5c1@mail.gmail.com>
References: <slrnh4pcf8.484.sitaramc@sitaramc.homelinux.net>
	 <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 03 02:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMX0c-0002fj-OO
	for gcvg-git-2@gmane.org; Fri, 03 Jul 2009 02:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZGCAv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbZGCAv7
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 20:51:59 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:53615 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbZGCAv6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 20:51:58 -0400
Received: by yxe26 with SMTP id 26so2927748yxe.33
        for <git@vger.kernel.org>; Thu, 02 Jul 2009 17:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CbaohCzKpUF6TsaWpmfPhjnY7gv+Ej40a9nevRKU6f4=;
        b=bOqxDTgtksyDxe3TF4JvWnaWONfe6GH4bgwj9p4Reqg9SdSfwIb8k2RqAR/CerjWqq
         O+eiqrLFOJm+h/VA7c6fWv4hVppE4IFNQ6kQWr8x03nRphOV1IZAJkilRTMnHFMv0W3G
         ybyadsGgYlq4uBMLblzmGOmWarA1H8yC0IBF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e/PbGOdlyjuCMACcI3w47sHzJzlMdwyPIUd27rQVLJA2cstj/2CrY1KRNsjARuCPGg
         sXkQ1r4D/a0bbK2RghzfcbBEzWCkS8VjH4Zkt/xx43PX1so42w8zA2LgQpbTTjgZ6p4P
         xQXeUqXRz9wR3sZQXq5v65mZbZWoOwwuWbg2A=
Received: by 10.231.10.137 with SMTP id p9mr873572ibp.52.1246582321082; Thu, 
	02 Jul 2009 17:52:01 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907021345440.3210@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122678>

On Fri, Jul 3, 2009 at 2:28 AM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:

> On Thu, 2 Jul 2009, Sitaram Chamarty wrote:

>> A couple of us were beating each other senseless on this
>> issue over on #git, so I thought I'd ask: is it OK to do
>> this? =A0Or would there potential be race conditions due to
>> the lack of proper locking?
>
> It should all work fine.
>
> We've had a few NFS issues due to oddities with renaming across
> directories, but modern git avoids the cross-directory renames, and t=
hat
> whole issue only hit some very specific cases anyway.
>
> And git doesn't have "proper locking", because it doesn't need it for
> database ops: git objects are stable. For refs, git should be using t=
he
> proper NFS-safe "create and atomic rename" ops.
>
> You do need to be a bit careful if you do maintenance operations
> concurrently (I would suggest avoiding doing concurrent "git gc --pru=
ne",
> for example), but any normal git workflow should be fine.
>
> There is one big thing to look out for: performance. You may want to =
add
>
> =A0 =A0 =A0 =A0[core]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PreloadIndex =3D true

Great!  Thanks for the really detailed reply; appreciate it very much.

I knew about core.PreloadIndex simply due to searching "man
git-config" for NFS etc., but not the rest of it.

> in your .git/config file, especially if you have a high-latency NFS s=
erver
> (but if you have a fast network and a high-end NFS server, you might =
be
> better off without it, so do your own testing).
>
> Btw, I think we fixed the problem we had with CIFS. That one was a ci=
fs
> filesystem problem on Linux, but it should be fixed in 2.6.30+ (commi=
t
> 0f4d634c: "cifs: flush data on any setattr"). If you have an older ke=
rnel
> (or are just uncertain), you can also work around it with
>
>        [core]
>                fsyncobjectfiles =3D true
>
> which may be a good thing in general (regardless of any cifs issues),=
 but
> in most cases the performance loss isn't worth it if your filesystem =
is
> stable and sane.

Though I asked this following from a debate on IRC, it now looks as if
this will solve another of my problems too.

Let me explain.

I'm evangelising git at work, and although most projects are happy,
even eager to setup a proper server for git, and those that can't are
happy to just use mine, there are a couple of projects that are almost
exclusively Windows _and_ cannot add another machine _and_ have client
confidentiality issues so they can't just use my server.

My alternatives for them so far were (1) VirtualBox running Fedora or
something within one of their beefier Windows servers or (2) the whole
cygwin install, which is painful compared to msysgit.

Sounds like we can just do it with traditional Windows fileshares, as
long as we make sure no one does a "git gc" on the bare repo that is
being shared.  That's a very small price to pay!

Thanks once again, and I'm copying Gitte in case he has anything to
add, seeing I have sneakily changed the focus of the question now :-)
[It wasn't pre-meditated, honest!]

Sitaram
