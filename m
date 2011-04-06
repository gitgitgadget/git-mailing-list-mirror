From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git: "git stash" changes owners and permissions
Date: Wed, 6 Apr 2011 15:52:12 -0500
Message-ID: <20110406205212.GC1922@elie>
References: <878vvnfp60.fsf@kiva6.ethz.ch>
 <20110406184938.GE1220@elie>
 <20110406200640.GF12557@sym.noone.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Axel Beckert <abe@debian.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 22:52:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ZiH-0000LD-4C
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 22:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab1DFUwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 16:52:19 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49570 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab1DFUwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 16:52:17 -0400
Received: by vws1 with SMTP id 1so1445074vws.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=u8JUxHlOUy/le5P6wdw6qu9XarKBmKfa1qBsfPhPjVA=;
        b=wGhkHBT+gfJvOl+CGiP+xA3XnzvycnbxpOOu6eVsiOPH/xMc6GXZ4rtJbO4DkHarVG
         9NF0Ze2YmLzgIFws+BAAYKbGm+c4keugoGak2bVzRIyeHLdNZrU59VybU82TamHoqRGD
         20AI1flFO9vQ1sA2vb4ETOTiTG5qz0H+x31I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZrnuekCpmmwXijTeXft+cdUodEymaAcu6G8EBknbJnYdKnY4ZKfKtNTBeS7I0nKyKS
         Wh5Phq+oVKCVT/QyQNUD6myHbwTF/MhvDf2d/3wi0+gJDVvcraj/pe4GcmSCwD29yzm7
         5lxxXhHkH3W8OHCA09laY8LoYcLPE2ZM+b9uU=
Received: by 10.52.177.196 with SMTP id cs4mr99286vdc.279.1302123137002;
        Wed, 06 Apr 2011 13:52:17 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id b26sm560535vby.3.2011.04.06.13.52.15
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 13:52:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110406200640.GF12557@sym.noone.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171016>

(moving to the git list)
Axel Beckert wrote[0]:

> I should probably look again for plugins or hooks taking care of file
> meta-data, but the last time I looked for such a thing, the stuff I
> found wasn't very promising. Any tips and hints are appreciated.

Everything I know about metadata tracking is at [1].  Which is to say,
I don't know much.  I believe the state of the art involves saving
scripts to store metadata along with the repository, as in Dan
Jacobson's git-cache-meta script and etckeeper's pre-commit.d
directory[2]. [3]

As mentioned before, I don't advise using git to deploy changed files.
It will change them in the wrong order and creates windows when they're
not present.  Perhaps a procedure like the following can work?

	cd /root; (umask 077 && mkdir tmp); cd tmp
	git clone /etc/interesting-subdir
	cd interesting-subdir
	... hack hack hack ...
	git commit
	... is it really ok?  check in whatever way I know ...

	# yes, it's okay.
	git push /etc/interesting-subdir/.git HEAD:refs/remotes/jrn/proposed
	cd /etc/interesting-subdir
	git diff jrn/proposed;	# one final check

	# deploy.
	rsync -a --exclude='.git' /root/tmp/interesting-subdir/ .
	git reset jrn/proposed
	git diff;	# should show no changes.

	# clean up.
	rm -r /root/tmp/interesting-subdir
	rmdir /root/tmp

Please keep us posted --- it would be nice to put whatever workflow
you end up with in a howto for distribution with git.

Regards,
Jonathan

[0] http://bugs.debian.org/621090
[1] https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Backups.2C_metadata.2C_and_large_files
[2] http://git.kitenet.net/?p=etckeeper.git;a=tree;f=pre-commit.d;hb=master
[3] It is as though we were in the days of shar as an archival format.
In the long term I will be happier if something pleasant based on
.gitattributes appears. ;-)
