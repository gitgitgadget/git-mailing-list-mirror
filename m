From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Use config file or file for repository owner's
	name.
Date: Tue, 5 Feb 2008 02:41:21 -0200
Message-ID: <20080205044121.GA13263@c3sl.ufpr.br>
References: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br> <7vwsprj0sv.fsf@gitster.siamese.dyndns.org> <20080131023629.GB7778@c3sl.ufpr.br> <7vsl0eg16c.fsf@gitster.siamese.dyndns.org> <7vabmmg0cb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 05:42:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMFdF-0001fj-ED
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 05:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbYBEEld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 23:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYBEEld
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 23:41:33 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:39783 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772AbYBEElc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 23:41:32 -0500
Received: from localhost (unknown [189.1.136.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 56739700003EA;
	Tue,  5 Feb 2008 02:41:30 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <7vabmmg0cb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72623>

On Wed, Jan 30, 2008 at 07:06:44PM -0800, Junio C Hamano wrote:
> If the config reading interface is too slow (somebody has to
> bench it on a large set of repositories), maybe we would need to

I made a simple bench as follows.

dd= 'dd if=/dev/zero of=/home/bruno/dds/$i bs=1M count=400000'
Machine: 4*opteron 2.8GHz
     32GB ram
     14*750GB RAID0 sata2 /home
     
Generated a 1000 projects [ too much?! git.debian.org has 668]
For each test a 'echo 2 > /proc/sys/vm/drop_caches' was done before running
it.

command: time gitweb.cgi > /dev/null

-----------------  -----------------  ------------  -----------------
With Project List   NO Project List      LoadAvg     description way
-----------------  -----------------  ------------  -----------------
->0*dd             ->0*dd
   1m0.851s           1m18.651s        0.78  0.70     description file
   1m1.511s           0m55.051s        0.83  0.35     gitweb.description
               
->2*dd             ->2*dd
   21m0.899s          17m19.706s       8.21  6.48     description file
   16m29.455s         13m36.602s       5.90  5.95     gitweb.description
                   
->4*dd             ->4*dd
   23m6.781s          26m51.544s       10.81 12       description file
   20m57.249s         26m32.704s       11.50 12.55    gitweb.description


My test was simple =) But we can get some conclusions on it.
Running a git-config -z -l for each git repository is not a problem, as we
obtain same speed on tests (only loosing on very high IO's) [maybe i should
run with 8*dd or 80...].

After that, having a gitweb.owner might not be a problem as we parse all
config file once.

Running the "git-for-each-ref" is the big killer [waaaw =P]. We could store
timestamp at gitweb.lastchange, which is updated by a hook?! Or store it in
some way[ i will bench with if stored].
-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
