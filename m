From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] process_{tree,blob}: Remove useless xstrdup calls
Date: Sat, 11 Apr 2009 12:58:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904111255530.4583@localhost.localdomain>
References: <20090408112854.GA8624@atjola.homenet> <alpine.LFD.2.00.0904101517520.4583@localhost.localdomain> <alpine.LFD.2.00.0904101714420.4583@localhost.localdomain> <alpine.LFD.2.00.0904101806340.4583@localhost.localdomain> <20090411134112.GA1673@atjola.homenet>
 <20090411140756.GA15288@atjola.homenet> <alpine.LFD.2.00.0904111115210.4583@localhost.localdomain> <20090411194000.GB21300@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 22:12:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsjYZ-0001BQ-OD
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 22:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693AbZDKUKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 16:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758540AbZDKUKH
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 16:10:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60041 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757771AbZDKUKG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 16:10:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BJwqfa019211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 12:59:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n3BJwogl017006;
	Sat, 11 Apr 2009 12:58:51 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090411194000.GB21300@atjola.homenet>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.445 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116342>



On Sat, 11 Apr 2009, Bj=F6rn Steinbrink wrote:
>=20
> No, this is x86-64, 8 byte pointers. But the savings are trivially
> explained I think. The struct object_array things are 20 bytes here (=
per
> object overhead!), so that's about 5M * 20 =3D 100M. And the average =
name
> length for the objects was 19 bytes, which means about another 100M.
> Both, the object_array stuff as well as the path names, were allocate=
d
> and never freed. Your patch removed the object_array stuff, and it ma=
de
> the memory allocations for the names temporary. Right?

Right.

My original one-liner patch just did the name freeing part, but it did =
so=20
only at the _end_ (when actually calling show_object()), so it probably=
=20
didn't help RSS very much - because you still had one point in time whe=
re=20
you had all the names allocated. It probably helped packing (since it=20
allocates more _afterwards_), but likely didn't make much of a differen=
ce=20
for just 'git rev-list".

So that was the impetus for trying to just avoid the "keep all objects=20
around on the 'object_array' thing" patch, and then cleaning up the=20
show_object() call semantics.

		Linus
