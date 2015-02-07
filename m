From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: read()  MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sat, 7 Feb 2015 13:20:20 -0500
Message-ID: <01f501d04302$bb9a46b0$32ced410$@nexbridge.com>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de> <01f201d04300$cce22ca0$66a685e0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "=?iso-8859-1?Q?'Torsten_B=F6gershausen'?=" <tboegi@web.de>,
	"'Joachim Schmitz'" <jojo@schmitz-digital.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 19:26:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKA5C-0004Kh-BH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 19:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209AbbBGSU0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2015 13:20:26 -0500
Received: from elephants.elehost.com ([216.66.27.132]:18641 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756025AbbBGSUZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2015 13:20:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t17IKLtx001108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Feb 2015 13:20:21 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <01f201d04300$cce22ca0$66a685e0$@nexbridge.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJmR/w5xrE0KMfMA1Zo9YnW3Qq2xQKZ8nS9AkLc2BObko2gAA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263450>

On 2015-02-07 13:07PM Randall S. Becker wrote:
>On 2015-02-07 12:30PM Torsten B=F6gershausen wrote:
>>On 2015-02-07 17.45, Joachim Schmitz wrote:
>>> Hi there
>>>=20
>>> While investigating the problem with hung git-upload-pack we think =
to=20
>>> have found a bug in wrapper.c:
>>>=20
>>> #define MAX_IO_SIZE (8*1024*1024)
>>>=20
>>> This is then used in xread() to split read()s into suitable chunks.
>>> So far so good, but read() is only guaranteed to read as much as=20
>>> SSIZE_MAX bytes at a time. And on our platform that is way lower th=
an=20
>>> those 8MB (only 52kB, POSIX allows it to be as small as 32k), and a=
s a=20
>>> (rather strange) consequence mmap() (from compat/mmap.c) fails with=
=20
>>> EACCESS (why EACCESS?), because xpread() returns something > 0.
>>>=20
>>> How large is SSIZE_MAX on other platforms? What happens there if yo=
u=20
>>> try to
>>> read() more? Should't we rather use SSIZE_MAX on all platforms? If =
I'm=20
>>> reading the header files right, on Linux it is LONG_MAX (2TB?), so =
I=20
>>> guess we should really go for MIN(8*1024*1024,SSIZE_MAX)?
>>How about changing wrapper.c like this:=20
>>#ifndef MAX_IO_SIZE
>> #define MAX_IO_SIZE (8*1024*1024)
>>#endif
>>---------------------

Although I do agree with Jojo, that MAX_IO_SIZE seems to be a platform
constant and should be defined in terms of SSIZE_MAX. So something like=
:

#ifndef MAX_IO_SIZE
# ifdef SSIZE_MAX
#  define MAX_IO_SIZE (SSIZE_MAX)
# else
#  define MAX_IO_SIZE (8*1024*1024)
# endif
#endif

would be desirable.

Cheers, Randall
