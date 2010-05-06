From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Multiblobs
Date: Fri, 07 May 2010 00:56:59 +0200
Message-ID: <4BE3493B.8010409@gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <20100506062644.GB16151@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 07 00:57:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAA0I-00073c-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab0EFW5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:57:08 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37411 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab0EFW5H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:57:07 -0400
Received: by wwb39 with SMTP id 39so407579wwb.19
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=UsjgW8lSJXbTVXfqpXCgkevOGRcFHCuqO3zL6CCi7i4=;
        b=AtkXfL6eYviABXxEeM0b8aEYCcHJLQZo4l8iZmn23b4scThVf1oLptxeSxLfHMBs1Z
         6cD53vjWnnii5cD0gUgtzkYvLzG5w2D0GFKPoJe9+fF/2MID+wlXnG8towQbFcAAE7Z7
         UyswmzlGy3io+wcQTUXAt6/5rHPoPC4waQgcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ePI6+iQ1OqDPXvaqKTakVEJn3qENqwJjkT2VxLTbSOxaKZiwLaSvvjBks0hOLizX32
         HToAw2BPaiGFQPE/RidUmhcD2wtvZ4Wcva3HXW/1/SnjttiYtCB25PvtmXToGnB0nfhE
         sixVKvzalmSU1weyDTTbjIq3o6CyO5Jwf+ENk=
Received: by 10.227.141.200 with SMTP id n8mr5195284wbu.200.1273186625569;
        Thu, 06 May 2010 15:57:05 -0700 (PDT)
Received: from [109.54.0.56] ([109.54.0.56])
        by mx.google.com with ESMTPS id u8sm10636255wbc.17.2010.05.06.15.57.02
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 15:57:04 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <20100506062644.GB16151@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147510>

Many thanks for the clear and evidently very well thought answer.
I wonder if I can take another minute of your (and Avery, and anybody 
else who is interested) time to feed a little more my curiosity.
And I apologize in advance for possible mistakes in my understanding of 
git internals.

Jeff King wrote:

> And for both of those cases, the upside is a speed increase, but the
> downside is a breakage of the user-visible git model (i.e., blobs get
> different sha1's depending on how they've been split).
Is this different from what happens with clean/smudge filters? I wonder 
what hash does a cleanable object get. The hash of its cleaned version 
or its original hash? If it is the first case, the hash can change if 
the filter is used/not-used or slightly modified, so I wonder if an 
enhanced "clean" filter capable of splitting an object into a multiblob 
would be different in this sense. If it gets the original hash, again I 
wonder if an enhanced "clean" filter capable of splitting an object into 
a multiblob could not do the same.
>  But being two
> years wiser than when I wrote the original message, I don't think that
> breakage is justified. Instead, you should retain the simple git object
> model, and consider on-the-fly content-specific splits. In other words,
> at rename (or delta) time notice that blob 123abc is a PDF, and that it
> can be intelligently split into several chunks, and then look for other
> files which share chunks with it. As a bonus, this sort of scheme is
> very easy to cache, just as textconv is. You cache the smart-split of
> the blob, which is immutable for some blob/split-scheme combination. And
> then you can even do rename detection on large blob 123abc without even
> retrieving it from storage.
>   
Now I see why for things like diffing, showing textual representations 
or rename detection caching can be much more practical.
My initial list of "potential applications" was definitely too wide and 
vague.
> Another benefit is that you still _store_ the original (you just don't
> look at it as often). 
... but of course if you keep storing the original, I guess there is no 
advantage in storage efficiency.
> Which means there is no annoyance with perfectly
> reconstructing a file. I had originally envisioned straight splitting,
> with concatenation as the reverse operation. But I have seen things like
> zip and tar files mentioned in this thread. They are quite challenging,
> because it is difficult to reproduce them byte-for-byte.
I agree, but this is already being done. For instance on odf and zip 
files, by using clean filters capable of removing compression you can 
greatly improve the storage efficiency of the delta machinery included 
in git. And of course, to re-create the original file is potentially 
challenging. But most time, it does not really matter. For instance, 
when I use this technique with odf files, I do not need to care if the 
smudge filter recreates the original file or not, the important thing is 
that it recreates a file that can then be cleaned to the same thing (and 
this makes me think that cleanable objects get the sha1 of the cleaned 
blob, see above).

In other terms, all the time we underline that git is about tracking 
/content/. However, when you have a structured file, and you want to 
track its /content/, most time you are not interested at all at the 
/envelope/ (e.g. the compression level of the odf/zip file): the content 
is what is inside (typically a tree-structured thing). And maybe scms 
could be made better at tracking structured files, by providing an easy 
way to tell the scm how to discard the envelope.

In fact, having the hash of the structured file only depend on its real 
content (the inner tree or list of files/streams/whatever), seems to me 
to be completely respectful of the git model. This is why I originally 
thought that having enhanced filters enabling the storage of the the 
inner matter of a structured file as a multiblob could make sense.
> The other application I saw in this thread is structured files where you
> actually _want_ to see all of the innards as individual files (e.g.,
> being able to do "git show HEAD:foo.zip/file.txt"). And for those, I
> don't think any sort of automated chunking is really desirable. If you
> want git to store and process those files individually, then you should
> provide them to git individually. In other words, there is no need for
> git to know or care at all that "foo.zip" exists, but you should simply
> feed it a directory containing the files. The right place to do that
> conversion is either totally outside of git, or at the edges of git
> (i.e., git-add and when git places the file in the repository).
Originally, I thought of creating wrappers for some git commands. 
However, things like "status" or "commit -a" appeared to me quite 
complicated to be done in a wrapper.
>  Our
> current hooks may not be sufficient, but that means those hooks should
> be improved, which to me is much more favorable than a scheme that
> alters the core of the git data model.
>   
Having a sufficient number of hooks could help a lot. However, if I 
remember properly, one of the reasons why the clean/smudge filters were 
introduced was to avoid the need to implement a similar functionality 
with hooks.


Thanks in advance for the further explanations that might come!

Sergio
