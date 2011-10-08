From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How pretty is pretty? git cat-file -p inconsistency
Date: Sat, 8 Oct 2011 18:36:32 +0200
Message-ID: <201110081836.33941.jnareb@gmail.com>
References: <4E8EBC00.90909@drmicha.warpmail.net> <m3r52o1hxr.fsf@localhost.localdomain> <4E906292.1020909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-4"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Oct 08 18:36:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCZtM-0008BP-8Y
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 18:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852Ab1JHQgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 12:36:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34748 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab1JHQgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 12:36:42 -0400
Received: by bkbzt4 with SMTP id zt4so6250416bkb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=lSDSZuFnm8WSszrx5T7G4k1ISALahWWeJjpzh72Ivp8=;
        b=vxRUYI2UhwsWySp3QZJaWp9Lm6we0DX1Qyn0ghW59asddRc3/aVI/xn553R19X8GKv
         nO4ANzWZfmARJwukb/FZohKEcoHz52e3obAJVl2bXdcaL8Fi6Qpedw21mUyzUgpa1/n7
         fzqFn84Dmb5V3c5JFdHuQ+7iMLQaHRB4EvuUM=
Received: by 10.204.6.206 with SMTP id a14mr1552468bka.38.1318091800951;
        Sat, 08 Oct 2011 09:36:40 -0700 (PDT)
Received: from [192.168.1.13] (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id x4sm4711907fad.1.2011.10.08.09.36.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 09:36:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4E906292.1020909@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183154>

On Sat, 8 Oct 2011, Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 08.10.2011 01:50:

> > Tree object consist of zero or more entries.  Each item consist of mode,
> > filename, and sha1:
> > 
> >   <mode> SPC <filename> NUL <sha1>
> > 
> > where
> > 
> > 1. <mode> is variable-length (!) text (!) containing mode of an
> >    entry. It encodes type of entry: if it is blob (including special
> >    case: symbolic link), tree i.e. directory, or a commit
> >    i.e. submodule.  Does not include leading zeros.
> > 
> > 2. <filename> is variable-length null-terminated ("\0") name of a file
> >    or directory, or name of directory where submodule is attached
> > 
> > 3. <sha1> is 40-bytes _binary_ identifier.
> > 
> > HTH
> 
> It does help, thanks.
> 
> Though I'm beginning to think we have a crazy object format. Not only do
> we have a lot of indirections (like ascii representation of decimal
> representation of length), but we store sha1 as ascii in commit and tag
> objects and as binary in tree objects. Which makes tree objects the only
> unpleasant ones to look at (and parse) in raw form. (I was hoping we can
> dispose of/deprecate cat-file -p in favor of show). Oh well.

Well, actually we have pretty consistent format, i.e. we use textual
format everywhere (textual size of blob instead of some variable-length
integer, textual name of type of object instead of a byte for it, epoch
as a text and not 64bit signed int in some network format, hexadecimal sha1,
space separated (sub)fields)... 

... with the sole exception of tree object, which uses _binary_ sha1.
What was Linus thinking?!?

To have consistency the tree entry should IMVHO look like this

  <textual mode> SPC <filename> NUL <hexadecimal sha1> LF


Nb. with hexadecimal sha-1 everywhere it would be I think possible (if very
very difficult) to move to different hash function: SHA-256, Skein, etc.
I don't know if it is now at all possible...

-- 
Jakub Narebski
Poland
