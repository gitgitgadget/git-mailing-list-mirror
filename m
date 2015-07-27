From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] tests: Remove some direct access to .git/logs
Date: Mon, 27 Jul 2015 18:56:05 -0400
Organization: Twitter
Message-ID: <1438037765.18134.8.camel@twopensource.com>
References: <1438028034-23609-1-git-send-email-dturner@twopensource.com>
	 <xmqqlhe1gtnb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 00:56:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJrJe-0007dT-0I
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 00:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646AbbG0W4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 18:56:09 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35743 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbbG0W4H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 18:56:07 -0400
Received: by qkbm65 with SMTP id m65so45062152qkb.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 15:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=oSYTWvDKBw3WWclkoBPgnuaxcfHct0ZidkGCbLkuOl0=;
        b=ifijE5iVOY8PRmqyX27s/8op3L916/CCGJRzRhoewBFkYDpfpxK/M7GSbgOKrUp4bR
         zZHhAHxPfBitOmb9OjclJ3pdjo/6xsxGv6wiGfMNIqAhE+alcNd10fRCu2j1i0x/Ubn2
         wPZoPR1x5WytoByVFF0oqFT3C21LwCrTccS4g7cWVsX2iUijBcGpdLoh6+I+XFzICyjq
         sFnGGfNhN2VrYbkWfvNOHMXG9oTUpa3Y+ZJBl7TjrE6a9A90hXpwAdL9mm7IAktPjVpz
         qaizW9nFHvOj4Ybud5jCz1fy0aALIZ/lZlnsXI+yVHDxlvD0iUXBaOiRPa7bPQ0w0LIe
         VWmA==
X-Gm-Message-State: ALoCoQmzEgGcSZd+/evocbLT81MHn3kPfLIULObVrK0f8mit9yBj4F4Rh7zb7U28mrNtMeC5PnRq
X-Received: by 10.55.49.76 with SMTP id x73mr44470294qkx.49.1438037766268;
        Mon, 27 Jul 2015 15:56:06 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id k6sm8206766qkh.48.2015.07.27.15.56.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 15:56:05 -0700 (PDT)
In-Reply-To: <xmqqlhe1gtnb.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274718>

On Mon, 2015-07-27 at 14:47 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > -: a repository with working tree always has reflog these days...
> > -: >.git/logs/refs/heads/master
> > +rm -f .git/logs/refs/heads/master
> 
> This looks quite different from how other tests are updated (which
> looked a lot more sensible).  The original has the effect of (1)
> ensuring that the log exists/is enabled for 'master' branch and (2)
> that log is emptied.  The updated has a quite different effect,
> but only when you are using filesystem based backend.

Yes, this is one of the areas where we need to do more work for
alternate backends -- for instance, we could provide a "git reflog
remove" command to replace that rm.  As the commit message notes, this
patch is a subset of what's necessary for multiple backends.

There are a number of other tests that e.g. rm -r .git/logs, which we
would also need to change for alternate backends.  

> >  test_expect_success \
> >  	"create $m (logged by touch)" \
> >  	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
> > -	 git update-ref HEAD '"$A"' -m "Initial Creation" &&
> > +	 git update-ref --create-reflog HEAD '"$A"' -m "Initial Creation" &&
> >  	 test '"$A"' = $(cat .git/'"$m"')'
> 
> And this update compensates for the earlier "remove 'master' reflog"
> (where it should have been "ensure creation and empty it") by
> creating, but it is unclear what would happen when we start using
> different ref backends.  Earlier we did not remove reflog from the
> backend, and we say "create" here---it would hopefully not error
> out, but it does not quite feel right.  Perhaps create and
> immediately prune all instead?  That feels like more in line with
> the way the other change in this patch do things.

If we create and immediately prune all, we'll lose the initial creation
entry, which we presumably want to test.

> >  test_expect_success 'fails silently when using -q with deleted reflogs' '
> >  	ref=$(git rev-parse HEAD) &&
> > -	: >.git/logs/refs/test &&
> > -	git update-ref -m "message for refs/test" refs/test "$ref" &&
> > +	git update-ref --create-reflog -m "message for refs/test" refs/test "$ref" &&
> 
> I cannot tell without enough pre-context, but I assume that we know
> there is no reflog for refs/test when this test piece starts---in
> which case this change looks sensible.

Yes, that is correct.

> > -	tail -n 4 .git/logs/HEAD |
> > -	sed -e "s/.*	//" >actual &&
> > +	git reflog HEAD -n4 |
> 
> This may happen to work but teaches a bad habit to readers.  Always
> order your command line by starting with dashed-options, then refs
> and then pathspecs.

Will fix on reroll.

> > diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
> > index 9ac7940..db9774e 100755
> > --- a/t/t7509-commit.sh
> > +++ b/t/t7509-commit.sh
> > @@ -90,22 +90,10 @@ sha1_file() {
> >  remove_object() {
> >  	rm -f $(sha1_file "$*")
> >  }
> > -no_reflog() {
> > -	cp .git/config .git/config.saved &&
> > -	echo "[core] logallrefupdates = false" >>.git/config &&
> > -	test_when_finished "mv -f .git/config.saved .git/config" &&
> > -
> > -	if test -e .git/logs
> > -	then
> > -		mv .git/logs . &&
> > -		test_when_finished "mv logs .git/"
> > -	fi
> > -}
> >  
> >  test_expect_success '--amend option with empty author' '
> >  	git cat-file commit Initial >tmp &&
> >  	sed "s/author [^<]* </author  </" tmp >empty-author &&
> > -	no_reflog &&
> >  	sha=$(git hash-object -t commit -w empty-author) &&
> >  	test_when_finished "remove_object $sha" &&
> >  	git checkout $sha &&
> > @@ -119,7 +107,6 @@ test_expect_success '--amend option with empty author' '
> >  test_expect_success '--amend option with missing author' '
> >  	git cat-file commit Initial >tmp &&
> >  	sed "s/author [^<]* </author </" tmp >malformed &&
> > -	no_reflog &&
> >  	sha=$(git hash-object -t commit -w malformed) &&
> >  	test_when_finished "remove_object $sha" &&
> >  	git checkout $sha &&
> 
> I can understand that .git/logs/ cannot be relied upon when you move
> your ref backend out of filesystem, but that does not quite explain
> why this change makes sense.  Puzzled...

It turns out that the removed portion of the test is totally
unnecessary; the tests are completely unrelated to reflogs.

On the reroll, I'll split this into a separate patch with its own
explanation.
