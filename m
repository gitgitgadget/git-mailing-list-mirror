From: =?UTF-8?Q?Daniel_H=C3=B6pfl?= <daniel@hoepfl.de>
Subject: [Bug] Permissions of temp file created in git's =?UTF-8?Q?sha=31=5Ffile?=
 =?UTF-8?Q?=2Ec=20correct=3F?=
Date: Wed, 02 Feb 2011 13:15:18 +0100
Message-ID: <5dfd4de157546244c86acd52564247ce@kloeckner.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 13:25:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkbmL-0003at-Pz
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 13:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1BBMZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 07:25:37 -0500
Received: from black.doesntexist.org ([78.46.104.147]:34603 "EHLO
	black.doesntexist.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab1BBMZh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 07:25:37 -0500
X-Greylist: delayed 616 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Feb 2011 07:25:36 EST
Received: by black.doesntexist.org (Postfix, from userid 5001)
	id AFFF01E486B1; Wed,  2 Feb 2011 13:15:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	black.doesntexist.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=ALL_TRUSTED,BAYES_50
	autolearn=ham version=3.2.5
Received: from kloeckner.org (localhost [127.0.0.1])
	by black.doesntexist.org (Postfix) with ESMTPSA id 275BA1E4816E;
	Wed,  2 Feb 2011 13:15:18 +0100 (CET)
X-Sender: daniel@hoepfl.de
User-Agent: RoundCube Webmail/0.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165905>

Hello,

I recently (very recently: yesterday) started using git. I switched from
Bazaar, that required me to have a file system that supports the executable
flag (as it always stores this flag based on what the file system says).
FAT does not support the executable flag.

To make a long story short: I modified Apple's FAT kernel extension to
support both, executable and the writable flag. With this file system, I
was not able to push a change to the repository that is stored on a volume
using the file system. I tracked the problem down to one changeset:
<http://git.kernel.org/?p=git/git.git;a=commit;h=5256b006312e4d06e11b49a8b128e9e550e54f31>
introduces the line "fd = git_mkstemp_mode(buffer, 0444);" in sha1_file.c.

This line creates a temporary file that has reading rights for everyone but
no writing rights. I was astonished that it is possible to actually write
to a file you do not have write permission on. My file system driver does
not allow any change on read-only files except changing rights. Especially
it refuses to rename or delete the file. Both is tried some lines after the
file creation (move_temp_to_file, called when returning from
write_loose_object), resulting in an error that aborts the push.

I think that my file system is right (of course ;-) ): A file that is not
writable must not be renamed (arguable as the name could be seen as the
content of the containing directory) and it must not be deleted.

Do anyone agree? If so, my suggestion is to replace both occurrences of
"0444" in sha1_file.c by "0644" (or better
"S_IRUSR|S_IWUSR|S_IWGRP|S_IWOTH", or even "0600"/"S_IRUSR|S_IWUSR"). The
changed rights are changed at the end of move_temp_to_file anyways and
allowing the owner to write to the file is probably not a security issue.

Bye,
   Daniel
