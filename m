From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: Re: GNU diff and git diff - difference on myers algorithm?
Date: Fri, 12 Jun 2015 11:52:58 -0700
Message-ID: <CAB=NE6VGX332=CvhQM4sc27AM8ae5S1kdRnm5sMfoqkU=b=ebg@mail.gmail.com>
References: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
 <0add7d95076f5b112af90d8566c29203@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:53:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3U4y-0003Ha-C2
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 20:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbbFLSxU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 14:53:20 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38357 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbbFLSxT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2015 14:53:19 -0400
Received: by igblz2 with SMTP id lz2so16501719igb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=cfm1N6734Z+cfqrim10ibw9fSypvtDKQHdjCmEZyMmY=;
        b=r+zPKk3tb/2EuBTG5EA7r9Is2mRKj2iM9gyF5TbtmizQcwMQXALtkqbaesFTWzi8Cn
         e0+l8mu+gLN3EEmOFRXc2dA2/uIcbCMY/bpT8+GrO93728L4EfHD8Tl/iCQ69TN1UuYB
         FXHdtmVZLbKg8OuhmUhf+iolJxi9w2Xal7yr+DxvB8Uax3s6OcWVMDW/U1HIw++DPRRD
         mfjKvybCFvQcP9gDCgfJwR0qWZwxQCqYPo/fcN+XjSMQ8rqHGPVWOfQ9YEWv1zRq8Pii
         sKH94A2l6+sXs0kz3vvtVhFvm8GHC6MVF+0sLRxYInuyO3pOOa+XF0afA+Ko6eigQbeB
         YJuQ==
X-Received: by 10.107.17.87 with SMTP id z84mr2182840ioi.81.1434135198619;
 Fri, 12 Jun 2015 11:53:18 -0700 (PDT)
Received: by 10.107.29.196 with HTTP; Fri, 12 Jun 2015 11:52:57 -0700 (PDT)
In-Reply-To: <0add7d95076f5b112af90d8566c29203@www.dscho.org>
X-Google-Sender-Auth: OY61Ie6ovSQgSS96TFv5LOaKnFs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271513>

On Tue, Jun 9, 2015 at 1:25 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Luis,
>
> On 2015-06-08 20:34, Luis R. Rodriguez wrote:
>> Based on a cursory review of the git code I get the impression that
>> GNU diff and git 'diff' do not share any code for the possible diff
>> algorithms.
>
> Indeed, Git's diff machinery is based[*1*] ofn libxdiff[*2*], not on GNU diff.

Great thanks for the confirmation. Interesting point by Linus on that
commit that changed from forking to use GNU diff to libxdiff:

  "generating a diff is not an exact
   science - you can get two different diffs (and you will), and they can
   both be perfectly valid. So it's not possible to "validate" the
   libxdiff output by just comparing it against GNU diff."

Indeed, simple example is using different starting context lines, or
different number of context lines. I do however wonder if under
certain parameters they *need* to be equal, or if this has been
studied exactly before.

>> I'm in particularly curious more about the default "myers"
>> algorithm.
>
> Are you looking for a freely available implementation of the Myers algorithm? Or are you interested in understanding it?

I was trying to determine the above, of possibilities of differences.
Now granted there are the "diffs" using different output layouts
should differ, and as I note above if you modify the conext preference
you might end up with slightly different diffs, but I am also curious
to know if anyone has done research to see whether or not two hunks
which are slightly different are functionally equivalent. More on the
reasoning behind this below.

> Please note that Myers' algorithm is just one first step in most diff implementations (and that other diff algorithms have become popular, in particular because comparing strings can be accelerated by hashing the text lines first, and those hashes can also be used to identify matching pairs of unique lines, giving rise to yet another huge performance boost for typical uses).

Awesome.

> The reason why Myers' algorithm is not sufficient for diff implementations is that it only optimizes the "edit distance", i.e. the amount of added/removed lines, while patches should be readable, too, i.e. prefer *consecutive* edits to disjunct ones.

Indeed, this is along the lines of what I am looking for but with some
other tweaks considered, more on this below.

> Just to mention one post-processing technique that is so useful that I implemented it for Git[*3*]: the "patience diff" algorithm of Bram Cohen (of BitTorrent fame) finds matching pairs of unique lines -- think of a function from which another function is refactored, for example, intuitively you want the diff to keep the signature of the original function as a context line.

Indeed.

> Disclaimer: While it is true that Gene and I shared an office for one month, and that I am once again working in the same institute as he does, all my knowledge about this algorithm stems from my reading his paper and implementing the algorithm in Java for use in JGit[*3*].

:)

>> I can take time to do a precise code review of the
>> algorithms used on both GNU diff and git but if someone can already
>> vet for any differences that'd be appreciated as it would save time.
>
> Again, I am curious what your goal is? I am sure I can support your quest better when I understand what the purpose of this code review should be.

OK wells I'm curious about more research / effort when trying to
evaluate a diff with two seprate but adjoining preprocessor directives
and if anyone has implemented an optimizaiton option to let the diff
generator join them.

For example, to let it infer that:

--- a/test.c
+++ b/test.c
@@ -10,8 +10,6 @@ int main(int argc, char *argv[])

 #ifdef FOO
        a = 4;
-#endif /* FOO */
-#ifdef FOO
        a = 5;
 #endif /* FOO */

is possible.

 Luis
