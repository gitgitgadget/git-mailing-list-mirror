From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH] git-completion.bash: add support for path completion
Date: Mon, 17 Dec 2012 12:17:14 +0100
Message-ID: <50CEFF3A.4050802@gmail.com>
References: <1355693080-4765-1-git-send-email-manlio.perillo@gmail.com> <7vy5gxnuy1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 12:17:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkYhf-0005Vc-2V
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 12:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab2LQLR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 06:17:29 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:43934 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab2LQLR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 06:17:29 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1896966wib.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 03:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=LBGman7RXiFxRDZWG0lt6NYauOmZ5NFAvfxvNUPEhhw=;
        b=ujDABcVZr/V1jkZWNdr8eotSiH2+emc8UQ0rmt85tTwCcZwRqBnxSjcgjUwutcrtPt
         G26SdNs0g+ppHzzN6CBH9BWIRyv7wP3H4VGnqjJ74puV/o+j7pHitg7p3unwsprpOeBg
         y2g/+1yEDPffm2KnKkaB4lWonT6LdSqRVurablUvKSYJgz0SNqArgPUq+fOoR/S1UFV1
         liMBfDEmbb8ISPcx769BIZNhzHJQ6Ewx9Zq7NTEiQTZvbZs0rz1OXnSQxC1LZFRjxRRO
         1jYvJtMR0q4kenYwK2Xi1dIvhuaiBK73IIf4INfSRTPW40jC8BLKuOL1QO4S0iRWtUCx
         pWtQ==
X-Received: by 10.180.86.39 with SMTP id m7mr15026539wiz.1.1355743047637;
        Mon, 17 Dec 2012 03:17:27 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id df2sm1464919wib.0.2012.12.17.03.17.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Dec 2012 03:17:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vy5gxnuy1.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211673>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 17/12/2012 05:50, Junio C Hamano ha scritto:
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> The git-completion.bash script did not implemented full support for
>> completion, for git commands that operate on files from the current
>> working directory or the index.
>>
>> For these commands, only options completion was available.
> 
> Hrm, "git mv CO<TAB>" completes it to "COPYING" for me.  Same for:
> 
>     git rm CO<TAB>
>     git clean Doc<TAB>
>     git commit --edit Doc<TAB>
> 
> There must be something missing from the above description, and the
> claim the above two paragraphs make does no make sense without that
> something that is missing.
> 

Thanks.

What is missing is that I forgot to explain that by "completion not
supported" I meant "*git aware* completion is not supported".

If you try, as an example, "git add <TAB>", bash will suggest *all*
files in your working directory, including ignored files and files with
no modifications.


>> * the path completion for the "git mv" and "git rm" commands is provided
>>   using "git ls-files --exclude-standard"
> 
> Does the above mean "git mv COPYING Doc<TAB>" would complete the
> command line to move it to Documentation/ directory?  
> 

It will suggest all tracked files from the Documentation directory.
One important detail is that it will recurse into sub directories.

This is not the behaviour of the current completion code.
The problem is that current code use ls-tree, and works only for paths
like <rev>:<path>.

My implementation use ls-files, that has a completly different interface
from ls-tree (and since I'm very new to git, this caused be some confusion).

It seems that with ls-files it is impossible to:

* get a list of path names without recursing into sub directories.
  (this is only possible for untracked directories)

* get the file mode for all "modified" or "deleted" files.

  If I do "git ls-files --stage --modified", git ignores the modified
  option and will list all files

> I think "using X" is of secondary importance.  Reviewers and future
> developers (who are reading "git log" output) can read it from the
> patch.  What is expected in the log message is why the implemenation
> was chosen, and in order to achieve what effect.
> 

Ok, thanks.

> 
>> * the path completion for the "git clean" command is provided using
>>   "git ls-files --exclude-standard -o"
>>
>> * the path completion for the "git commit" command is provides using
>>   "git diff-index --name-only HEAD"
> 
> As long as all of the above stops completion at directory boundary,
> I think the above sounds like a sensible thing to do.  e.g. when
> "ls-files" gives Documentation/Makefile and Documentation/git.txt,
> "git cmd Doc<TAB>" first would give "git cmd Documentation/" and
> then the second <TAB> would offer these two paths as choices.  That
> way, the user can choose to just execute "git cmd Documentation/"
> without even looking at these individual paths.
> 

Right, this is what bash usually do.
However I don't know how to implement this with git.

> I am not sure how you would handle the last parameter to "git mv",
> though.  That is by definition a path that does not exist,
> i.e. cannot be completed.
> 

Right, the code should be changed.
No completion should be done for the second parameter.



Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDO/zoACgkQscQJ24LbaUSD1ACfXeH2GizdNG/uzlSneEpdi1Na
6IoAni3ZrhhCMXbVoTqIVjH4mEX/XmaH
=w56v
-----END PGP SIGNATURE-----
