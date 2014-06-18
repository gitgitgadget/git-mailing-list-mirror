From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [PATCH v2 0/3] add strnncmp() function
Date: Wed, 18 Jun 2014 12:33:31 +0200
Message-ID: <20140618103331.GA12445@domone.podge>
References: <cover.1402990051.git.jmmahler@gmail.com>
 <53A02195.8080202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 12:33:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxDBW-000896-4a
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 12:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965745AbaFRKdi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2014 06:33:38 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:46726 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965268AbaFRKdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 06:33:36 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 0EB05484ED;
	Wed, 18 Jun 2014 12:33:32 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id D03C85FFB8; Wed, 18 Jun 2014 12:33:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53A02195.8080202@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.98.1 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251976>

On Tue, Jun 17, 2014 at 01:08:05PM +0200, Torsten B=F6gershausen wrote:
> On 2014-06-17 09.34, Jeremiah Mahler wrote:
> > Add a strnncmp() function which behaves like strncmp() except it ta=
kes
> > the length of both strings instead of just one.
> >=20
> > Then simplify tree-walk.c and unpack-trees.c using this new functio=
n.
> > Replace all occurrences of name_compare() with strnncmp().  Remove
> > name_compare(), which they both had identical copies of.
> >=20
> > Version 2 includes suggestions from Jonathan Neider [1]:
> >=20
> >   - Fix the logic which caused the new strnncmp() to behave differe=
ntly
> > 	from the old version.  Now it is identical to strncmp().
> >=20
> >   - Improve description of strnncmp().
> >=20
> > Also, strnncmp() was switched from using memcmp() to strncmp()
> > internally to make it clear that this is meant for strings, not
> > general buffers.
> I don't think this is a good change, for 2 reasons:
> - It changes the semantics of existing code, which should be carefull=
y
>   reviewed, documented and may be put into a seperate commit.
> - Looking into the code for memcmp() and strncmp() in libc,
>   I can see that memcmp() is written in 13 lines of assembler,
>   (on a 386 system) with a fast
>     repz cmpsb %es:(%edi),%ds:(%esi)
>   working as the core engine.
>  =20
>   strncmp() uses 83 lines of assembler, because after each comparison
>   the code needs to check of the '\0' in both strings.
> - I can't see a reason to replace efficient code with less efficient =
code,
>   so moving the old function "as is" into a include file, and declare
>   it "static inline" could be the first step.
>=20
That is not true, a rep cmpsb was fast for 486 but is relatively slow
for newer processors. For performance a correct answer is to measure it=
 than do=20
blind guess. Are these strings null terminated or is giving a size just
a hint? If it is a hint then a plain strcmp could be faster (this
depends on implementation). A reason is that for implementations that
check more bytes at once it is easier to combine a terminating null mas=
k with=20
difference than trying to first find which of first 16 bytes are differ=
ent and=20
then compare if it is within size.
