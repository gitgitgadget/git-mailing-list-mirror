From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: Git as a backup system?
Date: Mon, 08 Nov 2010 21:06:51 +0100
Message-ID: <4CD8585B.8000802@dirk.my1.cc>
References: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 21:15:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFY7s-0004VJ-Nw
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026Ab0KHUPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 15:15:31 -0500
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:54747 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab0KHUPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 15:15:31 -0500
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Nov 2010 15:15:30 EST
Received: from [84.176.40.73] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1PFXzQ-0000m3-7h; Mon, 08 Nov 2010 21:06:52 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <AANLkTikcBvN+5hkcc9+xt291B4Gm+Yhe53R3qY0PNt97@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160981>

Am 08.11.2010 19:01 schrieb Eric Frederich:
> I maintain a corporate MediaWiki installation.
> Currently I have a cron job that runs daily and tar's up the contents
> of the installation directory and runs a mysqldump.
>
> I wrote a script that untar'd the contents each backup, gunziped the
> mysql dump, and made a git commit.
> The resulting .git directory wound up being 837M, but after running a
> long (8 minute) "git gc" command, it went down to 204M.
>
> == Questions ==
> What mysqldump options would be good to use for storage in git?
> Right now I'm not passing any parameters to mysqldump and its doing
> all inserts for each table on a single huge line.
> Would git handle it better if each insert was on its own line?
>
> Are any of you using git for a backup system?  Have any tips, words of wisdom?
>
> Thanks,
> ~Eric

Hi Eric,

I also use mysqldump and Git to make backups of my databases. Indeed, it 
performs much better when each change (insert statement) is on a 
separate line. mysqldump has an option for that which I don't recommend, 
because it dramatically slows down the dump and the restore. It would 
then create separate "insert into ..." statement for each changed line.

For me the attached script worked very well: I pipe the output of 
mysqldump through the script and it simply inserts a linefeed after each 
record.

----------------------------------
#!/usr/bin/perl -p

use strict;
use warnings;

# Before:
# INSERT INTO `schliess_grund` VALUES 
(1,'Explizit'),(2,'Neuanmeldung'),(4,'Sperrung'),(3,'Timeout');
#
# After:
# INSERT INTO `schliess_grund` VALUES
#    (1,'Explizit'),
#    (2,'Neuanmeldung'),
#    (4,'Sperrung'),
#    (3,'Timeout');
if (/^(INSERT INTO .*? VALUES) (.*);$/)
{
     $_ = "$1\n     $2\n    ;\n";
     s/\),\(/\)\n    ,\(/g;
}
----------------------------------

The changeset will be much smaller. Let's call the script "wrap.pl". 
Then run the following:

----------------------------------
mysqldump --opt --routines [...] -r <outfile.tmp> <dbname>
./wrap.pl <outfile.tmp> > <outfile>; rm <outfile.tmp>
git add <outfile>
if ! git diff-index --quiet HEAD --; then
     git commit -m "Backup of ..."
fi
----------------------------------

Try it out!

Cheers,
     Dirk
