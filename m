From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in
	write_entry()
Date: Mon, 20 Apr 2009 17:33:05 +0400
Message-ID: <20090420133305.GE25059@dpotapov.dyndns.org>
References: <49EC2F7C.8070209@viscovery.net> <20090420110302.GB25059@dpotapov.dyndns.org> <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:35:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvteX-0003AO-Mq
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbZDTNdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 09:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbZDTNdh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:33:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:26866 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238AbZDTNdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 09:33:36 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1893312rvb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XBvszPj5k17cf5yzirphXUBs9EXIubS21Sc6NmYw6OM=;
        b=kpIuvUmgh1NzxSD+kmFfcdc1CNXX2n109GVxM8dFtcrnBZoWwL7+M8Psko++57AqmJ
         JDL+I+zgZyCCTTuq7mBZlTf5OMr1RuM8fQDBE2/wB4rsqFj6aerx/52XZjzCvN9uHFU0
         BX7fDSlWqS9Q46R3W0KukPWBpuW9l7knspMSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TJCeREBIdeuol5Sq2BlYrSjYgRCVl/czEjQn90UuZ/+skmGi/JFSS3n/Rhb62Up6E3
         KPNxOlzaXllNtKtqbMdBYUI5mO3pK1Gk7HU6kacgTQXxO+uufI7Rq0SJL+12Ha0dHcYa
         9HRCHptD0mo/ck7ztWMinSgtn5hUb3ZFda0oE=
Received: by 10.114.152.17 with SMTP id z17mr3321080wad.73.1240234415871;
        Mon, 20 Apr 2009 06:33:35 -0700 (PDT)
Received: from localhost ([91.78.50.115])
        by mx.google.com with ESMTPS id k37sm16855634rvb.8.2009.04.20.06.33.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 06:33:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116983>

On Mon, Apr 20, 2009 at 02:58:49PM +0200, Alex Riesen wrote:
> 2009/4/20 Dmitry Potapov <dpotapov@gmail.com>:
> > The cygwin version has the same problem. (In fact, it is even worse,
> > because we have an optimized version for lstat/stat but not for fstat,
> > and they return different values for some fields like i_no). But even
> > if we used the only Cygwin functions, we would still face the problem,
> > because Windows returns the wrong values for timestamps (and maybe
> > even size on FAT?). So I think the following patch should be squashed
> > on top.
> 
> I just sent a patch with an "optimized" fstat. I see no problems (at least none
> like these) with that patch. Timestamps match. Windows XP, yes. But since
> that MSDN article mentions that it is not guaranteed, I guess I just been lucky.

If the time passed between the creating file and end of writing to it is
small (less than timestamp resolution), you may not notice the problem.
The following program demonstrates the problem with fstat on Windows.
(I compiled it using Cygwin). If you remove 'sleep' then you may not
notice the problem for a long time.

-- >8 --
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define FILENAME "stat-test.tmp"

int main()
{
	struct stat st1, st2;

	memset(&st1, 0, sizeof(st1));
	memset(&st2, 0, sizeof(st2));

	unlink(FILENAME);
	int fd = open(FILENAME, O_CREAT|O_RDWR|O_TRUNC, S_IRWXU);
	if (fd == -1)
	{
		perror("Cannot open " FILENAME);
		return -1;
	}
	sleep(1); /* It is IMPORTANT! */
	write(fd, "test\n", 5);
	fstat(fd, &st1);
	close(fd);
	lstat(FILENAME, &st2);
	if (memcmp(&st1, &st2, sizeof(st1))==0)
		printf("fstat is OK\n");
	else
		printf("fstat is broken\n");
	return 0;
}
-- >8 --

Dmitry
