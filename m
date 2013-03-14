From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 3/3] difftool --dir-diff: symlink all files matching
 the working tree
Date: Thu, 14 Mar 2013 22:24:15 +0000
Message-ID: <20130314222415.GC4256@serenity.lan>
References: <cover.1363206651.git.john@keeping.me.uk>
 <cover.1363291949.git.john@keeping.me.uk>
 <ae17a152cadc650920c6446a4493384cc2e77309.1363291949.git.john@keeping.me.uk>
 <7v620ty8lc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 23:24:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGGZz-0006dq-Na
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 23:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab3CNWY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 18:24:29 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:57045 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab3CNWY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 18:24:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 53636161E47D;
	Thu, 14 Mar 2013 22:24:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bW3RbmSSzMH4; Thu, 14 Mar 2013 22:24:26 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id BDE8E161E291;
	Thu, 14 Mar 2013 22:24:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v620ty8lc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218175>

On Thu, Mar 14, 2013 at 02:28:31PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index 3aab6e1..70e09b6 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -340,6 +340,28 @@ test_expect_success PERL 'difftool --dir-diff' '
> >  	stdin_contains file <output
> >  '
> >  
> > +write_script .git/CHECK_SYMLINKS <<\EOF
> > +for f in file file2 sub/sub
> > +do
> > +	echo "$f"
> > +	readlink "$2/$f"
> > +done >actual
> > +EOF
> 
> When you later want to enhance the test to check a combination of
> difftool arguments where some paths are expected to become links and
> others are expected to become real files, wouldn't this helper
> become a bit awkward to use?  The element that expects a real file
> could be an empty line to what corresponds to the output from
> readlink, but still...
> 
> If t/ directory (or when the test is run with --root=<there>) is
> aliased with symlinks in such a way that "cd <there> && $(pwd)" does
> not match <there>, would this check with $(pwd) still work, I have
> to wonder?

It looks like t3903 uses "ls -l" for this sort of test, perhaps
something like this covers these cases better:

    write_script .git/CHECK_SYMLINKS <<\EOF
    for f in file file2 sub/sub
    do
        ls -l "$2/$f" >"$f".actual
    done
    EOF

    ...

    workdir=$(git rev-parse --show-toplevel)
    grep "-> $workdir/file" file.actual
    grep "-> $workdir/file2" file2.actual
    grep "-> $workdir/sub/sub" sub/sub.actual

It looks like we already rely on that output format in t3903 so I think
that is safe, but it would be nice to have a better way to say "does
this link point to that file?".  I can't think of a way to do that that
doesn't seem far too complicated for what's required here.

> > +test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstaged changes' '
> > +	cat <<EOF >expect &&
> > +file
> > +$(pwd)/file
> > +file2
> > +$(pwd)/file2
> > +sub/sub
> > +$(pwd)/sub/sub
> > +EOF
> 
> You can do this to align them nicer (note the "-" before EOF):
> 
> 	cat >expect <<-EOF &&
> 	file
>         $(pwd)/file
>         ...
>         EOF
> 
> > +	git difftool --dir-diff --symlink \
> > +		--extcmd "./.git/CHECK_SYMLINKS" branch HEAD &&
> > +	test_cmp actual expect
> > +'
> > +
>
> Thanks.
