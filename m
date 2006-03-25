From: Matthias Kestenholz <lists@irregular.ch>
Subject: Re: Bug encountered while comitting
Date: Sat, 25 Mar 2006 02:15:27 +0100
Message-ID: <20060325011527.GA23600@spinlock.ch>
References: <20060324183951.GA23193@spinlock.ch> <7vacbfzc3u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 02:16:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMxNr-0001Ai-UL
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 02:16:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWCYBP5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 20:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWCYBP5
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 20:15:57 -0500
Received: from mail20.bluewin.ch ([195.186.19.65]:19125 "EHLO
	mail20.bluewin.ch") by vger.kernel.org with ESMTP id S1751402AbWCYBP4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 20:15:56 -0500
Received: from spinlock.ch (62.203.176.109) by mail20.bluewin.ch (Bluewin 7.2.071)
        id 441EA2F9001165BF; Sat, 25 Mar 2006 01:15:39 +0000
Received: (nullmailer pid 26179 invoked by uid 1000);
	Sat, 25 Mar 2006 01:15:27 -0000
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vacbfzc3u.fsf@assigned-by-dhcp.cox.net>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17946>

* Junio C Hamano (junkio@cox.net) wrote:
> Matthias Kestenholz <lists@irregular.ch> writes:
> 
> > The PHP script created directories under .git/objects which were
> > only writable by www-data. There were other directories which were
> > owned by user mk and group www-data, and they were group writable.
> >
> > So, I had write access to only a part of the .git directory.
> 
> core.sharedrepository perhaps?
> 
> While it probably is not a good idea to have you in www-data, it
> appears that is essentially you will end up doing, because PHP
> scripts that may _create_ new directories better not to have
> privilege to give newly created directories away to you (busting
> your quota), so they will be owned by www-data.www-data and for
> you to be able to write into it you either need to be www-data
> user or in www-data group, with core.sharedrepostiory set.
> 

Thanks for your answer; I did not know about this option (I should
probably re-read all the docs).

Anyway, I think git should never corrupt a repository, even if it
does not have the write permissions it needs.

The following commands were sufficient to create a corrupt
repository with git (v1.2.4-1, debian package):

$ git-init-db
$ echo test > file
$ git-update-index --add file ; git commit -m 'message'

repeat (f.e. 10 times):
$ echo test >> file
$ git-update-index file ; git commit -m 'message'

$ sudo chown root .git/objects/*

repeat the modification and commit commands until you get a message
similar to the following:

unable to write sha1 filename .git/objects/90/b33..: Permission denied
fatal: 90b33... is not a valid 'tree' object
unable to write sha1 filename .git/objects/ba/fe4..: Permission denied
error: file: failed to insert into database
fatal: Unable to process file file
etc...

The result of this all is: refs/heads/master might now point to a
non-existant commit object. Every git command now errors out with:

fatal: bad tree object HEAD

and git-log shows no output (probably since it does not find a
commit to begin with)


git-commit should abort as soon as it encounters an error and not
update HEAD.

Thanks,
Matthias

(Note: To find the last valid commit object, I could just scan the
objects directory for the recently modified files and write the sha1
value to refs/heads/master, so I had no data loss.)



-- 
:wq
