From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: read()  MAX_IO_SIZE bytes, more than SSIZE_MAX?
Date: Sat, 7 Feb 2015 13:06:30 -0500
Message-ID: <01f201d04300$cce22ca0$66a685e0$@nexbridge.com>
References: <loom.20150207T174514-727@post.gmane.org> <54D64939.4080102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "=?iso-8859-1?Q?'Torsten_B=F6gershausen'?=" <tboegi@web.de>,
	"'Joachim Schmitz'" <jojo@schmitz-digital.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 19:06:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK9mC-00035D-61
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 19:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbbBGSGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2015 13:06:36 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17781 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbbBGSGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2015 13:06:35 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t17I6VKN000124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Feb 2015 13:06:31 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <54D64939.4080102@web.de>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJmR/w5xrE0KMfMA1Zo9YnW3Qq2xQKZ8nS9m6SgQmA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263449>

On 2015-02-07 12:30PM Torsten B=F6gershausen wrote:
>On 2015-02-07 17.45, Joachim Schmitz wrote:
>> Hi there
>>=20
>> While investigating the problem with hung git-upload-pack we think t=
o=20
>> have found a bug in wrapper.c:
>>=20
>> #define MAX_IO_SIZE (8*1024*1024)
>>=20
>> This is then used in xread() to split read()s into suitable chunks.
>> So far so good, but read() is only guaranteed to read as much as=20
>> SSIZE_MAX bytes at a time. And on our platform that is way lower tha=
n=20
>> those 8MB (only 52kB, POSIX allows it to be as small as 32k), and as=
 a=20
>> (rather strange) consequence mmap() (from compat/mmap.c) fails with=20
>> EACCESS (why EACCESS?), because xpread() returns something > 0.
>>=20
>> How large is SSIZE_MAX on other platforms? What happens there if you=
=20
>> try to
>> read() more? Should't we rather use SSIZE_MAX on all platforms? If I=
'm=20
>> reading the header files right, on Linux it is LONG_MAX (2TB?), so I=
=20
>> guess we should really go for MIN(8*1024*1024,SSIZE_MAX)?
>How about changing wrapper.c like this:=20
>#ifndef MAX_IO_SIZE
> #define MAX_IO_SIZE (8*1024*1024)
>#endif
>---------------------
>and to change config.mak.uname like this:
>ifeq ($(uname_S),NONSTOP_KERNEL)
>	BASIC_CFLAGS +=3D -DMAX_IO_SIZE=3D(32*1024) Does this work for you ?

Yes, thank you Torsten. I have made this change in our branch (on behal=
f of
Jojo). I think we can accept it. The (32*1024) does need to be properly
quoted, however.
