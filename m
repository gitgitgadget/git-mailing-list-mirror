From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 7/8] git-p4: decode p4 wildcard characters
Date: Tue, 8 Feb 2011 18:26:06 -0500
Message-ID: <20110208232606.GA32491@arf.padd.com>
References: <20110205224848.GA30963@arf.padd.com>
 <20110205225237.GH30963@arf.padd.com>
 <AANLkTi=Gah9yeYYnHPZ2Z6-OZQ2-CU5Kub=o5SqWAXht@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 09 00:26:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmwws-0000DZ-Od
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 00:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab1BHX0N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 18:26:13 -0500
Received: from honk.padd.com ([74.3.171.149]:57321 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753802Ab1BHX0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 18:26:12 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 7E47AEF;
	Tue,  8 Feb 2011 15:26:11 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8D66A31ADE; Tue,  8 Feb 2011 18:26:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Gah9yeYYnHPZ2Z6-OZQ2-CU5Kub=o5SqWAXht@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166374>

torarvid@gmail.com wrote on Tue, 08 Feb 2011 10:09 +0100:
> On Sat, Feb 5, 2011 at 11:52 PM, Pete Wyckoff <pw@padd.com> wrote:
> > + =A0 =A0# The p4 wildcards are not allowed in filenames. =A0It com=
plains
> > + =A0 =A0# if you try to add them, but you can override with "-f", =
in
> > + =A0 =A0# which case it translates them into %xx encoding. =A0Sear=
ch for
> > + =A0 =A0# and fix just these four characters. =A0Do % last so it d=
oes
> > + =A0 =A0# not inadvertantly create new %-escapes.
> > + =A0 =A0def wildcard_decode(self, path):
> > + =A0 =A0 =A0 =A0path =3D path.replace("%23", "#") \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .replace("%2A", "*") \
>=20
> This probably works fine on UNIX platforms, but the asterisk '*'
> character is not allowed in windows filenames. I don't really know
> what perforce does in that scenario. Does it make the most sense to
> just keep the %2A in the filename if we are running on windows (??)

I changed it to do the "*" translation if not self.isWindows, so
%2A will remain in the filename.  Good that you noticed it.

Just for giggles, I found a windows VM to test perforce on.
Built two files with different wildcards on a unix box, then
pointed a windows client at it:

C:\DOCUME~1\ADMINI~1\DESKTOP>set P4PORT=3D192.168.2.1:1666

C:\DOCUME~1\ADMINI~1\DESKTOP>p4 files //depot/...
//depot/file%25percent#1 - add change 1 (binary)
//depot/file%2Astar#1 - add change 1 (binary)

C:\DOCUME~1\ADMINI~1\DESKTOP>p4 client
Client soulfree saved.

C:\DOCUME~1\ADMINI~1\DESKTOP>p4 sync
//depot/file%25percent#1 - added as c:\Documents and Settings\Administr=
ator\Desktop\file%percent
//depot/file%2Astar#1 - added as c:\Documents and Settings\Administrato=
r\Desktop\file*star
open for write: c:\Documents and Settings\Administrator\Desktop\file*st=
ar: The filename, directory name, or volume label syntax is incorrect.

And only the one file was synced to the windows client.  So "*" is not
well handled in perforce on windows anyway.

Docs are not helpful:

http://www.perforce.com/perforce/doc.current/manuals/cmdref/o.fspecs.ht=
ml#1041962

=46or git, leaving a %2A in a filename is better than an error, I belie=
ve.

Thanks for the other acks.

		-- Pete
