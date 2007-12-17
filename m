From: Pascal Obry <pascal@obry.net>
Subject: Question about git-svn import
Date: Mon, 17 Dec 2007 18:18:29 +0100
Organization: Home - http://www.obry.net
Message-ID: <4766AF65.5060706@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 18:31:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Jmg-0000xP-KE
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 18:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbXLQR3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbXLQR3T
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 12:29:19 -0500
Received: from smtp20.orange.fr ([80.12.242.26]:39698 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbXLQR3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 12:29:18 -0500
Received: from smtp20.orange.fr (mwinf2014 [172.22.130.42])
	by mwinf2005.orange.fr (SMTP Server) with ESMTP id E535D1C21B5E
	for <git@vger.kernel.org>; Mon, 17 Dec 2007 18:19:15 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2014.orange.fr (SMTP Server) with ESMTP id 0B3961C000AB
	for <git@vger.kernel.org>; Mon, 17 Dec 2007 18:18:33 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2014.orange.fr (SMTP Server) with ESMTP id CC4D91C0008E
	for <git@vger.kernel.org>; Mon, 17 Dec 2007 18:18:32 +0100 (CET)
X-ME-UUID: 20071217171832836.CC4D91C0008E@mwinf2014.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68582>


Hi,

You'll find a script into this message that reproduce what I'll describe
below. Basically the Subversion repository add a given structure in the
past then rearranged to use the "standard" structure. The former
structure was:

   <root>
      |
      | - dir1
      | - dir2

The new one is:

   <root>
      |
      |- trunk
      |    | - dir1
      |    | - dir2
      |- branches
      |- tags

Now I want to import this project into Git (using git-svn) as the
project won't leave Subversion for the moment. When doing:

   $ git svn clone -s <repo> <git-repo>

In git-repo we get only the commits done inside <root>/trunk and not the
commits done in the former repository.

The question is what is the best way to deal with such a case with git-svn ?

Thanks.

############################ CUT HERE #############################
#!/bin/sh

REP=file://$(pwd)/repo

rm -fr repo co-repo git-repo

svnadmin create repo

svn co $REP co-repo
cd co-repo
mkdir dir
echo file1 > dir/file1
svn add dir dir/file1
svn ci -m "ci1" dir dir/file1

svn mkdir -m "create trunk" $REP/trunk
svn mkdir -m "create branches" $REP/branches
svn mkdir -m "create tags" $REP/tags

svn move -m "move dir under trunk" $REP/dir $REP/trunk/dir

svn update
sleep 2

echo file1 >> trunk/dir/file1
svn ci -m "ci2" trunk/dir/file1

sleep 2
svn update

cd ..

git svn clone -s $REP git-repo
############################ CUT HERE #############################

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
