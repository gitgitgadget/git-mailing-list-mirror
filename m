From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Fri, 29 May 2009 09:40:59 +0100
Message-ID: <b0943d9e0905290140i57aeaa33r8de34302b63ffa5e@mail.gmail.com>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
	 <20090528124817.GA22262@diana.vm.bytemark.co.uk>
	 <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com>
	 <b0943d9e0905280751k3b9f26c9gd907a7c11ca9d5e2@mail.gmail.com>
	 <20090529072050.GA9760@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 29 10:42:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9xfV-00006b-Ma
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 10:42:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433AbZE2IlC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 04:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757294AbZE2IlC
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 04:41:02 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:54708 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432AbZE2Ik7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 04:40:59 -0400
Received: by ey-out-2122.google.com with SMTP id 22so34101eye.37
        for <git@vger.kernel.org>; Fri, 29 May 2009 01:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=X5tECJqZvuLwBfKmxfj191PU/NGAmtOnaqygtcC9f4E=;
        b=wIs6wL4kD8lqDxDbF+cXZ7YUMcmPBNTznNcAcsXPHdKCHi4PSb09FMJw7w5NpUO0yc
         jJqw9+Ca3dO3EeDPeAeksD67sF+KUUDm+FRQUulFuHTvFzAUMW0MnwBR8gPlS+js2a3R
         wz0WVp1FNkydXZPw4vtjtwFvP5WWGXmSD1cUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k+WQNr2umCNi+W9G+30jKoCZNwoZLH+tahFcBAi+p/dlzyBM0YhiNzTR0yr337xsc6
         pAkoLNm6jmAbc9y2m9erC1a+baCLdqqOGYm2jfmTvd/8fsP++gQHHd5ZmGrQt/pnsDh+
         Ps/zfZWMuPb+Z0/CJSHo0WvOxOI9R3gIq+ZyQ=
Received: by 10.216.17.213 with SMTP id j63mr828941wej.140.1243586459377; Fri, 
	29 May 2009 01:40:59 -0700 (PDT)
In-Reply-To: <20090529072050.GA9760@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120261>

2009/5/29 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2009-05-28 15:51:20 +0100, Catalin Marinas wrote:
>
>> 2009/5/28 Catalin Marinas <catalin.marinas@gmail.com>:
>>
>> > 2009/5/28 Karl Hasselstr=F6m <kha@treskal.com>:
>> >
>> > > This funcion should probably return a list of zero or more merge
>> > > bases. See the --all flag to git merge-base.
>> >
>> > OK, I'll add this and check the stack base against this set(list).
>>
>> What about this change to the original patch (it's faster to just
>> return the sha1 refs than building the Commit objects):
>
> Creating Commit objects is really cheap---just look at the
> constructor. I made them that way on purpose, so that we'd never have
> to think twice about using Commit objects instead of passing sha1s
> around.

I was worried it may invoke git to get the CommitData.

> Also, you said "set", and I agree---the return value of
> get_mege_bases() should be a set. That's what it _is_, conceptually,
> and it makes little sense to obscure that fact.

If we return a set of commits, I suspect the Repository object
guarantees that having the same sha1 value always returns the same
Commit object and the code below is valid:

    merge_bases =3D repository.get_merge_bases(public_head, stack.base)
    if not stack.base in merge_bases:
        public_head =3D __create_commit(repository, stack.head.data.tre=
e,
                                      [public_head, stack.base], option=
s)
        repository.refs.set(public_ref, public_head, 'publish')
        out.info('Merged the stack base into "%s"' % public_ref)
        return

=2E..

    def get_merge_bases(self, commit1, commit2):
        """Return a set of merge bases of two commits."""
        sha1_list =3D self.run(['git', 'merge-base', '--all',
                              commit1.sha1, commit2.sha1]).output_lines=
()
        return set(self.get_commit(sha1) for sha1 in sha1_list)

--=20
Catalin
