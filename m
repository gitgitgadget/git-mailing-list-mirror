From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: msysgit git-submodule: "Unable to fetch in submodule path ..."
Date: Mon, 22 Jun 2009 13:46:57 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0906221342310.26061@ds9.cixit.se>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 14:47:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIivU-0002kv-Mk
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 14:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbZFVMq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 08:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbZFVMq6
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 08:46:58 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:57457 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751327AbZFVMq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 08:46:57 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n5MCkvJZ029526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Jun 2009 14:46:57 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n5MCkv2n029522;
	Mon, 22 Jun 2009 14:46:57 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 22 Jun 2009 14:46:57 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122032>

Peter Krefting:

>  Receiving objects: 100% (14752/14752), 5.07 MiB | 3629 KiB/s, done.
>  Resolving deltas: 100% (9278/9278), done.
>  Server supports multi_ack
>  Server supports side-band-64k
>  Server supports ofs-delta
>  Marking 76b96bfecc0d47013dd1fca1a555f12074eca814 as complete
>  Unable to fetch in submodule path 'modules/foo'

I added some extra debugging output to the code in builtin-fetch.c and 
builtin-fetch-pack.c, and ended up with this:

   Receiving objects: 100% (14752/14752), 5.07 MiB | 3383 KiB/s, done.
   Resolving deltas: 100% (9278/9278), done.
   cmd_fetch(): calling do_fetch()
   do_fetch(): calling get_ref_map()
   do_fetch(): get_ref_map() done
   do_fetch(): check_not_current_branch() done
   do_fetch(): read_ref() loop done
   fetch_refs(): quickfetch() returned -10001
   Server supports multi_ack
   Server supports side-band-64k
   Server supports ofs-delta
   Entering everything_local()
   everything_local() after 1st ref loop
   Marking 76b96bfecc0d47013dd1fca1a555f12074eca814 as complete
   everything_local() after mark_recent_complete_commits()
   everything_local() after 2nd ref loop
   everything_local() after filter_refs()
   everything_local() done with retval = 1
   everything_local() returned true
   do_fetch_pack() done
   fetch_pack(): calling reprepare_packed_git()
   fetch_pack(): done
   fetch_refs(): transport_fetch_refs() returned -1
   do_fetch(): fetch_refs(transport, ref_map) returned non-zero
   cmd_fetch(): do_fetch() return with exit_code = 1
   Unable to fetch in submodule path 'modules/foo'

This seems to indicate that fetch_refs() seems to think that the fetch 
(which is done over ssh) fails, whereas the regular trace output ("Receiving 
objects", etc.) indicates that it succeeds.

Is there anything obvious that I should have a look at here?

My next step otherwise is adding trace output to the transport_fetch_refs() 
and whatever it is it calls and that calls the code in builtin-fetch-pack.c. 
Anywhere in particular I should have a look at?

-- 
\\// Peter - http://www.softwolves.pp.se/
