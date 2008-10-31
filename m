From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: getting list of objects for packing
Date: Fri, 31 Oct 2008 14:32:18 -0500
Message-ID: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:33:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvzkT-0006Pb-Ly
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYJaTcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbYJaTcU
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:32:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40031 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbYJaTcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:32:20 -0400
Received: by mail.nrlssc.navy.mil id m9VJWJkS010156; Fri, 31 Oct 2008 14:32:19 -0500
X-OriginalArrivalTime: 31 Oct 2008 19:32:19.0262 (UTC) FILETIME=[63825DE0:01C93B8F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99626>


I'm trying to write a script that will repack large binary or compressed
objects into their own non-compressed, non-delta'ed pack file.

To make the decision about whether an object should go into this special
pack file or not, I want the output from 'git cat-file --batch-check'.
I get it with something similar to:

   git rev-list --objects --all |
      sed -e 's/^\([0-9a-f]\{40\}\).*/\1/' |
      git cat-file --batch-check

First question: Is the rev-list call correct?
  -If I am understanding things right, then the list of objects produced
   by rev-list will be in the right order for piping to pack-objects. 
  -The sed statement is stripping off anything after the sha1. Any way to
   get rev-list to print out just the sha1 so that sed is not necessary?

Then I want to parse the output from cat-file and use an external program
to detect the file format. Here is a simplified version:

  | while read sha1 type size; do

       if [ $type = "blob" ]; then
           if ! ( git cat-file blob "$sha1" | file -b - | grep text ) &&
              [ $size -ge $threshhold ]; then
               # pack into special pack
           else
               # pack normally into normal pack
           fi
       fi
  done

All of this has actually been rewritten into a perl script, so ignore any
syntax mistakes.

I have successfully created two of the pack files that I have been trying to
make. Where the definition of successful means that after removing the existing
packs and objects, and putting in place the two pack files that I generated,
'git fsck --full' prints no errors and exits successfully.

These two packs will be placed into a central repository.

ISSUE TWO:

I have placed these two packs into my own personal repo, and I have unpacked all
of the other objects so that they are loose.

I thought I could use a similar sequence of commands to pack those loose objects
into a normal and special pack. I added the --unpacked option to my rev-list
command, but it still lists many more objects than exist loosely in the repository.

   git rev-list --objects --unpacked --all

The man page says:

   --objects
          Print  the  object  IDs  of any object referenced by the listed
          commits. --objects foo ^bar thus means "send me all object  IDs
          which  I  need to download if I have the commit object bar, but
          not foo".

   --unpacked
          Only useful with --objects; print the object IDs that  are  not
          in packs.

Is this the correct behavior for rev-list --unpacked?
Am I mis-reading the --unpacked text, or should it be changed?

-brandon
