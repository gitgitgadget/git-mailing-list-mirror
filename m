From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Inspecting a corrupt git object
Date: Wed, 4 Aug 2010 15:02:29 +0200
Message-ID: <20100804130229.GA1537@jpl.local>
References: <20100804092530.GA30070@jpl.local> <201008041148.49668.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Aug 04 15:02:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgdcF-0002Yc-Mq
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 15:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654Ab0HDNCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 09:02:33 -0400
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:60301 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab0HDNCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 09:02:32 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 52CC2EA73B
	for <git@vger.kernel.org>; Wed,  4 Aug 2010 15:02:31 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At01AB8CWUxT46eEPGdsb2JhbACHZ5g5DAEBAQE1LcMrhTsE
X-IronPort-AV: E=Sophos;i="4.55,315,1278280800"; 
   d="scan'208";a="113582454"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb2.telenor.se with ESMTP; 04 Aug 2010 15:02:30 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id C12F6422BF; Wed,  4 Aug 2010 15:02:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008041148.49668.trast@student.ethz.ch>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152579>

On Wednesday, August 04, 2010 at 11:48 CEST,
     Thomas Rast <trast@student.ethz.ch> wrote:

> Magnus B=E4ck wrote:
>
> > From what I gather from the community book and Pro Git, a git objec=
t
> > file is a deflated representation of the object type as a string,
> > the payload size, a null byte, and the payload. Is there a standard
> > tool for inflating the file back so that I can inspect what the
> > actual difference between these two are? Short of writing a tool
> > utilizing zlib, at least.
>=20
> I'm sure it's a one-liner in almost any scripting language, e.g. you
> can use
>=20
>   python -c 'import sys,zlib; sys.stdout.write(zlib.decompress(open(s=
ys.argv[1]).read()))'
>=20
> with a filename argument if you have Python at hand.

That worked fine, thanks. Apparently this difference in the second byte
of the compressed data makes no difference for the end result -- the tw=
o
inflated files are identical.

Interestingly, just as we were about to transplant the loose object fro=
m
my working repository to the server where "git gc" failed and the objec=
t
was seemingly corrupt, the person doing the actual work (I don't have
access to the server) ran "git gc" to find the id of the bad object, an=
d
suddenly it completed without errors. The object in question had now
been included in a packfile, and upon unpacking that packfile to inspec=
t
the object it was identical to the file I had, i.e. the new loose objec=
t
was different from the original loose object. I had expected a loose
object -> packfile -> loose object cycle to not change anything.
Everything seems to be back to normal now, which is good, but I prefer
I understand why things get fixed.

We did have some initial problems with reaching the per-process limit
for open files (as no repack had been done for an extended time and 500=
0
packfiles were lingering), but it seems weird for such a problem to be
related to the possible corruptness of a single tree object.

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
