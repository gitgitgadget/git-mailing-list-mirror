From: Pascal Obry <pascal@obry.net>
Subject: git-svn very slow on fetch (shared git-svn repo)
Date: Sat, 10 Oct 2009 11:10:45 +0200
Organization: Home - http://www.obry.net
Message-ID: <4AD04F95.7050603@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 10 11:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwY0v-000502-KF
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 11:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756666AbZJJJLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 05:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbZJJJLT
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 05:11:19 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:60092 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443AbZJJJLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 05:11:18 -0400
Received: by ewy4 with SMTP id 4so1251951ewy.37
        for <git@vger.kernel.org>; Sat, 10 Oct 2009 02:10:06 -0700 (PDT)
Received: by 10.210.4.5 with SMTP id 5mr4516663ebd.23.1255165805515;
        Sat, 10 Oct 2009 02:10:05 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-79-118.w86-205.abo.wanadoo.fr [86.205.109.118])
        by mx.google.com with ESMTPS id 24sm2263264eyx.1.2009.10.10.02.10.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 02:10:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129875>


Here is the problem.

Doing a:

    $ git svn fetch

Takes age to update the repository. The long story is that I'm trying to 
have shared git-svn repositories.

I'm cloning the repository on a server using a standard "git svn clone". 
I then let users cloning this repository using the procedure described 
in git-svn help. Copy/paste here:

<<
        # Do the initial import on a server
                ssh server "cd /pub && git svn clone 
http://svn.example.com/project
        # Clone locally - make sure the refs/remotes/ space matches the 
server
                mkdir project
                cd project
                git init
                git remote add origin server:/pub/project
                git config --add remote.origin.fetch 
'+refs/remotes/*:refs/remotes/*'
                git fetch
        # Create a local branch from one of the branches just fetched
                git checkout -b master FETCH_HEAD
        # Initialize 'git svn' locally (be sure to use the same URL and 
-T/-b/-t options as were used on server)
                git svn init http://svn.example.com/project
        # Pull the latest changes from Subversion
                git svn rebase
 >>

If you do a "git svn fetch" (to get new branches) it takes age if you 
have imported branches that are not used since a long time.

I've traced this down to the Perl fetch_all procedure. It seems that the 
fetch is looking at the older version in all branches and then read the 
remote repository starting from this revision. As some branches are 
unused since a very long it it re-read most of the history. In my 
example it start at rev 8200 whereas the last revision on trunk is 
150000 (I put trace in git-svn Perl script).

I have observed that this happen only the first time.

This can be confirmed by the fact that if you break git-svn fetch 
process and restart it it will start to a later revision. So it seems 
that git-svn is keeping some kind of data about what has already been 
fetched but those data are not properly copied by the procedure above.

Is there a workaround that? Where are those data stored?

Any guidance would be very welcomed.

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
