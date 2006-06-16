From: Christopher Faylor <me@cgf.cx>
Subject: Re: Cygwin git and windows network shares
Date: Fri, 16 Jun 2006 18:30:06 -0400
Message-ID: <20060616223006.GA23737@trixie.casa.cgf.cx>
References: <4492AAFA.20807@grin.se> <17554.48926.852000.679014@lapjr.intranet.kiel.bmiag.de> <20060616221014.GA22181@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 17 00:30:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrMpR-0002Mm-1q
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 00:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWFPWaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 18:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWFPWaI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 18:30:08 -0400
Received: from pool-71-248-179-97.bstnma.fios.verizon.net ([71.248.179.97]:8920
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1751523AbWFPWaH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 18:30:07 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 7A76113C01F; Fri, 16 Jun 2006 18:30:06 -0400 (EDT)
To: Niklas Frykholm <niklas@grin.se>, git@vger.kernel.org,
	Juergen Ruehle <j.ruehle@bmiag.de>
Content-Disposition: inline
In-Reply-To: <20060616221014.GA22181@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21981>

On Fri, Jun 16, 2006 at 06:10:14PM -0400, Christopher Faylor wrote:
>On Fri, Jun 16, 2006 at 04:24:30PM +0200, Juergen Ruehle wrote:
>>Niklas Frykholm writes:
>> > I'm trying to use cygwin git (compiled from the 1.4.0 tarball) to create 
>> > repository on a windows network share, but I get an error message.
>> > 
>> >     $ cd //computer/git/project
>> >     $ git init-db
>> >     defaulting to local storage area
>> >     Could not rename the lock file?
>>
>>cygwin's rename seems to be capable of overwriting an existing target
>>only on NTFS. The following hack is a workaround, but is probably not
>>safe.
>
>Actually, Cygwin's rename has a specific check to make sure that the
>file is deleted.  It tries very hard to do things the right way but if
>your samba server doesn't return the correct error code then it is
>possible that it could be confused.

>diff --git a/lockfile.c b/lockfile.c
>index 2346e0e..5e78211 100644
>--- a/lockfile.c
>+++ b/lockfile.c
>@@ -48,6 +48,7 @@ int commit_lock_file(struct lock_file *l
>       strcpy(result_file, lk->filename);
>       i = strlen(result_file) - 5; /* .lock */
>       result_file[i] = 0;
>+      unlink(result_file);
>       i = rename(lk->filename, result_file);
>       lk->filename[0] = 0;
>       return i;

I also meant to ask if there was an i is nonzero after the call to the
rename() above?  If so, what was the errno?  If not, it is a huge
problem if rename is reporting that it is able to rename a file but is
not actually doing it.

cgf
(cygwin maintainer)
