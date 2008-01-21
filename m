From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] git-fsck: report missing author/commit line in a commit as an error
Date: Mon, 21 Jan 2008 08:00:49 +0100
Message-ID: <20080121070049.GA18819@auto.tuwien.ac.at>
References: <12008555922208-git-send-email-mkoegler@auto.tuwien.ac.at> <alpine.LSU.1.00.0801201918260.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 21 08:01:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGqeu-00081V-G2
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 08:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724AbYAUHAv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 02:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYAUHAv
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 02:00:51 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:46680 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbYAUHAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 02:00:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id AA26C680BECA;
	Mon, 21 Jan 2008 08:00:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVFlA0Szx6Fr; Mon, 21 Jan 2008 08:00:49 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 8ADF1680BEAC; Mon, 21 Jan 2008 08:00:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801201918260.5731@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71232>

On Sun, Jan 20, 2008 at 07:20:54PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sun, 20 Jan 2008, Martin Koegler wrote:
>=20
> > +	if (!commit->date)
> > +		return objerror(&commit->object, "invalid author/commiter line i=
n %s",
>=20
> s/commiter/committer/

Thanks. Will change in next version.

> It makes me wonder, though, if that's correct.  AFAICT it is the comm=
itter=20
> date, and the rest of the line _might_ be just fine.
>
> Why not be less intrusive and just change the printf() into a return=20
> objerror(), like the commit message suggests?

parse_commit_date returns zero, if
* the author line is missing
* the author line is not terminated with \n
* the committer line is missing
* the committer line does not contain >
* the > is not followed by a number bigger than zero
* the commiter line is not terminated with \n

So, in my option the message "bad commit date in %s" is incorrect/misle=
ading.

fsck_commit could be further simplified:

//  If tree is missing, parse_commit should return zero =3D> fsck_commi=
t would not be called=20
-        if (memcmp(buffer, "tree ", 5))
-                return objerror(&commit->object, "invalid format - exp=
ected 'tree' line");
//  If sha1 is missing/incorrect, parse_commit should return zero =3D> =
fsck_commit would not be called=20
-        if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] !=3D '\n')
-                return objerror(&commit->object, "invalid 'tree' line =
format - bad sha1");
         buffer +=3D 46;
         while (!memcmp(buffer, "parent ", 7)) {
//  If sha1 is missing/incorrect, parse_commit should return zero =3D> =
fsck_commit would not be called=20
-                if (get_sha1_hex(buffer+7, sha1) || buffer[47] !=3D '\=
n')
-                        return objerror(&commit->object, "invalid 'par=
ent' line format - bad sha1");
                buffer +=3D 48;
         }
         if (memcmp(buffer, "author ", 7))
                 return objerror(&commit->object, "invalid format - exp=
ected 'author' line");

I'm not sure, if this 6 lines should be dropped too.

The memcmp(buffer, "author ", 7) check is already done by
(!commit->date), but I prefer to keep it, as further committer/author
line checks can be based on it.

mfg Martin K=F6gler
PS:
While writting this mail, I noticed that parse_object_buffer does not
check the return value of parse_XX_buffer. I'll send a patch, which
correct this.
