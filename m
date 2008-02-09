From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening
 a file
Date: Fri, 08 Feb 2008 19:20:25 -0600
Message-ID: <47ACFFD9.2030705@nrlssc.navy.mil>
References: <20080208174654.2e9e679c@pc09.procura.nl>	<118833cc0802081215t380587f6w7b5c0aba66a55799@mail.gmail.com> <7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Morten Welinder <mwelinder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 02:21:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNePE-0001UM-DG
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 02:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbYBIBUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 20:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756068AbYBIBUh
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 20:20:37 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46476 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbYBIBUf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 20:20:35 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m191KP6s016116;
	Fri, 8 Feb 2008 19:20:25 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Feb 2008 19:20:25 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7v8x1vjiic.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 09 Feb 2008 01:20:25.0889 (UTC) FILETIME=[F3073910:01C86AB9]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--12.622000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMDczLTcwMzczMS03MDg3OTctNzEwNzE4LTcwMDk3MS03?=
	=?us-ascii?B?MDYyOTAtNzAxMjk2LTcwMzUyOS03MDAzMjQtNzAzMjgzLTcwMjcy?=
	=?us-ascii?B?Ni03MDI2ODMtNzA3MzYxLTcwODE3OS03MDkwNjUtNzA0NDI1LTE4?=
	=?us-ascii?B?ODAxOS03MDc5MDktNzA0NzQ3LTcwNDQ3My03MDM3MTItNzAyNjA5?=
	=?us-ascii?B?LTcwMjM1OC0xNDgwMzktMTQ4MDUxLTIwMDQz?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73182>

Junio C Hamano wrote:
> "Morten Welinder" <mwelinder@gmail.com> writes:
> 
>>> +/* Helper function to ensure that we are opening a file and not a directory */
>>> +static FILE *open_file(char *full_path)
>>> +{
>>> +       struct stat st_buf;
>>> +       if (stat(full_path, &st_buf) || !S_ISREG(st_buf.st_mode))
>>> +               return NULL;
>>> +       return (fopen(full_path, "r"));
>>> +}
>> That looks wrong.  stat+fopen has a pointless race condition that
>> open+fstat+fdopen would not have.
> 
> That's true.  How about doing something like this?
> 
>  (1) in a new file "compat/gitfopen.c" have this:
> 
> 	#include "../git-compat-util.h"
> 	#undef fopen
> 	FILE *gitfopen(const char *path, const char *mode)
>         {
> 		int fd, flags;
>                 struct stat st;
>         	if (mode[0] == 'w')
>                 	return fopen(path, mode);
> 		switch (mode[0]) {
>                 case 'r': flags = O_RDONLY; break;
>                 case 'a': flags = O_APPEND; break;
> 		default:
> 			errno = EINVAL;
>                 	return NULL;
> 		}
> 		fd = open(path, flags);
> 		if (fd < 0 || fstat(fd, &st))
>                 	return NULL;
> 		if (S_ISDIR(st_buf.st_mode)) {
>                 	errno = EISDIR;
>                         return NULL;
> 		}
> 		return fdopen(fd, mode);
> 	}

Can we use fileno()? Something like:

FILE *gitfopen(const char *path, const char *mode)
{   
        FILE *fp;
        struct stat st;

        if (strpbrk(mode, "wa"))
                return fopen(path, mode);

        if (!(fp = fopen(path, mode)))
                return NULL;

        if (fstat(fileno(fp), &st)) {
                fclose(fp);
                return NULL;
        }

        if (S_ISDIR(st.st_mode)) {
                fclose(fp);
                errno = EISDIR;
                return NULL;
        }

        return fp;
}   

-brandon
