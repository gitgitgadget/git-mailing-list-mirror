From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/3] Avoid doing extra 'lstat()'s for d_type if we
	have?an up-to-date cache entry
Date: Fri, 10 Jul 2009 17:04:07 +0400
Message-ID: <20090710130407.GE19425@dpotapov.dyndns.org>
References: <alpine.LFD.2.01.0907081933530.3352@localhost.localdomain> <alpine.LFD.2.01.0907081936470.3352@localhost.localdomain> <alpine.LFD.2.01.0907081940220.3352@localhost.localdomain> <alpine.LFD.2.01.0907081942380.3352@localhost.localdomain> <7vskh646bw.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0907090832200.3352@localhost.localdomain> <7vws6h3ji4.fsf@alter.siamese.dyndns.org> <20090709210513.GB19425@dpotapov.dyndns.org> <loom.20090709T214734-78@post.gmane.org> <20090709233024.GD19425@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 15:04:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPFmJ-0001ER-BZ
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 15:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524AbZGJNEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 09:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbZGJNEe
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 09:04:34 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:64859 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422AbZGJNEd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 09:04:33 -0400
Received: by bwz25 with SMTP id 25so854654bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1163Uz2Iar5mx6a/Ttifpo0ihUDzDgaMV14SUmsAKLc=;
        b=oCkWOsjgpalUPzH81j5J7IYbz1Ue983+5Lvso5+EWRMEYltSVoLalbSKxNT1tEnX0/
         kSvS5PS/lWClilkQy8SGicqqvDj1Um2yOykp0zbvLumQz/IeQVKztMLL3rMft4qffjJB
         26GTYjHKT9SNmTuSPlwzRXig0raaFGB91xCoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Cuqh7Bux3DIoODeQ3827oNZnv2x01r6Qa4HiMFjkpPZ1QVPu7WLfbSLXMNxucWNMJb
         3/7rWtUvNjrpvITA2tEqiFEBD9Eq/uk7epviiMm0sysQfLGa5vOREMIUw3MCXijGMWVi
         9lHLj97ZDuBKR8GvBZJzZ5l9iCPhhnuSnq7Qg=
Received: by 10.102.247.4 with SMTP id u4mr1099212muh.26.1247231072014;
        Fri, 10 Jul 2009 06:04:32 -0700 (PDT)
Received: from localhost (ppp85-141-235-157.pppoe.mtu-net.ru [85.141.235.157])
        by mx.google.com with ESMTPS id y6sm5475636mug.40.2009.07.10.06.04.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 06:04:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090709233024.GD19425@dpotapov.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123052>

On Fri, Jul 10, 2009 at 03:30:24AM +0400, Dmitry Potapov wrote:
> 
> But we still use readdir() from Cygwin and that may be source of extra
> syscalls that I observe...

opendir gives an extra 'stat' before opening directory
readdir produces one more extra 'stat' on the parent directory before
        returning '..'
open(.gitignore) does one extra 'stat' on the directory where it tries
        to open .gitignore (it did not exist in my tests)

So, the number of 'stat' on each directory is 2 plus the number of
subidectories that it has. Thus, the total number of 'stat' for all
directories is 3 multiple the number of directories in your repo. All
those 'stat' are artifacts of Cygwin. Also, you have 2 open per each
directory and one of them are redundant (at least, for Git purposes).
Overall (including syscalls for .gitignore), you have the following
number of syscalls for each directory in your repo:
  5 - QueryOpen (stat)
  3 - CreateFile (open)
  2 - CloseFile (close)
  1 - QueryFileInternalInformationFile

Here is the detail listing of testing of read_directory_recursive:
=====
opendir(.)
	QueryOpen,E:\dpotapov\repo
	CreateFile,E:\dpotapov\repo
first readdir call
	QueryDirectory,E:\dpotapov\repo
second readdir call that returns '..'
	QueryOpen,E:\dpotapov
	CreateFile,E:\dpotapov
	QueryFileInternalInformationFile,E:\dpotapov
	CloseFile,E:\dpotapov
open(.gitignore) -- .gitignore does not exist
	QueryOpen,E:\dpotapov\repo\.gitignore
	QueryOpen,E:\dpotapov\repo\.gitignore.lnk
	QueryOpen,E:\dpotapov\repo
	CreateFile,E:\dpotapov\repo\.gitignore
stat for untracked file
	QueryOpen,E:\dpotapov\repo\bar
opendir(dir1)
	QueryOpen,E:\dpotapov\repo\dir1
	CreateFile,E:\dpotapov\repo\dir1
first readdir call
	QueryDirectory,E:\dpotapov\repo\dir1
second readdir call that returns '..'
	QueryOpen,E:\dpotapov\repo
	CreateFile,E:\dpotapov\repo
	QueryFileInternalInformationFile,E:\dpotapov\repo
	CloseFile,E:\dpotapov\repo
open(.gitignore) -- .gitignore does not exist
	QueryOpen,E:\dpotapov\repo\dir1\.gitignore
	QueryOpen,E:\dpotapov\repo\dir1\.gitignore.lnk
	QueryOpen,E:\dpotapov\repo\dir1
	CreateFile,E:\dpotapov\repo\dir1\.gitignore
last readdir call that returns NULL
	QueryDirectory,E:\dpotapov\repo\dir1
closedir
	CloseFile,E:\dpotapov\repo\dir1
stat for some modified file
	QueryOpen,E:\dpotapov\repo\foo
last readdir call that returns NULL
	QueryDirectory,E:\dpotapov\repo
closedir
	CloseFile,E:\dpotapov\repo
=====

Dmitry
