From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFH] Git and filesystem ACLs: problem with 'git gc'
Date: Wed, 13 Jan 2010 15:56:58 +0100
Message-ID: <vpqeiludpdx.fsf@bauges.imag.fr>
References: <vpqy6k38lzd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 16:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV4ix-0001R5-Oa
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 16:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139Ab0AMPB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 10:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137Ab0AMPB0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 10:01:26 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38604 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab0AMPBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 10:01:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o0DEubah012754
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Jan 2010 15:56:38 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NV4eY-0004jH-KP; Wed, 13 Jan 2010 15:56:58 +0100
In-Reply-To: <vpqy6k38lzd.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue\, 12 Jan 2010 14\:57\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Jan 2010 15:56:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0DEubah012754
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1263999606.71924@OiE68xbt03kTIOCL/N/5cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136828>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I investigated a bit, and the problem seems to come from mkstemp,
> which is used by write_pack_file to create the temporary file: files
> created by mkstemp get an ACL umask of ---.
>
> Is it really a good idea to use mkstemp? We're inside
> .git/object/pack, for which the user is supposed to have already set
> correct permissions, so shouldn't we just create a random file name
> and then use a plain open(...) to create the file, leaving the umask
> do its job to control the permissions?

Digging a bit further, I noticed that _object_ creation was doing a

  set_shared_perm(filename, (S_IFREG|0444))

thus ignoring the umask, and setting r--r--r-- for all objects, while
_pack_ creation does roughly (in write_pack_file()) :

  mode_t mode = umask(0);
  mode = 0444 & ~mode;
  adjust_perm(pack_tmp_name, mode)

Thus setting the permissions to r--X--X-- where X is defined by the
umask. Is there any reason for this difference? I'd say we can rely on
the containing directory's permissions, and do for pack what Git
already does for objects.

[ On a side note, I don't understand what the S_IFREG is doing in the
call to set_shared_perm. It's passed to chmod, while S_IFREG is only
documented in the manpage for stat() ... ]

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
