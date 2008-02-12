From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Tue, 12 Feb 2008 16:25:58 -0500
Message-ID: <9e4733910802121325p7ce6b58axae71f698f76dbfd2@mail.gmail.com>
References: <200802081828.43849.kendy@suse.cz>
	 <m3ejbngtnn.fsf@localhost.localdomain>
	 <200802091627.25913.kendy@suse.cz>
	 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
	 <alpine.LSU.1.00.0802101640570.11591@racer.site>
	 <alpine.LSU.1.00.0802101845320.11591@racer.site>
	 <alpine.LSU.1.00.0802122036150.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Jan Holesovsky" <kendy@suse.cz>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2et-0005Ai-GP
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYBLV0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 16:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbYBLV0J
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:26:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:4206 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbYBLV0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:26:00 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2991967wah.23
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 13:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RbPnTWaMdakqgad8nv65AOAinnqFMZ+vlS7kECfA8Hk=;
        b=q2uGIf+vTBmW2hzWhdNUFDWtdgoXUUQ1hRsT9iDRVqRG4eu3Zy/NfyO9FFQk5TOpTNdL3R7f6txwJMiWBQLwCFY+O3FPj5jMswFOTT7k5T64S0DOMEAYcH5C6YwXZ9sOnnZhCFlj7j0/ceQh1yYfrXbeSRbcYiymVYjrPXaInCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QWOONSVQazFckI5FKvXpvkb5dTqfe9xIlndrvlfAOuydM6dRH0OGtidLyh6IiprIFHQtLW/cTKcfBF+hosS9szrFmlp/7KOrVjhj7jjTjxLzcrfTssSC75lPpr1T8WHveBiLBUuQGSNJX8Y6qI2HAomi4pq1LCnPerDQAeDgNxY=
Received: by 10.114.150.1 with SMTP id x1mr2051226wad.46.1202851558709;
        Tue, 12 Feb 2008 13:25:58 -0800 (PST)
Received: by 10.114.200.7 with HTTP; Tue, 12 Feb 2008 13:25:58 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802122036150.3870@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73693>

On 2/12/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 10 Feb 2008, Johannes Schindelin wrote:
>
> > $ /usr/bin/time git repack -a -d -f --window=150 --depth=150
> > Counting objects: 2477715, done.
> > Compressing objects:  19% (481551/2411764)
> > Compressing objects:  19% (482333/2411764)
> > fatal: Out of memory, malloc failed411764)
> > Command exited with non-zero status 1
> > 7118.37user 54.15system 2:01:44elapsed 98%CPU (0avgtext+0avgdata
> > 0maxresident)k
> > 0inputs+0outputs (29834major+17122977minor)pagefaults 0swaps
>
> I made the window much smaller (512 megabyte), and it still runs, after 27
> hours:
>
> Compressing objects:  20% (484132/2411764)
>
> However, it seems that it only worked on about 4000 objects in the last
> 20(!) hours.

I found that out with gcc. 95% went down in no time and the last 5%
took two hours. The 5% that got stuck were chains with 2000+ entries.

The neat thing about the multithread code is that it will keep
splitting the work load. That lets all of the easy deltas finish and
not get stuck behind the problem objects.

With quad core on gcc one core would get stuck on the problem objects.
The other three would finish their list and start splitting the
problem list. This effectively sorts the problems to the end of the
work load. By printing the object hash out as they are completed you
can easily identify the problem objects. If I recall right on gcc the
problem was a configure file that had 2000 entries in its delta chain.
That one delta chain took over an hour to process.

Could there be an N squared type problem when 2000 entry delta chains
are encountered? Maybe something that just isn't noticeable when
depth/window=50. Has testing been done with really long object chains
to make sure that only the minimal amount of work is being done? It
seems like something is breaking down when the chain length exceeds
the window size.

So, the first 19% were relatively quick.  The next percent
> not at all.
>
> Will keep you posted,
> Dscho
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
