From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Thu, 17 Apr 2014 09:32:34 +0300
Message-ID: <534F7582.9090303@bracey.fi>
References: <201404072130.15686.tboegi@web.de> <alpine.DEB.2.00.1404152009020.29301@ds9.cixit.se> <534E0B84.6070602@web.de> <534E60BF.5020602@bracey.fi> <534EE0E7.2030608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 08:48:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wag7g-0002AU-Qh
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 08:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbaDQGsd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2014 02:48:33 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:39181 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750986AbaDQGsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 02:48:32 -0400
Received: from mail605.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id A5CD01001021
	for <git@vger.kernel.org>; Thu, 17 Apr 2014 08:32:37 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 17 Apr 2014 08:37:53 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 17 Apr 2014 08:37:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <534EE0E7.2030608@web.de>
X-Ovh-Tracer-Id: 8556557818072567952
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500142/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246409>

On 16/04/2014 22:58, Torsten B=C3=B6gershausen wrote:
> Excellent, thanks for the pointers.
> Running the script below shows that
> "0X00AD SOFT HYPHEN" should have zero length (and some others too).
> I wonder if that is really the case, and which one of the last 2 line=
s
> in the script is the right one.
>
> What does this mean for us:
> "Cf 	Format 	a format control character"
>
Maybe dig back through the Git logs to check the original logic, but th=
e=20
comments suggest that "Cf" characters have been viewed as zero-width.=20
That makes sense - they're usually markers indicating things like=20
bidirectional text flow, so won't be taking space. (Although they may b=
e=20
causing even more extreme layout effects...)

Soft-hyphen is noted as an explicit exception to the rule in the utf8.c=
=20
comments. As of Unicode 4.0, it's supposed to be a character indicating=
=20
a point where a hyphen could be placed if a line-wrap occurs, and if=20
that wrap happens, then it can actually take up 1 space, otherwise not.=
=20
So its width could be either 0 or 1, depending. Or, quite likely, the=20
terminal doesn't treat it specially, and it always just looks like a=20
hyphen... Thus we err on the safe side and give it width 1.

See http://en.wikipedia.org/wiki/Soft_hyphen for background.

The comments suggest adding "-00AD +1160-11FF" to the uniset command=20
line for that tweak and for composing Hangul. (The +200B tweak isn't=20
necessary any more - Zero-Width Space U+200B became Cf officially in=20
Unicode 4.0.1:

http://en.wikipedia.org/wiki/Zero-width_space
http://www.unicode.org/review/resolved-pri.html#pri21
)

All of this is only really an approximation - a best-effort attempt to=20
figure out the width of a string without any actual communication with=20
the display device. So it'll never be perfect. The choice between doubl=
e=20
and single width in particular will often be unpredictable, unless you=20
had deeper locale knowledge.

Actually, while doing this, I've realised that this was originally=20
Markus Kuhn's implementation, and that is acknowledged at the top of th=
e=20
file:

http://www.cl.cam.ac.uk/~mgk25/ucs/wcwidth.c

Good, because he knows what he's doing.

Kevin
