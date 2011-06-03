From: Duncan Brown <dabrown@physics.syr.edu>
Subject: Re: [PATCH/RFC] http: pass http.cookiefile using CURLOPT_COOKIEFILE
Date: Thu, 2 Jun 2011 22:43:11 -0400
Message-ID: <BD4E94C2-E51C-44CA-8E6B-BE9371131DC5@physics.syr.edu>
References: <20110602203125.0E04C734F12@antares.phy.syr.edu> <BANLkTi=3cQx9L4rrkniBhqFfL1TuNgu0doaSpdV8ajgsWJvw1Q@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 04:43:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSKM2-0007Hr-Le
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 04:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab1FCCnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 22:43:13 -0400
Received: from smtp1.syr.edu ([128.230.18.82]:57786 "EHLO smtp1.syr.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401Ab1FCCnN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 22:43:13 -0400
Received: from [10.0.1.11] (pool-96-249-48-108.syrcny.fios.verizon.net [96.249.48.108])
	(authenticated bits=0)
	by smtp1.syr.edu (8.14.3/8.14.3) with ESMTP id p532hBWD010488
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 2 Jun 2011 22:43:12 -0400
In-Reply-To: <BANLkTi=3cQx9L4rrkniBhqFfL1TuNgu0doaSpdV8ajgsWJvw1Q@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.4.6813,1.0.148,0.0.0000
 definitions=2011-06-03_01:2011-06-03,2011-06-03,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 suspectscore=1
 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 engine=6.0.2-1012030000 definitions=main-1106020212
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174991>

Hi Shawn,

On Jun 2, 2011, at 8:01 PM, Shawn Pearce wrote:

> On Thu, Jun 2, 2011 at 13:31, Duncan Brown <dabrown@physics.syr.edu> wrote:
>> If the config option http.cookiefile is set, pass this file to libCURL using
>> the CURLOPT_COOKIEFILE option. This is similar to calling curl with the -b
>> option.  This allows git http authorization with authentication mechanisms
>> that use cookies, such as SAML Enhanced Client or Proxy (ECP) used by
>> Shibboleth.
> 
> Wow, the patch was this simple?

Yep, it took longer to google for the libCURL docs than it did to write the code! With this patch, I can do the following:

[dbrown@spice-dev2 test]$ ./ecp.sh SUGWG https://sugwg-git.phy.syr.edu/git/qm/info/refs?service=git-upload-pack dbrown
Enter host password for user 'dbrown':

001e# service=git-upload-pack
0000009b0b31a9bef84542ff7dd5a10eb72ef2a67d176a35 HEADmulti_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag multi_ack_detailed
003f0b31a9bef84542ff7dd5a10eb72ef2a67d176a35 refs/heads/master
00424b2259eb6bada1a160e8dcf394b93fa60a60c90d refs/tags/first_corr
004266eea9443af5f0026a44d58990547f8ff60897c6 refs/tags/pre_double
0043f8d991153a857af157e9dfaa9e8851ae2440cafd refs/tags/ptf_test_01
0000

ecp.sh is Scott Koranda's demonstration ECP client:

<https://wiki.shibboleth.net/confluence/display/SHIB2/Contributions#Contributions-simplebash>

It gets a Shib session cookie and stores it in ~/.curlcookies with curl and xlstproc command line tools. Now that I have my session cookie, I can do

[dbrown@spice-dev2 test]$ git config --global http.cookiefile "/home/dbrown/.curlcookies"
[dbrown@spice-dev2 test]$ git clone https://sugwg-git.phy.syr.edu/git/qm
Cloning into qm...
remote: Counting objects: 2071, done.
remote: Compressing objects: 100% (833/833), done.
remote: Total 2071 (delta 1352), reused 1851 (delta 1224)
Receiving objects: 100% (2071/2071), 681.53 KiB, done.
Resolving deltas: 100% (1352/1352), done.

Without the session cookie:

[dbrown@spice-dev2 test]$ rm ~/.curlcookies 
[dbrown@spice-dev2 test]$ git clone https://sugwg-git.phy.syr.edu/git/qm
Cloning into qm...
warning: remote HEAD refers to nonexistent ref, unable to checkout.

> Thanks Duncan!

No problem.

Cheers,
Duncan.

> 
>> ---
>>  Documentation/config.txt |    8 ++++++++
>>  http.c                   |    5 +++++
>>  2 files changed, 13 insertions(+), 0 deletions(-)
> 
> Junio, I didn't test this myself, but the code looks good to me. I
> don't see any obvious issues with it.
> 
> -- 
> Shawn.
> 

-- 

Duncan Brown                          Room 263-1, Department of Physics,
Associate Professor of Physics        Syracuse University, NY 13244, USA
Phone: (315) 443 5993             http://www.gravity.phy.syr.edu/~duncan
