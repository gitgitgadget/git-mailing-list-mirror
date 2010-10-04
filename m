From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v4 2/4] Add testcases for the --detect-dir-renames
 diffcore flag.
Date: Mon, 4 Oct 2010 23:37:03 +0200
Message-ID: <20101004213703.GW4983@home.lan>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <20101004203241.GF6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:27:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sZB-0002cX-3D
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab0JDV1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 17:27:12 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:56409 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756270Ab0JDV1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 17:27:11 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id CDD29D48094;
	Mon,  4 Oct 2010 23:27:03 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2siV-0004Kw-4A; Mon, 04 Oct 2010 23:37:03 +0200
Content-Disposition: inline
In-Reply-To: <20101004203241.GF6466@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158126>

On Mon, Oct 04, 2010 at 03:32:41PM -0500, Jonathan Nieder wrote:
> Yann Dirson wrote:
> 
> > From: Yann Dirson <ydirson@free.fr>
> > Subject: Add testcases for the --detect-dir-renames diffcore flag
> 
> Probably better for the test to be squashed with the patch that adds
> that option.

I tend to agree, but we see quite a lot of patches split this way it
seems.  Junio, any preference here ?


> > --- /dev/null
> > +++ b/t/t4046-diff-rename-factorize.sh
> > @@ -0,0 +1,326 @@
> [...]
> > +test_expect_success \
> > +    'commit the index.'  \
> > +    'git update-ref HEAD $(echo "original empty commit" | git commit-tree $(git write-tree))'
> 
> Nit:
> 
> Now test assertions tend to be written as
> 
> 	test_expect_success '...' '
> 		command &&
> 		command &&
> 		...
> 	'
> 
> The tabs to indent and opening ' at the end of the first line means
> less fuss in lining things up.  Making each test assertion include its
> setup means tests don't pass if something gets messed up in the setup,
> and using multiline test assertions with && means there is no
> confusion about what the tests were written to test.
> 
> As you mentioned, this has the unfortunate downside of messing with
> syntax highlighting.  Maybe the common text editors need a new mode
> for git-style test scripts?

There used to be a mmm-mode thingie for emacs which made such things
easier (multiple major modes with custom delimiters) - but that did
not handle quoting issues automagically either :)

One solution seen in some test scripts already is to define functions
outside of the test_expect* clauses.


>  Or maybe it would make sense to implement
> 
> 	test_begin_expecting_success '...'
> 	...
> 	test_end
> 
> --- it would certainly make quoting easier.

Not sure it would be possible without a macro processor.  And not sure
a macro processor would be welcome by everyone here :)


> It might make sense to compute the tree, commit, etc one at a time
> instead of this long one-liner.

If moved into a function which would make it readable, yes.


> To avoid quoting troubles and since these are innocuous commands, it
> could be nice to put this before the first test assertion.  Or even
> better:
> 
> 	mkdir a &&
> 	printf "Line %s\n" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 >a/path0 &&
> 	...

Well, when seeing for the first time such a construct, i tend to
wonder how portable it is amont printf implementations.  But hey, I'm
always thrilled to discover parts of the standard tools I had missed
until now :)


> [...]
> > +test_expect_success \
> > +    'git diff-index --detect-dir-renames after directory move.' \
> > +    'git diff-index --detect-dir-renames HEAD >current'
> > +grep -v "^\[DBG\] " <current >current.filtered
> > +cat >expected <<\EOF
> > +:040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100	a/	b/
> > +:100644 100644 fdbec444a77953b1bcc899d9fabfa202e5e68f08 fdbec444a77953b1bcc899d9fabfa202e5e68f08 R100	a/path0	b/path0
> > +:100644 100644 2f1f8d70c0fdad990819dfe37a31deb010805161 2f1f8d70c0fdad990819dfe37a31deb010805161 R100	a/path1	b/path1
> > +:100644 100644 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 dbde7141d737c8aa0003672c1bc21ded48c6c3b9 R100	a/path2	b/path2
> > +:100644 100644 c6971ab9f08a6cd9c89a0f87d94ae347aad6144a c6971ab9f08a6cd9c89a0f87d94ae347aad6144a R100	a/path3	b/path3
> > +EOF
> 
> Nit: although compare_diff_patch ensures the result is not dependent
> on the hash function, these hard-coded hashes are still hard for a
> human to read.  Could they be computed instead?

Well, that would just make the test harder to read imho.  Using
regexps would help for readability, but that would require another
compare_diff variant.  BTW, I should be using compare_diff_raw not
compare_diff_patch here.
