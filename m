From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/6] Add set to IntList
Date: Sun, 3 May 2009 09:07:01 +0200
Message-ID: <200905030907.02287.robin.rosenberg.lists@dewire.com>
References: <1241230127-28279-1-git-send-email-spearce@spearce.org> <1241230127-28279-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 03 09:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0VnM-0003XX-8Z
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 09:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbZECHHO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 03:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZECHHN
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 03:07:13 -0400
Received: from mail.dewire.com ([83.140.172.130]:3234 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbZECHHM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2009 03:07:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B9BAD10233DD;
	Sun,  3 May 2009 09:07:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eDc08rd50V76; Sun,  3 May 2009 09:07:06 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id E03D2800277;
	Sun,  3 May 2009 09:07:05 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1241230127-28279-2-git-send-email-spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118165>

l=F6rdag 02 maj 2009 04:08:42 skrev "Shawn O. Pearce" <spearce@spearce.=
org>:
> Some applications may wish to modify an int list.
>=20
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  .../tst/org/spearce/jgit/util/IntListTest.java     |   21 ++++++++++=
++++++++++
>  .../src/org/spearce/jgit/util/IntList.java         |   17 ++++++++++=
++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
>=20
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListT=
est.java b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.=
java
> index c470d55..ce0d7af 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.jav=
a
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/util/IntListTest.jav=
a
> @@ -144,6 +144,27 @@ public void testClear() {
>  		}
>  	}
> =20
> +	public void testSet() {
> +		final IntList i =3D new IntList();
> +		i.add(1);
> +		assertEquals(1, i.size());
> +		assertEquals(1, i.get(0));
> +	=09
> +		i.set(0, 5);
> +		assertEquals(5, i.get(0));
> +	=09
> +		try {
> +			i.set(5, 5);
> +			fail("accepted set of 5 beyond end of list");
> +		} catch (ArrayIndexOutOfBoundsException e){
> +			assertTrue(true);
> +		}
> +
> +		i.set(1, 2);
Oh, you grow the array here. Not obvious.

> +		assertEquals(2, i.size());
> +		assertEquals(2, i.get(1));
> +	}
> +
>  	public void testToString() {
>  		final IntList i =3D new IntList();
>  		i.add(1);
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java =
b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
> index 0a84793..9d86a5c 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/util/IntList.java
> @@ -94,6 +94,23 @@ public void add(final int n) {
>  	}
> =20
>  	/**
> +	 * Assign an entry in the list.
> +	 *=20
> +	 * @param index
> +	 *            index to set, must be in the range [0, {@link #size()=
}).
> +	 * @param n
> +	 *            value to store at the position.
> +	 */
> +	public void set(final int index, final int n) {
> +		if (count < index)
> +			throw new ArrayIndexOutOfBoundsException(index);
> +		else if (count =3D=3D index)
> +			add(n);

The interface is quite obscure here. One the one hand it checks for ass=
ignment
outside the set but it does grow the array when only one entry is missi=
ng. The
reader of the code won't see that easily. A different name and reflecti=
on of the
behaviour in the javadoc is needed. The class javadoc says "A more effi=
cient=20
List<Integer> using a primitive integer array." and I know of no java.u=
til.List's=20
that expand implicitly.

-- robin
