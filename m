X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 13:10:04 -0500
Message-ID: <A52817B6-0265-4164-8E5D-334AF92DC267@mac.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <457C1E8E.4080407@garzik.org> <elh91b$v6r$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 18:10:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <elh91b$v6r$1@sea.gmane.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-10_01:2006-12-08,2006-12-08,2006-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0611300000 definitions=main-0612100008
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33910>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtT7w-0000mU-Jj for gcvg-git@gmane.org; Sun, 10 Dec
 2006 19:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762307AbWLJSKM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 13:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762306AbWLJSKM
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 13:10:12 -0500
Received: from smtpout.mac.com ([17.250.248.172]:54041 "EHLO smtpout.mac.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762303AbWLJSKK
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 13:10:10 -0500
Received: from mac.com (smtpin01-en2 [10.13.10.146]) by smtpout.mac.com
 (Xserve/8.12.11/smtpout02/MantshX 4.0) with ESMTP id kBAIA9hn028090; Sun, 10
 Dec 2006 10:10:09 -0800 (PST)
Received: from [10.0.7.253] (hc6524e82.dhcp.vt.edu [198.82.78.130])
 (authenticated bits=0) by mac.com (Xserve/smtpin01/MantshX 4.0) with ESMTP id
 kBAIA5HN016478 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
 Sun, 10 Dec 2006 10:10:07 -0800 (PST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Dec 10, 2006, at 10:30:00, Jakub Narebski wrote:
> Jeff Garzik wrote:
>> I actively use git to version, store and distribute an exim mail  
>> configuration across six servers.  So far my solution has been a  
>> 'fix perms' script, or using the file perm checking capabilities  
>> of cfengine.
>
> Fix perms' script used on a checkout hook is a best idea I think.

Hmm, unfortunately that has problems with security-related race  
conditions when used directly for /etc.  Think about what happens  
with "/etc/shadow" in that case, for example.  (/etc/.git is of  
course 0700)  I'm sure there are others where non-root daemons get  
unhappy when they get an inotify event and their config files have  
suddenly become root:root:0600.  I also want to be able to "cd /etc  
&& git status" to see what changed after running "apt-get update" or  
maybe fiddling in SWAT or webmin, so a makefile which installs into / 
etc won't quite solve it either.  It would also be nice to see when  
things change the permissions on files in /etc, or even bind-mount an  
append-only volume over /etc/.git/objects to provide additional data  
security.

>> But it would be a lot better if git natively cared about ownership  
>> and  permissions (presumably via an option).
>
> There is currently no place for ownership and extended attributes  
> in the tree object; and even full POSIX permissions might be  
> challenge because for example currently unused 'is socket'  
> permission bit is used for experimental commit-in-tree submodule  
> support.

What about doing something crazy like "is socket" && "is directory"  
&& "is symlink"?  Or something else that old GIT versions would  
ignore and new GIT versions could do something useful with?  Perhaps  
like I mentioned in an earlier email, the new data could be stored as  
part of a modified "file" object.  Alternatively could a directory  
have a file named with an empty string with bogus mode bits which  
points to an extended-attributes-tree object?

> And given Linus stance that git is "content tracker"...

Extended attributes are content too!  This includes things like  
icons, security labels (Think unclassified/confidential/secret/top- 
secret/etc), ACLs, summaries, and other metadata.  Content tracker  
purists could also just ignore the new default-off config options and  
be perfectly happy with status-quo. :-D

> In the loooong thread "VCS comparison table" there was some talk  
> about using git (or any SCM) to manage /etc. Check out:
>
>  * Message-ID: <Pine.LNX.4.64.0610220926170.3962@g5.osdl.org>
>    http://permalink.gmane.org/gmane.comp.version-control.git/29765
>  * Message-ID: <20061023051932.GA8625@evofed.localdomain>
>    http://marc.theaimsgroup.com/? 
> i=<20061023051932.GA8625@evofed.localdomain>
>
> (and other messages in this subthread).

I have, and while it's interesting material that thread produced no  
real patches :-D.  I'd like to introduce some new config options to  
control the new code: "preserve_full_perms", "preserve_posix_acls",  
"preserve_security_labels", and "preserve_user_xattrs" which default  
to false but when set modify GIT's behavior to store, retrieve, and  
compare additional data.

If you have any suggestions on how to store the data such that old  
GIT ignores it I'm all ears :-D.

Cheers,
Kyle Moffett
