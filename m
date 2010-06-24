From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [GSoC update extra!] git-remote-svn: Week 8
Date: Thu, 24 Jun 2010 13:07:52 -0500
Message-ID: <20100624180752.GA1642@burratino>
References: <1277386408-29943-1-git-send-email-artagnon@gmail.com>
 <20100624173956.GA1600@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 20:08:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORqqT-0007JM-RO
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 20:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632Ab0FXSII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jun 2010 14:08:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54327 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab0FXSIG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 14:08:06 -0400
Received: by iwn41 with SMTP id 41so1084392iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=faffwcUq0pJVJlE0teuK7jcyUgLJpDzDFYP627ShfMo=;
        b=In4UTTnvkZRYXc/uD7XAZrkXPtZ+luo2jv93+jNqslGtK/Bh1ac6C8tLVO/myfkiT3
         n0BjLwbXOt+zdGt5x4E9npAiwujLUBeR0XPoktJCo7SvdhVMm6CYHK50MuSxNdA4re/L
         3TJFzgqCHzkDPKgqk0BBc//ZQ+kwKDt4oObUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=A/33LbobMURNkHXt8GRQUhAle/fQ35rbLq1YD3WAtf6p+W0r86+qqx/d+mJqIwa7WA
         pvXufF3AlH44k73cWZzSAL2l6mz/xYxn8DmtlTyRYuHqWbzz6mDn1e8ILyFSzTGZE+Dm
         FqUO5KzmU4vsfe/TKjfcS2peLS3+KwzAVtR+o=
Received: by 10.231.36.9 with SMTP id r9mr10033567ibd.105.1277402884553;
        Thu, 24 Jun 2010 11:08:04 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm18764876ibg.21.2010.06.24.11.08.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 11:08:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624173956.GA1600@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149615>

Jonathan Nieder wrote:

> Git has all the blobs and all the trees, so except for the mapping
> between marks, subversion revs, and git revs, svn-fe does not need to
> persist much data at all.
>=20
> Of course, that requires that the fast-import stream is going directl=
y
> to git.

One more thought.

If we are tracking the history of separate subversion branches separate=
ly,
then reading back trees includes an oddity:

Suppose someone tries to reimplement git-svn on top of svn-fe[1].

 $ git svn --fe clone --stdlayout http://path/to/some/svn/root

Behind the scenes, git-svn processes the fast-import stream it is
receiving and writes its _own_ fast-import stream with paths munged
and commits split up into separate commits on each branch.  Good.

Now the oddity: suppose that in the repository, svn-fe finds an

 svn copy branches@r11 branches-old

operation.  In other words, it needs the tree for
http://path/to/some/svn/root/branches@r11.  This does not correspond
to a single git tree, since the content of each branch has been given
its own commit.

However, this does not seem to be fatal: one could just make
=E2=80=98git svn --fe=E2=80=99 build a branch with the full history at =
the same time
as it builds the other branches.  Ugly, but I don=E2=80=99t see another=
 way
around it without making svn-fe and =E2=80=98git svn --fe=E2=80=99 know=
 more about
each other than I would like.

Jonathan

[1] Eric, we are discussing the remote-svn series[2] and especially
Ram, Sverre, and David=E2=80=99s recent comments[3].  Apologies for not
keeping you in the loop sooner; your insights have always been
helpful in the past.

As for the idea of reimplementing git-svn on top of svn-fe: yes, the
fast-import stream would need more information to support
--follow-parent, but that piece is not so hard to add AFAICT.  Of
course, I am mentioning this not because it is important to keep the
git-svn interface but because the --stdlayout feature is very useful
and we may want to port it over some day.

[2] http://thread.gmane.org/gmane.comp.version-control.git/149571
[3] http://thread.gmane.org/gmane.comp.version-control.git/149594
