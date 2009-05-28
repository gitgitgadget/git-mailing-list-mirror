From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git-svn clone problem
Date: Thu, 28 May 2009 10:22:07 -0700
Message-ID: <20090528172207.GB315@mail.oracle.com>
References: <20090527221601.GA12914@mail.oracle.com> <86d4c5e00905271911g58cccc1bwd4b881541db6f7a5@mail.gmail.com> <20090528024153.GH12914@mail.oracle.com> <op.uumqk2gt1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 28 19:22:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9jJB-0004iF-3e
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 19:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZE1RWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 13:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbZE1RWG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 13:22:06 -0400
Received: from acsinet12.oracle.com ([141.146.126.234]:41627 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZE1RWF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 13:22:05 -0400
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by acsinet12.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4SHLjfa032088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 28 May 2009 17:21:47 GMT
Received: from acsmt353.oracle.com (acsmt353.oracle.com [141.146.40.153])
	by acsinet15.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4SDwehT017799;
	Thu, 28 May 2009 17:22:48 GMT
Received: from ca-server1.us.oracle.com by acsmt357.oracle.com
	with ESMTP id 17370562911243531313; Thu, 28 May 2009 12:21:53 -0500
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.69)
	(envelope-from <joel.becker@oracle.com>)
	id 1M9jIe-0004Z3-SV; Thu, 28 May 2009 10:21:52 -0700
Content-Disposition: inline
In-Reply-To: <op.uumqk2gt1e62zd@merlin.emma.line.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Source-IP: acsmt353.oracle.com [141.146.40.153]
X-Auth-Type: Internal IP
X-CT-RefId: str=0001.0A01020A.4A1EC839.0230:SCFMA4539814,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120200>

On Thu, May 28, 2009 at 09:47:16AM +0200, Matthias Andree wrote:
> Am 28.05.2009, 04:41 Uhr, schrieb Joel Becker <Joel.Becker@oracle.com>:
>
>> On Wed, May 27, 2009 at 07:11:01PM -0700, Deskin Miller wrote:
>>> The problem here isn't with git-svn; rather, it is with the svn
>>> repository at oss.oracle.com claiming a nonsensical UUID.  svn uses
>>> UUIDs behind the scenes to identify each repository, and git-svn does
>>> the same thing.  When doing git svn init (or clone, which is just init
>>> && fetch) the svn server sends back a UUID which identifies it.  When
>>> I use wireshark and expand the first HTTP packet back from a good svn
>>> server, I see something like the following embedded in the xml tree:
>>>
>>> <lp3:repository-uuid>
>>> 612f8ebc-c883-4be0-9ee0-a4e9ef946e3a
>>> </lp3:repository-uuid>
>>>
>>> However when I do the same with oss.oracle.com I see
>>>
>>> <lp2:repository-uuid>
>>> ????????-????-????-????-????????????
>>> </lp2:repository-uuid>
>>>
>>> git-svn tries to play along for a while, but the bottom line is that a
>>> string of question marks isn't a UUID.
>>>
>>> There's more about svn's use of UUIDs in the svn book.  Perhaps the
>>> admin of oss.oracle.com can correct this UUID problem so one can use
>>> git-svn with this repository.
>>
>> 	Is this some new feature of svn that git-svn has decided to
>> require?  We're running subversion 1.4.4 there, and git-svn used to work
>> against those repos.
>> 	Hmm, it's only a couple of very old repos with this problem -
>> they were probably created with subversion 1.1 or 1.0.  I found how to
>> fix it.  Thanks.
>
> Hi Joel,
>
> could you share a pointer to or outline of the solution with the list, 
> for the completeness of the (searchable) archives?

	Sure.  I went to the svn book, this part:

http://chestofbooks.com/computers/revision-control/subversion-svn/Managing-Repository-UUIDs-Reposadmin-Maint-Uuids.html

	My server's running 1.4.4, so the 1.5 command 'svnadmin setuuid
/var/svn/repos' will not work.  Instead I used the second method.  I
created a shell function to generate the uuid:

  uu() {
      echo SVN-fs-dump-format-version: 2;
      echo;
      echo -n "UUID: ";
      uuidgen;
  }

I then used that with the second method to update my repositories:

  # uu | svnadmin load --force-uuid /var/svn/repos

Obviously I replaced '/var/svn/repos' with my own repository paths.
	It's nice that Subversion uses standard UUIDs.  It works
directly with  uuidgen.

Joel

-- 

"The lawgiver, of all beings, most owes the law allegiance.  He of all
 men should behave as though the law compelled him.  But it is the
 universal weakness of mankind that what we are given to administer we
 presently imagine we own."
        - H.G. Wells

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
