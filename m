From: Pascal Obry <pascal@obry.net>
Subject: something fishy with Git commit and log from file
Date: Wed, 06 Aug 2008 12:30:06 +0200
Organization: Home - http://www.obry.net
Message-ID: <48997D2E.9030708@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 12:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQgJ7-00024n-P0
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 12:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbYHFKa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 06:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYHFKa1
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 06:30:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:20448 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYHFKaY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 06:30:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1544687fgg.17
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 03:30:22 -0700 (PDT)
Received: by 10.86.65.9 with SMTP id n9mr290108fga.55.1218018621848;
        Wed, 06 Aug 2008 03:30:21 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.201.122])
        by mx.google.com with ESMTPS id l12sm3524479fgb.6.2008.08.06.03.30.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 03:30:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91499>


The following command fails on my repository:

    $ git commit --file=clog
    fatal: could not read log file 'clog': No such file or directory

    $ cat clog
    toto

Using the following command the commit pass without problem:

    $ cat clog | git commit --file=-

With GDB I get:

$ gdb --args git ci --file=clog
This GDB was configured as "i686-pc-cygwin"...
(gdb) break strbuf_read_file
Breakpoint 1 at 0x44e64a: file strbuf.c, line 301.
(gdb) run
Starting program: /usr/local/bin/git.exe ci --file=clog

Breakpoint 1, strbuf_read_file (sb=0x22cac0, path=0x22ccfa "clog", 
hint=0) at strbuf.c:301
301             fd = open(path, O_RDONLY);
(gdb) print path
$1 = 0x0

???? outch, this is strange, or a gdb artifact?

(gdb) n
302             if (fd < 0)
(gdb) print fd
$2 = -1
(gdb) print *0x22ccfa
$3 = 1735355491
(gdb) print (char)*0x22ccfa
$4 = 99 'c'
(gdb) print (char)*0x22ccfb
$5 = 108 'l'
(gdb) print (char)*0x22ccfc
$6 = 111 'o'
(gdb) print (char)*0x22ccfd
$7 = 103 'g'
(gdb) print (char)*0x22ccfe
$8 = 0 '\0'

But looks like path really contains 'clog'!!!

No luck for now to find the problem. Note that the same command pass 
fine on other repositories. At this point this looks really like some 
kind of memory corruption...

I'm on Windows, using Git for Cygwin and the compiler is:

$ gcc --version
gcc (GCC) 3.4.4 (cygming special, gdc 0.12, using dmd 0.125)

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
