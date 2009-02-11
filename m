From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Add automatic git-mergetool invocation to the new 
	infrastructure
Date: Wed, 11 Feb 2009 10:48:00 +0000
Message-ID: <b0943d9e0902110248n7aa14743p19079e3d967f77a9@mail.gmail.com>
References: <20090210141157.28782.10027.stgit@pc1117.cambridge.arm.com>
	 <20090211092028.GC26136@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXCey-0004mz-35
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbZBKKsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 05:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbZBKKsG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:48:06 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:52250 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895AbZBKKsD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 05:48:03 -0500
Received: by bwz5 with SMTP id 5so172210bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 02:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2wnhC1Gz+/fDTsKrR93tyqi8nMMrWmTDIreSWfbksXQ=;
        b=nNQhTAx/YEyUjkSZzMPeq82emff47u6pg+ZiNWV1en4PTarj0GVYSmpmZpGv//4onU
         FL5VsDuyLz04Kw9k6TRhebP3g9opMLrkAyP3EplyT+xN/JBTIUfapFDWAWViCPNsaSnG
         DJ1DnYTvAyKNG+lQ+DZqNXoycI9oiUNhPyZok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bR61JcPJIN95pMWagJWwk8g8JsNDDc0UPTyoQoKgpxTE4tPvSNL2bj2NNO7/7CmpZJ
         xcyVHI/uLhmI3YhBrYKGpecLiMNaS89SQ2i3gS9RaCXHXQ7ch2YVVw6qAMdrpSF8cQ8a
         ILVF0BjDFegqaZ4mR1KVc/mpx/xEoD6f/v7H0=
Received: by 10.223.113.195 with SMTP id b3mr1935188faq.79.1234349281178; Wed, 
	11 Feb 2009 02:48:01 -0800 (PST)
In-Reply-To: <20090211092028.GC26136@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109401>

2009/2/11 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-02-10 14:14:07 +0000, Catalin Marinas wrote:
>> I'm still not entirely sure where the check for stgit.autoimerge
>> should be done. In the classic infrastructure, it is done in the
>> merge function. With this patch, it is done in Transaction.push().
>> Should we push this even further to stgit.commands.push? My opinion
>> is not since by having it in Transaction we get the advantage not
>> listing the conflicts if the mergetool succeeds and we don't need to
>> abort the transaction.
>
> Yes, one advantage of having it here is that if the user resolves the
> conflict, we can just continue. I'm not sure I personally like that
> mode of operation -- you might have guessed by now that I like
> noninteractive mechanisms -- but I can see how it's useful to someone
> who does.

I find it useful when I prepare a kernel release and pick patches from
many branches, it saves some typing with having to run the mergetool
and restart the pick or push command. It's also useful for "sync".

> Another advantage of having it here is that it automatically just
> works for all commands, not just "stg push".

It works for commands that use Transaction.push_patch(). Other
commands that use IndexAndWorktree.merge() via some other function
would not work. Will there be such functions? I suspect a "sync"
implementation would need additional support in Transaction.

Any thoughts on calling mergetool from IndexAndWorktree.merge() (with
an additional parameter to explicitly enable this rather than just
reading the config option)?

> The disadvantage that I see is that we ask the user to put work into
> resolving conflicts before we've made sure that we won't roll back th=
e
> whole transaction. If this is to become a dependable feature, we need
> a way to make sure we'll never throw away the user's work.

Maybe push_patch() can receive a parameter on whether to invoke
mergetool. The calling code should know the behaviour for aborting
transactions and only ask for interactivity if the command is expected
to leave conflicts in the index.

>> --- a/stgit/lib/git.py
>> +++ b/stgit/lib/git.py
>> @@ -842,6 +842,12 @@ class IndexAndWorktree(RunWithEnvCwd):
>>                  raise MergeConflictException(conflicts)
>>          except run.RunException, e:
>>              raise MergeException('Index/worktree dirty')
>> +    def mergetool(self, files =3D []):
>> +        """Invoke 'git mergetool' on the current IndexAndWorktree t=
o resolve
>> +        any outstanding conflicts."""
>> +        err =3D os.system('git mergetool %s' % ' '.join(files))
>> +        if err:
>> +            raise MergeException('"git mergetool" failed, exit code=
: %d' % err)
>>      def changed_files(self, tree, pathlimits =3D []):
>>          """Return the set of files in the worktree that have change=
d with
>>          respect to C{tree}. The listing is optionally restricted to
>
> This is the right place for this method. But what happens if "files"
> isn't specified -- do we operate on all files then? The method
> documentation should probably say this.

Yes, it operates on all, I'll add a comment.

> (Small style tip: In Python, you're free to mutate the default values
> of your arguments, and those changes will be visible the next time yo=
u
> call the funtction. You don't change "files" in this function, but
> it's probably still a good idea to make the default value an immutabl=
e
> type, such as tuple.)

I've bean hit by this problem in the past but haven't learned :-).

--=20
Catalin
