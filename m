From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH] Create a debugging tool "jgit rebuild-commitgraph"
Date: Mon, 16 Mar 2009 21:09:46 +0100
Message-ID: <200903162109.46653.robin.rosenberg.lists@dewire.com>
References: <1236954901-30990-1-git-send-email-spearce@spearce.org> <200903151234.39367.robin.rosenberg@dewire.com> <20090316144450.GN22920@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:11:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJ9m-0005VI-3u
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392AbZCPUKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 16:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbZCPUKA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:10:00 -0400
Received: from mail.dewire.com ([83.140.172.130]:5189 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbZCPUJ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 16:09:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D04D6138AD53;
	Mon, 16 Mar 2009 21:09:52 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTbgIQmgV8UK; Mon, 16 Mar 2009 21:09:50 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 0DD70138AD57;
	Mon, 16 Mar 2009 21:09:50 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <20090316144450.GN22920@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113362>

m=E5ndag 16 mars 2009 15:44:50 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> >=20
> > I'd hate to put such a dangerous thing in the list of normal tools.=
 If the user
> > want to shoot him/her-self in the foot they should get a license fi=
rst.
>=20
> How about squashing this in?

Does it have to be a utility accessible through the pgm interface? Why =
not=20
just run ut as java org.spearce.jgit.pgm.debug.RebuildCommitGraph ?=20

>=20
> diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCom=
mitGraph.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCo=
mmitGraph.java
> index ccee997..cc23438 100644
> --- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCommitGrap=
h.java
> +++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/RebuildCommitGrap=
h.java
> @@ -50,6 +50,7 @@
>  import java.util.Map;
> =20
>  import org.kohsuke.args4j.Argument;
> +import org.kohsuke.args4j.Option;
>  import org.spearce.jgit.errors.MissingObjectException;
>  import org.spearce.jgit.errors.ObjectWritingException;
>  import org.spearce.jgit.lib.Commit;
> @@ -85,6 +86,11 @@
>   * <p>
>   */
>  class RebuildCommitGraph extends TextBuiltin {
> +	private final String REALLY =3D "--destroy-this-repository";
> +
> +	@Option(name =3D REALLY, usage =3D "approve destruction of reposito=
ry")
> +	boolean really;
> +
>  	@Argument(index =3D 0, required =3D true, metaVar =3D "REFS", usage=
 =3D "for-each-ref output")
>  	File refList;
> =20
> @@ -97,6 +103,30 @@
> =20
>  	@Override
>  	protected void run() throws Exception {
> +		if (!really && !db.getAllRefs().isEmpty()) {
> +			final StringBuilder m =3D new StringBuilder();
> +			m.append("fatal: ");
> +			m.append("This program will destroy the repository:");
> +			m.append("\n");
> +			m.append("fatal:\n");
> +			m.append("fatal:    ");
> +			m.append(db.getDirectory().getAbsolutePath());
> +			m.append("\n");
> +			m.append("fatal:\n");
> +			m.append("fatal: ");
> +			m.append("To continue, add ");
> +			m.append(REALLY);
> +			m.append(" to the command line");
> +			m.append("\n");
> +			m.append("fatal:");
> +			System.err.println(m);
> +			throw die("Need approval to destroy current repository");

What's wrong with old fashioned '+' ? (which just translated to exactly=
 this series
of StringBuilder calls anyway?

> +		}
> +		if (!refList.isFile())
> +			throw die("no such file: " + refList.getPath());
> +		if (!graph.isFile())
> +			throw die("no such file: " + graph.getPath());
> +
>  		recreateCommitGraph();
>  		detachHead();
>  		deleteAllRefs();

-- robin
