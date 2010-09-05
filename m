From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 01/15] README-sparse-clone: Add a basic writeup of my
 ideas for sparse clones
Date: Sat, 4 Sep 2010 21:13:13 -0600
Message-ID: <AANLkTikxCwSOBVREuRc7sShJahKR5FXWdaW79f_K36bU@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-2-git-send-email-newren@gmail.com>
	<AANLkTikx89M+JcOcabU3TazGB=k8x39QLbVe7sH7Vvaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 05:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os5fV-0007zo-Q5
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 05:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab0IEDNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 23:13:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46436 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab0IEDNO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 23:13:14 -0400
Received: by fxm13 with SMTP id 13so1992800fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 20:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QcyTJvlcvJQNYvJEWRbXhDwUVd11HcUTYYdSDFaaEnk=;
        b=DgIs3BRFwzRx6LQB2qPmpkUf4vFfLQdhudaamkkP3tfzmfuZsBjF8eunE2xnyDn0KO
         KONIFeGAlfuHhlxwQgRM9b6YsjRNYE3QxRn8TPeer8zbEX5eoDUChUNYpqJIN90doKQ8
         45KYwcga0XXu/EkPucNWWnHbQ6IHW0kjq6oHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R8NwfiReeRnI5oTvrFk8ofe/o8NV7/MwebB+6a7ToOaOpEopLkGLfPckV/Z4EVaxTr
         4BxIuTAmDFRgTl4bzzib9YH4lXQ9VBgkuKAAAPzktPDReM8ek0ZLo9oCLb0hn7JwOxjW
         nxj4KHyC3J4MEAj+SMS1DPTojiaWNR4x/QtHA=
Received: by 10.223.112.13 with SMTP id u13mr1531177fap.36.1283656393269; Sat,
 04 Sep 2010 20:13:13 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sat, 4 Sep 2010 20:13:13 -0700 (PDT)
In-Reply-To: <AANLkTikx89M+JcOcabU3TazGB=k8x39QLbVe7sH7Vvaa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155415>

On Sat, Sep 4, 2010 at 9:01 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Sun, Sep 5, 2010 at 10:13 AM, Elijah Newren <newren@gmail.com> wro=
te:
>> +To ensure minimum necessary connectivity, we also download basic
>> +information from otherwise excluded commits
>> + =C2=A0* parents of these commits
>> + =C2=A0* trees matching the specified sparse path(s)
>> +but, for security and space reasons, do not download
>> + =C2=A0* author
>> + =C2=A0* author date
>> + =C2=A0* committer
>> + =C2=A0* committer date
>> + =C2=A0* log message
>> +Such commits are still considered "missing" (see item I4 for more
>> +details about how we handle "missing" commits).
>
> Just an observation. When I ran pack-objects with irrelevant commits
> removed (i.e. try_to_simplify_commit) on Documentation/, I got a 6MB
> pack. When I ran it without commit simplification, I got 16MB pack.
> That's 10MB larger.

Hmm.  I get 22MB pack for a full clone of git.git and 13 MB for a
sparse clone with Documentation/; that's including all commits too.  I
wonder why our numbers differ by 3 MB.  Weird.

> Now I don't how much of that 10MB share is commit messages, authors,
> committers and trees but I suspect trees take a large part in it.
> Maybe you can just fake the trees in those fake commits as well, to
> avoid downloading more trees.

I originally planned to do that, but that makes working with tags and
branches difficult.  For example, documenters could clone a repository
but be unable to make new commits on top of maint or master since we
probably wouldn't have trees for the tips of those branches.

So I really think trees are needed.  Of course, for someone making a
sparse clone of "just" the Documentation directory will need the
toplevel trees, but they won't need trees under t/, for example.  So
they do get some savings.
