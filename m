From: Wolfgang Denk <wd@denx.de>
Subject: Destructive side-effect of "cg-status"
Date: Fri, 30 Sep 2005 18:03:53 +0200
Message-ID: <20050930160353.F025C352B7B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Sep 30 18:05:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELNMt-00011X-J0
	for gcvg-git@gmane.org; Fri, 30 Sep 2005 18:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVI3QEM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Sep 2005 12:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVI3QEM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Sep 2005 12:04:12 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:21120 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1030351AbVI3QEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2005 12:04:12 -0400
Received: from fwd26.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1ELNMo-0000X1-02; Fri, 30 Sep 2005 18:04:10 +0200
Received: from denx.de (E1C4xsZ18eVv+rJJaVaTOsEb9w8HhJ08bkeXqvj4xzNDqQEMXQIK0u@[84.150.101.119]) by fwd26.sul.t-online.de
	with esmtp id 1ELNMf-0J7it60; Fri, 30 Sep 2005 18:04:01 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id 08A3842A2B
	for <git@vger.kernel.org>; Fri, 30 Sep 2005 18:03:59 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id F025C352B7B
	for <git@vger.kernel.org>; Fri, 30 Sep 2005 18:03:53 +0200 (MEST)
To: git@vger.kernel.org
X-ID: E1C4xsZ18eVv+rJJaVaTOsEb9w8HhJ08bkeXqvj4xzNDqQEMXQIK0u@t-dialin.net
X-TOI-MSGID: 36a1d5e3-73ea-4c26-81f2-cc25e5978e20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9565>

So far I  thought  "cg-status"  is  a  harmless  command  which  just
displays  some  status information. It ain't so. One of our engineers
reported a  corrupted  repository  after  I  ran  "cg-status"  in  his
directory:

$ cg-status
Heads:
   >master      805f93e4ca96d0c0cb2d2f9532d9666b22961e88
  R origin      805f93e4ca96d0c0cb2d2f9532d9666b22961e88

error: open failed
fatal: cache corrupted
error: open failed
? COPYING
? CREDITS
? Documentation/00-INDEX
? Documentation/BUG-HUNTING
...
error: open failed
read_cache: Permission denied
...
error: open failed
read_cache: Permission denied
...


As mentioned before,  all  I  did  was  running  "cg-status"  in  his
directory. Here is what happens:

Before:

	-> rpm -q cogito
	cogito-0.15.1-1
	-> id
	uid=500(wd) gid=500(wd) groups=200(gitmaster),400(denx),500(wd)
	-> umask
	0002
	-> ls -ld .git
	drwxrwxrwx  6 sr sr 80 Sep 30 17:49 .git
	-> ls -l .git/index
	-rw-r--r--  1 sr sr 1728032 Sep 30 17:17 .git/index

Then:

	-> cg-status
	Heads:
	   >master      805f93e4ca96d0c0cb2d2f9532d9666b22961e88
	  R origin      805f93e4ca96d0c0cb2d2f9532d9666b22961e88

	M arch/ppc/configs/bubinga_defconfig
	M arch/ppc/configs/walnut_defconfig
	-> ls -l .git/index
	-rw-------  1 wd wd 1728032 Sep 30 17:49 .git/index
	^^^^^^^^^^    ^^^^^

That means, that "cg-status" actually *rewrote* .git/index,  with  me
(wd)  as  new  owner, and - ignoring my umask - with permissions that
prevent the original owner (sr) to access the file!

Arghhhh!!!

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Generally speaking, there are other ways to accomplish whatever it is
that you think you need ...                               - Doug Gwyn
