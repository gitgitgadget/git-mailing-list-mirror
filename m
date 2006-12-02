X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: On removing files and "git-rm is pointless"
Date: Sat, 2 Dec 2006 09:37:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
References: <87odqm2ppv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 17:37:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87odqm2ppv.wl%cworth@cworth.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33030>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqYnZ-000582-Lk for gcvg-git@gmane.org; Sat, 02 Dec
 2006 18:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424234AbWLBRhK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 12:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424267AbWLBRhK
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 12:37:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:64393 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1424234AbWLBRhI (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 12:37:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2Hb3jQ014463
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 09:37:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2Hb3DC024401; Sat, 2 Dec
 2006 09:37:03 -0800
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Carl Worth wrote:
>
> Some people have recently asked questions about why we even have a
> "git rm" command since it seems so pointless if you understand git's
> model and "commit -a" well enough.

I have to admit that I'm not a big fan of "git rm".

I'd like it more if it defaulted to actually removing the file, preferably 
refusing to with an error message if the file didn't match the index. And 
then use "git rm -f" to force-remove a dirty file.

As it is, because I just find "git rm" to be annoying, I simply do what 
you talk about:

> 	rm file
> 	git commit -a

Works fine for me, and is more natural than "git rm" at least in my mind.

> Is our new documentation going to lead users to discover this great
> feature?

I definitely wouldn't object at all. The _best_ of both worlds would be 
to:

 - document how git will detect changes to files it knows about 
   (_including_ removal) automatically with "git commit -a", and make it 
   clear that "git rm" thus isn't really needed.

 - but because it makes sense to have the mirror symmetry of "git add" and 
   "git rm", and because people expect to be able to do "git rm" from 
   other systems anyway, just keep the command around, and possibly make 
   the default behaviour a bit more obvious.

On "git rm", I'd suggest:

 - with no flags: remove the working file too, but _only_ if it matches 
   the index. NOTE! This is a change in semantics, but damn, if people 
   have found "git add" hard to understand, I think "git rm" is much 
   worse, and doesn't even match "git mv" (whcih _does_ move the working 
   file, and doesn't just do a in-index move)

 - with "-f": do what "git rm -f" does now. Just force the thing. Don't 
   care whether the file is dirty in the working tree or whether it even 
   exists in the index. Just get rid of it already, both in the index 
   (regardless of state or whether it is there at all) _and_ in the 
   working tree (again, regardless of state)

One thing to look out for: "git rm" actually defaults to the recursive 
behaviour, something that might take people by surprise. If you give it a 
directory name, it will happily delete all tracked files from within that 
directory, even without "-r". That is probably a design mistake. So it 
would probably make sense to:

 - without "-r", don't do the partial matches at the beginning (but still 
   do globbing matches, of course, so "git rm dir/*" wouldn't need an 
   "-r", but "git rm -r dir/", which does the same thing, _would_ need an 
   "-r" to be effective)

Final note: arguably, the current "git rm" is a better mirror image of 
"git add" than what I suggest above. "git add" doesn't actually create the 
working file (you had to do that yourself), so you _could_ argue that "git 
rm" as it stands now is closer to the "reverse" of git add. The same is 
true of the recursive behaviour.

However, I'd argue that:

 - "rm" isn't the reverse of "add" in the first place. If we had a "git 
   subtract" file, _that_ would be the reverse of "git add" ;)

 - "rm" isn't the reverse of "add" in another sense: "rm" is just more 
   dangerous. So not having the mirror-image semantics makes sense simply 
   becaue the dangerousness of the commands aren't mirror images.

Anyway, I don't personally much care. As mentioned, I'll happily just 
remove the file and do "git commit -a" instead (or, indeed, if I want to 
play with the index, I'm perfectly comfy just doing "git update-index" 
with "--force-remove" or something - but clearly I'm more confy with the 
index and it's strangly named commands than most ;^).

