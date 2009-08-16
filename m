From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linus' sha1 is much faster!
Date: Sun, 16 Aug 2009 15:47:08 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908161539300.3162@localhost.localdomain>
References: <4A85F270.20703@draigBrady.com> <87eirbef3c.fsf@master.homenet>
	<alpine.LFD.2.01.0908161306340.3162@localhost.localdomain>
	<87ab1ze76y.fsf@master.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: Bug-coreutils@gnu.org, =?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigBrady.com>,
	Git Mailing List <git@vger.kernel.org>
To: Giuseppe Scrivano <gscrivano@gnu.org>
X-From: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org Mon Aug 17 00:48:02 2009
Return-path: <bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org>
Envelope-to: gcgcb-bug-coreutils-616@gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McoWA-0005N6-JZ
	for gcgcb-bug-coreutils-616@gmane.org; Mon, 17 Aug 2009 00:48:02 +0200
Received: from localhost ([127.0.0.1]:40476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1McoWA-0002H4-1q
	for gcgcb-bug-coreutils-616@gmane.org; Sun, 16 Aug 2009 18:48:02 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1McoW7-0002GG-KI
	for bug-coreutils@gnu.org; Sun, 16 Aug 2009 18:47:59 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1McoW2-00028Z-DF
	for Bug-coreutils@gnu.org; Sun, 16 Aug 2009 18:47:58 -0400
Received: from [199.232.76.173] (port=54768 helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1McoW2-00028K-9p
	for Bug-coreutils@gnu.org; Sun, 16 Aug 2009 18:47:54 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57627)
	by monty-python.gnu.org with esmtps
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.60)
	(envelope-from <torvalds@linux-foundation.org>)
	id 1McoVw-0001ky-WA; Sun, 16 Aug 2009 18:47:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id n7GMl97G006408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Aug 2009 15:47:10 -0700
Received: from localhost (localhost [127.0.0.1]) by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	n7GMl8cV014577; Sun, 16 Aug 2009 15:47:08 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <87ab1ze76y.fsf@master.homenet>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
X-MIME-Autoconverted: from 8bit to quoted-printable by
	smtp1.linux-foundation.org id n7GMl97G006408
X-detected-operating-system: by monty-python.gnu.org: GNU/Linux 2.6 (newer, 3)
X-BeenThere: bug-coreutils@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "GNU Core Utilities: bug reports and discussion"
	<bug-coreutils.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-coreutils>
List-Post: <mailto:bug-coreutils@gnu.org>
List-Help: <mailto:bug-coreutils-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-coreutils>,
	<mailto:bug-coreutils-request@gnu.org?subject=subscribe>
Sender: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Errors-To: bug-coreutils-bounces+gcgcb-bug-coreutils-616=gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126092>



On Mon, 17 Aug 2009, Giuseppe Scrivano wrote:
>=20
> Thanks for the hint.  I tried gcc-4.4 and it produces slower code than
> 4.3 on the gnulib SHA1 implementation and my patch makes it even more!

Check out the asm, see if you can see why. One of the most common problem=
s=20
with P4's is literally that you end up loading from the same stack slot=20
that you just stored to (gcc can do some really crazy spills), and that=20
causes a store buffer hazard replay.

My personal opinion is that Netburst is useless for trying to optimize C=20
code for. It's just too random.

> I noticed that on my machine your implementation is ~30-40% faster usin=
g
> SHA_ROT for rol/ror instructions than inline assembly, at least with th=
e
> test-case P=C3=A1draig wrote.  Am I the only one reporting it?

I bet it's the same thing. Small perturbations of the source causing smal=
l=20
changes to register allocation and thus spilling, and then Netburst goes=20
crazy one way or another. It's interestign trying to fix it, and very=20
frustrating.

My workstation is a Nehalem (but Core 2 will have pretty much the same=20
behavior), and it doesn't have the crazy netburst behavior. Shorter and=20
simpler code generally performs better (which is _not_ true on Netburst).=
=20

On my machine, for example, forcing gcc to do those rotates on registers=20
is the difference between ~381MB/s and 415MB/s. And that's mainly because=
=20
it makes gcc keep A-E in registers, rather than trying to cache the=20
array[] references.

			Linus
