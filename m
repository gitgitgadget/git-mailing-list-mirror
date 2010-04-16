From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Possible bug in Git
Date: Fri, 16 Apr 2010 08:53:00 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004160845350.15116@i5.linux-foundation.org>
References: <4BC6EECE.6060408@gestiweb.com> <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com>  <7vr5mggt9a.fsf@alter.siamese.dyndns.org> <o2m32541b131004151706hb48a0d04yf7fa4238d423a4e3@mail.gmail.com>
 <k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?David_Mart=EDnez_Mart=ED?= 
	<desarrollo@gestiweb.com>, git@vger.kernel.org,
	deavidsedice@gmail.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 17:56:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2nu6-0007rN-1p
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 17:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab0DPP4U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 11:56:20 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40196 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756615Ab0DPP4T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 11:56:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o3GFtXRn005766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 Apr 2010 08:55:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o3GFtWRH013896;
	Fri, 16 Apr 2010 08:55:32 -0700
In-Reply-To: <k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.447 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145068>



On Thu, 15 Apr 2010, Avery Pennarun wrote:
> >
> > The output seems to match neither parent in any way, and yet the
> > simplification has resulted in no diff at all. =A0Strange, no?
>=20
>  mkdir testy
>  cd testy
>  git init
>  cp /etc/profile .
>  git add profile
>  git commit -m root
>  git checkout -b a master
>  cat /etc/profile >>profile
>  git commit -a -m test1
>  git checkout -b b master
>  cat /etc/profile | tr A-Za-z a-zA-Z >profile
>  git commit -a -m test1b
>  git merge a
>    # produces a conflict
>  true >profile   # blank the file
>  git commit -a -m resolved
>  git show HEAD:profile
>    # no output
>=20
> Note that if you instead replace the file with a nonempty (but
> different) file, you get something appropriate as the output.

Hmm. That does seem to be a bug. It's clearly an evil merge that doesn'=
t=20
match either side, and we should show it as such.

And yes, changing the

	true >profile

to

	echo 1 >profile

changes it to suddenly show it as such.

I guess the issue is that combine-diff decides that there is nothing in=
=20
the result that isn't in either of the sources (because there is nothin=
g=20
at all in the result), and as such it's not "interesting" after all.

		Linus
