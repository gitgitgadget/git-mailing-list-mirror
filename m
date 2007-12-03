From: David Voit <david.voit@gmail.com>
Subject: Re: git-svn: .git/svn disk usage
Date: Mon, 3 Dec 2007 18:51:44 +0000 (UTC)
Message-ID: <loom.20071203T182924-435@post.gmane.org>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 20:01:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzGXQ-0007Ok-HL
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 20:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbXLCTAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 14:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXLCTAO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 14:00:14 -0500
Received: from main.gmane.org ([80.91.229.2]:36238 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750AbXLCTAM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 14:00:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IzGWQ-0002PI-7O
	for git@vger.kernel.org; Mon, 03 Dec 2007 19:00:02 +0000
Received: from rx0660.cip.uni-regensburg.de ([132.199.235.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 19:00:02 +0000
Received: from david.voit by rx0660.cip.uni-regensburg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Dec 2007 19:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 132.199.235.98 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.13pre) Gecko/20070505 (Debian-1.8.0.14~pre071019b-0etch1) Epiphany/2.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66949>

Ollie Wild <aaw <at> google.com> writes:

> 
> Hi,
> 
> I've been using git-svn to mirror the gcc repository at
> svn://gcc.gnu.org/svn/gcc.  Recently, I noticed that my .git directory
> is consuming 11GB of disk space.  Digging further, I discovered that
> 9.8GB of this is attributable to the .git/svn directory (which
> includes 200 branches and 2,588 tags).  Given that my .git/objects
> directory is 652MB, it seems that it ought to be possible to store
> this information in a more compact form.
> 
> I'm curious if other developers have run into this issue.  If so, are
> there any proposals / plans for improving the storage of git-svn
> metadata?
> 
> Thanks,
> Ollie
> 

Hi all,

I've seen the same effect, so i tried to reduce the size of the revdb and made a
new format:
First, in the bin files the sha1 are stored as hexvalues not as ascii, this
reduces the a single sha1 from 41 bytes to 20.
Second, only save the non-zero commits, thats what the idx are used for.
A idx file has three 32bit integers per entry.
The first integer represents the first zero svn revision, the second the last
zero revision and the last integer is the position of the next non-zero revision
in the bin.

Example:
Revision 0-373006 are zero revision and 373007 is the first actualy used revision
and 373008-373623 are again zero revisions
the idx has the following content:
0 373006 0
373007 373007 1

and the bin only saves
59037b8043268c9ca0d87ba86519ed0b5358c8a1
eef3f7e25993a46e3c4242aa502d93e909b08c57

The format currently used produce a 373624*41bytes large file.

Used on a git-svn clone here, i get:
The results are:
old:
1,1G    hadoop (1004M   svn/)
new:
47M     hadoop (5,9M    svn/)

in detail:

.git/svn/trunk:
old:
-rw-r--r-- 1 david david 24M 2007-11-29 10:26
.rev_db.13f79535-47bb-0310-9956-ffa450edef68
-rw-r--r-- 1 david david 75K 2007-11-29 10:26
.rev_db.7fecf15c-03ad-4724-994c-e980afa7160c
new:
-rw-r--r-- 1 david david 32K 2007-12-03 18:40
revdb-13f79535-47bb-0310-9956-ffa450edef68.bin
-rw-r--r-- 1 david david 18K 2007-12-03 18:40
revdb-13f79535-47bb-0310-9956-ffa450edef68.idx
-rw-r--r-- 1 david david  32K 2007-12-03 18:44
revdb-7fecf15c-03ad-4724-994c-e980afa7160c.bin
-rw-r--r-- 1 david david 2,0K 2007-12-03 18:44
revdb-7fecf15c-03ad-4724-994c-e980afa7160c.idx

Here a example sourcecode to test this idea:

I try to integrate this in git-svn this week.

NOTE: I'm not a perl hacker, so use at your own risk.

Bye David
ps.: I'm not a member of this list please reply directly to me.

migrate.pl:
$uuid = "7fecf15c-03ad-4724-994c-e980afa7160c";

open (NONZERO, '.rev_db.'.$uuid);
open (IDX, '>revdb-'.$uuid.'.idx');
open (BIN, '>revdb-'.$uuid.'.bin');

$first_zero = 0;
$pos = 0;
$rev = 0;

while ($sha1 = <NONZERO>) {

chomp($sha1);

if ($sha1 ne ("0" x 40))
{
        print BIN pack("H40", $sha1);

        if ($first_zero != $rev)
        {
                print IDX pack("N N N", $first_zero, ($rev-1), $pos);
        }

        $first_zero=$rev+1;
        $pos++;
}

$rev++;

}

close(BIN);
close(IDX);
close(NONZERO);

parse.pl:
use strict;
use Fcntl;

my(@index, $buf, $i);
my($uuid) = "13f79535-47bb-0310-9956-ffa450edef68";
my($db_path) = "revdb-$uuid.bin";

sysopen(IDX, "revdb-$uuid.idx", O_RDONLY);

while (sysread(IDX, $buf, 12)) {
   my($minrev, $maxrev, $pos) = unpack("N N N", $buf);

   push @index, [$minrev, $maxrev, $pos];
}

close(IDX);

my($lastindex) = scalar(@index)-1;
my($lastindexpos) = $index[$lastindex][2];
my($lastindexrev) = $index[$lastindex][1];

my @stat = stat $db_path;
($stat[7] % 20) == 0 or die "$db_path inconsistent size: $stat[7]\n";
my ($maxrev) = ($stat[7]/20)-($lastindexpos)+($lastindexrev);
my ($minrev) = $index[0][1]+1;

my($cachestep) = int((scalar(@index))/9);
my(@cache);
for (my($i)=0; $i < scalar(@index); $i += $cachestep) {
   push @cache, [$index[$i][0], $i];
}

my($lastsearch) = 0;

sub pos2sha1 {
   my($pos) = @_;
   sysopen(BINDB, $db_path, O_RDONLY);

   sysseek(BINDB, $pos, 0);

   my($buf);
   sysread(BINDB, $buf, 20);

   return unpack ("H40", $buf);

   close(BINDB);
}

sub get_sha1 {
   my($rev) = @_;
   my($i) = 0;

   if (($rev <= 0) || ($rev > $maxrev) || $rev <= $index[0][1]) {
      return ("0" x 40);
   }

   if ($rev > $lastindexrev) {
      my($pos) = (((($rev-1) - $lastindexrev)+$lastindexpos))*20;

      return pos2sha1($pos);
   }

   if(($rev >= $index[$lastsearch][0] && $rev <= $index[$lastsearch][1]) ||
($rev >= $index[$lastsearch+1][0] && $rev <= $index[$lastsearch+1][1])) {
      return ("0" x 40);
   }
   elsif ($rev > $index[$lastsearch][1] && $rev < $index[$lastsearch+1][0]) {
      my($pos) = (($rev-1) - $index[$lastsearch][1] + $index[$lastsearch][2]) * 20;

      return pos2sha1($pos);
   }
   elsif($rev > $index[$lastsearch+1][1] && $rev < $index[$lastsearch+2][0]) {
      $lastsearch++;

      my($pos) = (($rev-1) - $index[$lastsearch][1] + $index[$lastsearch][2]) * 20;

      return pos2sha1($pos);
   }
   elsif($lastsearch != 0 && $rev > $index[$lastsearch-1][1] && $rev <
$index[$lastsearch][0]) {
      $lastsearch--;

      my($pos) = (($rev-1) - $index[$lastsearch][1] + $index[$lastsearch][2]) * 20;

      return pos2sha1($pos);
   }

   my($l, $r);
   $l = 0;
   $r = scalar(@index)-1;

   my($lastcache) = scalar(@cache)-1;

   for (my($i)=0; $i <= $lastcache; $i++) {
      if ($rev >= $cache[$i][0]) {
         $l = $cache[$i][1];
      }

      if ($rev < $cache[$lastcache-$i][0]) {
         $r = $cache[$lastcache-$i][1];
      }
   }

   if ($rev <= $index[$l][1]) {
      return ("0" x 40);
   }

   while ($l <= $r) {
      $i = int(($l + $r)/2);

      if ($rev >= $index[$i][0]  && $rev <= $index[$i][1]) {
         $lastsearch = $i;

         return ("0" x 40);
      }
      elsif ($rev <= $index[$i][0]) {
         $r = $i-1;
      }
      elsif ($rev >= $index[$i+1][0]) {
         $l = $i+1;
      } 
      else {
         $lastsearch = $i;
         my($pos) = (($rev-1) - $index[$i][1] + $index[$i][2]) * 20;

         return pos2sha1($pos);
      }
   }

   return ("0" x 40);
}

for (my($i)=$maxrev; $i >= $minrev; $i--) {
   my($sha1) = get_sha1($i);
   if ($sha1 ne ("0" x 40)) {
      print "$i = $sha1\n";
   }
}
