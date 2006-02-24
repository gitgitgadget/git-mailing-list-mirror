From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-rm: Fix to properly handle files with spaces, tabs, newlines, etc.
Date: Fri, 24 Feb 2006 14:23:08 +0100
Message-ID: <81b0412b0602240523l1b10c910q6e5d2e3cef82e306@mail.gmail.com>
References: <87u0ass7tj.wl%cworth@cworth.org> <43FB8F31.9090302@people.pl>
	 <87slqcs4y5.wl%cworth@cworth.org> <87r75ws48c.wl%cworth@cworth.org>
	 <7vaccjst3x.fsf@assigned-by-dhcp.cox.net>
	 <8764n7rl6s.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Krzysiek Pawlik" <krzysiek.pawlik@people.pl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 14:23:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCcug-0002B2-Ed
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 14:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWBXNXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 08:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWBXNXL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 08:23:11 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:55689 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751014AbWBXNXK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 08:23:10 -0500
Received: by nproxy.gmail.com with SMTP id l36so206362nfa
        for <git@vger.kernel.org>; Fri, 24 Feb 2006 05:23:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GH2gg9vjsjMarrCcyyPRH9Jq+dUSWJ2S5u5DKQlmopr3L3xTgkJtT3V07ccKOIUs/cQVH4eM22O1vnEexE2+kQvP7Z+rb+i4QO8OycsJEH0QFlNKl6eM0n4RumpQ2cv4h5wzyk5RqxllX+1eYYA9EE60lP4M2sk5+er7Xg08ZMM=
Received: by 10.49.33.14 with SMTP id l14mr2766904nfj;
        Fri, 24 Feb 2006 05:23:08 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Fri, 24 Feb 2006 05:23:08 -0800 (PST)
To: "Carl Worth" <cworth@cworth.org>
In-Reply-To: <8764n7rl6s.wl%cworth@cworth.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16701>

On 2/23/06, Carl Worth <cworth@cworth.org> wrote:
> +# Setup some files to be removed, some with funny characters
> +touch -- foo bar baz 'space embedded' 'tab     embedded' 'newline
> +embedded' -q
> +git-add -- foo bar baz 'space embedded' 'tab   embedded' 'newline
> +embedded' -q
> +git-commit -m "add files"

This doesn't work on some exotic filesystems (ntfs and fat):

*** t3600-rm.sh ***
touch: cannot touch `tab\tembedded': No such file or directory
touch: cannot touch `newline\nembedded': No such file or directory
error: pathspec 'tab    embedded' did not match any.
error: pathspec 'newline
embedded' did not match any.
Maybe you misspelled it?
Nothing to commit
* FAIL 1: Pre-check that foo exists and is in index before git-rm foo
        [ -f foo ] && git-ls-files --error-unmatch foo
* FAIL 2: Test that git-rm foo succeeds
        git-rm foo
* FAIL 4: Pre-check that bar exists and is in index before "git-rm -f bar"
        [ -f bar ] && git-ls-files --error-unmatch bar
* FAIL 5: Test that "git-rm -f bar" succeeds
        git-rm -f bar
* FAIL 6: Post-check that bar does not exist and is not in index after
"git-rm -f bar"
        ! [ -f bar ] && ! git-ls-files --error-unmatch bar
* FAIL 7: Test that "git-rm -- -q" succeeds (remove a file that looks
like an option)
        git-rm -- -q
* FAIL 8: Test that "git-rm -f" succeeds with embedded space, tab, or
newline characters.
        git-rm -f 'space embedded' 'tab embedded' 'newline
        embedded'
* FAIL 10: When the rm in "git-rm -f" fails, it should not remove the
file from the index
        git-ls-files --error-unmatch baz
* failed 8 among 10 test(s)
