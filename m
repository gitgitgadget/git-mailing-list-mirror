From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Sat, 3 Jul 2010 19:35:43 -0500
Message-ID: <20100704003543.GA25858@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100702051201.GC7209@burratino>
 <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com>
 <20100702154028.GB2287@burratino>
 <1278201760.9701.39.camel@denix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Jul 04 02:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVDCK-0005aa-W0
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 02:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab0GDAg1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 20:36:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42284 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357Ab0GDAg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 20:36:26 -0400
Received: by iwn7 with SMTP id 7so4418434iwn.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 17:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=04cNJILgX3SAQk53J60SwOxhq4zGQDw7S0Xe5T0TL2Q=;
        b=dRQqh/v3iCSBoucBcJdkbDtvB9rV8+v0Ck6VpGETWVGQS+drXb3cM6cpynGRKky8VL
         YIKLlTNsQ8YdfepVLkvR8FMcF/ytnglMHAlu7n4TzjWZ9nGxh2F5XxWUGIMlhIkbzqDn
         3WLDTApKZkI568zOMHWmIdaLhYlysmvWQAbzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YbBJbPRXfsdWVpwUQFlQIlsxohx7WHVqn3PjXYmE/eNG+wwR4TjHvD9qhPNvBy9zDP
         ohRH6M2UI58q9cjZ5WwwSYsXFXmB8O0JsSVrLDlnm1m9BIfxK92/NDPOSuUlkcf/vSKz
         3QW8zgeSmJKKddfQk59/6no1vfHiQ9A1RTQHI=
Received: by 10.231.170.79 with SMTP id c15mr1058516ibz.82.1278203777060;
        Sat, 03 Jul 2010 17:36:17 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h8sm10588525ibk.3.2010.07.03.17.36.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 03 Jul 2010 17:36:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278201760.9701.39.camel@denix>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150214>

Sam Vilain wrote:

> It should be very simple to implement --batch-verify as well, which i=
s
> essentially the same thing, just only printing the header and not the
> contents.
>=20
> How hard do you think it would be to implement a 'rev-parse' command?
> Perhaps you can see where this is going... :-)

Well, I think I understand what you are saying, but it=E2=80=99s not qu=
ite
like that.  fast-import is already doing a lot of work to keep track
of this collection of objects in a pack that is not yet accessible to
git because its index has not been written yet.

svn-fe needs those objects (well, it at least needs a few blobs when
it learns to apply a delta to the latest revision).  So what to do?

One option is to make fast-import into a library, or copy the code we
need into svn-fe.  And that would be possible!  But it would make
svn-fe much more complicated, and there would be this second
fast-import interface to maintain.

Or svn-fe could keep the full text of all files from the latest
revision in a temporary directory.  To get blobs for an _older_
revision, it would still need to ask git, but such copy operations are
uncommon enough that the time to request a checkpoint and wait for
things to settle could be tolerable.  The main downside: in a huge
repository like ASF=E2=80=99s, that=E2=80=99s a good amount of wasted s=
pace.

Or one can teach fast-import to supply exactly what we need from it,
which is the raw content of some blobs (and perhaps trees) it has
written to pack and not indexed yet.

Jonathan
