From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH maint 0/3] do not write files outside of work-dir
Date: Wed, 01 Jun 2011 08:31:57 +0200
Message-ID: <4DE5DCDD.4020303@viscovery.net>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com> <20110601041439.GH29958@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	gitster@pobox.com, johannes.schindelin@gmx.de,
	Theo Niessink <theo@taletn.com>
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 08:32:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QReyS-0006XN-J3
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 08:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab1FAGcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 02:32:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49884 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab1FAGcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 02:32:06 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QReyD-0000wG-PB; Wed, 01 Jun 2011 08:32:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7E3DA1660F;
	Wed,  1 Jun 2011 08:31:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110601041439.GH29958@ece.pdx.edu>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174849>

Am 6/1/2011 6:14, schrieb Tait:
>> Theo Niessink has uncovered a serious sercurity issue in Git for Windows,
>> where cloning an evil repository can arbitrarily overwrite files outside
>> the repository...
> 
> Filenames starting with C: are not necessarily absolute. Consider
> "c:foo.txt" where c: is the current directory on drive C, or

We have a different notion of "absolute path". This one *is* absolute per
our definition. See below.

> "c:stream1" where c is a single-letter filename in the current directory
> with an alternate data stream such as would be shown by dir /r. The

On my system, this does not create a file in the current directory with an
alternate data stream, but - while the working directory is somewhere on
drive D - a file is created on drive C.

> has_dos_drive_prefix check is overly broad. Maybe this is intentional and
> just needs to be documented. Absolute paths like \\localhost\C$\file.txt
> and \\?\C:\file.txt do seem to be caught, because they start with '\'.
> 
> Microsoft says[1] a path is relative unless:
>   - it begins with "\\"
>   - it begins with a disk designator followed by a directory separator
>   - it begins with a single "\"
> 
> On that basis, has_dos_drive_prefix(path) should be:
>   isalpha(*(path)) && (path)[1] == ':' && is_dir_sep((path)[2])

This is not the definition of "relative path" that we are interested in.
Let $PWD be the current directory. For our purposes, a path $P is relative
if $P and $PWD/$P designate the same file system entry. Otherwise, $P is
an absolute path.

With this definition, the current has_dos_drive_prefix() is good enough.

> However, there are also paths within the NT namespace (as opposed to the
> Win32 namespace, [1] again) that might be considered absolute, or at least
> to which git should not try to write. Examples would be PRN, CONOUT$, AUX,

For our purposes, these names are all relative paths. It's a case of
"Doctor, it hurts when I stick my finger in my eye" if you have a
repository with these names.

Note that git never writes to these files: It always first allocates a
temporary file, eg. nul.123456; but this will already fail because these
special file names are forbidden even when a file extension is attached.

-- Hannes
