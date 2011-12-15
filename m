From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Branch names with slashes
Date: Thu, 15 Dec 2011 23:41:00 +0100
Message-ID: <4EEA777C.6040607@alum.mit.edu>
References: <CAGcUY13TOodu1BO3DCoNnVvNZ9QkWAbD-RmyqQX6P1q6tcO+yg@mail.gmail.com> <4EEA5B55.1040405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Leonardo Kim <dalinaum@gmail.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 23:41:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJzC-0002bK-RJ
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 23:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759622Ab1LOWlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 17:41:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:51284 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759605Ab1LOWlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 17:41:04 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.2.128] (p54BEA4CB.dip.t-dialin.net [84.190.164.203])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBFMf0BP018272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Dec 2011 23:41:01 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4EEA5B55.1040405@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187250>

On 12/15/2011 09:40 PM, Neal Kreitzinger wrote:
> On 12/14/2011 4:17 AM, Leonardo Kim wrote:
>> Branch names can contain slashes, so we can use 'development/foo' as
>> a branch name. If I choose 'development' as a branch name, it doesn't
>> work. There is a directory named development at '.git/refs/heads'
>> directory. So we cannot create a file named development for
>> 'refs/heads/development'.
>>
>> An error message may occurs like below. Unfortunately, It is not of
>> help to me. 'error: 'refs/heads/development/foo' exists; cannot
>> create 'refs/heads/development'.
>>
>> I think that dealing with a file system and an error message above is
>> not sufficient for a novice like me. I hope that it should be
>> improved.
>>
> FYI, We also use slashes in our branchnames to leverage some of the
> benefits of a path-like namespace like pattern matching and the logical
> expression of hierarchies using descriptive compound names. (We use git
> 1.7.1 on linux.) Here's something to keep in mind: You have to plan
> (think ahead) for your naming conventions so that the namespaces will
> maintain uniqueness at a peer level over time that cannot be confused as
> subdirs under .git/refs/heads. For example:
> 
> branchnames:
> /mysystem/generic
> /mysystem/generic/project1
> 
> will not work because /mysystem/generic appears to be a parent dir to
> /mysystem/generic/project1 under .git/refs/heads.  The solution is:
> 
> /mysystem/generic/base
> /mysystem/generic/project1
> 
> these branches can coexist because they are unique without one appearing
> to be a parent dir of the other.  IOW, their namespaces are peers in
> their entirety. To carry the example a little further,
> 
> /mysystem/generic/project1/part2
> will not work because once again it appears to be a subdir of an
> existing branchname (ref).  However,
> /mysystem/generic/project1-part2
> will work.
> 
> I think the reason for this is that if you look at .git/refs/heads you
> will see that these slash delimited branch names are actually stored as
> subdirs in the filesystem sense.  Therefore, git will get confused and
> error out as it tries to find branchnames that are not entirely unique
> by their full path namespace under .git/refs/heads because a branch
> namespace that is a prefix (in the filesystem sense) of another branch
> name would occupy the same path under .git/refs/heads without being
> distinguishable as unique, and vice versa.

Everything that you say is correct.  And it is known, at least to a few
git implementers (i.e., not a bug but a conscious design decision).  For
example, the function is_refname_available() is used explicitly to
prevent refnames that conflict in the way that you describe *even if*
the refnames in question are packed and therefore not 1:1 with
filesystem paths.  This is all a limitation of the fact that references
*can* be represented by files and therefore they inherit the filesystem
constraint that a file and subdirectory within a single parent directory
cannot have the same name.

I don't believe that it would be possible to relax this limitations
without at least a little breakage of backwards compatibility.

What is the bottom line?  Feel free to submit patches to improve the
documentation or error reporting.  But I doubt that the underlying
limitation will be removed.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
