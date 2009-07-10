From: "Martin Ettl" <ettl.martin@gmx.de>
Subject: found another resource leak in file xdiff-interface.c
Date: Fri, 10 Jul 2009 09:47:57 +0200
Message-ID: <20090710074757.322180@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 09:48:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPAq4-0003ws-C3
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 09:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbZGJHsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 03:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbZGJHsE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 03:48:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:53964 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750891AbZGJHsD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 03:48:03 -0400
Received: (qmail 17952 invoked by uid 0); 10 Jul 2009 07:48:01 -0000
Received: from 141.74.1.71 by www133.gmx.net with HTTP;
 Fri, 10 Jul 2009 09:47:57 +0200 (CEST)
X-Authenticated: #45868255
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX19PuNYJsG1P0HIKsBW/H3IPolPnEphp4feUbEDRgs
 ex5z+9Ha9HEj60TK22ymckysnRLUm/1+uD/w== 
X-GMX-UID: GcBvcuxIYW0tW7uX2mRpBnh8amthc9sU
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123042>

Hi friends,

i have detected another resource leak (using the static code analysis t=
ool cppcheck) in file xdiff-interface.c.

The tool prints the following warning:

[git.1.6.3.3/xdiff-interface.c:215](error) resource leak f


int read_mmfile(mmfile_t *ptr, const char *filename)
{
//...
	if (sz && fread(ptr->ptr, sz, 1, f) !=3D 1)
		return error("Could not read %s", filename);
	fclose(f);
// ....
	ptr->size =3D sz;
	return 0;
}

A possible solution might be:

int read_mmfile(mmfile_t *ptr, const char *filename)
{
//...
	if (sz && fread(ptr->ptr, sz, 1, f) !=3D 1)
        {
	        fclose(f);
		return error("Could not read %s", filename);
        }
	fclose(f);
// ....
	ptr->size =3D sz;
	return 0;
}

Best regards

Ettl Martin

--=20
GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
