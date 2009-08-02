From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Subtree merging of sub-directories between repositories?
Date: Sun, 2 Aug 2009 04:30:58 -0400
Message-ID: <32541b130908020130q11f1fa03yca276ab86c2ea4d5@mail.gmail.com>
References: <2729632a0908012337l6d84ba76o81239d324ba11cf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 02 10:31:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXWTe-0001Mh-4s
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 10:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbZHBIbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 04:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZHBIbW
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 04:31:22 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:41788 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbZHBIbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 04:31:17 -0400
Received: by gxk9 with SMTP id 9so5094736gxk.13
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/tFhF3wBLypfWbUYnPkA1YsdkHZUITdJ1VttYIT6Kpg=;
        b=c1cFSdygIgZhvacBWW5T97maQDRGu5CjmvwRO6CV3YDc590PCoKpDTrlfRDeFM886l
         JdvF9Y7yd7W3s8Mn/WuecQ+Xk92zACKKW9ERDevL1jyKaAkm8LeQYAgj37Shayl0Suy3
         KQgwpQ6Eo2qCue17Lq01DP5s6sfHkyY2ZLeg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hL+zUNuNsKbF6Z5rbPNafBFJZH+ehqB/m0hC0NbxJJWRH2F0X2z4dz2N1+jCCYRQ01
         80sNqJTt7SlbyxglEoT3nyd4hb5O59hjunVNRUY4lqiVu7niQhHqx6YLWhTxvQfHO//B
         wApftRynrYxf9vI0eodzyz13tvD71ydDCS+cU=
Received: by 10.150.136.5 with SMTP id j5mr8131380ybd.109.1249201878094; Sun, 
	02 Aug 2009 01:31:18 -0700 (PDT)
In-Reply-To: <2729632a0908012337l6d84ba76o81239d324ba11cf2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124671>

On Sun, Aug 2, 2009 at 2:37 AM, <skillzero@gmail.com> wrote:
> Is it possible to use the subtree merge strategy to import just one
> directory from a repository into a directory of a different
> repository? The subtree merge example describes bringing in an entire
> repository as a directory, but I'm not sure how to adapt that to just
> import part of the source repository. The repositories are completely
> different, but repository A has a couple directories I want to import
> into repository B (along with the history that affected those
> directories). I may also make changes on either side and it would be
> nice to be able to re-merge in either direction.
>
> I was thinking I might need something like the git-subtree script, but
> maybe this can be done with standard git commands?

git tracks the history of the entire tree, not each subtree.  So if
you use the existing set of commit objects in A, then you'll pull in
*all* the files of A.

You have basically two choices here:

1) Merge the *entire* history of project A into project B, and during
the merge, delete the files you don't want.  (This will result in a
repo that's about the size of A+B, even if you only keep 1% of the
files, and every change to every file in A will now show up in B's
history.)  Merging future changes from A to B will be relatively easy
(although you'll get conflicts on those files you deleted), but
merging from B back to A will probably make a mess.

2) Use "git subtree split" to take the subdir of A and give it a
history of its own, then merge that history into a subdir of B (using
"git subtree add" or any other subtree merge method you want to use).
You can then git subtree split/merge back and forth between A and B in
the future to copy future changes from one to the other.

The disadvantage of #2 is that git subtree ends up creating new "fake"
commit objects for your new shared subproject.  If you merge the new
subproject back into A, you'll end up with some duplicate commit
messages (unless you use --squash).

Hope this helps.

Have fun,

Avery
