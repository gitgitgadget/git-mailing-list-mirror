From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/5] Retry if fdopen() fails due to ENOMEM
Date: Tue, 10 Mar 2015 12:44:22 +0100
Message-ID: <54FED916.6020607@alum.mit.edu>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu> <54F9365E.2000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 12:44:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVIaZ-0005TD-6u
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 12:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbbCJLoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 07:44:39 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51655 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666AbbCJLoi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 07:44:38 -0400
X-AuditID: 12074411-f79fa6d000006b8a-fa-54fed9195e5d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 39.F9.27530.919DEF45; Tue, 10 Mar 2015 07:44:25 -0400 (EDT)
Received: from [192.168.69.130] (p4FC962B5.dip0.t-ipconnect.de [79.201.98.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2ABiMoP002214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 10 Mar 2015 07:44:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <54F9365E.2000705@web.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsUixO6iqCt581+IweHdwhZdV7qZLBp6rzBb
	vL25hNGis+MrowOLx85Zd9k9Ll5S9vi8Sc7j9rNtLAEsUdw2SYklZcGZ6Xn6dgncGU2zbrMX
	nOCo2HO1nb2B8S1bFyMnh4SAicSBiy/ZIWwxiQv31gPFuTiEBC4zSsxqbmGEcM4zSZx78JgR
	pIpXQFti/42/QB0cHCwCqhIPrmeAhNkEdCUW9TQzgdiiAkESL2/9hSoXlDg58wkLiC0ikCXx
	7dMXVpBWZgFbia1PmEHCwgJ2EofPPmQCCQsJxEns/gzWySmgJrHk5R+wTmYBPYkd13+xQtjy
	Es1bZzNPYBSYhWTBLCRls5CULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pS
	uokREsqCOxhnnJQ7xCjAwajEw7vC8F+IEGtiWXFl7iFGSQ4mJVHepitAIb6k/JTKjMTijPii
	0pzU4kOMEhzMSiK8pUeBcrwpiZVVqUX5MClpDhYlcV6+Jep+QgLpiSWp2ampBalFMFkZDg4l
	Cd5114EaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFRGl8MjFOQFA/QXqUbIHuL
	CxJzgaIQracYFaXEedeCzBUASWSU5sGNhSWoV4ziQF8K89qAtPMAkxtc9yugwUxAg9mZ/4AM
	LklESEk1MG6qe7MkNJnz4b1mn2n13et2Jwnvejc7u2l6U+H6ODOn59GvlLNlW+vYH5eqWVcK
	Zlf+1Lyz5g+TutiK+9c2H2G5u2zmizSuHNnemMuB1w6tfn9tbuU7D6PvCYFfWr3i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265229>

On 03/06/2015 06:08 AM, Torsten B=F6gershausen wrote:
> On 03/05/2015 05:07 PM, Michael Haggerty wrote:
>> One likely reason for fdopen() to fail is the lack of memory for
>> allocating a FILE structure. When that happens, try freeing some
>> memory and calling fdopen() again in the hope that it will work the
>> second time.
>>
>> This change was suggested by Jonathan Nieder [1]
>>
>> In the first patch it is unsatisfying that try_to_free_routine() is
>> called with a magic number (1000) rather than sizeof(FILE). But the =
C
>> standard doesn't guarantee that FILE is a complete type, so I can't
>> think of a better approach. Suggestions, anybody?
>=20
> it's not the sizeof(FILE) which is critical, it is the size of the bu=
ffer
> associated with a FILE
>=20
> http://pubs.opengroup.org/onlinepubs/009695399/basedefs/stdio.h.html
>=20
> BUFSIZ may be  your friend, and if it is not defined, 4096 may be a
> useful default.

Good point. If this patch series is not dropped as being useless, I wil=
l
make this change.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
