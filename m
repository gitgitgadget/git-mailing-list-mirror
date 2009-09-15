From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGit 07/19] implemented the packs file update functionality
Date: Tue, 15 Sep 2009 21:23:45 +0200
Message-ID: <200909152123.46131.robin.rosenberg.lists@dewire.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com> <1252867475-858-7-git-send-email-mr.gaffo@gmail.com> <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "mike.gaffney" <mike.gaffney@asolutions.com>
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 15 22:34:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnejb-0006Fk-W7
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 22:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758434AbZIOUeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Sep 2009 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758392AbZIOUee
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 16:34:34 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:42467 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755625AbZIOUed convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 16:34:33 -0400
Received: from sleipner.localnet (90.232.74.170) by pne-smtpout1-sn2.hy.skanova.net (7.3.140.3)
        id 4A7285AE0053CEDF; Tue, 15 Sep 2009 21:24:42 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1252867475-858-8-git-send-email-mr.gaffo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128586>

s=C3=B6ndag 13 september 2009 20:44:23 skrev mr.gaffo@gmail.com:
> From: mike.gaffney <mike.gaffney@asolutions.com>
>=20
> ---
>  .../jgit/lib/UpdateDirectoryInfoCacheTest.java     |   23 ++++++++++=
++++++++-
>  .../spearce/jgit/lib/UpdateDirectoryInfoCache.java |   17 +++++++++-=
----
>  2 files changed, 32 insertions(+), 8 deletions(-)
>=20
> diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDir=
ectoryInfoCacheTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/l=
ib/UpdateDirectoryInfoCacheTest.java
> index 11d183e..25b78c5 100644
> --- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryI=
nfoCacheTest.java
> +++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/UpdateDirectoryI=
nfoCacheTest.java
> @@ -1,11 +1,30 @@
>  package org.spearce.jgit.lib;
> =20
> +import java.io.File;
> +import java.util.ArrayList;
> +import java.util.List;
> +
>  import junit.framework.TestCase;
> =20
> +import org.spearce.jgit.util.JGitTestUtil;
> +
>  public class UpdateDirectoryInfoCacheTest extends TestCase {
> +	private static final String PACK_NAME =3D "pack-34be9032ac282b11fa9=
babdc2b2a93ca996c9c2f";
> +	private static final File TEST_PACK =3D JGitTestUtil.getTestResourc=
eFile(PACK_NAME + ".pack");
> +	private static final File TEST_IDX =3D JGitTestUtil.getTestResource=
=46ile(PACK_NAME + ".idx");
>  =09
> -	public void testBase() throws Exception {
> -		fail("nyi");
> +	public void testCreatesTheFileAndPutsTheContentsIn() throws Excepti=
on {
> +		List<PackFile> packs =3D new ArrayList<PackFile>();
> +		packs.add(new PackFile(TEST_IDX, TEST_PACK));
> +	=09
> +		File packsFile =3D File.createTempFile(UpdateDirectoryInfoCacheTes=
t.class.getSimpleName(), "tstdata");
> +		packsFile.deleteOnExit();
> +	=09
> +		String expectedContents =3D new PacksFileContentsCreator(packs).to=
String();
> +	=09
> +		new UpdateDirectoryInfoCache(packs, packsFile).execute();
> +	=09
> +		assertEquals(expectedContents, JGitTestUtil.readFileAsString(packs=
=46ile));
>  	}
> =20
>  }
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirector=
yInfoCache.java b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirec=
toryInfoCache.java
> index 2bceb9e..72a315a 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCa=
che.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/UpdateDirectoryInfoCa=
che.java
> @@ -1,22 +1,27 @@
>  package org.spearce.jgit.lib;
> =20
> +import java.io.BufferedWriter;
>  import java.io.File;
> +import java.io.FileOutputStream;
> +import java.io.IOException;
>  import java.util.List;
> =20
>  public class UpdateDirectoryInfoCache {
> =20
>  	private List<PackFile> packsList;
> -	private File infoDirectory;
> +	private File infoPacksFile;
> =20
>  	public UpdateDirectoryInfoCache(List<PackFile> packsList,
> -			File infoDirectory) {
> +									File infoPacksFile) {
>  		this.packsList =3D packsList;
> -		this.infoDirectory =3D infoDirectory;
> +		this.infoPacksFile =3D infoPacksFile;
>  	}
> =20
> -	public void execute() {
> -//		File objectFile =3D objectDatabase.
> -//		String packsContents =3D new PacksFileContentsCreator(this.objec=
tDatabase.listLocalPacks()).toString();
> +	public void execute() throws IOException {
> +		String packsContents =3D new PacksFileContentsCreator(packsList).t=
oString();
> +		FileOutputStream fos =3D new FileOutputStream(infoPacksFile);
> +		fos.write(packsContents.getBytes());
> +		fos.close();
>  	}
> =20
>  }

These cleanups could have been done by rewriting the patch set before s=
ubmitting.

-- robin
