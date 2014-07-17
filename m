From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: git_inetd_server: run git-http-backend using inetd
Date: Thu, 17 Jul 2014 14:28:26 -0700
Message-ID: <43923BC7-08AF-4900-AC5E-B2F0FE7CD5AC@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 23:28:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7tEA-0006v6-Dl
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 23:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbaGQV2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 17:28:30 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36321 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbaGQV23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 17:28:29 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so3807270pdj.35
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:to:content-type:content-transfer-encoding:subject
         :mime-version:date;
        bh=YrGR1c5GdEWSphkS8nCrhWSafGVDabhAeZ4B3NVGPJg=;
        b=YimVhg2qO062nEI6XNKTnRupVUlbhRBCF880uJJ2ALZKCDg+2LM7k/5PB62KJvtfHl
         /Czc1dRMJSDH1VWGofI+q/n3AhLen5rGhsFenDQoxg4gGSguwUqLkhX8KcM9r7QYAfGQ
         UMJmkugKsBtpEWHpjdpivxlkqcbX4Ck+p2ovznz2ffzGC1XbGWoWv49jz9d+fzc04gQk
         H9MDnTn6ZicPW10LsadCnB6Rw4AdhwWR5apjFZWLHgIhFS/9un8F6vcjYyejgMqC+Fdy
         iTjs0PrFwpLTBPMWEu+L+Gimd0R4lgMv4QunHVGQXEPYbgir/MtN/0nyEJmrsLDmnN9N
         gaeg==
X-Received: by 10.68.171.193 with SMTP id aw1mr27020463pbc.117.1405632508850;
        Thu, 17 Jul 2014 14:28:28 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id zc10sm14405243pac.46.2014.07.17.14.28.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 14:28:28 -0700 (PDT)
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253782>

===========
What is it?
===========
I have created a script (POSIX sh compatible) that allows running git- 
http-backend via inetd or similar service (it makes it like git-http- 
backend had a --inet option just like git-daemon does).

This allows the Git smart HTTP protocol to be served without needing  
to run a standard web server (assuming inetd, xinetd, launchd or  
similar is already available).

It is available at [1] with a GPL license.

====
Why?
====
I have several machines/virtual machines that need to be able to fetch  
from a central Git repository without authentication (several of them  
are test platforms and are therefore not trusted and typing a password  
on every fetch is a non-starter as some of the fetches are  
automated).  I also don't want to have to run a web server just to  
serve Git fetches.

Of course you say, "why not use git daemon for that?"  Well, I was (in  
--inetd mode), but it has a serious problem and until recently I  
didn't know the cause.

Talking to a git-daemon server works great for my FreeBSD, Darwin,  
cygwin, msysgit platforms, but it's terrible for my Linux platforms.

On the Linux platforms every git fetch would hang for at least 15  
seconds before starting the fetch.  I just wrote that off as some odd  
configuration issue I was going to have to live with (although it only  
happened with Git and not web browsing or curl fetches).  It's killer  
though when fetching a project with lots of submodules as each one has  
the delay.

Recently though, I discovered the cause.  While I don't actually run  
Debian itself, all my Linux platforms are Debian offspring (Ubuntu,  
Raspbian, Linux Mint, etc.).  The problem is in the Debian git package  
[2] specifically the "0010-transport-optionally-honor-DNS-SRV- 
records.diff" patch located in the Debian diffs file [3].

The 0010 patch makes "git://host/..." fetches first try to fetch a git  
SRV record from DNS.  This patch has a compile time option to enable  
it, but once baked in it cannot be turned off at runtime and the  
binary packages for my distributions all have it turned on and baked  
in.  And none of these distributions have a visible "WARNING: Git has  
patches that may cause it to behave oddly, violate RFC standards and/ 
or experience unexpected delays."

It so happens that my internal network is setup using mDNS [4] (on  
Linux/FreeBSD by installing Avahi and nss-mdns packages).

When I then try to fetch using a "git://host/..." URL where "host" is  
an mDNS host name, the 0010 patch causes git to attempt to lookup a  
DNS SRV record on the non-mDNS regular DNS service (a violation of RFC  
6762 [4] section 22) and this is what has to time out before the real  
fetch can start.

Since the patch does not try to lookup an SRV record for "http:// 
host/..." URLs, switching from git: to http: for fetches eliminates  
the problem.  However, git-http-backend does not have any of the -- 
daemon or --inetd related options that git-daemon does.  Hence the  
git_inetd_server.sh script [1] that provides the equivalent of a -- 
inetd option for git-http-backend.

I have since discovered that the 0010 patch behavior can be bypassed  
by explicitly including a port number in the git: URLs.  So instead of  
"git://example.local/repo.git" using "git://example.local:9418/ 
repo.git" avoids the delaying SRV lookup.  This is highly unintuitive  
since omitting the default port for a scheme should not change its  
behavior (according to RFC 3986 [5] section 3.2.3 the port should be  
omitted by producers and normalizers if it's the same as the scheme's  
default port).  In any case, unless git_inetd_server.sh can be run on  
the default http port (80), the resulting http: URLs are no more  
convenient than the git: URLs with an explicit port.

Nonetheless, others may find this script helpful as it allows the Git  
smart (and non-smart) HTTP protocol to be served without needing to  
run a standard web server so I decided to share it.

--Kyle

=====
Links
=====
[1] https://github.com/mackyle/git_inetd_server
[2] https://packages.debian.org/wheezy/git
[3] http://ftp.de.debian.org/debian/pool/main/g/git/git_1.7.10.4-1+wheezy1.diff.gz
[4] RFC 6762 http://tools.ietf.org/html/rfc6762
[5] RFC 3986 http://tools.ietf.org/html/rfc3986
