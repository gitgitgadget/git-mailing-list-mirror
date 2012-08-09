From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH/RFC v2 06/16] t3700: sleep for 1 second, to avoid
 interfering with the racy code
Date: Thu, 9 Aug 2012 15:19:32 +0200
Message-ID: <20120809131932.GD25671@tommy-fedora.surfnet.iacbox>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-7-git-send-email-t.gummerer@gmail.com>
 <7vsjc023sr.fsf@alter.siamese.dyndns.org>
 <20120807165947.GD913@tgummerer>
 <7vr4rhrvfm.fsf@alter.siamese.dyndns.org>
 <7vmx25rtj5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 15:19:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzSeO-0003qu-2E
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 15:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758153Ab2HINTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 09:19:38 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40711 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab2HINTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 09:19:36 -0400
Received: by wibhm11 with SMTP id hm11so347073wib.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 06:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CBBH5+fC5o99+348Obf1Hphk11fbhS3OoJyW167Yl6g=;
        b=mWijsZhxLlNe+28uCi4n4Mm4bwehRgCMhgdHRQoEta3Y0uQvXQb8Le0C+ibuZPRe1v
         JraHt8PNLIV9rw63Eb61FY4zUnqEosyCO+PLNAbjO2WfCBnu//cv6xUszFXa8rkZXu3E
         KpiFJPIWH3wAf0gucR5TplwiesTgj3KgZgAkzILMYEn9TXh4XMUiiZB73YMovriQfU1t
         TC5OsybXnTlA4TCmqvALH5oOX5YmqRjvWbwztUnfl0KWznpBJMWQ0jYLBsUNQ15/rptH
         aqKC2XV6kyJUuXh5VpIchQioVb1xx97VIYwbimYhBbcQFtLhfk8STvOFQgOcBoeuB3b1
         EaRw==
Received: by 10.180.81.38 with SMTP id w6mr2905514wix.10.1344518375526;
        Thu, 09 Aug 2012 06:19:35 -0700 (PDT)
Received: from localhost ([46.18.27.15])
        by mx.google.com with ESMTPS id w7sm1683395wiz.0.2012.08.09.06.19.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 06:19:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmx25rtj5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203157>

On 08/08, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > So whether done with "sleep" or "test-chmtime", avoiding a racily
> > clean situation sounds like sweeping a bug in the v5 code in racy
> > situation under the rug to me (unless I am misunderstanding what
> > you are doing with this change and in your explanation, or the test
> > was checking a wrong thing, that is).
> >
> > Even more confused....
> 
> OK, after staring this test for a long time, and going back to
> 3d1f148 (refresh_index: do not show unmerged path that is outside
> pathspec, 2012-02-17), I give up.
> 
> Let me ask the same question in a more direct way.  Which part of
> this test break with your series?
> 
>         test_expect_success 'git add --refresh with pathspec' '
>                 git reset --hard &&
>                 echo >foo && echo >bar && echo >baz &&
>                 git add foo bar baz && H=$(git rev-parse :foo) && git rm -f foo &&
>                 echo "100644 $H 3	foo" | git update-index --index-info &&
> 	# "sleep 1 &&" in the update here ...
>                 test-chmtime -60 bar baz &&
>                 >expect &&
>                 git add --refresh bar >actual &&
>                 test_cmp expect actual &&
> 
>                 git diff-files --name-only >actual &&
>                 ! grep bar actual&&
>                 grep baz actual
>         '
> 
> We prepare an index with bunch of paths, we make "foo" unmerged, we
> smudge bar and baz stat-dirty, so that "diff-files" would report
> them, even though their contents match what is recorded in the
> index.

After getting confused a bit myself, I now think here is the problem.
The v5 code smudges baz when doing git add --refresh bar.  Therefore
baz isn't considered stat-dirty by the code, but a racily smudged entry
and therefore its content gets checked, thus not showing up in
git diff-files.  The mtime doesn't get checked anymore as it is used
as smudge marker and thus 0.  Adding sleep just avoids smudging the
entry.

The alternative would be to use the size or the crc as smudge marker
but I don't think they are good canidates, as they can still be used
by the reader to avoid checking the filesystem.

Another alternative would be to introduce a CE_SMUDGED flag as it was
suggested by Thomas on irc IIRC, but we chose to use the mtime as
smudge marker instead.

> Then we say "git add --refresh bar".  As far as I know, the output
> from "git add --refresh <pathspec>" is limited to "foo: needs merge"
> if and only if "foo" is covered by <pathspec> and "foo" is unmerged.
> 
> 	Side note: If "--verbose" is given to the same command, we
> 	also give "Unstaged changes after refreshing the index:"
> 	followed by "M foo" or "U foo" if "foo" does not match the
> 	index but not unmerged, or if "foo" is unmerged, again if
> 	and only if "foo" is covered by <pathspec>.  But that is not
> 	how we invoke "git add --refresh" in this test.
> 
> So if you are getting a test failure from the test_cmp, wouldn't it
> mean that your series broke what 3d1f148 did (namely, make sure we
> report only on paths that are covered by <pathspec>, in this case
> "bar"), as the contents of "bar" in the working tree matches what is
> recorded in the index?
> 
> If the failure you are seeing is that "bar" appears in the output of
> "git diff-files --name-only", it means that "diff-files" noticed
> that "bar" is stat-dirty after "git add --refresh bar".  Wouldn't it
> mean that the series broke "git add --refresh bar" in such a way
> that it does not to refresh what it was told to refresh?
> 
> Another test that could fail after the point you added "sleep 1" is
> that the output from "git diff-files --name-only" fails to list
> "baz" in its output, but with "test-chmtime -60 bar baz", we made
> sure that "bar" and "baz" are stat-dirty, and we only refreshed
> "bar" and not "baz".  If that is the case, then would it mean that
> the series broke "git add --refresh bar" in such a way that it
> refreshes something other than what it was told to refresh?
>
> In any case, having to change this test in any way smells like there
> is some breakage in the series; it is not immediately obvious to me
> that the current test is checking anything wrong as I suspected in
> the earlier message.
> 
> So,... I dunno.
> 
