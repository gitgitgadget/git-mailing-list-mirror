From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [RFH] Git and filesystem ACLs: problem with 'git gc'
Date: Tue, 12 Jan 2010 14:57:10 +0100
Message-ID: <vpqy6k38lzd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 15:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUhI7-0008JL-JC
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 15:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab0ALOAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 09:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264Ab0ALOAJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 09:00:09 -0500
Received: from imag.imag.fr ([129.88.30.1]:47839 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab0ALOAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 09:00:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o0CDvAEi006028
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jan 2010 14:57:12 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NUhF8-0003G0-Eb; Tue, 12 Jan 2010 14:57:10 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 12 Jan 2010 14:57:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136720>

Hi,

I tried setting up a Git repository restricting the access using the
filesystem's ACL. In short: It almost works, but pack creation break
it. I'm looking for help to fix it.

The setup is: my user is "moy", my $HOME is rwx------ and my umask is
077 (i.e. by default, I don't share anything). I want to authorize a
user "foo" to access my repository:

cd ~/test/
git init testacl
setfacl -Rm u:foo:rwx '/home/moy/test/testacl'
setfacl -Rm d:u:foo:rwx '/home/moy/test/testacl'
setfacl -Rm d:u:moy:rwx '/home/moy/test/testacl'
setfacl -m u:foo:x '/home/moy/test'
setfacl -m u:foo:x '/home/moy'

With this setup, I can create new files, and the user foo can do the
same, the ACLs give permission to each other. Object creation (git
add, git commit) work:

$ getfacl .git/objects/3c/7a37f109f8e7f7b9f8b64833ea331fa9b047f5 
# file: .git/objects/3c/7a37f109f8e7f7b9f8b64833ea331fa9b047f5
# owner: moy
# group: perms
user::r--
user:moy:rwx
user:foo:rwx
group::---
mask::rwx
other::r--

but when pack files are created by a user, the file is not readable by
the other:

$ getfacl .git/objects/pack/pack-cf224e8b0da92fd72fbea8f101912db4835445d1.pack 
# file: .git/objects/pack/pack-cf224e8b0da92fd72fbea8f101912db4835445d1.pack
# owner: moy
# group: perms
user::r--
user:moy:rwx			#effective:---
user:len:rwx			#effective:---
group::---
mask::---
other::---

$ ls -l .git/objects/pack/pack-cf224e8b0da92fd72fbea8f101912db4835445d1.pack 
-r--------+ 1 moy perms 468 Jan 12 13:18 .git/objects/pack/pack-cf224e8b0da92fd72fbea8f101912db4835445d1.pack

My interpretation of the problem is that Git tried to remove the
permission for group (~ chmod g-rwx) on the pack file, and as an
undesirable side effect, setting the group permissions also sets the
ACL mask, and prevents other users from accessing it, even though they
have a user-ACL.

A workaround for this is to set core.sharedrepository to 'group', but
since object creation just works, I guess the pack creation should
just work too, with or without core.sharedrepository ...

I investigated a bit, and the problem seems to come from mkstemp,
which is used by write_pack_file to create the temporary file: files
created by mkstemp get an ACL umask of ---.

Is it really a good idea to use mkstemp? We're inside
.git/object/pack, for which the user is supposed to have already set
correct permissions, so shouldn't we just create a random file name
and then use a plain open(...) to create the file, leaving the umask
do its job to control the permissions?

Thanks,

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
