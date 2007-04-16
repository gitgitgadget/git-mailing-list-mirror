From: Steven Grimm <koreth@midwinter.com>
Subject: Segmentation fault in git-svn
Date: Mon, 16 Apr 2007 15:17:55 -0700
Message-ID: <4623F613.5010108@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 00:18:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdZWM-0005Ms-R0
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 00:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030990AbXDPWR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031020AbXDPWR6
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 18:17:58 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58205 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030990AbXDPWR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 18:17:58 -0400
Received: (qmail 17238 invoked from network); 16 Apr 2007 22:17:57 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=RIVeApt8oxCH7146SDuAEU5IVrIfzzW1R74gEKs9xZdMS5CHhvUnxpwQb0VQIUKW  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 16 Apr 2007 22:17:57 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44698>

I expect this is really a libsvn bug, but git-svn triggers it, so I'm 
hoping someone else has run into and solved it, or at least that someone 
can reproduce it.

If I try to clone the "memcached" public repository with the command line

  git-svn clone --branches=branches --trunk=trunk 
http://code.sixapart.com/svn/memcached

it cranks along fine until revision 299, then dies with SIGSEGV. If I 
run it again, it appears to pick up where it left off, then dies again 
at revision 399, then again at revision 499. (There are fewer than 600 
revisions in that repo so it's anyone's guess if it'd die at 599 given 
the chance.)

This happens on both a Linux box (amd64, FC4, svn version 1.4.3) and my 
Mac (Intel OS 10.4, svn version 1.2.3 from Fink), so at the very least 
it's not platform-specific. It also happens periodically on the private 
svn repository at my company, though not as predictably. On my Mac, I'm 
using the very latest git code from "master".

I ran the Perl interpreter under gdb to get a stack trace:

#0  get_private (hk=0x8050300000001, id=0x2aaaaf187b2b "SVN") at 
ne_request.c:273
#1  0x00002aaaaf186983 in parsed_request (sess=0xfbc0e0, 
method=0x2aaaaf188e19 "PROPFIND", url=0x11e5ab0 "/svn/memcached",
    body=0x100ce00 "<?xml version=\"1.0\" encoding=\"utf-8\"?><propfind 
xmlns=\"DAV:\"><prop><version-controlled-configuration 
xmlns=\"DAV:\"/><resourcetype xmlns=\"DAV:\"/><baseline-relative-path 
xmlns=\"http://subversion.tigris.o"..., body_file=0x0, 
set_parser=0x2aaaaf1816e0 <set_parser>, elements=0x2aaaaf28c9e0, 
use_neon_shim=1, validate_compat_cb=0x2aaaaf1811b0 <validate_element>,
    startelm_compat_cb=0x2aaaaf181290 <start_element>, 
endelm_compat_cb=0x2aaaaf181400 <end_element>, startelm_cb=0, 
cdata_cb=0, endelm_cb=0, baton=0x7fffff84f630, extra_headers=0x11e5ac0,
    status_code=0x0, spool_response=0, pool=0x11e5788) at 
subversion/libsvn_ra_dav/util.c:602
#2  0x00002aaaaf187228 in svn_ra_dav__parsed_request_compat 
(sess=Variable "sess" is not available.
) at subversion/libsvn_ra_dav/util.c:876
#3  0x00002aaaaf1818b8 in svn_ra_dav__get_props (results=0x7fffff84f6d0, 
sess=0xfbc0e0, url=0x11e5ab0 "/svn/memcached", depth=Variable "depth" is 
not available.
) at subversion/libsvn_ra_dav/props.c:531
#4  0x00002aaaaf1819b6 in svn_ra_dav__get_props_resource 
(rsrc=0x7fffff84f7e8, sess=0xfbc0e0, url=0x11e5a80 "/svn/memcached", 
label=0x0, which_props=0x2aaaaf28c940, pool=0x11e5788)
    at subversion/libsvn_ra_dav/props.c:558
#5  0x00002aaaaf181c16 in svn_ra_dav__search_for_starting_props 
(rsrc=0x7fffff84f7e8, missing_path=0x7fffff84f7e0, sess=0xfbc0e0, 
url=0xfaefd8 "http://code.sixapart.com/svn/memcached",
    pool=0x11e5788) at subversion/libsvn_ra_dav/props.c:667
#6  0x00002aaaaf181e85 in svn_ra_dav__get_baseline_props 
(bc_relative=0x7fffff84f850, bln_rsrc=0x7fffff84f868, sess=0xfbc0e0, 
url=Variable "url" is not available.
) at subversion/libsvn_ra_dav/props.c:775
#7  0x00002aaaaf1824a3 in svn_ra_dav__get_baseline_info (is_dir=0x0, 
bc_url=0x7fffff84f990, bc_relative=0x7fffff84f980, latest_rev=0x0, 
sess=0xfbc0e0, url=Variable "url" is not available.
)
    at subversion/libsvn_ra_dav/props.c:898
#8  0x00002aaaaf17ffe0 in svn_ra_dav__get_log (session=Variable 
"session" is not available.
) at subversion/libsvn_ra_dav/log.c:430
#9  0x00002aaaaf4c46fa in _wrap_svn_ra_get_log (my_perl=Variable 
"my_perl" is not available.
) at svn_ra.c:4552
#10 0x0000003bd9e9b67e in Perl_pp_entersub () from 
/usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/CORE/libperl.so
#11 0x0000003bd9e7f3cd in Perl_runops_debug () from 
/usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/CORE/libperl.so
#12 0x0000003bd9e39b49 in perl_run () from 
/usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/CORE/libperl.so
#13 0x0000000000401a01 in main ()

Can anyone else reproduce this?

-Steve
